<script lang="ts">
	import { goto, invalidateAll } from '$app/navigation';
	import { volumes } from '$lib/data/volumes';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();

	let expandedId: number | null = $state(null);
	let reviewNote = $state('');
	let actionLoading = $state(false);
	let actionError = $state('');

	const statuses = [
		{ value: 'pending', label: 'Pending' },
		{ value: 'under_review', label: 'Under Review' },
		{ value: 'approved', label: 'Approved' },
		{ value: 'rejected', label: 'Rejected' }
	];

	function setFilter(status: string, volume?: string) {
		let url = `/curator?status=${status}`;
		if (volume) url += `&volume=${volume}`;
		goto(url, { invalidateAll: true });
	}

	function toggleExpand(id: number) {
		if (expandedId === id) {
			expandedId = null;
		} else {
			expandedId = id;
			reviewNote = '';
			actionError = '';
		}
	}

	async function handleReview(correctionId: number, action: string) {
		actionLoading = true;
		actionError = '';

		try {
			const res = await fetch(`/api/corrections/${correctionId}/review`, {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ action, reviewNote: reviewNote || undefined })
			});

			if (!res.ok) {
				const errData = await res.json().catch(() => null);
				actionError = errData?.message ?? `Error ${res.status}`;
				return;
			}

			expandedId = null;
			reviewNote = '';
			await invalidateAll();
		} catch {
			actionError = 'Network error. Please try again.';
		} finally {
			actionLoading = false;
		}
	}

	function statusClass(status: string): string {
		switch (status) {
			case 'pending': return 'status-pending';
			case 'under_review': return 'status-review';
			case 'approved': return 'status-approved';
			case 'rejected': return 'status-rejected';
			default: return '';
		}
	}

	function formatDate(date: Date | string): string {
		return new Date(date).toLocaleDateString('en-US', {
			month: 'short',
			day: 'numeric',
			year: 'numeric',
			hour: 'numeric',
			minute: '2-digit'
		});
	}

	function getVolumeName(id: string): string {
		const v = volumes.find(v => v.id === id);
		return v?.subtitle ?? id;
	}
</script>

<svelte:head>
	<title>Curator Dashboard — Criticalis</title>
</svelte:head>

