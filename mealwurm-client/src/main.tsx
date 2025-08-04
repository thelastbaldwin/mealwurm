import { Suspense, lazy } from "react";
import { createRoot } from "react-dom/client";
import Loading from "./pages/Loading.tsx";
import Main from "./pages/Main.tsx";

import "@fontsource-variable/cormorant";
import "./index.css";

const Recipes = lazy(() => import("./pages/Recipes.tsx"));

import { BrowserRouter, Route, Routes } from "react-router";
import { Auth0Provider } from "@auth0/auth0-react";

const providerConfig = {
  domain: import.meta.env.VITE_AUTH0_DOMAIN,
  clientId: import.meta.env.VITE_AUTH0_CLIENT_ID,
  authorizationParams: {
    redirect_uri: window.location.origin,
    audience: import.meta.env.VITE_AUTH0_AUDIENCE,
  },
};

createRoot(document.getElementById("root")!).render(
  <Auth0Provider {...providerConfig}>
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
  </Auth0Provider>
);
