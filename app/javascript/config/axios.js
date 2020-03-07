import axios from "axios";
const instance = () => {
  const axiosInstance = axios.create();
  axiosInstance.interceptors.request.use(
    async config => {
      config.headers.common["X-CSRF-TOKEN"] = document.querySelector(
        '[name="csrf-token"]'
      ).content;
      config.headers.common["Accept"] = "application/json"; // this line should do the trick
      return config;
    },
    error => {
      Promise.reject(error);
    }
  );
  return axiosInstance;
};
export default instance();
