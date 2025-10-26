-- Create role for BI
CREATE ROLE bi_readonly LOGIN PASSWORD 'bi_readonly';

-- Revoke usage to all other schemas
REVOKE USAGE ON SCHEMA public, stg, clean FROM bi_readonly;
REVOKE SELECT ON ALL TABLES IN SCHEMA public, stg, clean FROM bi_readonly;


-- remove PUBLIC’s implicit access to the public schema
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT USAGE, CREATE ON SCHEMA public TO postgres;


-- Grant access to schema mart
GRANT USAGE ON SCHEMA mart TO bi_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA mart TO bi_readonly;

--Grant readonly access to BI in future
ALTER DEFAULT PRIVILEGES IN SCHEMA mart
  GRANT SELECT ON TABLES TO bi_readonly;

-- Test access
SELECT has_schema_privilege('bi_readonly', 'mart', 'USAGE');

SELECT table_schema, table_name, privilege_type
FROM information_schema.table_privileges
WHERE grantee = 'bi_readonly';
