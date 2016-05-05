OCAMLMAKEFILE=OCamlMakefile

SAMPLE_OPTS = RESULT=calendar_samples SOURCES="auth/config.ml calendar/samples.ml" PACKS=nethttpd,gapi-ocaml
#CLIENT_SAMPLE_OPTS = RESULT=client_sample SOURCES=src/client.ml PACKS=netclient

all: calendar_samples

calendar_samples: calendar/samples.ml
	make -f $(OCAMLMAKEFILE) $(SAMPLE_OPTS) dnc

clean:
	make -f $(OCAMLMAKEFILE) $(SAMPLE_OPTS) clean

