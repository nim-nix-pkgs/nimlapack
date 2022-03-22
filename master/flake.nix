{
  description = ''Nim binding for LAPACK'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimlapack-master.flake = false;
  inputs.src-nimlapack-master.owner = "andreaferretti";
  inputs.src-nimlapack-master.ref   = "master";
  inputs.src-nimlapack-master.repo  = "nimlapack";
  inputs.src-nimlapack-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimlapack-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimlapack-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}