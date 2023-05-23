# Think its simplest OS for Qt framework installing
FROM ubuntu:latest

# Setting ubuntu env
# build-essential libgl1-mesa-dev - is needed for Qt framework
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y cmake ninja-build g++ build-essential libgl1-mesa-dev git

RUN apt-get install -y \
    qml6-module-qtquick qt6-multimedia-dev linguist-qt6 \
    qt6-base-dev qt6-base-private-dev qt6-declarative-dev \
    qt6-declarative-private-dev qt6-tools-dev qt6-tools-private-dev \
    qt6-scxml-dev qt6-documentation-tools libqt6core5compat6-dev \
    qt6-tools-dev-tools qt6-l10n-tools qt6-shader-baker libqt6shadertools6-dev qt6-quick3d-dev \
    qt6-quick3d-dev-tools libqt6svg6-dev libqt6quicktimeline6-dev libqt6serialport6-dev

# Folder struct:
# vtkfolder
# | src
# | build
# | install
RUN mkdir vtk-folder && cd vtk-folder && \
    git clone https://github.com/Kitware/VTK.git src && \
    cd src && git checkout v9.2.0 && git submodule init && git submodule update && \
    cd Remote && git clone https://github.com/dgobbi/vtk-dicom

RUN cd vtk-folder && mkdir build && mkdir install

RUN cd vtk-folder/build && cmake ../src . \
    -DCMAKE_BUILD_TYPE=Release \
    -DVTK_GROUP_ENABLE_Qt=YES -DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES \
    -DVTK_MODULE_ENABLE_VTK_RenderingQt=YES -DVTK_MODULE_ENABLE_VTK_ViewsQt=YES -DVTK_QT_VERSION=6 \
    -DVTK_MODULE_ENABLE_VTK_DICOM=YES \
    -DCMAKE_INSTALL_PREFIX=/vtk-folder/install

RUN cd vtk-folder/build && \
    cmake --build . --config Debug -j 14 && \
    cmake --install .

ENV VTK_DIR /vtk-folder/install/lib/cmake/vtk-9.2

RUN mkdir app

ADD ./src app/

WORKDIR app