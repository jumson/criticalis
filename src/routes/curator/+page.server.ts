import { error, redirect } from '@sveltejs/kit';
import { db } from '$lib/server/db';
import { correction, user } from '$lib/server/schema';
import { eq, and, desc, sql, inArray } from 'drizzle-orm';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ locals, url }) => {
	if (!locals.user) {
		redirect(302, '/sign-in');
	}

	if (locals.user.role !== 'curator' && locals.user.role !== 'admin') {
		error(403, 'Access restricted to curators');
	}

	const statusFilter = url.searchParams.get('status') ?? 'pending';
	const volumeFilter = url.searchParams.get('volume');

	const conditions = [];
	if (statusFilter && ['pending', 'under_review', 'approved', 'rejected'].includes(statusFilter)) {
		conditions.push(eq(correction.status, statusFilter as any));
	}
	if (volumeFilter) {
		conditions.push(eq(correction.volumeId, volumeFilter));
	}

	const where = conditions.length > 0 ? and(...conditions) : undefined;

	const corrections = await db
		.select({
			id: correction.id,
			volumeId: correction.volumeId,
			sectionIndex: correction.sectionIndex,
			cfi: correction.cfi,
			originalText: correction.originalText,
			proposedText: correction.proposedText,
			explanation: correction.explanation,
			type: correction.type,
			status: correction.status,
			reviewNote: correction.reviewNote,
			createdAt: correction.createdAt,
			updatedAt: correction.updatedAt,
			submitterName: user.name,
			submitterEmail: user.email
		})
		.from(correction)
		.leftJoin(user, eq(correction.submittedBy, user.id))
		.where(where)
		.orderBy(desc(correction.createdAt))
		.limit(100);

	// Get counts per status for the sidebar
	const counts = await db
		.select({
			status: correction.status,
			count: sql<number>`count(*)::int`
		})
		.from(correction)
		.groupBy(correction.status);

	const statusCounts: Record<string, number> = {};
	for (const row of counts) {
		statusCounts[row.status] = row.count;
	}

	return {
		corrections,
		statusFilter,
		volumeFilter,
		statusCounts
	};
};
