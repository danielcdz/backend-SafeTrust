CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create the escrow_transaction_users table
CREATE TABLE escrow_transaction_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_email VARCHAR(150) REFERENCES users(email),
    escrow_transaction_id TEXT REFERENCES escrow_transactions(contract_id),
    role VARCHAR(20),
    status VARCHAR(20),
    is_primary BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_escrow_user_role UNIQUE (escrow_transaction_id, user_email, role)
);

-- Create an index for faster lookups
CREATE INDEX idx_escrow_transaction_users_transaction_id ON escrow_transaction_users(escrow_transaction_id);
CREATE INDEX idx_escrow_transaction_users_user_id ON escrow_transaction_users(user_email); 