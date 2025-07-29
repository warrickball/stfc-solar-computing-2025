help:
	@echo "make {help,check,build}"

check:
	Rscript -e "sandpaper::check_lesson()"

clean:
	Rscript -e "sandpaper::reset_site()"

build: FORCE
	Rscript -e "sandpaper::build_lesson(preview = FALSE)"

FORCE: ;
