FROM ocaml/opam:alpine-3.13-ocaml-4.11 as build

RUN sudo apk add --no-cache libev-dev m4 linux-headers

ADD monadmin_bot.opam .
RUN opam install . --deps-only

ADD . .
RUN sudo chown -R opam:nogroup . && eval $(opam env) && dune build --build-dir /home/opam/build

FROM alpine:3.13

COPY --from=build /home/opam/build/default/bin/monadmin_bot.exe app.exe

RUN  apk add --no-cache libev-dev m4 linux-headers

CMD ./app.exe --port=$PORT --debug

