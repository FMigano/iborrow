# iBorrow - Library Management App

## Overview

iBorrow is a mobile library management application built with Flutter and designed to work with Supabase. It provides an intuitive interface for both library users and administrators to manage book borrowing efficiently.

## Features

### For Users:

- 📚 Browse available books
- 🔍 Search books by title, author, or genre
- 📖 Borrow and return books
- ⭐ Mark favorite books
- 📊 Track borrowing history
- ⚡ Smart filters and recommendations

### For Administrators:

- 👥 Manage library users
- 📊 View comprehensive statistics
- 📚 Add and manage book inventory
- 🔍 Track borrowing activity
- ⚠️ Monitor overdue books
- 📈 Generate reports

## Project Structure

```
lib/
├── auth/                   # Authentication screens
│   ├── login_screen.dart   # Unified login for users and admins
│   └── signup_screen.dart  # User registration
├── core/                   # Core utilities and configurations
│   ├── app_export.dart     # Central exports
│   └── utils/              # Utility classes
├── library_admin/          # Admin-specific screens
│   └── admin_dashboard.dart
├── library_user/           # User-specific screens
│   └── user_dashboard.dart
├── routes/                 # Navigation management
│   └── app_routes.dart
├── theme/                  # UI themes and styling
│   ├── theme_helper.dart
│   └── text_style_helper.dart
├── widgets/                # Reusable UI components
│   ├── custom_image_view.dart
│   ├── custom_submit_button.dart
│   └── custom_text_field.dart
└── main.dart              # App entry point
```

## Design Integration

This project has been integrated with UI components from a Figma-generated Flutter design featuring:

### Visual Elements:

- **Color Scheme**: Orange-themed palette (#FC8520, #BA5A13, #FFF2DF)
- **Typography**: Inter font family with responsive sizing
- **Assets**: Background images and icons properly integrated
- **Responsive Design**: Figma-based responsive scaling system

### UI Components:

- Custom text fields with validation
- Branded submit buttons with loading states
- Flexible image view component
- Consistent spacing and styling

## Technology Stack

- **Frontend**: Flutter 3.8.1+
- **Backend**: Supabase (ready for integration)
- **State Management**: Provider
- **UI Components**: Custom widgets with Material Design
- **Authentication**: Supabase Auth (planned)
- **Database**: PostgreSQL via Supabase (planned)

## Authentication Flow

### Dual Login System:

- **Users**: Create accounts via signup screen
- **Admins**: Use predefined admin credentials
- **Route Logic**: Email-based detection for admin vs user dashboard routing

### Security Features:

- Input validation for all forms
- Password strength requirements
- Remember me functionality
- Secure logout with confirmation

## Getting Started

### Prerequisites:

- Flutter SDK 3.8.1 or higher
- Dart 3.0.0 or higher

### Installation:

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure Supabase connection (when ready)
4. Run `flutter run` to start the app

### Dependencies:

- `provider`: State management
- `supabase_flutter`: Backend integration
- `flutter_svg`: SVG image support
- `shared_preferences`: Local storage
- `connectivity_plus`: Network status

## Assets Integrated

From the original Figma design:

- ✅ Login/Signup background images
- ✅ Icon assets and illustrations
- ✅ Inter font family (Regular & Bold)
- ✅ Color palette and theme
- ✅ Responsive scaling system

## Backend: Supabase setup

1) Create a Supabase project (you already have one).
2) Add environment variables when running the app:
- flutter run --dart-define SUPABASE_URL=your-project-url --dart-define SUPABASE_ANON_KEY=your-anon-key

