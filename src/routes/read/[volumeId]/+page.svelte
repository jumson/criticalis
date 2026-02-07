<script lang="ts">
	import { onMount } from 'svelte';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();

	let readerContainer: HTMLElement;
	let tocItems: Array<{ label: string; href: string; subitems?: any[] }> = $state([]);
	let currentLocation: string = $state('');
	let progress: number = $state(0);
	let loading: boolean = $state(true);
	let errorMessage: string = $state('');
	let showToc: boolean = $state(false);
	let view: any = $state(null);
	let hasBookmark: boolean = $state(false);
	let lastCfi: string = $state('');

	const bookmarkKey = `criticalis-bookmark-${data.volume.id}`;

	function saveBookmark() {
		if (lastCfi) {
			localStorage.setItem(bookmarkKey, JSON.stringify({
				cfi: lastCfi,
				location: currentLocation,
				progress,
				savedAt: Date.now()
			}));
			hasBookmark = true;
		}
	}

	function getSavedBookmark(): { cfi: string; location: string; progress: number } | null {
		try {
			const raw = localStorage.getItem(bookmarkKey);
			if (raw) return JSON.parse(raw);
		} catch { /* ignore */ }
		return null;
	}

	function clearBookmark() {
		localStorage.removeItem(bookmarkKey);
		hasBookmark = false;
	}

	onMount(async () => {
		hasBookmark = !!getSavedBookmark();

		try {
			// Dynamic import of foliate-js view module (registers <foliate-view> custom element)
			// Loaded from static/ so Vite doesn't process it — foliate-js uses native ES modules
			// @ts-ignore — runtime import from static dir, not a module TS can resolve
			await import('/foliate-js/view.js');

			// foliate-view is a custom element with methods not on HTMLElement
			// eslint-disable-next-line @typescript-eslint/no-explicit-any
			const el = document.createElement('foliate-view') as any;
			readerContainer.appendChild(el);
			view = el;

			// Style the reader to fill its container
			el.style.width = '100%';
			el.style.height = '100%';

			// Listen for location changes
			el.addEventListener('relocate', (e: Event) => {
				const detail = (e as CustomEvent).detail;
				if (detail.tocItem) {
					currentLocation = detail.tocItem.label ?? '';
				}
				if (detail.fraction != null) {
					progress = Math.round(detail.fraction * 100);
				}
				if (detail.cfi) {
					lastCfi = detail.cfi;
				}
			});

			// Listen for section loads to capture text selection
			el.addEventListener('load', (e: Event) => {
				const { doc } = (e as CustomEvent).detail;
				doc.addEventListener('mouseup', () => {
					const selection = doc.defaultView?.getSelection();
					if (selection && selection.toString().trim()) {
						handleTextSelection(selection.toString().trim());
					}
				});
			});

			// Fetch and open the ePub
			const epubUrl = `/api/epub/${data.volume.id}`;
			await el.open(epubUrl);

			// Extract TOC
			if (el.book?.toc) {
				tocItems = el.book.toc;
			}

			// Restore saved position or start at the beginning
			const saved = getSavedBookmark();
			if (saved?.cfi) {
				await el.init({ lastLocation: saved.cfi });
			} else {
				await el.init({ showTextStart: true });
			}
			loading = false;
		} catch (err) {
			console.error('Failed to load ePub:', err);
			errorMessage = err instanceof Error ? err.message : 'Failed to load book';
			loading = false;
		}
	});

	function handleTextSelection(text: string) {
		// For now, just log it — this is the hook for Phase 2 corrections
		console.log('Selected text:', text);
	}

	function goToTocItem(href: string) {
		if (view) {
			view.goTo(href);
			showToc = false;
		}
	}

	function goPrev() {
		view?.prev();
	}

	function goNext() {
		view?.next();
	}

	function handleKeydown(e: KeyboardEvent) {
		if (e.key === 'ArrowLeft') goPrev();
		else if (e.key === 'ArrowRight') goNext();
	}
</script>

