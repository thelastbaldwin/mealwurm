export type Ingredient = {
  id: string;
  text: string;
  createdAt: string; // ISO 8601 format
  createdBy: string; // UUID
  lastModifiedAt: string; // ISO 8601 format
  lastModifiedBy: string; // UUID
};
