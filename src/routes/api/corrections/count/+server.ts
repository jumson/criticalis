import { json } from '@sveltejs/kit';
import { db } from '$lib/server/db';
import { correction } from '$lib/server/schema';
import { eq, and, sql } from 'drizzle-orm';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ url }) => {
	const volumeId = url.searchParams.get('volumeId');

	if (!volumeId) {
		return json({ total: 0, pending: 0, approved: 0 });
	}

	const counts = await db
		.select({
			status: correction.status,
			count: sql<number>`count(*)::int`
		})
		.from(correction)
		.where(eq(correction.volumeId, volumeId))
		.groupBy(correction.status);

	const result: Record<string, number> = { total: 0, pending: 0, approved: 0 };
	for (const row of counts) {
		result[row.status] = row.count;
		result.total += row.count;
	}

	return json(result);
};