<div class="container curator-page">
	<h1>Curator Dashboard</h1>

	<div class="dashboard-layout">
		<!-- Sidebar filters -->
		<aside class="dashboard-sidebar">
			<div class="sidebar-section">
				<h3>Status</h3>
				{#each statuses as s}
					<button
						class="sidebar-item"
						class:active={data.statusFilter === s.value}
						onclick={() => setFilter(s.value, data.volumeFilter ?? undefined)}
					>
						<span>{s.label}</span>
						<span class="sidebar-count">{data.statusCounts[s.value] ?? 0}</span>
					</button>
				{/each}
			</div>

			<div class="sidebar-section">
				<h3>Volume</h3>
				<button
					class="sidebar-item"
					class:active={!data.volumeFilter}
					onclick={() => setFilter(data.statusFilter ?? 'pending')}
				>
					All Volumes
				</button>
				{#each volumes as v}
					<button
						class="sidebar-item"
						class:active={data.volumeFilter === v.id}
						onclick={() => setFilter(data.statusFilter ?? 'pending', v.id)}
					>
						{v.subtitle}
					</button>
				{/each}
			</div>
		</aside>

		<!-- Main content -->
		<div class="dashboard-main">
			{#if data.corrections.length === 0}
				<div class="empty-state">
					<p>No corrections with status "{data.statusFilter}".</p>
				</div>
			{:else}
				<div class="corrections-queue">
					{#each data.corrections as c}
						<div class="queue-card" class:expanded={expandedId === c.id}>
							<!-- Card header (always visible) -->
							<button class="queue-header" onclick={() => toggleExpand(c.id)}>
								<div class="queue-meta">
									<span class="correction-type">{c.type === 'fix' ? 'Correction' : 'Footnote'}</span>
									<span class="correction-status {statusClass(c.status)}">{c.status.replace('_', ' ')}</span>
									<span class="queue-volume">{getVolumeName(c.volumeId)}</span>
								</div>
								<div class="queue-preview">
									<span class="original-preview">{c.originalText.slice(0, 80)}{c.originalText.length > 80 ? '...' : ''}</span>
								</div>
								<div class="queue-info">
									<span class="queue-author">{c.submitterName ?? 'Unknown'}</span>
									<span class="queue-date">{formatDate(c.createdAt)}</span>
								</div>
							</button>

							<!-- Expanded detail view -->
							{#if expandedId === c.id}
								<div class="queue-detail">
									<!-- Side-by-side comparison -->
									<div class="comparison">
										<div class="comparison-side original">
											<h4>Original Text</h4>
											<div class="comparison-text">
												{c.originalText}
											</div>
										</div>

										{#if c.type === 'fix'}
											<div class="comparison-side proposed">
												<h4>Proposed Correction</h4>
												<div class="comparison-text">
													{c.proposedText}
												</div>
											</div>
										{:else}
											<div class="comparison-side footnote">
												<h4>Footnote Content</h4>
												<div class="comparison-text">
													{c.proposedText}
												</div>
											</div>
										{/if}
									</div>

									{#if c.explanation}
										<div class="detail-explanation">
											<h4>Explanation</h4>
											<p>{c.explanation}</p>
										</div>
									{/if}

									<div class="detail-metadata">
										<p>Submitted by <strong>{c.submitterName ?? 'Unknown'}</strong> ({c.submitterEmail ?? ''})</p>
										<p>Created: {formatDate(c.createdAt)}</p>
										{#if c.cfi}
											<p class="detail-cfi">CFI: <code>{c.cfi}</code></p>
										{/if}
										{#if c.reviewNote}
											<p class="detail-review-note">Previous review note: {c.reviewNote}</p>
										{/if}
									</div>

									<!-- Review actions -->
									<div class="review-section">
										<label class="review-field">
											<span>Review note (optional)</span>
											<textarea
												bind:value={reviewNote}
												rows="2"
												placeholder="Add a note about your decision..."
											></textarea>
										</label>

										{#if actionError}
											<div class="review-error">{actionError}</div>
										{/if}

										<div class="review-actions">
											<button
												class="btn-approve"
												disabled={actionLoading}
												onclick={() => handleReview(c.id, 'approve')}
											>
												Approve
											</button>
											<button
												class="btn-changes"
												disabled={actionLoading}
												onclick={() => handleReview(c.id, 'request_changes')}
											>
												Request Changes
											</button>
											<button
												class="btn-reject"
												disabled={actionLoading}
												onclick={() => handleReview(c.id, 'reject')}
											>
												Reject
											</button>
										</div>
									</div>
								</div>
							{/if}
						</div>
					{/each}
				</div>
			{/if}
		</div>
	</div>
</div>

<style>
	.curator-page {
		padding: 2rem 1.5rem 3rem;
	}

	.curator-page h1 {
		font-size: 1.5rem;
		margin-bottom: 1.5rem;
	}

	.dashboard-layout {
		display: grid;
		grid-template-columns: 220px 1fr;
		gap: 1.5rem;
	}

	/* Sidebar */
	.dashboard-sidebar {
		display: flex;
		flex-direction: column;
		gap: 1.5rem;
	}

	.sidebar-section h3 {
		font-size: 0.8rem;
		font-family: var(--font-sans);
		text-transform: uppercase;
		letter-spacing: 0.04em;
		color: var(--color-text-faint);
		margin-bottom: 0.5rem;
		padding: 0 0.5rem;
	}

	.sidebar-item {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		text-align: left;
		background: none;
		border: none;
		padding: 0.45rem 0.75rem;
		font-size: 0.85rem;
		color: var(--color-text-muted);
		border-radius: var(--radius);
		transition: background 0.15s, color 0.15s;
	}

	.sidebar-item:hover {
		background: var(--color-accent-light);
		color: var(--color-text);
	}

	.sidebar-item.active {
		background: var(--color-accent-light);
		color: var(--color-accent);
		font-weight: 500;
	}

	.sidebar-count {
		font-size: 0.75rem;
		background: var(--color-border-light);
		padding: 0.1rem 0.4rem;
		border-radius: 99px;
		color: var(--color-text-faint);
	}

	.sidebar-item.active .sidebar-count {
		background: var(--color-accent);
		color: white;
	}

	/* Queue cards */
	.corrections-queue {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.queue-card {
		background: var(--color-bg-elevated);
		border: 1px solid var(--color-border-light);
		border-radius: var(--radius-lg);
		overflow: hidden;
		transition: border-color 0.15s;
	}

	.queue-card.expanded {
		border-color: var(--color-accent);
	}

	.queue-header {
		display: block;
		width: 100%;
		text-align: left;
		background: none;
		border: none;
		padding: 1rem 1.25rem;
		transition: background 0.15s;
	}

	.queue-header:hover {
		background: var(--color-bg);
	}

	.queue-meta {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		margin-bottom: 0.4rem;
	}

	.correction-type {
		font-size: 0.8rem;
		font-weight: 500;
		color: var(--color-text);
	}

	.correction-status {
		font-size: 0.7rem;
		padding: 0.1rem 0.45rem;
		border-radius: 99px;
		font-weight: 500;
		text-transform: capitalize;
	}

	.status-pending { background: #fef3c7; color: #92400e; }
	.status-review { background: #dbeafe; color: #1e40af; }
	.status-approved { background: #d1fae5; color: #065f46; }
	.status-rejected { background: #fee2e2; color: #991b1b; }

	.queue-volume {
		font-size: 0.8rem;
		color: var(--color-text-faint);
	}

	.queue-preview {
		margin-bottom: 0.3rem;
	}

	.original-preview {
		font-family: var(--font-serif);
		font-size: 0.9rem;
		color: var(--color-text);
		line-height: 1.4;
	}

	.queue-info {
		display: flex;
		gap: 0.75rem;
		font-size: 0.8rem;
		color: var(--color-text-faint);
	}

	/* Expanded detail */
	.queue-detail {
		border-top: 1px solid var(--color-border-light);
		padding: 1.25rem;
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.comparison {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 1rem;
	}

	.comparison-side {
		padding: 1rem;
		border-radius: var(--radius);
	}

	.comparison-side h4 {
		font-size: 0.75rem;
		font-family: var(--font-sans);
		text-transform: uppercase;
		letter-spacing: 0.03em;
		color: var(--color-text-faint);
		margin-bottom: 0.5rem;
	}

	.comparison-text {
		font-family: var(--font-serif);
		font-size: 0.95rem;
		line-height: 1.6;
	}

	.original {
		background: #fef2f2;
	}

	.proposed {
		background: #f0fdf4;
	}

	.footnote {
		background: var(--color-accent-light);
	}

	.detail-explanation {
		padding: 0.75rem;
		background: var(--color-bg);
		border-radius: var(--radius);
	}

	.detail-explanation h4 {
		font-size: 0.75rem;
		font-family: var(--font-sans);
		text-transform: uppercase;
		letter-spacing: 0.03em;
		color: var(--color-text-faint);
		margin-bottom: 0.3rem;
	}

	.detail-explanation p {
		margin: 0;
		font-size: 0.9rem;
	}

	.detail-metadata {
		font-size: 0.8rem;
		color: var(--color-text-muted);
	}

	.detail-metadata p {
		margin: 0.2rem 0;
	}

	.detail-cfi code {
		font-family: var(--font-mono);
		font-size: 0.75rem;
		background: var(--color-bg);
		padding: 0.15rem 0.3rem;
		border-radius: 3px;
	}

	.detail-review-note {
		font-style: italic;
	}

	/* Review section */
	.review-section {
		border-top: 1px solid var(--color-border-light);
		padding-top: 1rem;
	}

	.review-field {
		display: flex;
		flex-direction: column;
		gap: 0.3rem;
		margin-bottom: 0.75rem;
	}

	.review-field span {
		font-size: 0.8rem;
		font-weight: 500;
		color: var(--color-text-muted);
	}

	.review-field textarea {
		padding: 0.6rem 0.75rem;
		border: 1px solid var(--color-border);
		border-radius: var(--radius);
		font-size: 0.85rem;
		font-family: inherit;
		background: var(--color-bg);
		color: var(--color-text);
		resize: vertical;
	}

	.review-field textarea:focus {
		outline: none;
		border-color: var(--color-accent);
		box-shadow: 0 0 0 2px rgba(124, 94, 60, 0.15);
	}

	.review-error {
		background: #fef2f2;
		color: var(--color-danger);
		border: 1px solid #fecaca;
		border-radius: var(--radius);
		padding: 0.5rem;
		font-size: 0.85rem;
		margin-bottom: 0.75rem;
	}

	.review-actions {
		display: flex;
		gap: 0.5rem;
	}

	.btn-approve,
	.btn-changes,
	.btn-reject {
		padding: 0.5rem 1rem;
		font-size: 0.85rem;
		font-weight: 500;
		border: none;
		border-radius: var(--radius);
		transition: opacity 0.15s;
	}

	.btn-approve {
		background: #059669;
		color: white;
	}

	.btn-approve:hover:not(:disabled) {
		background: #047857;
	}

	.btn-changes {
		background: #2563eb;
		color: white;
	}

	.btn-changes:hover:not(:disabled) {
		background: #1d4ed8;
	}

	.btn-reject {
		background: var(--color-danger);
		color: white;
	}

	.btn-reject:hover:not(:disabled) {
		background: #b91c1c;
	}

	.btn-approve:disabled,
	.btn-changes:disabled,
	.btn-reject:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}

	.empty-state {
		text-align: center;
		padding: 3rem 1rem;
		color: var(--color-text-muted);
	}

	@media (max-width: 600px) {
		.curator-page {
			padding: 1.5rem 1rem 2rem;
		}

		.dashboard-layout {
			grid-template-columns: 1fr;
		}

		.dashboard-sidebar {
			flex-direction: row;
			overflow-x: auto;
			gap: 1rem;
		}

		.sidebar-section {
			min-width: fit-content;
		}

		.comparison {
			grid-template-columns: 1fr;
		}

		.review-actions {
			flex-direction: column;
		}
	}
</style>
