import React, { Component } from "react";
import PropTypes from "prop-types";
import { Table, Button, ButtonGroup, Form, Alert  } from "react-bootstrap";
import _ from "lodash";
import axios from "../config/axios"
class Warehouse extends Component {
    constructor(props) {
        super(props);
        this.state = {
          message: null,
          stocks: _.mapKeys(props.stocks, stock => stock.id),
          productId: 1,
          count: 1,
          variant: null
        };
    }
    createStock = async e => {
        e.preventDefault();
        try {
            let { data, status } = await axios.post(
                `/warehouses/${this.props.id}/stocks`,
                {
                  stock: {
                    product_id: this.state.productId,
                    count: this.state.count
                  }
                }
            );
            if (status === 200) {
                this.setState(({ stocks }) => ({
                  stocks: { ...stocks, [data.id]: data },
                  message: "Successfully created stock.",
                  variant: "success"
                }));
            }
        } catch (error) {
            const {
                response: { data }
            } = error;
            console.log(error.response);
        }
    };
    deleteStock = async stockId => {
        try {
            let { data, status } = await axios.delete(
                `/warehouses/${this.props.id}/stocks/${stockId}`
            );
            if (status === 200) {
                this.setState(({ stocks }) => ({
                    stocks: _.filter(
                    stocks,
                    stock => !(stock.id === data.id)
                    ),
                    message: "Successfully deleted stock.",
                    variant: "danger"
                }));
            }
        } catch (error) {
            const {
                response: { data }
            } = error;
            console.log(data);
        }
    };
    render = () => (
        <>
            {!_.isNull(this.state.message) && !_.isNull(this.state.variant) && (
                <Alert variant={this.state.variant}>
                <Alert.Heading>{this.state.message}</Alert.Heading>
                <Button
                    onClick={() => this.setState({ message: null, variant: null })}
                >
                    Close
                </Button>
                </Alert>
            )}
            <Form onSubmit={this.createStock}>
                <Form.Group>
                    <Form.Control
                        as="select"
                        onChange={e => this.setState({ productId: e.target.value })}
                        value={this.state.productId}
                    >
                        {_.map(this.props.products, product => (
                        <option value={product.id} key={product.id}>
                            {product.name}
                        </option>
                        ))}
                    </Form.Control>
                    <Form.Group>
                        <Form.Control
                        placeholder="Count"
                        value={this.state.count}
                        onChange={e => this.setState({ count: e.target.value })}
                        />
                    </Form.Group>
                </Form.Group>
                <Button type="submit" variant="success">
                    Add Stock
                </Button>
            </Form>
            <Table striped hover>
                <thead>
                    <tr>
                        <td>Product</td>
                        <td>Quantity</td>
                        <td>Actions</td>
                    </tr>
                </thead>
                <tbody>
                    {_.map(
                        this.state.stocks,
                        stock =>
                            stock.id && (
                                <tr key={stock.id}>
                                <td>{stock.product.name}</td>
                                <td>{stock.count}</td>
                                <td>
                                    <ButtonGroup>
                                    <Button variant="primary">&#9998;</Button>
                                    <Button
                                        variant="danger"
                                        onClick={() => this.deleteStock(stock.id)}
                                    >
                                        &#128465;
                                    </Button>
                                    </ButtonGroup>
                                </td>
                                </tr>
                            )
                    )}
                </tbody>
            </Table>
        </>
    );
}
Warehouse.propTypes = {
    id: PropTypes.number,
    product: PropTypes.arrayOf(
      PropTypes.shape({
        id: PropTypes.number,
        name: PropTypes.string
      })
    ),
    stocks: PropTypes.arrayOf(
      PropTypes.shape({
        count: PropTypes.number,
        id: PropTypes.number,
        product: PropTypes.shape({
          name: PropTypes.string,
          sku: PropTypes.string
        })
      })
    )
};
export default Warehouse;
