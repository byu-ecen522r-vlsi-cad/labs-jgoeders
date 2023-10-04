
init:
	git submodule init
	git submodule update

create-conda-env:
	conda env create -f environment.yml
# after creating environment, run: conda activate openroad

openroad-deps:
	cd third_party/OpenROAD-flow-scripts && git submodule init
	cd third_party/OpenROAD-flow-scripts && git submodule update

	third_party/OpenROAD-flow-scripts/tools/OpenROAD/etc/DependencyInstaller.sh -local -common

openroad-flow-deps:	
# source ${HOME}/.local/env.sh before running this
	third_party/OpenROAD-flow-scripts/etc/DependencyInstaller.sh -local -common

openroad-build:
# source third_party/OpenROAD-flow-scripts/env.sh before running this
	third_party/OpenROAD-flow-scripts/build_openroad.sh --local