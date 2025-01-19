{
  allowUnfree = true;
  allowUnfreePredicate = pkgs: true;
  permittedInsecurePackages = [
    "electron-27.3.11" # for logseq, see https://github.com/logseq/logseq/issues/11644
  ];
}
