OCAMLMAKEFILE=OCamlMakefile

SAMPLE_OPTS = RESULT=calendar_samples SOURCES="auth/config.ml calendar/samples.ml" PACKS=nethttpd,gapi-ocaml
ADD_EVENT_OPTS = RESULT=add_event SOURCES="auth/config.ml calendar/add_event.ml" PACKS=nethttpd,gapi-ocaml
#CLIENT_SAMPLE_OPTS = RESULT=client_sample SOURCES=src/client.ml PACKS=netclient

all: calendar_samples add_event

calendar_samples: auth/config.ml calendar/samples.ml
	make -f $(OCAMLMAKEFILE) $(SAMPLE_OPTS) dnc

add_event: auth/config.ml calendar/add_event.ml
	make -f $(OCAMLMAKEFILE) $(ADD_EVENT_OPTS) dnc

clean:
	make -f $(OCAMLMAKEFILE) $(SAMPLE_OPTS) clean
	make -f $(OCAMLMAKEFILE) $(ADD_EVENT_OPTS) clean

