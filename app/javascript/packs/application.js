import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import popper from "popper.js";
import jquery from "jquery";
import "../application.scss";

window.Popper = popper;
window.jQuery = jquery;
window.$ = jquery;

import "bootstrap";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
// Support component names relative to this directory:
require.context("../images", true);

const componentRequireContext = require.context("components", true);
const ReactRailsUJS = require("react_ujs");

ReactRailsUJS.useContext(componentRequireContext);
