## Digital Library

This repository is a monorepo with a React/Vite frontend and an Express/Knex API.

### Render architecture

Deploy two services from the same repository:

- **Web Service**: root directory `server`, build command `npm ci`, start command `npm start`
- **Static Site**: root directory `client`, build command `npm ci && npm run build`, publish directory `dist`

`render.yaml` contains both services and configures the frontend SPA rewrite.

### Backend environment variables

Set these on the API web service:

- `NODE_ENV=production`
- `DB_DIALECT=postgres`
- `DATABASE_URL` = the connection URL for the existing Render PostgreSQL database
- `DB_SSL=true`
- `JWT_SECRET` = a long random secret
- `CLIENT_ORIGIN` = the deployed static-site URL
- `API_URL` = the deployed API URL (used by Swagger)

Render supplies `PORT` automatically. Do not commit `server/.env`; use `server/.env.example` for local setup.

### Frontend environment variable

Set `VITE_API_URL` on the static site to the deployed API URL, for example `https://diglib-api.onrender.com`.

### Database setup

Run the project’s complete base schema in the existing PostgreSQL database before deploying the API. Then run `database/reservation_migration.sql` and, if needed, update the email in `database/admin_setup.sql` before running it. The migration files assume the base tables already exist.

### Local development

Install dependencies in `server` and `client`, copy `server/.env.example` to `server/.env`, then run each package’s development script from its directory.
