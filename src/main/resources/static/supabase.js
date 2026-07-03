// supabase.js

const SUPABASE_PROJECT_URL = 'https://deumrbnhyjhbozolxnel.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_At-J7JlNyllJsfHRstiKFA_ar8LSLGI';

const supabaseClient = window.supabase.createClient(
    SUPABASE_PROJECT_URL,
    SUPABASE_ANON_KEY
);

// Verify connection on page load
if (supabaseClient) {
    console.log('Connection successful: Supabase client initialized.');
} else {
    console.error('Connection failed: Failed to initialize Supabase client.');
}

// Make variables and client globally accessible without overwriting the window.supabase library object
window.supabaseClient = supabaseClient;
window.SUPABASE_PROJECT_URL = SUPABASE_PROJECT_URL;
window.SUPABASE_ANON_KEY = SUPABASE_ANON_KEY;

// Verify SDK and Client presence
console.log("Supabase SDK:", window.supabase);
console.log("Supabase Client:", window.supabaseClient);
