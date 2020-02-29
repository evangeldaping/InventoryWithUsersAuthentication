import axios from "axios";
const instance = () => {
  const axiosInstance = axios.create();
  axiosInstance.interceptors.request.use(
    async config => {
      config.headers["X-CSRF-TOKEN"] = document.querySelector(
        '[name="csrf-token"]'
      ).content;
      config.headers["Content-Type"] = "application/json";
      return config;
    },
    error => {
      Promise.reject(error);
    }
  );
  return axiosInstance;
};
export default instance();
