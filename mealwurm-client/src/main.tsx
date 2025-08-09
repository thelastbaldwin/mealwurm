import { Suspense, lazy } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter, Route, Routes } from "react-router";
import { UserManager } from "oidc-client-ts";
import { AuthProvider } from "react-oidc-context";
import Loading from "./pages/Loading.tsx";
import Main from "./pages/Main.tsx";

import "@fontsource-variable/cormorant";
import "./index.css";

const Recipes = lazy(() => import("./pages/Recipes.tsx"));

const userManager = new UserManager({
  authority: import.meta.env.VITE_AUTH_DOMAIN,
  client_id: import.meta.env.VITE_AUTH_CLIENT_ID,
  redirect_uri: import.meta.env.VITE_AUTH_REDIRECT_URI,
  post_logout_redirect_uri: window.location.origin,
  monitorSession: true,
});

createRoot(document.getElementById("root")!).render(
  <AuthProvider userManager={userManager}>
    <BrowserRouter>
      <Routes>
        <Route
          path="/"
          element={
            <Suspense fallback={<Loading />}>
              <Main />
            </Suspense>
          }
        />
        <Route
          path="/recipes"
          element={
            <Suspense fallback={<Loading />}>
              <Recipes />
            </Suspense>
          }
        />
        <Route path="loading" element={<Loading />} />
      </Routes>
    </BrowserRouter>
  </AuthProvider>
);
