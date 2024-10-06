import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Accordion from "./hooks/accordion"
import { initAccordions } from "./hooks/accordion";

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken},
  hooks: {
    Accordion
  }
})

// Initialize accordions when the DOM is loaded
document.addEventListener('DOMContentLoaded', initAccordions);

// ... rest of your app.js file
