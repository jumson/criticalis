<script lang="ts">
	import { authClient } from '$lib/auth-client';
	import { goto } from '$app/navigation';

	let email = $state('');
	let password = $state('');
	let error = $state('');
	let loading = $state(false);

	async function handleSubmit(e: Event) {
		e.preventDefault();
		error = '';
		loading = true;

		try {
			const result = await authClient.signIn.email({
				email,
				password
			});

			if (result.error) {
				error = result.error.message ?? 'Sign in failed. Check your credentials.';
			} else {
				goto('/');
			}
		} catch {
			error = 'An unexpected error occurred. Please try again.';
		} finally {
			loading = false;
		}
	}
</script>

<svelte:head>
	<title>Sign In — Criticalis</title>
	<meta name="description" content="Sign in to your Criticalis account." />
</svelte:head>

<div class="container auth-page">
	<div class="auth-card">
		<h1>Sign In</h1>
		<p class="auth-subtitle">Welcome back to Criticalis.</p>

		{#if error}
			<div class="auth-error">{error}</div>
		{/if}

		<form onsubmit={handleSubmit}>
			<label class="field">
				<span class="field-label">Email</span>
				<input
					type="email"
					bind:value={email}
					required
					autocomplete="email"
					placeholder="you@example.com"
				/>
			</label>

			<label class="field">
				<span class="field-label">Password</span>
				<input
					type="password"
					bind:value={password}
					required
					autocomplete="current-password"
					placeholder="Your password"
				/>
			</label>

			<button type="submit" class="btn-primary" disabled={loading}>
				{loading ? 'Signing in...' : 'Sign In'}
			</button>
		</form>

		<p class="auth-footer">
			Don't have an account? <a href="/sign-up">Sign up</a>
		</p>
	</div>
</div>

<style>
	.auth-page {
		display: flex;
		justify-content: center;
		padding: 3rem 1.5rem;
	}

	.auth-card {
		width: 100%;
		max-width: 400px;
		background: var(--color-bg-elevated);
		border: 1px solid var(--color-border-light);
		border-radius: var(--radius-lg);
		padding: 2rem;
		box-shadow: var(--shadow-md);
	}

	.auth-card h1 {
		font-size: 1.5rem;
		margin-bottom: 0.25rem;
	}

	.auth-subtitle {
		color: var(--color-text-muted);
		font-size: 0.9rem;
		margin: 0 0 1.5rem;
	}

	.auth-error {
		background: #fef2f2;
		color: var(--color-danger);
		border: 1px solid #fecaca;
		border-radius: var(--radius);
		padding: 0.75rem;
		font-size: 0.85rem;
		margin-bottom: 1rem;
	}

	form {
		display: flex;
		flex-direction: column;
		gap: 1rem;
	}

	.field {
		display: flex;
		flex-direction: column;
		gap: 0.3rem;
	}

	.field-label {
		font-size: 0.85rem;
		font-weight: 500;
		color: var(--color-text);
	}

	.field input {
		padding: 0.6rem 0.75rem;
		border: 1px solid var(--color-border);
		border-radius: var(--radius);
		font-size: 0.9rem;
		font-family: inherit;
		background: var(--color-bg);
		color: var(--color-text);
		transition: border-color 0.15s;
	}

	.field input:focus {
		outline: none;
		border-color: var(--color-accent);
		box-shadow: 0 0 0 2px rgba(124, 94, 60, 0.15);
	}

	.btn-primary {
		padding: 0.65rem 1rem;
		background: var(--color-accent);
		color: white;
		border: none;
		border-radius: var(--radius);
		font-size: 0.9rem;
		font-weight: 500;
		margin-top: 0.5rem;
		transition: background 0.15s;
	}

	.btn-primary:hover:not(:disabled) {
		background: var(--color-accent-hover);
	}

	.btn-primary:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}

	.auth-footer {
		margin-top: 1.5rem;
		text-align: center;
		font-size: 0.85rem;
		color: var(--color-text-muted);
	}

	@media (max-width: 600px) {
		.auth-page {
			padding: 1.5rem 1rem;
		}

		.auth-card {
			padding: 1.5rem;
		}
	}
</style>
