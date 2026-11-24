.PHONY: skill-zip validate

skill-zip:
	bash scripts/build-skill-zip.sh

validate:
	claude plugin validate .
