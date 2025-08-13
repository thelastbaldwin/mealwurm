import { type Ingredient } from "./Ingredient";

export type Recipe = {
  id: string;
  createdAt: string;
  lastModifiedAt: string;
  createdBy: string;
  lastModifiedBy: string | null;
  title: string;
  instructions: string;
  prepTime: number;
  cookTime: number;
  ingredients: Ingredient[];
  tags: [];
};
