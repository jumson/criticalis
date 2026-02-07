import { betterAuth } from 'better-auth';
import { drizzleAdapter } from 'better-auth/adapters/drizzle';
import { db } from './db';
import * as schema from './schema';

export const auth = betterAuth({
	secret: process.env.BETTER_AUTH_SECRET || 'dev-secret-change-in-production',
	baseURL: process.env.BETTER_AUTH_URL || process.env.PUBLIC_URL || 'http://localhost:5173',
	database: drizzleAdapter(db, {
		provider: 'pg',
		schema: {
			user: schema.user,
			session: schema.session,
			account: schema.account,
			verification: schema.verification
		}
	}),
	emailAndPassword: {
		enabled: true
	},
	user: {
		additionalFields: {
			role: {
				type: 'string',
				defaultValue: 'contributor',
				input: false
			}
		}
	}
});