<svelte:head>
	<title>{data.volume.subtitle} — The Treasury of David - Criticalis</title>
	<meta name="description" content="Read The Treasury of David {data.volume.subtitle} ({data.volume.psalms}) by C. H. Spurgeon. Community-corrected edition." />
	<meta property="og:title" content="{data.volume.subtitle} — The Treasury of David" />
	<meta property="og:description" content="Read {data.volume.psalms} from The Treasury of David by C. H. Spurgeon." />
	<meta property="og:type" content="book" />
	<meta property="og:site_name" content="Criticalis" />
	{@html `<script type="application/ld+json">${JSON.stringify({
		"@context": "https://schema.org",
		"@type": "Book",
		"name": `The Treasury of David — ${data.volume.subtitle}`,
		"author": { "@type": "Person", "name": "Charles Haddon Spurgeon" },
		"bookFormat": "EBook",
		"numberOfPages": 0,
		"description": `${data.volume.psalms} — A commentary on the Book of Psalms`
	})}</script>`}
</svelte:head>

<svelte:window onkeydown={handleKeydown} />

<div class="reader-layout">
	<!-- Sidebar TOC -->
	<aside class="toc-sidebar" class:open={showToc}>
		<div class="toc-header">
			<h3>Table of Contents</h3>
			<button class="close-btn" onclick={() => (showToc = false)} aria-label="Close table of contents">
				<svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true">
					<path d="M5 5l10 10M15 5l-10 10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
				</svg>
			</button>
		</div>
		<nav class="toc-list">
			{#each tocItems as item}
				<button class="toc-item" onclick={() => goToTocItem(item.href)}>
					{item.label}
				</button>
				{#if item.subitems}
					{#each item.subitems as sub}
						<button class="toc-item toc-subitem" onclick={() => goToTocItem(sub.href)}>
							{sub.label}
						</button>
					{/each}
				{/if}
			{/each}
		</nav>
	</aside>

	<!-- Main reader area -->
	<div class="reader-main">
		<!-- Top bar -->
		<div class="reader-toolbar">
			<button class="toolbar-btn" onclick={() => (showToc = !showToc)} title="Table of Contents">
				<svg width="20" height="20" viewBox="0 0 20 20" fill="none">
					<path d="M3 5h14M3 10h14M3 15h14" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
				</svg>
			</button>
			<div class="toolbar-title">
				<span class="toolbar-volume">{data.volume.subtitle}</span>
				{#if currentLocation}
					<span class="toolbar-sep">/</span>
					<span class="toolbar-location">{currentLocation}</span>
				{/if}
			</div>
			<button
				class="toolbar-btn bookmark-btn"
				class:active={hasBookmark}
				onclick={() => hasBookmark ? clearBookmark() : saveBookmark()}
				title={hasBookmark ? 'Remove bookmark' : 'Bookmark this page'}
			>
				<svg width="20" height="20" viewBox="0 0 20 20" fill={hasBookmark ? 'currentColor' : 'none'}>
					<path d="M5 3h10v14l-5-3-5 3V3z" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/>
				</svg>
			</button>
			<a href="/" class="toolbar-btn" title="Back to volumes">
				<svg width="20" height="20" viewBox="0 0 20 20" fill="none">
					<path d="M5 10h10M5 10l4-4M5 10l4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
			</a>
		</div>

		<!-- Book content -->
		<div class="reader-content" bind:this={readerContainer}>
			{#if loading}
				<div class="reader-loading">
					<p>Loading {data.volume.subtitle}...</p>
				</div>
			{/if}
			{#if errorMessage}
				<div class="reader-error">
					<p>Error: {errorMessage}</p>
					<a href="/">Back to volumes</a>
				</div>
			{/if}
		</div>

		<!-- Bottom bar -->
		<div class="reader-nav">
			<button class="nav-btn" onclick={goPrev} title="Previous page">
				<svg width="20" height="20" viewBox="0 0 20 20" fill="none">
					<path d="M12 4l-6 6 6 6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
			</button>
			<div class="progress-bar">
				<div class="progress-fill" style="width: {progress}%"></div>
			</div>
			<span class="progress-text">{progress}%</span>
			<button class="nav-btn" onclick={goNext} title="Next page">
				<svg width="20" height="20" viewBox="0 0 20 20" fill="none">
					<path d="M8 4l6 6-6 6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
			</button>
		</div>
	</div>
</div>

<style>
	.reader-layout {
		display: flex;
		height: calc(100vh - 56px);
		overflow: hidden;
		position: relative;
	}

	/* Sidebar TOC */
	.toc-sidebar {
		position: absolute;
		left: 0;
		top: 0;
		bottom: 0;
		width: 300px;
		background: var(--color-bg-elevated);
		border-right: 1px solid var(--color-border);
		z-index: 50;
		transform: translateX(-100%);
		transition: transform 0.25s ease;
		display: flex;
		flex-direction: column;
		box-shadow: var(--shadow-lg);
	}

	.toc-sidebar.open {
		transform: translateX(0);
	}

	.toc-header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0.75rem 1rem;
		border-bottom: 1px solid var(--color-border-light);
	}

	.toc-header h3 {
		font-size: 0.9rem;
		font-family: var(--font-sans);
		font-weight: 600;
	}

	.close-btn {
		background: none;
		border: none;
		color: var(--color-text-muted);
		padding: 4px;
		border-radius: 4px;
	}

	.close-btn:hover {
		background: var(--color-accent-light);
	}

	.toc-list {
		overflow-y: auto;
		padding: 0.5rem;
		flex: 1;
	}

	.toc-item {
		display: block;
		width: 100%;
		text-align: left;
		background: none;
		border: none;
		padding: 0.5rem 0.75rem;
		border-radius: var(--radius);
		font-size: 0.85rem;
		color: var(--color-text);
		line-height: 1.4;
	}

	.toc-item:hover {
		background: var(--color-accent-light);
	}

	.toc-subitem {
		padding-left: 1.5rem;
		color: var(--color-text-muted);
		font-size: 0.8rem;
	}

	/* Main reader */
	.reader-main {
		flex: 1;
		display: flex;
		flex-direction: column;
		min-width: 0;
	}

	.reader-toolbar {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		padding: 0.5rem 1rem;
		border-bottom: 1px solid var(--color-border-light);
		background: var(--color-bg-elevated);
	}

	.toolbar-btn {
		display: flex;
		align-items: center;
		justify-content: center;
		background: none;
		border: none;
		color: var(--color-text-muted);
		padding: 6px;
		border-radius: var(--radius);
		text-decoration: none;
	}

	.toolbar-btn:hover {
		background: var(--color-accent-light);
		color: var(--color-text);
		text-decoration: none;
	}

	.bookmark-btn.active {
		color: var(--color-accent);
	}

	.toolbar-title {
		flex: 1;
		display: flex;
		align-items: center;
		gap: 0.5rem;
		font-size: 0.85rem;
		overflow: hidden;
	}

	.toolbar-volume {
		font-weight: 600;
		white-space: nowrap;
	}

	.toolbar-sep {
		color: var(--color-text-faint);
	}

	.toolbar-location {
		color: var(--color-text-muted);
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.reader-content {
		flex: 1;
		position: relative;
		overflow: hidden;
		background: white;
	}

	.reader-loading,
	.reader-error {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: 100%;
		color: var(--color-text-muted);
		gap: 1rem;
	}

	.reader-error p {
		color: var(--color-danger);
	}

	/* Bottom nav */
	.reader-nav {
		display: flex;
		align-items: center;
		gap: 0.75rem;
		padding: 0.5rem 1rem;
		border-top: 1px solid var(--color-border-light);
		background: var(--color-bg-elevated);
	}

	.nav-btn {
		display: flex;
		align-items: center;
		justify-content: center;
		background: none;
		border: none;
		color: var(--color-text-muted);
		padding: 6px;
		border-radius: var(--radius);
	}

	.nav-btn:hover {
		background: var(--color-accent-light);
		color: var(--color-text);
	}

	.progress-bar {
		flex: 1;
		height: 4px;
		background: var(--color-border-light);
		border-radius: 2px;
		overflow: hidden;
	}

	.progress-fill {
		height: 100%;
		background: var(--color-accent);
		border-radius: 2px;
		transition: width 0.3s ease;
	}

	.progress-text {
		font-size: 0.75rem;
		color: var(--color-text-faint);
		min-width: 2.5rem;
		text-align: right;
	}

	@media (max-width: 600px) {
		.reader-layout {
			height: calc(100vh - 48px);
		}

		.toc-sidebar {
			width: 100%;
		}

		.reader-toolbar {
			padding: 0.4rem 0.5rem;
			gap: 0.25rem;
		}

		.toolbar-title {
			font-size: 0.8rem;
		}

		.toolbar-volume {
			max-width: 120px;
			overflow: hidden;
			text-overflow: ellipsis;
		}

		.reader-nav {
			padding: 0.4rem 0.5rem;
			gap: 0.5rem;
		}

		.progress-text {
			font-size: 0.7rem;
			min-width: 2rem;
		}
	}
</style>
