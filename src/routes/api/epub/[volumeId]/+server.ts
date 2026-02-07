import { error } from '@sveltejs/kit';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { getVolumeById } from '$lib/data/volumes';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ params }) => {
	const volume = getVolumeById(params.volumeId);
	if (!volume) {
		error(404, 'Volume not found');
	}

	const sourcesDir = process.env.SOURCES_PATH || join(process.cwd(), 'sources');
	const epubPath = join(sourcesDir, volume.filename);

	try {
		const fileBuffer = await readFile(epubPath);
		return new Response(fileBuffer, {
			headers: {
				'Content-Type': 'application/epub+zip',
				'Content-Disposition': `inline; filename="${volume.filename}"`,
				'Cache-Control': 'public, max-age=86400'
			}
		});
	} catch {
		error(500, 'Could not read ePub file');
	}
};
