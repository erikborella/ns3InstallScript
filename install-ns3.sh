#!/bin/bash

sudo apt install gcc g++ python gcc g++ python python-dev mercurial python-setuptools git qt5-default gir1.2-goocanvas-2.0 python-gi python-gi-cairo python-pygraphviz python3-gi python3-gi-cairo python3-pygraphviz gir1.2-gtk-3.0 ipython ipython3 openmpi-bin openmpi-common openmpi-doc libopenmpi-dev autoconf cvs bzr unrar gdb valgrind  uncrustify doxygen graphviz imagemagick texlive texlive-extra-utils texlive-latex-extra texlive-font-utils texlive-lang-portuguese dvipng python-sphinx dia  gsl-bin libgsl-dev flex bison libfl-dev tcpdump sqlite sqlite3 libsqlite3-dev libxml2 libxml2-dev cmake libc6-dev libc6-dev-i386 libclang-dev llvm-dev automake libgtk2.0-0 libgtk2.0-dev vtun lxc libboost-signals-dev libboost-filesystem-dev

# faz a verificação do arquivo, faz o seu download e extrai seu conteudo

if [ -s "ns-allinone-3.28.tar.bz2" ]
then

    echo "Extraindo arquivos"
    tar xjf ns-allinone-3.28.tar.bz2

else

    echo "Arquivo ns-allinone-3.28.tar.bz2 não encontrado, fazendo o download dele"

    wget http://www.nsnam.org/release/ns-allinone-3.28.tar.bz2

    echo "Extraindo arquivos"

    tar xjf ns-allinone-3.28.tar.bz2
    rm ns-allinone-3.28.tar.bz2

fi

cd ns-allinone-3.28

echo "Compilando o ns-3"

./build.py --enable-examples --enable-tests

cd ns-3.28

echo "Configurando o ns-3"

./waf -d optimized --enable-examples --enable-tests configure

CXXFLAGS="-O3" ./waf configure

./waf -d optimized configure; ./waf

./waf --disable-python configure

./waf --enable-sudo configure

./waf distclean

rm -rf build

cd ../

./build.py --enable-examples --enable-tests

cd ns-3.28

./test.py -c core

clear

echo "Rodando Hellow word:..."

./waf --run hello-simulator
