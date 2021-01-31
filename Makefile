# The name of your project (as given in the dune-project file)
project_name = monadmin_bot

# The opam package configuration file
opam_file = $(project_name).opam

.PHONY: deps run run-debug

# Alis to update the opam file and install the needed deps
deps: $(opam_file)

# Build and run the app
run:
	dune exec ./bin/$(project_name).exe

# Build and run the app with Opium's internal debug messages visible
run-debug:
	dune exec ./bin/$(project_name).exe -- --debug

# Update the package dependencies when new deps are added to dune-project
$(opam_file): dune-project
	-dune build @install        # Update the $(project_name).opam file
	opam install . --deps-only # Install the new dependencies
		
