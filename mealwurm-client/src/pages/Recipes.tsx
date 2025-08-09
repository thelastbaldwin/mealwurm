import { useEffect } from "react";
import { Container } from "../components";
import fetchWrapper from "../api/fetchWrapper";
import { useAuth, withAuthenticationRequired } from "react-oidc-context";
import Loading from "./Loading";

const fetchRecipes = async (token: string) => {
  const result = await fetchWrapper.get("/recipes", token);
  return result;
};

const PrivateRecipes = () => {
  const { user } = useAuth();

  useEffect(() => {
    const loadDependencies = async () => {
      const token = user?.access_token || "";
      const recipes = await fetchRecipes(token);

      console.log(recipes);
    };
    loadDependencies();
  }, []);

  console.log("user", user);

  return (
    <Container>
      <section className="flex flex-1 justify-center">
        <div>
          <h1 className="mb-4 text-2xl">Recipes</h1>
        </div>
      </section>
    </Container>
  );
};

const Recipes = withAuthenticationRequired(PrivateRecipes, {
  OnRedirecting: () => <Loading />,
});

export default Recipes;
