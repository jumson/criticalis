import { json, error } from '@sveltejs/kit';
import { db } from '$lib/server/db';
import { correction } from '$lib/server/schema';
import { eq } from 'drizzle-orm';
import type { RequestHandler } from './$types';

export const POST: RequestHandler = async ({ request, params, locals }) => {
	if (!locals.user) {
		error(401, 'Authentication required');
	}

	if (locals.user.role !== 'curator' && locals.user.role !== 'admin') {
		error(403, 'Only curators can review corrections');
	}

	const correctionId = parseInt(params.id);
	if (isNaN(correctionId)) {
		error(400, 'Invalid correction ID');
	}

	const body = await request.json();
	const { action, reviewNote } = body;

	if (!action || !['approve', 'reject', 'request_changes'].includes(action)) {
		error(400, 'Action must be "approve", "reject", or "request_changes"');
	}

	// Verify the correction exists
	const [existing] = await db
		.select()
		.from(correction)
		.where(eq(correction.id, correctionId))
		.limit(1);

	if (!existing) {
		error(404, 'Correction not found');
	}

	const statusMap: Record<string, string> = {
		approve: 'approved',
		reject: 'rejected',
		request_changes: 'under_review'
	};

	const [updated] = await db
		.update(correction)
		.set({
			status: statusMap[action] as any,
			reviewedBy: locals.user.id,
			reviewNote: reviewNote || null,
			updatedAt: new Date()
		})
		.where(eq(correction.id, correctionId))
		.returning();

	return json(updated);
};
