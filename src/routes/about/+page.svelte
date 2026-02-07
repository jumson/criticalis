<svelte:head>
	<title>About - Criticalis</title>
	<meta name="description" content="Criticalis is an open-source platform for collaboratively improving public domain works through crowdsourced corrections and annotations." />
	<meta property="og:title" content="About Criticalis" />
	<meta property="og:description" content="An open platform for crowdsourced correction and annotation of public domain texts." />
	<meta property="og:type" content="website" />
</svelte:head>

<div class="container about">
	<h1>About Criticalis</h1>

	<p>
		Criticalis is a platform for collaboratively improving public domain works
		through crowdsourced corrections and annotations.
	</p>

	<h2>The Problem</h2>
	<p>
		When older printed works are digitized using Optical Character Recognition (OCR),
		the resulting text often contains errors &mdash; especially with unusual fonts,
		archaic spellings, and aging print quality. These errors accumulate across hundreds
		of pages, degrading the reading experience.
	</p>
	<p>
		Additionally, many older works contain vocabulary, references, and cultural context
		that modern readers may not immediately understand.
	</p>

	<h2>The Solution</h2>
	<p>
		Criticalis provides a web-based reading experience where community members can:
	</p>
	<ul>
		<li><strong>Submit corrections</strong> to fix OCR errors and typos</li>
		<li><strong>Add footnotes</strong> explaining archaic words and historical context</li>
		<li><strong>Vote and discuss</strong> proposed changes</li>
	</ul>
	<p>
		A curator reviews community submissions and publishes improved editions of the text,
		giving credit to contributors.
	</p>

	<h2>The First Subject</h2>
	<p>
		<em>The Treasury of David</em> by Charles Haddon Spurgeon is a seven-volume
		exposition and commentary on the Book of Psalms, published in the late 19th century.
		The OCR-digitized versions from Google Books contain numerous errors that the
		community can help correct.
	</p>

	<h2>Open Source</h2>
	<p>
		Criticalis is open source. The corrected texts remain in the public domain,
		freely available to everyone.
	</p>
</div>

<style>
	.about {
		max-width: 640px;
		padding-top: 2rem;
		padding-bottom: 3rem;
	}

	.about h1 {
		font-size: 1.8rem;
		margin-bottom: 1rem;
	}

	.about h2 {
		font-size: 1.2rem;
		margin-top: 2rem;
		margin-bottom: 0.5rem;
	}

	.about p {
		color: var(--color-text-muted);
		line-height: 1.8;
		margin: 0.75rem 0;
	}

	.about ul {
		color: var(--color-text-muted);
		line-height: 1.8;
		padding-left: 1.5rem;
	}

	.about li {
		margin: 0.25rem 0;
	}

	@media (max-width: 600px) {
		.about {
			padding-top: 1.5rem;
		}

		.about h1 {
			font-size: 1.4rem;
		}

		.about h2 {
			font-size: 1.1rem;
			margin-top: 1.5rem;
		}

		.about p {
			font-size: 0.9rem;
		}
	}
</style>
