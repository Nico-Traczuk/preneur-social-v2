
import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

// Define el hook para guardar/cargar threads
const Hooks = {
  ThreadPersister: {
    mounted() {
      // Cargar datos iniciales
      const savedThreads = localStorage.getItem("saved_threads");
      if (savedThreads) {
        this.pushEvent("load_threads", { threads: JSON.parse(savedThreads) });
      }

      // Escuchar eventos para guardar
      this.handleEvent("persist_threads", ({ threads }) => {
        localStorage.setItem("saved_threads", JSON.stringify(threads));
      });
    }
  }
};
const initialThreads = localStorage.getItem("saved_threads") || "[]";
document.getElementById("threads-container").dataset.initialThreads = initialThreads;


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks  // Registra los hooks
})

// Conecta el socket
liveSocket.connect()
