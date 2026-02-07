import { json, error } from '@sveltejs/kit';
import { db } from '$lib/server/db';
import { correction } from '$lib/server/schema';
import { eq, and, desc } from 'drizzle-orm';
import { getVolumeById } from '$lib/data/volumes';
import type { RequestHandler } from './$types';

export const POST: RequestHandler = async ({ request, locals }) => {
	if (!locals.user) {
		error(401, 'You must be signed in to submit corrections.');
	}

	const body = await request.json();
	const { volumeId, sectionIndex, cfi, originalText, proposedText, explanation, type } = body;

	// Validate required fields
	if (!volumeId || !originalText || !proposedText) {
		error(400, 'Missing required fields: volumeId, originalText, proposedText');
	}

	if (!getVolumeById(volumeId)) {
		error(400, 'Invalid volume ID');
	}

	if (type && type !== 'fix' && type !== 'footnote') {
		error(400, 'Type must be "fix" or "footnote"');
	}

	const [result] = await db.insert(correction).values({
		volumeId,
		sectionIndex: sectionIndex ?? null,
		cfi: cfi ?? null,
		originalText: originalText.trim(),
		proposedText: proposedText.trim(),
		explanation: explanation?.trim() || null,
		type: type || 'fix',
		submittedBy: locals.user.id
	}).returning();

	return json(result, { status: 201 });
};

export const GET: RequestHandler = async ({ url }) => {
	const volumeId = url.searchParams.get('volumeId');
	const status = url.searchParams.get('status');
	const limit = Math.min(parseInt(url.searchParams.get('limit') ?? '50'), 100);
	const offset = parseInt(url.searchParams.get('offset') ?? '0');

	const conditions = [];
	if (volumeId) {
		conditions.push(eq(correction.volumeId, volumeId));
	}
	if (status) {
		conditions.push(eq(correction.status, status as any));
	}

	const where = conditions.length > 0 ? and(...conditions) : undefined;

	const corrections = await db
		.select()
		.from(correction)
		.where(where)
		.orderBy(desc(correction.createdAt))
		.limit(limit)
		.offset(offset);

	return json(corrections);
};
