<script lang="ts">
	import '../app.css';

	let { children } = $props();
</script>

<svelte:head>
	<title>Criticalis</title>
</svelte:head>

<header class="site-header">
	<div class="container header-inner">
		<a href="/" class="logo">
			<span class="logo-text">Criticalis</span>
		</a>
		<nav class="nav">
			<a href="/">Volumes</a>
			<a href="/about">About</a>
		</nav>
	</div>
</header>

<main>
	{@render children()}
</main>

<footer class="site-footer">
	<div class="container">
		<p>
			Improving public domain works through community collaboration.
		</p>
	</div>
</footer>

<style>
	.site-header {
		background: var(--color-bg-elevated);
		border-bottom: 1px solid var(--color-border);
		position: sticky;
		top: 0;
		z-index: 100;
	}

	.header-inner {
		display: flex;
		align-items: center;
		justify-content: space-between;
		height: 56px;
	}

	.logo {
		text-decoration: none;
	}

	.logo:hover {
		text-decoration: none;
	}

	.logo-text {
		font-family: var(--font-serif);
		font-size: 1.3rem;
		font-weight: 700;
		color: var(--color-text);
		letter-spacing: -0.02em;
	}

	.nav {
		display: flex;
		gap: 1.5rem;
	}

	.nav a {
		font-size: 0.9rem;
		color: var(--color-text-muted);
		text-decoration: none;
	}

	.nav a:hover {
		color: var(--color-text);
		text-decoration: none;
	}

	main {
		min-height: calc(100vh - 56px - 80px);
	}

	.site-footer {
		border-top: 1px solid var(--color-border-light);
		padding: 1.5rem 0;
		text-align: center;
	}

	.site-footer p {
		margin: 0;
		font-size: 0.85rem;
		color: var(--color-text-faint);
	}

	@media (max-width: 600px) {
		.header-inner {
			height: 48px;
		}

		.logo-text {
			font-size: 1.1rem;
		}

		.nav {
			gap: 1rem;
		}

		.nav a {
			font-size: 0.85rem;
		}

		main {
			min-height: calc(100vh - 48px - 72px);
		}

		.site-footer {
			padding: 1rem 0;
		}

		.site-footer p {
			font-size: 0.8rem;
		}
	}
</style>
