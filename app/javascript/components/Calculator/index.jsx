import React, { Component } from "react";
import PropTypes from "prop-types";

import Select from "./Select";

class Calculator extends Component {
  constructor(props) {
    super(props);

    this.state = {
      firstValue: props.firstValue,
      secondValue: props.secondValue,
      operator: props.operator
    };
  }

  calc = () =>
    eval(
      `${this.state.firstValue || 0} ${this.state.operator} ${this.state
        .secondValue || 0}`
    );

  render = () => (
    <div id="calc">
      <h1>{this.props.title}</h1>
      <input
        value={this.state.firstValue}
        onChange={e => this.setState({ firstValue: e.target.value })}
      />
      <Select
        value={this.state.operator}
        onChange={operator => this.setState({ opreator })}
      />
      <input
        value={this.state.secondValue}
        onChange={e => this.setState({ secondValue: e.target.value })}
      />
      = {this.calc()}
    </div>
  );
}

Calculator.propTypes = {
  title: PropTypes.string,
  firstValue: PropTypes.number,
  secondValue: PropTypes.number,
  operator: PropTypes.string
};

Calculator.defaultProps = {
  title: "Calculator",
  firstValue: 0,
  secondValue: 0,
  operator: "+"
};

export default Calculator;
