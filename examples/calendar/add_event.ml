(* Calendar service samples (http://code.google.com/apis/calendar/v3/using.html) *)

(*** Setup ***)

open GapiUtils.Infix
open GapiCalendarV3Model
open GapiCalendarV3Service
       
(*** How to configure your client and authenticate using OAuth 2.0 for native
   * applications. ***)

let config_file = Sys.argv.(1)
let config = Config.parse ~filename:config_file ()
let get = Config.get config
let set = Config.set config	     

let check_mark = "\xE2\x9C\x94"
let application_name = "post_done"

(* The clientId and clientSecret are copied from the API Access tab on
 * the Google APIs Console *)
let client_id = get "oa2_id"
let client_secret = get "oa2_secret"
let refresh_access_token = None
		      
let configuration =
  { GapiConfig.default with
        GapiConfig.application_name = application_name;
        GapiConfig.auth = GapiConfig.OAuth2
                            { GapiConfig.client_id;
                              client_secret;
			      refresh_access_token}}

(* Or your redirect URL for web based applications. *)
let redirect_uri = get "oa2_uri"
let scope = [GapiCalendarV3Service.Scope.calendar] 
(* Step 1: Authorize --> *)

let authorize session = 
  let authorization_url =
    GapiOAuth2.authorization_code_url
      ~redirect_uri
      ~scope
      ~response_type:"code"
      client_id in
  let code =
    begin
      (* Point or redirect your user to the authorization_url. *)
      print_endline "Go to the following link in your browser:";
      print_endline authorization_url;
      (* Read the authorization code from the standard input stream. *)
      print_endline "What is the authorization code?";
      input_line stdin
    end in
  (* Step 2: Exchange --> *)
  let (response, session) =
    GapiOAuth2.get_access_token
      ~client_id
      ~client_secret
      ~code
      ~redirect_uri
      session in
  match response with
    GapiAuthResponse.OAuth2AccessToken token ->
    (session,
     token.GapiAuthResponse.OAuth2.access_token,
     token.GapiAuthResponse.OAuth2.refresh_token)
  | _ -> failwith "Not supported OAuth2 response"
;;

  (* End of Step 1 <-- *)

(* Start a new session *)
let () =
  GapiConversation.with_curl
    configuration
    (fun session ->
     let (session, access_token, refresh_token) =
       try
	 (session, get "access_token", get "refresh_token")
       with Not_found -> 
	 let (session, access_token, refresh_token) as result = authorize session in
	 begin
	   set "access_token" access_token;
	   set "refresh_token" refresh_token;
	   Config.save ~filename:config_file config;
	   result
	 end in

     (* Step 2: Exchange --> *)
     (* End of Step 2 <-- *)

     (* Update session with OAuth2 tokens *)
     let session = {
	 session with
	 GapiConversation.Session.auth =
	   GapiConversation.Session.OAuth2 {
	       GapiConversation.Session.oauth2_token = access_token;
	       refresh_token
	     }
       } in
     
     (*** Working with events ***)
     
     (* Creating events *)
     let start_date = Unix.time () in
     (* 5min *)
     let end_date = start_date +. 300.0 in
    
     let event = {
	 Event.empty with
	 Event.summary = check_mark^"Appointment";
	 Event.location = "Somewhere";
	 Event.start = { EventDateTime.empty with
	 		 EventDateTime.dateTime =
	 		   Netdate.create start_date };
	 Event._end = { EventDateTime.empty with
	 		EventDateTime.dateTime =
	 		  Netdate.create end_date };
       } in
     let (created_event, session) =
       try
	 EventsResource.insert
	   ~calendarId:"primary"
	   event
	   session
       with GapiService.ServiceError e ->
	 print_endline e.GapiError.RequestError.message;
	 failwith "Error"
     in

     print_endline created_event.Event.id;
     (* Retrieving events *)
     let _ =
       let rec get_events next_page_token session =
	 let (events, session') =
	   try
	     EventsResource.list
	       ~pageToken:next_page_token
	       ~calendarId:"primary"
	       session
	   with Curl.CurlException _ as e ->
	     begin
	       Printexc.to_string e |> print_endline;
	       failwith "get event"
	     end    
	 in

	 List.iter
	   (fun event ->
	    print_endline event.Event.summary)
	   events.Events.items;

	 if events.Events.nextPageToken <> "" then
	   get_events events.Events.nextPageToken session'
	 else
	   session'
       in
       get_events "" session in
     ()
    )

