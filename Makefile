IN_ENV = . .venv/bin/activate;

env:
	python3 -m venv .venv
	$(IN_ENV) pip install -r requirements.txt

demo:
	sc -target asic_demo