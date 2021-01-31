(lang dune 2.0)

(generate_opam_files true)

(name monadmin_bot)

(version 0.1.0)

(authors "Matheus Bernardo")

(license MIT)

(source
 (uri "git+https://github.com/matheussbernardo/monadministranto.git"))

(maintainers "matheussbernardo@gmail.com")

(homepage "https://github.com/matheussbernardo/monadministranto")

(bug_reports "https://github.com/matheussbernardo/monadministranto/issues")

(documentation "https://github.com/matheussbernardo/monadministranto")

(package
 (name monadmin_bot)
 (synopsis "TELEGRAM BOT")
 (description "TELEGRAM BOT")
 (depends
  (dune
   (>= 2.8.2))
  (ocaml
   (>= 4.11.0))
  (core
   (>= v0.14.0))
  (opium
   (>= 0.20.0))
  (yojson
   (>= 1.7.0))
  (ppx_deriving_yojson
   (>= 3.6.1))
  (cohttp-lwt-unix
   (>= 2.5.4))
  (logs
   (>= 0.7.0))))
