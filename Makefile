# IN_ENV = conda activate openroad &&	

create-conda-env:
	conda env create -f environment.yml

openroad-deps:
	cd third_party/OpenROAD-flow-scripts && git submodule init
	cd third_party/OpenROAD-flow-scripts && git submodule update

	third_party/OpenROAD-flow-scripts/tools/OpenROAD/etc/DependencyInstaller.sh -local -common

openroad-flow-deps:	
	. ${HOME}/.local/env.sh && third_party/OpenROAD-flow-scripts/etc/DependencyInstaller.sh -local -common

openroad-build:
	. ${HOME}/.local/env.sh && third_party/OpenROAD-flow-scripts/build_openroad.sh --local