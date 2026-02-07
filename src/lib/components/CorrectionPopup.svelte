<script lang="ts">
	type CorrectionData = {
		volumeId: string;
		sectionIndex?: number;
		cfi?: string;
		originalText: string;
	};

	type Props = {
		selection: CorrectionData | null;
		user: App.Locals['user'];
		onclose: () => void;
		onsuccess: () => void;
	};

	let { selection, user, onclose, onsuccess }: Props = $props();

	let activeTab: 'fix' | 'footnote' = $state('fix');
	let proposedText = $state('');
	let explanation = $state('');
	let submitting = $state(false);
	let error = $state('');

	// Reset form when selection changes
	$effect(() => {
		if (selection) {
			proposedText = selection.originalText;
			explanation = '';
			error = '';
			activeTab = 'fix';
		}
	});

	async function handleSubmit(e: Event) {
		e.preventDefault();
		if (!selection) return;

		error = '';
		submitting = true;

		try {
			const body: Record<string, unknown> = {
				volumeId: selection.volumeId,
				originalText: selection.originalText,
				type: activeTab
			};

			if (selection.sectionIndex != null) body.sectionIndex = selection.sectionIndex;
			if (selection.cfi) body.cfi = selection.cfi;

			if (activeTab === 'fix') {
				if (proposedText.trim() === selection.originalText) {
					error = 'The proposed text is identical to the original.';
					submitting = false;
					return;
				}
				body.proposedText = proposedText;
				body.explanation = explanation || undefined;
			} else {
				// Footnote: proposedText stores the footnote content
				body.proposedText = explanation;
				body.explanation = undefined;
			}

			const res = await fetch('/api/corrections', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify(body)
			});

			if (!res.ok) {
				const data = await res.json().catch(() => null);
				error = data?.message ?? `Error ${res.status}: submission failed.`;
				return;
			}

			onsuccess();
		} catch {
			error = 'Network error. Please try again.';
		} finally {
			submitting = false;
		}
	}
</script>

