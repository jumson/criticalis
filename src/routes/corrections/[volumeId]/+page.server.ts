import { error } from '@sveltejs/kit';
import { db } from '$lib/server/db';
import { correction, user } from '$lib/server/schema';
import { eq, and, desc } from 'drizzle-orm';
import { getVolumeById } from '$lib/data/volumes';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ params, url }) => {
	const volume = getVolumeById(params.volumeId);
	if (!volume) {
		error(404, 'Volume not found');
	}

	const statusFilter = url.searchParams.get('status');

	const conditions = [eq(correction.volumeId, params.volumeId)];
	if (statusFilter && ['pending', 'under_review', 'approved', 'rejected'].includes(statusFilter)) {
		conditions.push(eq(correction.status, statusFilter as any));
	}

	const corrections = await db
		.select({
			id: correction.id,
			volumeId: correction.volumeId,
			originalText: correction.originalText,
			proposedText: correction.proposedText,
			explanation: correction.explanation,
			type: correction.type,
			status: correction.status,
			createdAt: correction.createdAt,
			submitterName: user.name
		})
		.from(correction)
		.leftJoin(user, eq(correction.submittedBy, user.id))
		.where(and(...conditions))
		.orderBy(desc(correction.createdAt))
		.limit(100);

	return {
		volume,
		corrections,
		statusFilter
	};
};
