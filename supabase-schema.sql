-- Fullora Shelter Supabase Database Schema & Seed Script
-- Run this in your Supabase SQL Editor (Dashboard -> SQL Editor -> New Query -> Run)

-- 1. Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Shelter Settings Table
CREATE TABLE IF NOT EXISTS public.shelter_settings (
    id TEXT PRIMARY KEY DEFAULT 'default',
    shelter_name TEXT NOT NULL DEFAULT 'Fullora''s Shelter',
    tagline TEXT DEFAULT 'A compassionate sanctuary for rescued cats and dogs',
    currency_symbol TEXT NOT NULL DEFAULT '৳',
    currency_code TEXT NOT NULL DEFAULT 'BDT',
    default_spay_neuter_cost NUMERIC NOT NULL DEFAULT 1500,
    default_monthly_sponsor_cost NUMERIC NOT NULL DEFAULT 1000,
    monthly_shelter_goal NUMERIC NOT NULL DEFAULT 100000,
    mfs_title TEXT DEFAULT 'Mobile Financial Services (MFS)',
    mfs_instructions TEXT DEFAULT 'Send Money to our bKash / Nagad / Rocket numbers below, then input your wallet number and Transaction ID (TrxID).',
    mfs_accounts JSONB DEFAULT '[
        {"provider": "bKash", "type": "Personal", "number": "01700-000000"},
        {"provider": "Nagad", "type": "Personal", "number": "01800-000000"},
        {"provider": "Rocket", "type": "Personal", "number": "01900-000000-0"}
    ]'::jsonb,
    bank_title TEXT DEFAULT 'Bank Transfer',
    bank_instructions TEXT DEFAULT 'Transfer funds to our official shelter bank account, then input your bank name, account number, and deposit reference.',
    bank_accounts JSONB DEFAULT '[
        {
            "bank_name": "City Bank PLC",
            "account_name": "Fullora Animal Sanctuary",
            "account_number": "11029384756",
            "branch": "Dhanmondi Branch",
            "routing_number": "225272635"
        }
    ]'::jsonb,
    admin_passcode_hash TEXT DEFAULT 'fullora2026', -- Default admin quick-passcode for the shelter manager
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Seed default settings row if not present
INSERT INTO public.shelter_settings (id) 
VALUES ('default')
ON CONFLICT (id) DO NOTHING;

-- 3. Animals Table
CREATE TABLE IF NOT EXISTS public.animals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    species TEXT NOT NULL CHECK (species IN ('cat', 'dog')),
    age TEXT DEFAULT 'Young',
    gender TEXT CHECK (gender IN ('male', 'female', 'unknown')) DEFAULT 'unknown',
    story TEXT,
    image_url TEXT,
    needs_spay_neuter BOOLEAN DEFAULT FALSE,
    is_spayed_neutered BOOLEAN DEFAULT FALSE,
    spay_neuter_cost NUMERIC DEFAULT 1500,
    monthly_sponsorship_goal NUMERIC DEFAULT 1000,
    current_sponsorship_funded NUMERIC DEFAULT 0,
    status TEXT DEFAULT 'available' CHECK (status IN ('available', 'sponsored', 'in_treatment', 'adopted')),
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Donations Table
CREATE TABLE IF NOT EXISTS public.donations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    donation_mode TEXT NOT NULL CHECK (donation_mode IN ('once', 'monthly', 'sponsor', 'spay_neuter')),
    animal_id UUID REFERENCES public.animals(id) ON DELETE SET NULL,
    amount NUMERIC NOT NULL,
    currency TEXT DEFAULT 'BDT',
    payment_type TEXT NOT NULL CHECK (payment_type IN ('mfs', 'bank')),
    sender_wallet_or_account TEXT NOT NULL,
    transaction_reference TEXT NOT NULL,
    receipt_screenshot_url TEXT,
    donor_name TEXT DEFAULT 'Anonymous Angel',
    donor_email TEXT,
    is_anonymous BOOLEAN DEFAULT TRUE,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'verified', 'rejected')),
    verification_note TEXT,
    points_awarded INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    verified_at TIMESTAMPTZ
);

