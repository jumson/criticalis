import {
	pgTable,
	text,
	integer,
	timestamp,
	boolean,
	serial,
	varchar,
	pgEnum,
	uniqueIndex
} from 'drizzle-orm/pg-core';

// --- Enums ---

export const userRoleEnum = pgEnum('user_role', ['contributor', 'curator', 'admin']);

export const correctionStatusEnum = pgEnum('correction_status', [
	'pending',
	'under_review',
	'approved',
	'rejected'
]);

export const correctionTypeEnum = pgEnum('correction_type', ['fix', 'footnote']);

// --- Auth tables (managed by Better Auth, defined here for Drizzle awareness) ---

export const user = pgTable('user', {
	id: text('id').primaryKey(),
	name: text('name').notNull(),
	email: text('email').notNull().unique(),
	emailVerified: boolean('email_verified').notNull().default(false),
	image: text('image'),
	role: userRoleEnum('role').notNull().default('contributor'),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	updatedAt: timestamp('updated_at').notNull().defaultNow()
});

export const session = pgTable('session', {
	id: text('id').primaryKey(),
	expiresAt: timestamp('expires_at').notNull(),
	token: text('token').notNull().unique(),
	ipAddress: text('ip_address'),
	userAgent: text('user_agent'),
	userId: text('user_id')
		.notNull()
		.references(() => user.id, { onDelete: 'cascade' })
});

export const account = pgTable('account', {
	id: text('id').primaryKey(),
	accountId: text('account_id').notNull(),
	providerId: text('provider_id').notNull(),
	userId: text('user_id')
		.notNull()
		.references(() => user.id, { onDelete: 'cascade' }),
	accessToken: text('access_token'),
	refreshToken: text('refresh_token'),
	idToken: text('id_token'),
	accessTokenExpiresAt: timestamp('access_token_expires_at'),
	refreshTokenExpiresAt: timestamp('refresh_token_expires_at'),
	scope: text('scope'),
	password: text('password'),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	updatedAt: timestamp('updated_at').notNull().defaultNow()
});

export const verification = pgTable('verification', {
	id: text('id').primaryKey(),
	identifier: text('identifier').notNull(),
	value: text('value').notNull(),
	expiresAt: timestamp('expires_at').notNull(),
	createdAt: timestamp('created_at'),
	updatedAt: timestamp('updated_at')
});

// --- Application tables ---

export const correction = pgTable('correction', {
	id: serial('id').primaryKey(),
	volumeId: varchar('volume_id', { length: 16 }).notNull(),
	sectionIndex: integer('section_index'),
	cfi: text('cfi'),
	originalText: text('original_text').notNull(),
	proposedText: text('proposed_text').notNull(),
	explanation: text('explanation'),
	type: correctionTypeEnum('type').notNull().default('fix'),
	status: correctionStatusEnum('status').notNull().default('pending'),
	submittedBy: text('submitted_by')
		.notNull()
		.references(() => user.id, { onDelete: 'cascade' }),
	reviewedBy: text('reviewed_by').references(() => user.id),
	reviewNote: text('review_note'),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	updatedAt: timestamp('updated_at').notNull().defaultNow()
});

export const vote = pgTable('vote', {
	id: serial('id').primaryKey(),
	correctionId: integer('correction_id')
		.notNull()
		.references(() => correction.id, { onDelete: 'cascade' }),
	userId: text('user_id')
		.notNull()
		.references(() => user.id, { onDelete: 'cascade' }),
	value: integer('value').notNull(), // +1 or -1
	createdAt: timestamp('created_at').notNull().defaultNow()
}, (table) => [
	uniqueIndex('vote_user_correction_idx').on(table.userId, table.correctionId)
]);

export const comment = pgTable('comment', {
	id: serial('id').primaryKey(),
	correctionId: integer('correction_id')
		.notNull()
		.references(() => correction.id, { onDelete: 'cascade' }),
	parentId: integer('parent_id'),
	userId: text('user_id')
		.notNull()
		.references(() => user.id, { onDelete: 'cascade' }),
	body: text('body').notNull(),
	createdAt: timestamp('created_at').notNull().defaultNow(),
	updatedAt: timestamp('updated_at').notNull().defaultNow()
});
