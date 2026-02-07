<script lang="ts">
	import { goto } from '$app/navigation';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();

	const statuses = [
		{ value: '', label: 'All' },
		{ value: 'pending', label: 'Pending' },
		{ value: 'under_review', label: 'Under Review' },
		{ value: 'approved', label: 'Approved' },
		{ value: 'rejected', label: 'Rejected' }
	];

	function setFilter(status: string) {
		const url = `/corrections/${data.volume.id}${status ? `?status=${status}` : ''}`;
		goto(url, { invalidateAll: true });
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
			year: 'numeric'
		});
	}
</script>

<svelte:head>
	<title>Corrections — {data.volume.subtitle} — Criticalis</title>
	<meta name="description" content="View proposed corrections for {data.volume.subtitle} of The Treasury of David." />
</svelte:head>

<div class="container corrections-page">
	<div class="page-header">
		<div>
			<h1>Corrections</h1>
			<p class="page-subtitle">{data.volume.subtitle} — {data.volume.psalms}</p>
		</div>
		<a href="/read/{data.volume.id}" class="btn-back">Back to Reader</a>
	</div>

	<!-- Status filter tabs -->
	<div class="filter-tabs">
		{#each statuses as s}
			<button
				class="filter-tab"
				class:active={(data.statusFilter ?? '') === s.value}
				onclick={() => setFilter(s.value)}
			>
				{s.label}
			</button>
		{/each}
	</div>

	<!-- Corrections list -->
	{#if data.corrections.length === 0}
		<div class="empty-state">
			<p>No corrections found{data.statusFilter ? ` with status "${data.statusFilter}"` : ''}.</p>
			<p class="empty-hint">Select text in the reader to submit a correction.</p>
		</div>
	{:else}
		<div class="corrections-list">
			{#each data.corrections as c}
				<div class="correction-card">
					<div class="correction-meta">
						<span class="correction-type">{c.type === 'fix' ? 'Correction' : 'Footnote'}</span>
						<span class="correction-status {statusClass(c.status)}">{c.status.replace('_', ' ')}</span>
						<span class="correction-date">{formatDate(c.createdAt)}</span>
						{#if c.submitterName}
							<span class="correction-author">by {c.submitterName}</span>
						{/if}
					</div>

					<div class="correction-diff">
						<div class="diff-original">
							<span class="diff-label">Original</span>
							<p>{c.originalText}</p>
						</div>
						{#if c.type === 'fix'}
							<div class="diff-arrow">
								<svg width="16" height="16" viewBox="0 0 20 20" fill="none">
									<path d="M4 10h12M12 6l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
								</svg>
							</div>
							<div class="diff-proposed">
								<span class="diff-label">Proposed</span>
								<p>{c.proposedText}</p>
							</div>
						{:else}
							<div class="diff-footnote">
								<span class="diff-label">Footnote</span>
								<p>{c.proposedText}</p>
							</div>
						{/if}
					</div>

					{#if c.explanation}
						<div class="correction-explanation">
							<span class="diff-label">Explanation</span>
							<p>{c.explanation}</p>
						</div>
					{/if}
				</div>
			{/each}
		</div>
	{/if}
</div>

<style>
	.corrections-page {
		padding: 2rem 1.5rem 3rem;
	}

	.page-header {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		margin-bottom: 1.5rem;
	}

	.page-header h1 {
		font-size: 1.5rem;
		margin-bottom: 0.2rem;
	}

	.page-subtitle {
		color: var(--color-text-muted);
		font-size: 0.9rem;
		margin: 0;
	}

	.btn-back {
		font-size: 0.85rem;
		padding: 0.5rem 1rem;
		border: 1px solid var(--color-border);
		border-radius: var(--radius);
		color: var(--color-text-muted);
		text-decoration: none;
		white-space: nowrap;
	}

	.btn-back:hover {
		border-color: var(--color-accent);
		color: var(--color-text);
		text-decoration: none;
	}

	.filter-tabs {
		display: flex;
		gap: 0;
		border-bottom: 1px solid var(--color-border-light);
		margin-bottom: 1.5rem;
		overflow-x: auto;
	}

	.filter-tab {
		background: none;
		border: none;
		padding: 0.6rem 1rem;
		font-size: 0.85rem;
		color: var(--color-text-muted);
		border-bottom: 2px solid transparent;
		white-space: nowrap;
		transition: color 0.15s, border-color 0.15s;
	}

	.filter-tab:hover {
		color: var(--color-text);
	}

	.filter-tab.active {
		color: var(--color-accent);
		border-bottom-color: var(--color-accent);
		font-weight: 500;
	}

	.empty-state {
		text-align: center;
		padding: 3rem 1rem;
		color: var(--color-text-muted);
	}

	.empty-hint {
		font-size: 0.85rem;
		margin-top: 0.5rem;
		color: var(--color-text-faint);
	}

	.corrections-list {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.correction-card {
		background: var(--color-bg-elevated);
		border: 1px solid var(--color-border-light);
		border-radius: var(--radius-lg);
		padding: 1.25rem;
	}

	.correction-meta {
		display: flex;
		align-items: center;
		gap: 0.75rem;
		margin-bottom: 0.75rem;
		flex-wrap: wrap;
	}

	.correction-type {
		font-size: 0.8rem;
		font-weight: 500;
		color: var(--color-text);
	}

	.correction-status {
		font-size: 0.75rem;
		padding: 0.15rem 0.5rem;
		border-radius: 99px;
		font-weight: 500;
		text-transform: capitalize;
	}

	.status-pending {
		background: #fef3c7;
		color: #92400e;
	}

	.status-review {
		background: #dbeafe;
		color: #1e40af;
	}

	.status-approved {
		background: #d1fae5;
		color: #065f46;
	}

	.status-rejected {
		background: #fee2e2;
		color: #991b1b;
	}

	.correction-date {
		font-size: 0.8rem;
		color: var(--color-text-faint);
	}

	.correction-author {
		font-size: 0.8rem;
		color: var(--color-text-muted);
	}

	.correction-diff {
		display: flex;
		align-items: stretch;
		gap: 0.75rem;
	}

	.diff-original,
	.diff-proposed,
	.diff-footnote {
		flex: 1;
		padding: 0.75rem;
		border-radius: var(--radius);
	}

	.diff-original {
		background: #fef2f2;
	}

	.diff-proposed {
		background: #f0fdf4;
	}

	.diff-footnote {
		flex: 1;
		background: var(--color-accent-light);
		padding: 0.75rem;
		border-radius: var(--radius);
	}

	.diff-arrow {
		display: flex;
		align-items: center;
		color: var(--color-text-faint);
		flex-shrink: 0;
	}

	.diff-label {
		display: block;
		font-size: 0.7rem;
		text-transform: uppercase;
		letter-spacing: 0.04em;
		color: var(--color-text-faint);
		margin-bottom: 0.3rem;
		font-weight: 500;
	}

	.correction-diff p,
	.diff-footnote p,
	.correction-explanation p {
		margin: 0;
		font-family: var(--font-serif);
		font-size: 0.9rem;
		line-height: 1.5;
	}

	.correction-explanation {
		margin-top: 0.75rem;
		padding: 0.75rem;
		background: var(--color-bg);
		border-radius: var(--radius);
	}

	@media (max-width: 600px) {
		.corrections-page {
			padding: 1.5rem 1rem 2rem;
		}

		.page-header {
			flex-direction: column;
			gap: 0.75rem;
		}

		.page-header h1 {
			font-size: 1.3rem;
		}

		.correction-diff {
			flex-direction: column;
		}

		.diff-arrow {
			transform: rotate(90deg);
			align-self: center;
		}
	}
</style>
