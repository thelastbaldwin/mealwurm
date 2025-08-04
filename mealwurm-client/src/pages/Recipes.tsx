import { useEffect } from "react";
import { Container } from "../components";
import fetchWrapper from "../api/fetchWrapper";
import { useAuth0 } from "@auth0/auth0-react";

const fetchRecipes = async (token: string) => {
  const result = await fetchWrapper.get("/recipes", token);
  return result;
};

function Recipes() {
  const { getAccessTokenSilently, user } = useAuth0();

  useEffect(() => {
    const loadDependencies = async () => {
      const token = await getAccessTokenSilently();
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
}

export default Recipes;
