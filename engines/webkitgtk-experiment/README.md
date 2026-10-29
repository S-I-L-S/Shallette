# WebKitGTK experiment (second engine track)

Minimal proof that Shallette's model (engine renders content, our chrome around it)
holds on a non-Gecko engine. See docs/ENGINES.md for why WebKitGTK is the recommended
second build.

Build on openSUSE Tumbleweed:

    sudo zypper in webkit2gtk3-devel gtk3-devel
    make
    ./shallette-webkit https://example.com

On this host (Mac Pro 5,1) the WebKitGTK runtime is already installed
(libwebkit2gtk-4.1 2.54.1) — only the -devel packages are missing.
