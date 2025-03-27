
import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

// Define el hook para guardar/cargar threads
const Hooks = {
  ThreadPersister: {
    mounted() {
      console.log("Hook mounted, loading threads...");
      const savedThreads = localStorage.getItem("saved_threads");
      if (savedThreads) {
        console.log("Found saved threads:", savedThreads);
        this.pushEvent("load_saved_threads", { threads: JSON.parse(savedThreads) });
      }

      this.handleEvent("persist_threads", ({ threads }) => {
        console.log("Persisting threads:", threads);
        localStorage.setItem("saved_threads", JSON.stringify(threads));
      });
    }
  }
};



let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks  // Registra los hooks
})

// Conecta el socket
liveSocket.connect()
