import React from "react";
import PropTypes from "prop-types";

const Button = ({ color, onClick, children }) => (
  <button className={`btn btn-${color}`} onClick={onClick} type="button">
    {children}
  </button>
);

Button.propTypes = {
  color: PropTypes.string,
  onClick: PropTypes.func,
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.string,
    PropTypes.number
  ]).isRequired
};

Button.defaultProps = {
  color: "primary",
  onClick: () => {}
};

export default Button;
