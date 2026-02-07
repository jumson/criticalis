import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit()],
	build: {
		rollupOptions: {
			// foliate-js is served as static files and loaded at runtime in the browser
			external: ['/foliate-js/view.js']
		}
	}
});
