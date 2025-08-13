import { Link, useNavigate } from "react-router";
import {
  Button,
  Menu,
  MenuItem,
  MenuTrigger,
  Popover,
} from "react-aria-components";
import { AlignJustify, Worm } from "lucide-react";
import { useAuth } from "react-oidc-context";

const Header = () => {
  const { isAuthenticated, signinRedirect, signoutRedirect } = useAuth();
  const navigate = useNavigate();

  // useEffect(() => {
  //   const getToken = async () => {
  //     const token = await getAccessTokenSilently();
  //     console.log(token);
  //   };
  //   if (isAuthenticated) {
  //     getToken();
  //   }
  // }, [getAccessTokenSilently, isAuthenticated]);

  return (
    <header className="flex justify-between items-center mt-3">
      <div className="flex justify-start items-baseline">
        <Worm />
        <h1 className="text-3xl">
          <Link to="/">MealWurm</Link>
        </h1>
      </div>
      <MenuTrigger>
        <Button aria-label="Menu" className="p-1">
          <AlignJustify />
        </Button>
        <Popover>
          <Menu className="text-right">
            {/* {!isAuthenticated && (
                <NavItem>
                  <Button
                    id="qsLoginBtn"
                    color="primary"
                    className="btn-margin"
                    onClick={() => loginWithRedirect()}
                  >
                    Log in
                  </Button>
                </NavItem>
              )} */}
            {!isAuthenticated && (
              <MenuItem
                onAction={signinRedirect}
                className="cursor-pointer hover:bg-zinc-100 p-1"
              >
                Log in
              </MenuItem>
            )}
            {isAuthenticated && (
              <>
                <MenuItem
                  onAction={() => navigate("/add-recipe")}
                  className="cursor-pointer hover:bg-zinc-100 p-1"
                >
                  Add Recipe
                </MenuItem>
                <MenuItem
                  onAction={() => navigate("/recipes")}
                  className="cursor-pointer hover:bg-zinc-100 p-1"
                >
                  Recipes
                </MenuItem>
                <MenuItem
                  onAction={signoutRedirect}
                  className="cursor-pointer hover:bg-zinc-100 p-1"
                >
                  Log out
                </MenuItem>
              </>
            )}
          </Menu>
        </Popover>
      </MenuTrigger>
    </header>
  );
};

export default Header;
