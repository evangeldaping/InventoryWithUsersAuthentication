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
