FROM ocaml/opam:alpine-3.13-ocaml-4.11 as build
RUN sudo apk add --no-cache libev-dev m4 linux-headers

ADD monadmin_bot.opam .
RUN opam install . --deps-only


ADD . .
RUN sudo chown -R opam:nogroup . && eval $(opam env) && dune build @install

FROM alpine:3.13

COPY --from=build /home/opam/_build/default/bin/monadmin_bot.exe app.exe

RUN sudo apk add --no-cache libev-dev m4 linux-headers

EXPOSE 3000
CMD ./app.exe

