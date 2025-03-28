defmodule ProjectSocialNetworksWeb.ThoughtLive do
  use ProjectSocialNetworksWeb, :live_view

  # Datos de ejemplo
  @mock_pensamientos [
    %{
      id: 1,
      usuario: %{nombre: "Juan Roman Riquelme", avatar: "https://tn.com.ar/resizer/NHBFFiOPddpYnb6QrPdPty5wcaI=/arc-anglerfish-arc2-prod-artear/public/QLNSCUL7PZIBGS27B4XQPOQ4EU.jpg"},
      contenido: "Seremos menos malos que los demas ",
      imagen: "https://media.tycsports.com/files/2023/11/03/641148/riquelme_1440x810_wmk.webp?v=2",
      hora: "10:30 AM",
      fecha: "Hoy"
    },
    %{
      id: 2,
      usuario: %{nombre: "Franco Colapinto", avatar: "https://tn.com.ar/resizer/v2/franco-colapinto-todavia-no-debuto-como-piloto-de-alpine-foto-xalpinef1team-GQZBS625SRCYDMRAD77NYUJISI.png?auth=ac3de868422c9c58025dc345af8110c26b8ff6631c52f617e456d84c3e21595b&width=767"},
      contenido: "No se quien es la china suarez, yo solo manejo autos",
      hora: "Ayer",
      fecha: "2:45 PM"
    },
    %{
      id: 3,
      usuario: %{nombre: "Nicolas Traczuk", avatar: "https://i.ibb.co/XrNtwJ1P/Whats-App-Image-2025-01-08-at-7-39-33-PM.jpg"},
      contenido: "Tailwind > Bootstrap.",
      hora: "Ayer",
      fecha: "9:15 AM"
    }
  ]

  # def mount(_params, _session, socket) do
  #   IO.inspect("LiveView Montado")
  #   {:ok, assign(socket,

  #     mostrar_modal: false,
  #     pensamientos: @mock_pensamientos,
  #     nuevo_pensamiento: ""

  #   )}
  # end

  def mount(_params, _session, socket) do
    # Carga inicial desde localStorage (si existe)
    if connected?(socket) do
      send(self(), :load_from_localstorage)
    end

    {:ok, assign(socket,
      mostrar_modal: false,
      pensamientos: @mock_pensamientos,
      nuevo_pensamiento: ""

    )}
  end
  def render(assigns) do
    ~H"""
    <div class="h-screen w-full  absolute">

    <div class="fixed top-0 left-0 w-20 hover:w-64 bg-black h-screen p-4 transition-all duration-300 ease-in-out overflow-hidden group border-r-2">
      <!-- Logo - Mantiene tamaño grande -->
      <div class="bg-black rounded-xl px-2 py-4 mb-2 ">
        <img
          src="https://preneur.ai/assets/images/Preneur_Logo_Light_AI_hyy3tf.png"

        />
      </div>

      <!-- Menú -->
      <ul class="space-y-5  ">
        <!-- Inicio -->
        <li>
          <a href="#" class=" transform transition duration-300 ease-in-out flex items-center p-3 rounded-xl text-gray-200 hover:bg-white hover:text-black">
            <!-- Ícono - Tamaño fijo -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor"> <!-- Aumenté a h-8 w-8 -->
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
            </svg>
            <!-- Texto que solo aparece en hover -->
            <span class="ml-4 font-medium hidden group-hover:inline text-lg">Home</span> <!-- Añadí text-lg -->
          </a>
        </li>

        <!-- Explorar -->
        <li>
          <a href="#" class="transform transition duration-300 ease-in-out flex items-center p-3 rounded-xl text-gray-200 hover:bg-white hover:text-black">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <span class="ml-4 font-medium hidden group-hover:inline text-lg">Explore</span>
          </a>
        </li>

        <!-- Notificaciones -->
        <li>
          <a href="#" class="transform transition duration-300 ease-in-out flex items-center p-3 rounded-xl text-gray-200 hover:bg-white hover:text-black">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
            </svg>
            <span class="ml-4 font-medium hidden group-hover:inline text-lg">Notifications</span>
          </a>
        </li>

        <!-- Mensajes -->
        <li>
          <a href="#" class="transform transition duration-300 ease-in-out flex items-center p-3 rounded-xl text-gray-200 hover:bg-white hover:text-black">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
            </svg>
            <span class="ml-4 font-medium hidden group-hover:inline text-lg">Messages</span>
          </a>
        </li>

        <!-- Perfil -->
        <li>
          <a href="#" class="flex items-center p-3 rounded-xl text-gray-200 hover:bg-white hover:text-black">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
            </svg>
            <span class="ml-4 font-medium hidden group-hover:inline text-lg">Profile</span>
          </a>
        </li>
      </ul>
    </div>

    <!-- Contenido con titulo -->
      <div class="max-w-2xl container  mx-auto ">

        <!-- Botón para abrir modal -->
        <button id="abrir-modal"
          phx-click="mostrar_modal"
          class="transform transition duration-300 ease-in-out fixed bottom-8 right-8 bg-red-300 hover:bg-red-400 text-white rounded-full p-4 shadow-lg hover:cursor-pointer"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
          </svg>
        </button>

        <!-- Lista de pensamientos -->
          <div id="threads-container" phx-hook="ThreadPersister"  class="overflow-y-scroll space-y-4  p-5 h-full bg-gray-50 h-screen">
            <div>
              <h1 class="text-2xl font-bold px-2 py-2   hover:underline  ">What is happening in Preneur World?</h1>
            </div>
            <div>
            <form phx-submit="agregar_pensamiento" class="p-4 border-b-2 border-gray-200" >
              <div class="flex space-x-3">
                <img
                  src="https://i.ibb.co/XrNtwJ1P/Whats-App-Image-2025-01-08-at-7-39-33-PM.jpg"
                  alt="Tu avatar"
                  class="h-16 w-16 rounded-full object-cover"
                />
                <textarea
                  name="pensamiento"
                  phx-change="actualizar_texto"
                  value={@nuevo_pensamiento}
                  class="flex-1 border-1 rounded-lg border-gray-300 focus:ring-0 text-gray-800 placeholder-gray-400 resize-none"
                  rows="3"
                  placeholder="What are you thinking?"
                  autofocus
                ></textarea>
              </div>

              <div class="mt-2 flex justify-end space-x-3">

                <button
                  type="submit"
                  class="px-4 py-2 rounded-full bg-red-400 text-white hover:bg-red-600 disabled:opacity-50"
                  disabled={@nuevo_pensamiento == ""}
                >
                  Send
                </button>
              </div>
            </form>
            </div>

          <%= for pensamiento <- @pensamientos do %>
            <div id={"thread-#{pensamiento.id}"}  class="thread-item bg-white p-4 border-2 border-gray-200 shadow rounded-xl shadow-white">
              <div class="flex items-start space-x-4 ">
                <img
                  src={pensamiento.usuario.avatar}
                  alt="imagen avatar"
                  class="h-16 w-16 rounded-full object-cover"
                />
                <div class="flex-1">
                  <div class="flex items-center space-x-2">
                    <span class="font-semibold text-gray-900"><%= pensamiento.usuario.nombre %></span>
                    <span class="text-gray-500 text-sm">· <%= pensamiento.fecha %> a las <%= pensamiento.hora %></span>
                  </div>
                  <p class="mt-1 text-gray-800"><%= pensamiento.contenido %></p>
                  <%= if pensamiento[:imagen] do %>
                    <div class="mt-3 rounded-lg overflow-hidden">
                      <img
                        src={pensamiento[:imagen]}
                        class="w-full h-auto max-h-96 object-cover rounded-lg"
                        alt="Imagen adjunta"
                      />
                    </div>
                  <% end %>
                  <div class="mt-3 flex space-x-4 text-gray-500 text-sm">
                    <button class="transform transition duration-300 ease-in-out flex items-center space-x-1 hover:text-white hover:bg-blue-400 rounded-full p-2 hover:cursor-pointer">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                      </svg>
                      <span>Like</span>
                    </button>
                    <button class="transform transition duration-300 ease-in-out flex items-center space-x-1 hover:text-white hover:bg-green-400 rounded-full p-2 hover:cursor-pointer">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
                      </svg>
                      <span>Comment</span>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          <% end %>
        </div>
        <%= if @mostrar_modal do %>
        <div id="send-modal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50"
            phx-window-keydown="cerrar_modal"
            phx-key="escape">

          <div class="bg-white rounded-lg shadow-xl w-full max-w-xl" phx-click-away="cerrar_modal">
            <div class="p-4 border-b">
              <h2 class="text-xl font-bold text-gray-800">What are you thinking?</h2>
            </div>

           <form phx-submit="agregar_pensamiento" class="p-4" phx-click-away={JS.push("cerrar_modal")}>
              <div class="flex space-x-3">
                <img
                  src="https://i.ibb.co/XrNtwJ1P/Whats-App-Image-2025-01-08-at-7-39-33-PM.jpg"
                  alt="Tu avatar"
                  class="h-16 w-16 rounded-full object-cover"
                />
                <textarea
                  name="pensamiento"
                  phx-change="actualizar_texto"
                  value={@nuevo_pensamiento}
                  class="flex-1 border-1 rounded-lg border-gray-300 focus:ring-0 text-gray-800 placeholder-gray-400 resize-none"
                  rows="3"
                  placeholder="What are you thinking?"
                  autofocus
                ></textarea>
              </div>

              <div class="mt-4 flex justify-end space-x-3">
                <button
                  type="button"
                  phx-click="cerrar_modal"
                  class="px-4 py-2 rounded-full border border-gray-300 text-gray-700 hover:bg-gray-200"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  class="px-4 py-2 rounded-full bg-red-400 text-white hover:bg-red-600 disabled:opacity-50"
                  disabled={@nuevo_pensamiento == ""}
                >
                  Send
                </button>
              </div>
            </form>
          </div>
        </div>
      <% end %>
    </div>
      </div>




    """
  end


  # Saver y cargar threads


  # Manejadores de eventos
  def handle_event("mostrar_modal", _params, socket) do

    {:noreply, assign(socket, :mostrar_modal, true)}
  end

  def handle_event("cerrar_modal", _, socket) do
    {:noreply, assign(socket, :mostrar_modal, false)}
  end

  def handle_event("actualizar_texto", %{"pensamiento" => texto}, socket) do
    {:noreply, assign(socket, nuevo_pensamiento: texto)}
  end

  def handle_event("load_saved_threads", %{"threads" => threads}, socket) do
    {:noreply, assign(socket, pensamientos: threads)}
  end

  def handle_event("restore_threads", %{"threads" => threads}, socket) do
    {:noreply, assign(socket, pensamientos: threads)}
  end

  def handle_event("agregar_pensamiento", %{"pensamiento" => texto}, socket) do
    # Validación básica (opcional)
    if String.trim(texto) == "" do
      {:noreply, socket}
    else
      nuevo_pensamiento = %{
        id: System.unique_integer([:positive]),
        usuario: %{nombre: "Tú", avatar: "https://i.ibb.co/XrNtwJ1P/Whats-App-Image-2025-01-08-at-7-39-33-PM.jpg"},
        contenido: texto,
        fecha: "Ahora",
        hora: "Ahora"
      }

      updated_threads = [nuevo_pensamiento | socket.assigns.pensamientos]

      {:noreply,
       socket
       |> assign(
          pensamientos: updated_threads,
          nuevo_pensamiento: "",
          mostrar_modal: false,
          updated_at: System.unique_integer([:positive])  # Fuerza re-render
       )
       |> push_event("persist_threads", %{threads: updated_threads})
      }
    end
  end

end
