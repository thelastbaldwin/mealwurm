class FetchWrapper {
  baseUrl: string;
  generalHeaders = {
    "Content-Type": "application/json",
    credentials: "same-origin",
  };

  constructor(baseUrl: string) {
    this.baseUrl = baseUrl;
  }

  async get(url: string, token: string) {
    try {
      const response = await fetch(`${this.baseUrl}${url}`, {
        method: "GET",
        headers: {
          ...this.generalHeaders,
          ...{ authorization: `Bearer ${token}` },
        },
      });
      return response.json();
    } catch (error: unknown) {
      console.log("Error fetching data:", error);
    }
  }

  async put<T>(url: string, data: T) {
    const response = await fetch(`${this.baseUrl}${url}`, {
      method: "PUT",
      body: JSON.stringify(data),
      headers: this.generalHeaders,
    });
    return response.json();
  }

  async post<T>(url: string, data: T) {
    const response = await fetch(`${this.baseUrl}${url}`, {
      method: "POST",
      body: JSON.stringify(data),
      headers: this.generalHeaders,
    });
    return response.json();
  }

  async delete(url: string) {
    const response = await fetch(`${this.baseUrl}${url}`, {
      method: "DELETE",
      headers: this.generalHeaders,
    });
    return response.json();
  }
}

const fetchWrapper = new FetchWrapper(import.meta.env.VITE_API_URL);
export default fetchWrapper;
