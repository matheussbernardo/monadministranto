open Opium

let url =
  Printf.sprintf "https://api.telegram.org/bot%s/sendMessage"
    (Sys.getenv "TELEGRAM_BOT")

let send_message chat_id text =
  let headers = Cohttp.Header.init_with "Content-Type" "application/json" in
  let json_body =
    `Assoc [ ("chat_id", `Int chat_id); ("text", `String text) ]
  in
  let body = json_body |> Yojson.Safe.to_string |> Cohttp_lwt.Body.of_string in
  Cohttp_lwt_unix.Client.post (Uri.of_string url) ~headers ~body

let print_json req =
  let open Lwt.Syntax in
  let+ json = Request.to_json_exn req in

  let update = json |> Telegram.Update.of_yojson |> Result.get_ok in
  Logs.info (fun m -> m "Received update: %s" update.message.text);
  let _message = send_message update.message.chat.id "RECEBIDO" in
  Response.of_json (`String "OK")

let app = App.empty |> App.post "/" print_json

let log_level = Some Logs.Debug

(** Configure the logger *)
let set_logger () =
  Logs.set_reporter (Logs_fmt.reporter ());
  Logs.set_level log_level

(** Run the application *)
let () =
  set_logger ();
  (* run_command' generates a CLI that configures a deferred run of the app *)
  match App.run_command' app with
  (* The deferred unit signals the deferred execution of the app *)
  | `Ok (app : unit Lwt.t) -> Lwt_main.run app
  | `Error -> exit 1
  | `Not_running -> exit 0
