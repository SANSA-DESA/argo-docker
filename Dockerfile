FROM docker.io/jupyterhub/k8s-singleuser-sample:2.0.0
LABEL maintainer="SANSA <info@sansa.org.za>"

USER root
WORKDIR /tmp
# COPY start.sh /bin/start.sh
# RUN chmod 0777 /bin/start.sh
RUN mkdir /etc/datacube; ln -s /etc/datacube/datacube.conf /etc/datacube.conf

ENV PYCURL_SSL_LIBRARY=openssl
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    build-essential \
    python3.9-dev \
    libpq-dev \
    libgdal-dev \
    gcc \
    g++ \
    git \
    curl \
    libcurl3-openssl-dev \
    python3-gdal \
    python3-pip \
    vim \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

#    libgdal-dev=3.2.2+dfsg-2+deb11u2 \
#RUN apt-get update --yes && \
#    apt-get -y install curl libcurl3-openssl-dev && \
#    pip install --no-input --ignore-installed --force-reinstall pycurl

USER ${NB_UID}
WORKDIR "${HOME}"

# COPY conda-requirements.txt /tmp/
# RUN conda install -y -q -c conda-forge \
#    --file /tmp/conda-requirements.txt

# RUN conda update -y -n base conda ;\

# RUN conda install -y -q -c conda-forge \
#    gdal==3.4.0 \
#    dask-gateway==0.9.0 && \
#    conda install -y -q datacube==1.8.7

COPY freeze-requirements.txt /tmp/
RUN pip install -U --requirement /tmp/freeze-requirements.txt