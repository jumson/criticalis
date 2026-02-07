<script lang="ts">
	import { volumes } from '$lib/data/volumes';
</script>

<svelte:head>
	<title>Criticalis - The Treasury of David</title>
</svelte:head>

<div class="container hero">
	<h1>The Treasury of David</h1>
	<p class="subtitle">by C. H. Spurgeon</p>
	<p class="description">
		A community effort to correct and annotate this classic seven-volume exposition
		on the Book of Psalms. Help improve the OCR-generated text and add explanatory
		footnotes for modern readers.
	</p>
</div>

<div class="container">
	<h2 class="section-title">Volumes</h2>
	<div class="volumes-grid">
		{#each volumes as volume}
			<a href="/read/{volume.id}" class="volume-card">
				<div class="volume-number">{volume.roman}</div>
				<div class="volume-info">
					<h3>{volume.subtitle}</h3>
					<p class="volume-psalms">{volume.psalms}</p>
				</div>
				<div class="volume-arrow">
					<svg width="20" height="20" viewBox="0 0 20 20" fill="none">
						<path d="M7 4l6 6-6 6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</div>
			</a>
		{/each}
	</div>
</div>

<style>
	.hero {
		text-align: center;
		padding: 3rem 1.5rem 2rem;
	}

	.hero h1 {
		font-size: 2.2rem;
		color: var(--color-text);
		margin-bottom: 0.25rem;
	}

	.subtitle {
		font-family: var(--font-serif);
		font-style: italic;
		color: var(--color-text-muted);
		font-size: 1.1rem;
		margin: 0.25rem 0 1rem;
	}

	.description {
		max-width: 540px;
		margin: 0 auto;
		color: var(--color-text-muted);
		font-size: 0.95rem;
		line-height: 1.7;
	}

	.section-title {
		font-size: 1.2rem;
		margin-bottom: 1rem;
		padding-bottom: 0.5rem;
		border-bottom: 1px solid var(--color-border-light);
	}

	.volumes-grid {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
		padding-bottom: 3rem;
	}

	.volume-card {
		display: flex;
		align-items: center;
		gap: 1rem;
		padding: 1rem 1.25rem;
		background: var(--color-bg-elevated);
		border: 1px solid var(--color-border-light);
		border-radius: var(--radius-lg);
		text-decoration: none;
		color: inherit;
		transition: border-color 0.15s, box-shadow 0.15s;
	}

	.volume-card:hover {
		border-color: var(--color-border);
		box-shadow: var(--shadow-sm);
		text-decoration: none;
		color: inherit;
	}

	.volume-number {
		font-family: var(--font-serif);
		font-size: 1.4rem;
		font-weight: 700;
		color: var(--color-accent);
		min-width: 2.5rem;
		text-align: center;
	}

	.volume-info {
		flex: 1;
	}

	.volume-info h3 {
		font-size: 1rem;
		font-family: var(--font-sans);
		font-weight: 600;
	}

	.volume-psalms {
		margin: 0.15rem 0 0;
		font-size: 0.85rem;
		color: var(--color-text-muted);
	}

	.volume-arrow {
		color: var(--color-text-faint);
	}
</style>
