import type { Handle } from '@sveltejs/kit';
import { auth } from '$lib/server/auth';

export const handle: Handle = async ({ event, resolve }) => {
	// Resolve auth session from cookies
	const session = await auth.api.getSession({
		headers: event.request.headers
	});

	event.locals.user = session?.user ?? null;
	event.locals.session = session?.session ?? null;

	const response = await resolve(event);

	// Content Security Policy for foliate-js:
	// Allow blob: URLs for ePub content rendering, but block external scripts.
	response.headers.set(
		'Content-Security-Policy',
		[
			"default-src 'self' blob:",
			"script-src 'self'",
			"style-src 'self' blob: 'unsafe-inline'",
			"img-src 'self' blob: data:",
			"connect-src 'self' blob: data:",
			"frame-src blob: data:",
			"object-src blob: data:",
			"form-action 'self'"
		].join('; ')
	);

	return response;
};
