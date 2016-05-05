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
3. modify google api config in calenar/samples.ml

```
let client_id = "YOUR_CLIENT_ID"
let client_secret = "YOUR_CLIENT_SECRET"
let redirect_uri = "http://localhost/" (* sample *)
```

* a) using ocaml interpreter
1. start ocaml

    ```
    ocaml
    ```
2. inside ocaml

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
    ./calendar_samples
    ```
* run
  * input code
* result 
  * task is listed?
  * and more?
