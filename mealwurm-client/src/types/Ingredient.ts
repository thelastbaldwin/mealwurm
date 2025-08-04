export const Units = {
  0: "NONE",
  1: "CUP",
  2: "GALLON",
  3: "GRAM",
  4: "KILOGRAM",
  5: "LITER",
  6: "MILLIGRAM",
  7: "MILLILITER",
  8: "OUNCE",
  9: "PINT",
  10: "POUND",
  11: "QUART",
  12: "TABLESPOON",
  13: "TEASPOON",
};

export type Ingredient = {
  id: string;
  name: string;
  quantity: number;
  unit: number; // maps to UNITS
  modifier: string;
  createdAt: string; // ISO 8601 format
  createdBy: string; // UUID
  lastModifiedAt: string; // ISO 8601 format
  lastModifiedBy: string; // UUID
};
