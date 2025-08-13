import type { withClassName, withChildren } from "../types";
import Header from "./Header";
import clsx from "clsx";

interface MainProps extends withChildren, withClassName {}

const Container: React.FC<MainProps> = ({ className, children }) => {
  return (
    <main className={clsx("flex flex-col ml-2 mr-2 min-h-screen", className)}>
      <Header />
      {children}
    </main>
  );
};

export default Container;
