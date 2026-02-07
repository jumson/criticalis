import { error } from '@sveltejs/kit';
import { getVolumeById } from '$lib/data/volumes';
import type { PageLoad } from './$types';

export const load: PageLoad = ({ params }) => {
	const volume = getVolumeById(params.volumeId);
	if (!volume) {
		error(404, 'Volume not found');
	}
	return { volume };
};
