export interface Volume {
	id: string;
	number: number;
	roman: string;
	title: string;
	subtitle: string;
	filename: string;
	pdfFilename: string;
	psalms: string;
}

export const volumes: Volume[] = [
	{
		id: 'vol-1',
		number: 1,
		roman: 'I',
		title: 'The Treasury of David',
		subtitle: 'Volume I',
		filename: 'The_Treasury_of_David-I.epub',
		pdfFilename: 'The_Treasury_of_David-I.pdf',
		psalms: 'Psalms 1\u201326'
	},
	{
		id: 'vol-2',
		number: 2,
		roman: 'II',
		title: 'The Treasury of David',
		subtitle: 'Volume II',
		filename: 'The_Treasury_of_David-II.epub',
		pdfFilename: 'The_Treasury_of_David-II.pdf',
		psalms: 'Psalms 27\u201352'
	},
	{
		id: 'vol-3',
		number: 3,
		roman: 'III',
		title: 'The Treasury of David',
		subtitle: 'Volume III',
		filename: 'The_Treasury_of_David-III.epub',
		pdfFilename: 'The_Treasury_of_David-III.pdf',
		psalms: 'Psalms 53\u201378'
	},
	{
		id: 'vol-4',
		number: 4,
		roman: 'IV',
		title: 'The Treasury of David',
		subtitle: 'Volume IV',
		filename: 'The_Treasury_of_David-IV.epub',
		pdfFilename: 'The_Treasury_of_David-IV.pdf',
		psalms: 'Psalms 79\u2013103'
	},
	{
		id: 'vol-5',
		number: 5,
		roman: 'V',
		title: 'The Treasury of David',
		subtitle: 'Volume V',
		filename: 'The_Treasury_of_David-V.epub',
		pdfFilename: 'The_Treasury_of_David-V.pdf',
		psalms: 'Psalms 104\u2013118'
	},
	{
		id: 'vol-6',
		number: 6,
		roman: 'VI',
		title: 'The Treasury of David',
		subtitle: 'Volume VI',
		filename: 'The_Treasury_of_David-VI.epub',
		pdfFilename: 'The_Treasury_of_David-VI.pdf',
		psalms: 'Psalms 119\u2013124'
	},
	{
		id: 'vol-7',
		number: 7,
		roman: 'VII',
		title: 'The Treasury of David',
		subtitle: 'Volume VII',
		filename: 'The_Treasury_of_David-VII.epub',
		pdfFilename: 'The_Treasury_of_David-VII.pdf',
		psalms: 'Psalms 125\u2013150'
	}
];

export function getVolumeById(id: string): Volume | undefined {
	return volumes.find((v) => v.id === id);
}

export function getVolumeByNumber(num: number): Volume | undefined {
	return volumes.find((v) => v.number === num);
}
