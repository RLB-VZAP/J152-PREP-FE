<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%--
    auth.jsp - combined Login / Register screen.

    Both forms POST to:  <context>/auth
    The hidden "action" field tells the servlet which flow to run:
        action=login     -> email, password
        action=register  -> fullName, email, password, confirmPassword

    Switch panels with ?mode=register / ?mode=login (works without JavaScript).
    Feedback codes come back as ?error=... / ?success=... and are mapped to fixed
    text below, so no user supplied value is ever echoed into the page.
--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>HelpDeskPro - Sign in</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tailwind.css">
    </head>
    <body class="min-h-screen bg-slate-100 text-slate-800 antialiased">

        <main class="mx-auto flex min-h-screen max-w-md flex-col justify-center px-4 py-10">

            <header class="mb-6 text-center">
                <h1 class="text-2xl font-bold tracking-tight text-slate-900">HelpDeskPro</h1>
                <p class="mt-1 text-sm text-slate-500">Support ticket management</p>
            </header>

            <div class="rounded-xl border border-slate-200 bg-white shadow-sm">

                <!-- Tabs -->
                <nav class="grid grid-cols-2 border-b border-slate-200" aria-label="Authentication mode">
                    <a href="?mode=login"
                       class="px-4 py-3 text-center text-sm font-medium transition ${param.mode eq 'register' ? 'text-slate-500 hover:text-slate-700' : 'border-b-2 border-brand-600 text-brand-700'}">
                        Sign in
                    </a>
                    <a href="?mode=register"
                       class="px-4 py-3 text-center text-sm font-medium transition ${param.mode eq 'register' ? 'border-b-2 border-brand-600 text-brand-700' : 'text-slate-500 hover:text-slate-700'}">
                        Register
                    </a>
                </nav>

                <div class="p-6">

                    <!-- Error banner -->
                    <div class="mb-4 rounded-md border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 ${empty param.error ? 'hidden' : ''}"
                         role="alert">
                        ${param.error eq 'invalid'  ? 'Incorrect email or password.' : ''}
                        ${param.error eq 'exists'   ? 'An account with that email already exists.' : ''}
                        ${param.error eq 'mismatch' ? 'The passwords entered do not match.' : ''}
                        ${param.error eq 'inactive' ? 'This account has been deactivated. Contact an administrator.' : ''}
                        ${param.error eq 'required' ? 'Please complete all required fields.' : ''}
                    </div>

                    <!-- Success banner -->
                    <div class="mb-4 rounded-md border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700 ${empty param.success ? 'hidden' : ''}"
                         role="status">
                        ${param.success eq 'registered' ? 'Account created. You can sign in now.' : ''}
                    </div>

                    <!-- ===================== LOGIN ===================== -->
                    <form method="post"
                          action="${pageContext.request.contextPath}/auth"
                          class="space-y-4 ${param.mode eq 'register' ? 'hidden' : ''}">
                        <input type="hidden" name="action" value="login">

                        <div>
                            <label for="login-email" class="mb-1 block text-sm font-medium text-slate-700">
                                Email address
                            </label>
                            <input id="login-email" name="email" type="email" required
                                   autocomplete="username" maxlength="254"
                                   placeholder="you@example.com"
                                   class="w-full rounded-md border border-slate-300 px-3 py-2 text-sm placeholder:text-slate-400 focus:border-brand-500 focus:ring-2 focus:ring-brand-100 focus:outline-none">
                        </div>

                        <div>
                            <label for="login-password" class="mb-1 block text-sm font-medium text-slate-700">
                                Password
                            </label>
                            <input id="login-password" name="password" type="password" required
                                   autocomplete="current-password"
                                   class="w-full rounded-md border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:ring-2 focus:ring-brand-100 focus:outline-none">
                        </div>

                        <button type="submit"
                                class="w-full rounded-md bg-brand-600 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-brand-700 focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 focus:outline-none">
                            Sign in
                        </button>

                        <p class="text-center text-sm text-slate-500">
                            No account?
                            <a href="?mode=register" class="font-medium text-brand-700 hover:underline">Register</a>
                        </p>
                    </form>

                    <!-- ==================== REGISTER ==================== -->
                    <form method="post"
                          action="${pageContext.request.contextPath}/auth"
                          class="space-y-4 ${param.mode eq 'register' ? '' : 'hidden'}">
                        <input type="hidden" name="action" value="register">

                        <div>
                            <label for="reg-fullName" class="mb-1 block text-sm font-medium text-slate-700">
                                Full name
                            </label>
                            <input id="reg-fullName" name="fullName" type="text" required
                                   autocomplete="name" maxlength="120"
                                   placeholder="Jane Doe"
                                   class="w-full rounded-md border border-slate-300 px-3 py-2 text-sm placeholder:text-slate-400 focus:border-brand-500 focus:ring-2 focus:ring-brand-100 focus:outline-none">
                        </div>

                        <div>
                            <label for="reg-email" class="mb-1 block text-sm font-medium text-slate-700">
                                Email address
                            </label>
                            <input id="reg-email" name="email" type="email" required
                                   autocomplete="email" maxlength="254"
                                   placeholder="you@example.com"
                                   class="w-full rounded-md border border-slate-300 px-3 py-2 text-sm placeholder:text-slate-400 focus:border-brand-500 focus:ring-2 focus:ring-brand-100 focus:outline-none">
                        </div>

                        <div>
                            <label for="reg-password" class="mb-1 block text-sm font-medium text-slate-700">
                                Password
                            </label>
                            <input id="reg-password" name="password" type="password" required
                                   minlength="8" autocomplete="new-password"
                                   class="w-full rounded-md border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:ring-2 focus:ring-brand-100 focus:outline-none">
                            <p class="mt-1 text-xs text-slate-500">At least 8 characters.</p>
                        </div>

                        <div>
                            <label for="reg-confirmPassword" class="mb-1 block text-sm font-medium text-slate-700">
                                Confirm password
                            </label>
                            <input id="reg-confirmPassword" name="confirmPassword" type="password" required
                                   minlength="8" autocomplete="new-password"
                                   class="w-full rounded-md border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:ring-2 focus:ring-brand-100 focus:outline-none">
                        </div>

                        <button type="submit"
                                class="w-full rounded-md bg-brand-600 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-brand-700 focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 focus:outline-none">
                            Create account
                        </button>

                        <p class="text-center text-sm text-slate-500">
                            Already registered?
                            <a href="?mode=login" class="font-medium text-brand-700 hover:underline">Sign in</a>
                        </p>
                    </form>

                </div>
            </div>

            <p class="mt-6 text-center text-xs text-slate-400">
                &copy; HelpDeskPro - J152
            </p>
        </main>
    </body>
</html>