3) Database schema (SQL)
```sql
-- profiles table
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null,
  email text not null,
  role text not null default 'user',
  created_at timestamp with time zone default now()
);
alter table public.profiles enable row level security;

-- Reservations table
create table if not exists public.reservations (
  id bigint primary key generated always as identity,
  user_id uuid not null references auth.users(id) on delete cascade,
  book_title text not null,
  book_author text,
  status text not null default 'reserved',
  created_at timestamp with time zone default now()
);
alter table public.reservations enable row level security;

-- RLS policies
create policy "Users can manage own profile"
  on public.profiles for select using (auth.uid() = id);

create policy "Insert own profile"
  on public.profiles for insert with check (auth.uid() = id);

create policy "Users can read own reservations"
  on public.reservations for select using (auth.uid() = user_id);

create policy "Users can insert own reservations"
  on public.reservations for insert with check (auth.uid() = user_id);
```

4) Edge Functions

4.1) create_user_profile
Create a function to create a profile right after sign-up.

File: supabase/functions/create_user_profile/index.ts
```ts
// deno-lint-ignore-file no-explicit-any
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const supabase = createClient(supabaseUrl, serviceRoleKey);

    const authHeader = req.headers.get("Authorization") ?? "";
    const jwt = authHeader.replace("Bearer ", "");

    // Authenticated user
    const { data: userData, error: userErr } = await supabase.auth.getUser(jwt);
    if (userErr || !userData.user) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), { status: 401 });
    }

    const body = await req.json().catch(() => ({}));
    const username = body.username ?? userData.user.user_metadata?.username ?? "user";
    const email = body.email ?? userData.user.email;

    // Upsert to be idempotent
    const { error } = await supabase.from("profiles").upsert({
      id: userData.user.id,
      username,
      email,
      role: "user",
    });

    if (error) throw error;

    return new Response(JSON.stringify({ ok: true }), { status: 200 });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e?.message ?? e) }), { status: 400 });
  }
});
```

4.2) reserve_book
Reserve a book for the authenticated user.

File: supabase/functions/reserve_book/index.ts
```ts
// deno-lint-ignore-file no-explicit-any
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const supabase = createClient(supabaseUrl, serviceRoleKey);

    const authHeader = req.headers.get("Authorization") ?? "";
    const jwt = authHeader.replace("Bearer ", "");

    const { data: userData, error: userErr } = await supabase.auth.getUser(jwt);
    if (userErr || !userData.user) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), { status: 401 });
    }

    const { title, author } = await req.json();
    if (!title) {
      return new Response(JSON.stringify({ error: "title is required" }), { status: 400 });
    }

    const { error } = await supabase.from("reservations").insert({
      user_id: userData.user.id,
      book_title: title,
      book_author: author ?? null,
      status: "reserved",
    });

    if (error) throw error;

    return new Response(JSON.stringify({ ok: true }), { status: 200 });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e?.message ?? e) }), { status: 400 });
  }
});
```

4.3) Deploy functions and set secrets
```bash
# From your Supabase project folder (CLI initialized)
supabase secrets set SUPABASE_URL=YOUR_URL SUPABASE_SERVICE_ROLE_KEY=YOUR_SERVICE_ROLE_KEY
supabase functions deploy create_user_profile
supabase functions deploy reserve_book
```

5) Run the app
```bash
flutter run \
  --dart-define SUPABASE_URL=YOUR_URL \
  --dart-define SUPABASE_ANON_KEY=YOUR_ANON_KEY
```

Notes:
- The app automatically invokes create_user_profile after sign-up and reserve_book when reserving.
- Direct table writes are kept as fallback and require the RLS policies above.

## Next Steps

1. **Supabase Integration**: Configure authentication and database
2. **Book Management**: Implement CRUD operations for books
3. **Search & Filters**: Advanced search functionality
4. **Notifications**: Push notifications for due dates
5. **Analytics**: Usage statistics and reporting
6. **Offline Support**: Local caching for better performance

## Development Notes

- The app uses a responsive design system based on Figma specifications
- All UI components are built with accessibility in mind
- The architecture supports easy integration with Supabase
- State management is set up for scalable development
- Code is organized following Flutter best practices

## Contributing

This app is structured to support team development with:

- Clear separation of user and admin functionality
- Modular widget architecture
- Consistent coding patterns
- Proper error handling and validation

---

**iBorrow** - Making library management simple and efficient! 📚✨
