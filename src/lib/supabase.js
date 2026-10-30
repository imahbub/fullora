import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL || 'https://sxpjpvcdjqlwmuaprymi.supabase.co';
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Fallback initial data in case database tables are not yet seeded
export const DEFAULT_SETTINGS = {
  shelter_name: "Fullora's Shelter",
  tagline: "A compassionate sanctuary and medical refuge for rescued cats and dogs",
  currency_symbol: "৳",
  currency_code: "BDT",
  default_spay_neuter_cost: 1500,
  default_monthly_sponsor_cost: 1000,
  monthly_shelter_goal: 100000,
  mfs_title: "Mobile Financial Services (MFS)",
  mfs_instructions: "Send Money to our bKash, Nagad, or Rocket accounts below. Once sent, enter your wallet phone number and the Transaction ID (TrxID) below.",
  mfs_accounts: [
    { provider: "bKash", type: "Personal", number: "01712-345678" },
    { provider: "Nagad", type: "Personal", number: "01812-345678" },
    { provider: "Rocket", type: "Personal", number: "01912-345678-9" }
  ],
  bank_title: "Bank Account Transfer",
  bank_instructions: "Transfer to our shelter bank account via BEFTN/NPSB/Internet Banking, then enter your bank name, account number, and deposit reference below.",
  bank_accounts: [
    {
      bank_name: "City Bank PLC",
      account_name: "Fullora Animal Sanctuary",
      account_number: "11029384756",
      branch: "Dhanmondi Branch",
      routing_number: "225272635"
    }
  ]
};

export const DEMO_ANIMALS = [
  {
    id: "a1",
    name: "Bagheera",
    species: "cat",
    age: "1.5 years",
    gender: "male",
    story: "Rescued from a busy highway drain with injured paws. Now completely recovered, affectionate, and loves head scratches.",
    image_url: "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=800&q=80",
    needs_spay_neuter: false,
    is_spayed_neutered: true,
    spay_neuter_cost: 1500,
    monthly_sponsorship_goal: 1000,
    current_sponsorship_funded: 600,
    status: "available",
    is_featured: true
  },
  {
    id: "a2",
    name: "Luna",
    species: "cat",
    age: "8 months",
    gender: "female",
    story: "Gentle calico kitten rescued during monsoon rains. She is healthy but urgently needs spaying surgery before adoption.",
    image_url: "https://images.unsplash.com/photo-1573865526739-10659fec78a5?auto=format&fit=crop&w=800&q=80",
    needs_spay_neuter: true,
    is_spayed_neutered: false,
    spay_neuter_cost: 1500,
    monthly_sponsorship_goal: 1000,
    current_sponsorship_funded: 0,
    status: "available",
    is_featured: true
  },
  {
    id: "a3",
    name: "Sheru",
    species: "dog",
    age: "2 years",
    gender: "male",
    story: "A loyal desi dog found with severe malnutrition. He is now strong, playful, and the shelter's honorary greeting ambassador.",
    image_url: "https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=800&q=80",
    needs_spay_neuter: false,
    is_spayed_neutered: true,
    spay_neuter_cost: 1500,
    monthly_sponsorship_goal: 1000,
    current_sponsorship_funded: 1000,
    status: "sponsored",
    is_featured: true
  },
  {
    id: "a4",
    name: "Bella",
    species: "dog",
    age: "1 year",
    gender: "female",
    story: "Sweet golden-furred puppy rescued from construction site debris. Needs vaccination and neutering support.",
    image_url: "https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?auto=format&fit=crop&w=800&q=80",
    needs_spay_neuter: true,
    is_spayed_neutered: false,
    spay_neuter_cost: 1500,
    monthly_sponsorship_goal: 1000,
    current_sponsorship_funded: 250,
    status: "available",
    is_featured: false
  },
  {
    id: "a5",
    name: "Chai",
    species: "cat",
    age: "3 years",
    gender: "female",
    story: "Chai loves sunbathing by the shelter window. A calm senior cat who purrs whenever someone sits nearby.",
    image_url: "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?auto=format&fit=crop&w=800&q=80",
    needs_spay_neuter: false,
    is_spayed_neutered: true,
    spay_neuter_cost: 1500,
    monthly_sponsorship_goal: 1000,
    current_sponsorship_funded: 1000,
    status: "sponsored",
    is_featured: false
  },
  {
    id: "a6",
    name: "Rocky",
    species: "dog",
    age: "4 years",
    gender: "male",
    story: "Gentle giant who survived a fracture. He walks with a joyful hop and is looking for a monthly food and care sponsor.",
    image_url: "https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=800&q=80",
    needs_spay_neuter: false,
    is_spayed_neutered: true,
    spay_neuter_cost: 1500,
    monthly_sponsorship_goal: 1000,
    current_sponsorship_funded: 300,
    status: "available",
    is_featured: false
  }
];

export const DEMO_DONATIONS = [
  {
    id: "d1",
    donor_name: "Tanvir Ahmed",
    amount: 1500,
    currency: "BDT",
    donation_mode: "spay_neuter",
    payment_type: "mfs",
    transaction_reference: "9K28JA71B",
    status: "verified",
    created_at: new Date(Date.now() - 3600000 * 2).toISOString(),
    badge: "Life Changer ✂️"
  },
  {
    id: "d2",
    donor_name: "Anonymous Angel",
    amount: 1000,
    currency: "BDT",
    donation_mode: "sponsor",
    payment_type: "mfs",
    transaction_reference: "8L19MB52C",
    status: "verified",
    created_at: new Date(Date.now() - 3600000 * 6).toISOString(),
    badge: "Secret Benefactor 🕵️"
  },
  {
    id: "d3",
    donor_name: "Nusrat Jahan",
    amount: 2000,
    currency: "BDT",
    donation_mode: "monthly",
    payment_type: "bank",
    transaction_reference: "CITY-2026-981",
    status: "verified",
    created_at: new Date(Date.now() - 3600000 * 24).toISOString(),
    badge: "Guardian Angel 🌟"
  }
];
