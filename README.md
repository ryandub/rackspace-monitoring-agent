Virgo
====================
A project.

License
====================

virgo is distributed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).


Building on a Unix-like Operating System
====================

    ./configure
    make

Building on Windows
====================

Install the following:

* Windows .NET 4 Framework: http://www.microsoft.com/net/
* Python 2.7: http://www.python.org/download/releases/2.7.2/
* MSYS Git: http://code.google.com/p/msysgit/
* Windows 7 SDK: https://www.microsoft.com/download/en/details.aspx?id=8279
* VS 2010 C++ Express: http://www.microsoft.com/visualstudio/en-us/products/2010-editions/visual-cpp-express
* VS 2010 SP1: https://www.microsoft.com/download/en/details.aspx?id=23691

Once the dependencies are installed:

    python configure
    python build.py

Then open `out/monitoring-agent.sln`.

See also: http://www.chromium.org/developers/how-tos/build-instructions-windows
