Google APIs Examples
====================

In this directory you can find samples of how to use the library to interact
with various services. These samples are ported from Google documentation. In
each subdirectory named like a service, there are 2 files:

* `samples.ml`: developer's guide samples
* `monadic.ml`: developer's guide samples using monadic style

See `auth/README.md` for details about the authorization process.

How to run calendar/samples.ml
------------------------------
* prepare
1. install opam
2. install gapi-opam with opam

    ```
    opam install -y gapi-opam
    ```
3. create oauth2 config file (e.g. .config)

    ```
    oa2_id=CLIENT_ID
    oa2_secret=SECRET
    oa2_uri=REDIRECT_URI
    access_token=CACHED_ACCESS_TOKEN(optional)
    refresh_token=CACHED_REFRESH_TOKEN(optional)
    ```
* a) using ocaml interpreter
1. edit config_file to refer oauth2 config file

    ```
    let config_file = ".config"
   ```
1. start ocaml

    ```
    ocaml
    ```
2. inside ocaml interpreter, input following lines

    ```
    # #use "topfind";;
    #require "gapi-ocaml"
    #use "calendar/samples.ml";;
    ```
* b) build & run
  1. build
 
    ```
    make
    ```
  2. run

    ```
    ./calendar_samples .config
    ```
* run
  * input code
* result 
  * events of google calendar are listed
  * and more?
