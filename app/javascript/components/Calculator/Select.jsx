import React from "react";
import PropTypes from "prop-types";

import { OPERATORS } from "../../globals";

const Select = ({ value, onChange }) => (
  <select value={value} onChange={e => onChange(e.target.value)}>
    {OPERATORS.map(operator => (
      <option value={operator} key={operator}>
        {operator}
      </option>
    ))}
  </select>
);

Select.propTypes = {
  value: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequred
};

export default Select;
