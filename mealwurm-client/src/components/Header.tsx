import { Link, useNavigate } from "react-router";
import {
  Button,
  Menu,
  MenuItem,
  MenuTrigger,
  Popover,
} from "react-aria-components";
import { AlignJustify, Worm } from "lucide-react";
import { useAuth0 } from "@auth0/auth0-react";

const Header = () => {
  const { user, isAuthenticated, loginWithRedirect, logout } = useAuth0();
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

  const logoutWithRedirect = () =>
    logout({
      logoutParams: {
        returnTo: window.location.origin,
      },
    });

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
                onAction={() => loginWithRedirect()}
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
                  onAction={() => logoutWithRedirect()}
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
