# Dockerfile for binder

FROM sagemath/sagemath:8.8

# Copy the contents of the repo in ${HOME}
COPY --chown=sage:sage . ${HOME}

RUN sage -pip install jupyterlab
RUN sage -pip install 'RISE>=5.5.0,<5.7.0'
ARG SSL_KEYSTORE_PASSWORD
USER root
RUN apt-get update
# RUN apt-get install -y apt-utils
# RUN apt-get install -y make
RUN apt-get install -y git 
RUN git clone https://github.com/miguelmarco/kenzo/
WORKDIR kenzo
RUN git checkout testing
RUN sage -ecl < compile.lisp
RUN mv kenzo--all-systems.fasb ${HOME}/sage/local/lib/ecl/kenzo.fas
WORKDIR ${HOME}
COPY kenzo.py sage/src/sage/interfaces/
COPY kenzo.py sage/local/lib/python2.7/site-packages/sage/interfaces/
# RUN ls -l sage/src/sage/interfaces/
# WORKDIR sage
# RUN apt-get install -y make 
# RUN sage -br
WORKDIR ${HOME}
#user 1001


