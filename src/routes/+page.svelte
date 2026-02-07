<script lang="ts">
	import { volumes } from '$lib/data/volumes';
</script>

<svelte:head>
	<title>Criticalis - The Treasury of David by C. H. Spurgeon</title>
	<meta name="description" content="Read and help correct The Treasury of David by C. H. Spurgeon — a seven-volume exposition on the Book of Psalms. Community-driven OCR correction and annotation." />
	<meta property="og:title" content="Criticalis - The Treasury of David" />
	<meta property="og:description" content="A community effort to correct and annotate this classic seven-volume exposition on the Book of Psalms." />
	<meta property="og:type" content="website" />
	<meta property="og:site_name" content="Criticalis" />
	<meta name="twitter:card" content="summary" />
	<meta name="twitter:title" content="Criticalis - The Treasury of David" />
	<meta name="twitter:description" content="Community-driven correction and annotation of The Treasury of David by C. H. Spurgeon." />
	{@html `<script type="application/ld+json">${JSON.stringify({
		"@context": "https://schema.org",
		"@type": "CollectionPage",
		"name": "The Treasury of David",
		"author": { "@type": "Person", "name": "Charles Haddon Spurgeon" },
		"description": "A seven-volume exposition and commentary on the Book of Psalms",
		"numberOfItems": 7,
		"isPartOf": {
			"@type": "WebSite",
			"name": "Criticalis",
			"description": "Collaborative correction and annotation of public domain works"
		}
	})}</script>`}
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
				<div class="volume-cover">
					<div class="cover-spine"></div>
					<div class="cover-front">
						<span class="cover-ornament">&#x2766;</span>
						<span class="cover-title">Treasury<br/>of David</span>
						<span class="cover-roman">{volume.roman}</span>
						<span class="cover-author">Spurgeon</span>
					</div>
				</div>
				<div class="volume-info">
					<h3>{volume.subtitle}</h3>
					<p class="volume-psalms">{volume.psalms}</p>
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
		margin-bottom: 1.25rem;
		padding-bottom: 0.5rem;
		border-bottom: 1px solid var(--color-border-light);
	}

	.volumes-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
		gap: 1.25rem;
		padding-bottom: 3rem;
	}

	.volume-card {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 0.75rem;
		padding: 1rem;
		background: var(--color-bg-elevated);
		border: 1px solid var(--color-border-light);
		border-radius: var(--radius-lg);
		text-decoration: none;
		color: inherit;
		transition: border-color 0.15s, box-shadow 0.15s, transform 0.15s;
	}

	.volume-card:hover {
		border-color: var(--color-border);
		box-shadow: var(--shadow-md);
		text-decoration: none;
		color: inherit;
		transform: translateY(-2px);
	}

	.volume-cover {
		width: 100px;
		height: 140px;
		display: flex;
		border-radius: 2px 4px 4px 2px;
		box-shadow: var(--shadow-sm), 2px 2px 6px rgba(0, 0, 0, 0.12);
		overflow: hidden;
		flex-shrink: 0;
	}

	.cover-spine {
		width: 8px;
		background: #5c4229;
		flex-shrink: 0;
	}

	.cover-front {
		flex: 1;
		background: linear-gradient(135deg, #7c5e3c 0%, #5c4229 100%);
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		gap: 0.25rem;
		padding: 0.5rem;
		color: #f0e8dc;
		border-left: 1px solid rgba(255, 255, 255, 0.1);
	}

	.cover-ornament {
		font-size: 1rem;
		opacity: 0.6;
		line-height: 1;
	}

	.cover-title {
		font-family: var(--font-serif);
		font-size: 0.65rem;
		text-align: center;
		line-height: 1.3;
		letter-spacing: 0.02em;
	}

	.cover-roman {
		font-family: var(--font-serif);
		font-size: 1.4rem;
		font-weight: 700;
		line-height: 1;
	}

	.cover-author {
		font-size: 0.55rem;
		text-transform: uppercase;
		letter-spacing: 0.1em;
		opacity: 0.7;
	}

	.volume-info {
		text-align: center;
	}

	.volume-info h3 {
		font-size: 0.95rem;
		font-family: var(--font-sans);
		font-weight: 600;
	}

	.volume-psalms {
		margin: 0.15rem 0 0;
		font-size: 0.8rem;
		color: var(--color-text-muted);
	}

	@media (max-width: 600px) {
		.hero {
			padding: 2rem 1rem 1.5rem;
		}

		.hero h1 {
			font-size: 1.6rem;
		}

		.subtitle {
			font-size: 1rem;
		}

		.description {
			font-size: 0.9rem;
		}

		.volumes-grid {
			grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
			gap: 1rem;
		}

		.volume-card {
			padding: 0.75rem;
		}

		.volume-cover {
			width: 88px;
			height: 124px;
		}

		.volume-info h3 {
			font-size: 0.85rem;
		}

		.volume-psalms {
			font-size: 0.75rem;
		}
	}
</style>