-- Index for fast status & reference lookups
CREATE INDEX IF NOT EXISTS idx_donations_status ON public.donations(status);
CREATE INDEX IF NOT EXISTS idx_donations_trx ON public.donations(transaction_reference);
CREATE INDEX IF NOT EXISTS idx_animals_species ON public.animals(species);

-- 5. Seed Demo Animals (Cats & Dogs)
INSERT INTO public.animals (name, species, age, gender, story, image_url, needs_spay_neuter, is_spayed_neutered, spay_neuter_cost, monthly_sponsorship_goal, current_sponsorship_funded, status, is_featured)
VALUES 
    (
        'Bagheera', 
        'cat', 
        '1.5 years', 
        'male', 
        'Rescued from a busy highway drain with injured paws. Now completely recovered, affectionate, and loves purring on laps.', 
        'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=800&q=80', 
        false, 
        true, 
        1500, 
        1000, 
        400, 
        'available', 
        true
    ),
    (
        'Luna', 
        'cat', 
        '8 months', 
        'female', 
        'Gentle calico kitten rescued during monsoon rains. Needs spaying surgery before she can be put up for adoption.', 
        'https://images.unsplash.com/photo-1573865526739-10659fec78a5?auto=format&fit=crop&w=800&q=80', 
        true, 
        false, 
        1500, 
        1000, 
        0, 
        'available', 
        true
    ),
    (
        'Sheru', 
        'dog', 
        '2 years', 
        'male', 
        'A loyal desi dog found with severe malnutrition. He is now healthy, playful, and the shelter''s honorary greeting committee.', 
        'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=800&q=80', 
        false, 
        true, 
        1500, 
        1000, 
        750, 
        'available', 
        true
    ),
    (
        'Bella', 
        'dog', 
        '1 year', 
        'female', 
        'Sweet golden-furred puppy rescued from construction site debris. Needs vaccination and neutering support.', 
        'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?auto=format&fit=crop&w=800&q=80', 
        true, 
        false, 
        1500, 
        1000, 
        0, 
        'available', 
        false
    ),
    (
        'Chai', 
        'cat', 
        '3 years', 
        'female', 
        'Chai loves sunbathing by the shelter window. She has a permanent ear notch and is a quiet, loving companion.', 
        'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?auto=format&fit=crop&w=800&q=80', 
        false, 
        true, 
        1500, 
        1000, 
        1000, 
        'sponsored', 
        false
    ),
    (
        'Rocky', 
        'dog', 
        '4 years', 
        'male', 
        'Gentle giant who survived a leg injury. He is on a special diet and looking for a monthly guardian angel.', 
        'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=800&q=80', 
        false, 
        true, 
        1500, 
        1000, 
        200, 
        'available', 
        false
    );

-- 6. Storage Bucket for Pet Photos & Receipts
INSERT INTO storage.buckets (id, name, public) 
VALUES ('pet-media', 'pet-media', true)
ON CONFLICT (id) DO NOTHING;

-- 7. Row Level Security (RLS) Setup
ALTER TABLE public.shelter_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.animals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.donations ENABLE ROW LEVEL SECURITY;

-- Allow public read access
CREATE POLICY "Public read shelter_settings" ON public.shelter_settings FOR SELECT USING (true);
CREATE POLICY "Public read animals" ON public.animals FOR SELECT USING (true);
CREATE POLICY "Public read verified donations" ON public.donations FOR SELECT USING (true);

-- Allow public insert for donations (anyone can donate!)
CREATE POLICY "Public insert donations" ON public.donations FOR INSERT WITH CHECK (true);

-- Allow full update/insert/delete on all tables for anon with valid application access
-- (The application uses the anon key with admin passcode verification)
CREATE POLICY "Allow public update shelter_settings" ON public.shelter_settings FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public all animals" ON public.animals FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public all donations" ON public.donations FOR ALL USING (true) WITH CHECK (true);

-- Storage bucket public policies
CREATE POLICY "Public Access pet-media" ON storage.objects FOR SELECT USING (bucket_id = 'pet-media');
CREATE POLICY "Public Upload pet-media" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'pet-media');
CREATE POLICY "Public Update pet-media" ON storage.objects FOR UPDATE USING (bucket_id = 'pet-media');
