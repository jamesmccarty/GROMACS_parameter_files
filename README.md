# GROMACS_parameter_files
some example GROMACS .mdp files for setting up and performing moleculecular dynamics in GROMACS

Files include:
    ions.mpd - for use with genion to replace solvent molecules with ions
    em.mdp - to perform steepest descent energy minimization of a structure
    nvt.mdp - NVT ensemble with protein positions restrained
    npt.mdp - NPT ensemble equilibration using Parrinello-Rahman barostat 
    production_nvt.mdp - NVT ensemble using leap-frog integrator 
    production.mdp - NPT ensemble using leap-frog integrator
    vacuum.mdp - parameter file for running simulations in a vacuum (no solvent)