{#if selection}
	<!-- svelte-ignore a11y_click_events_have_key_events -->
	<!-- svelte-ignore a11y_no_static_element_interactions -->
	<div class="popup-backdrop" onclick={onclose}>
		<div class="popup" onclick={(e) => e.stopPropagation()}>
			<div class="popup-header">
				<h3>Submit Correction</h3>
				<button class="popup-close" onclick={onclose} aria-label="Close">
					<svg width="18" height="18" viewBox="0 0 20 20" fill="none">
						<path d="M5 5l10 10M15 5l-10 10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
					</svg>
				</button>
			</div>

			{#if !user}
				<div class="popup-auth-prompt">
					<p>You need to sign in to submit corrections.</p>
					<a href="/sign-in" class="btn-primary">Sign In</a>
					<p class="small">Don't have an account? <a href="/sign-up">Sign up</a></p>
				</div>
			{:else}
				<div class="popup-tabs">
					<button
						class="tab"
						class:active={activeTab === 'fix'}
						onclick={() => (activeTab = 'fix')}
					>
						Suggest Correction
					</button>
					<button
						class="tab"
						class:active={activeTab === 'footnote'}
						onclick={() => (activeTab = 'footnote')}
					>
						Add Footnote
					</button>
				</div>

				<form onsubmit={handleSubmit}>
					<div class="original-text">
						<span class="label">Selected text</span>
						<blockquote>{selection.originalText}</blockquote>
					</div>

					{#if activeTab === 'fix'}
						<label class="field">
							<span class="label">Corrected text</span>
							<textarea
								bind:value={proposedText}
								required
								rows="3"
								placeholder="Enter the corrected version..."
							></textarea>
						</label>

						<label class="field">
							<span class="label">Explanation <span class="optional">(optional)</span></span>
							<textarea
								bind:value={explanation}
								rows="2"
								placeholder="Why is this correction needed?"
							></textarea>
						</label>
					{:else}
						<label class="field">
							<span class="label">Footnote</span>
							<textarea
								bind:value={explanation}
								required
								rows="4"
								placeholder="Add an explanatory note for this passage..."
							></textarea>
						</label>
					{/if}

					{#if error}
						<div class="popup-error">{error}</div>
					{/if}

					<div class="popup-actions">
						<button type="button" class="btn-secondary" onclick={onclose}>Cancel</button>
						<button type="submit" class="btn-primary" disabled={submitting}>
							{submitting ? 'Submitting...' : 'Submit'}
						</button>
					</div>
				</form>
			{/if}
		</div>
	</div>
{/if}

<style>
	.popup-backdrop {
		position: fixed;
		inset: 0;
		background: rgba(0, 0, 0, 0.4);
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 200;
		padding: 1rem;
	}

	.popup {
		background: var(--color-bg-elevated);
		border-radius: var(--radius-lg);
		box-shadow: var(--shadow-lg);
		width: 100%;
		max-width: 480px;
		max-height: 90vh;
		overflow-y: auto;
		padding: 1.5rem;
	}

	.popup-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 1rem;
	}

	.popup-header h3 {
		font-size: 1.1rem;
		font-family: var(--font-sans);
		font-weight: 600;
	}

	.popup-close {
		background: none;
		border: none;
		color: var(--color-text-muted);
		padding: 4px;
		border-radius: 4px;
	}

	.popup-close:hover {
		background: var(--color-accent-light);
	}

	.popup-auth-prompt {
		text-align: center;
		padding: 1rem 0;
	}

	.popup-auth-prompt p {
		color: var(--color-text-muted);
		margin: 0 0 1rem;
	}

	.popup-auth-prompt .small {
		font-size: 0.85rem;
		margin-top: 1rem;
	}

	.popup-tabs {
		display: flex;
		gap: 0;
		border-bottom: 1px solid var(--color-border-light);
		margin-bottom: 1rem;
	}

	.tab {
		flex: 1;
		background: none;
		border: none;
		padding: 0.6rem 0.5rem;
		font-size: 0.85rem;
		color: var(--color-text-muted);
		border-bottom: 2px solid transparent;
		transition: color 0.15s, border-color 0.15s;
	}

	.tab:hover {
		color: var(--color-text);
	}

	.tab.active {
		color: var(--color-accent);
		border-bottom-color: var(--color-accent);
		font-weight: 500;
	}

	form {
		display: flex;
		flex-direction: column;
		gap: 0.75rem;
	}

	.original-text {
		background: var(--color-accent-light);
		border-radius: var(--radius);
		padding: 0.75rem;
	}

	.original-text blockquote {
		margin: 0.3rem 0 0;
		font-family: var(--font-serif);
		font-size: 0.9rem;
		line-height: 1.5;
		color: var(--color-text);
	}

	.label {
		display: block;
		font-size: 0.8rem;
		font-weight: 500;
		color: var(--color-text-muted);
		text-transform: uppercase;
		letter-spacing: 0.03em;
	}

	.optional {
		font-weight: 400;
		text-transform: none;
	}

	.field {
		display: flex;
		flex-direction: column;
		gap: 0.3rem;
	}

	.field textarea {
		padding: 0.6rem 0.75rem;
		border: 1px solid var(--color-border);
		border-radius: var(--radius);
		font-size: 0.9rem;
		font-family: var(--font-serif);
		background: var(--color-bg);
		color: var(--color-text);
		resize: vertical;
		transition: border-color 0.15s;
	}

	.field textarea:focus {
		outline: none;
		border-color: var(--color-accent);
		box-shadow: 0 0 0 2px rgba(124, 94, 60, 0.15);
	}

	.popup-error {
		background: #fef2f2;
		color: var(--color-danger);
		border: 1px solid #fecaca;
		border-radius: var(--radius);
		padding: 0.6rem;
		font-size: 0.85rem;
	}

	.popup-actions {
		display: flex;
		gap: 0.75rem;
		justify-content: flex-end;
		margin-top: 0.25rem;
	}

	.btn-primary {
		padding: 0.55rem 1rem;
		background: var(--color-accent);
		color: white;
		border: none;
		border-radius: var(--radius);
		font-size: 0.85rem;
		font-weight: 500;
		text-decoration: none;
		display: inline-block;
		text-align: center;
		transition: background 0.15s;
	}

	.btn-primary:hover:not(:disabled) {
		background: var(--color-accent-hover);
	}

	.btn-primary:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}

	.btn-secondary {
		padding: 0.55rem 1rem;
		background: none;
		color: var(--color-text-muted);
		border: 1px solid var(--color-border);
		border-radius: var(--radius);
		font-size: 0.85rem;
		transition: border-color 0.15s, color 0.15s;
	}

	.btn-secondary:hover {
		border-color: var(--color-border);
		color: var(--color-text);
	}

	@media (max-width: 600px) {
		.popup {
			max-width: 100%;
			padding: 1rem;
		}
	}
</style>
