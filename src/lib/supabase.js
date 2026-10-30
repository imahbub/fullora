// Provide a safe WebSocket fallback for Node.js build-time SSG in environments < Node 22
if (typeof WebSocket === 'undefined') {
  globalThis.WebSocket = class DummyWebSocket {};
}

import { createClient } from '@supabase/supabase-js';
export * from './data.js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL || 'https://sxpjpvcdjqlwmuaprymi.supabase.co';
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: typeof window !== 'undefined',
  },
  realtime: {
    transport: typeof window !== 'undefined' ? window.WebSocket : undefined,
  }
});
