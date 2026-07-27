{
  allowUnfree = true;
  allowUnfreePredicate = pkgs: true;
  permittedInsecurePackages = [
    "electron-39.8.10" # for logseq, see older1 https://github.com/logseq/logseq/issues/11644
  ];
}
