FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=codeigniter \
    BITNAMI_APP_VERSION=3.1.0-1 \
    PATH=/opt/bitnami/java/bin:/opt/bitnami/php/bin:/opt/bitnami/mysql/bin/:$PATH

# Install java dependency
RUN bitnami-pkg install java-1.8.0_91-0 --checksum 64cf20b77dc7cce3a28e9fe1daa149785c9c8c13ad1249071bc778fa40ae8773

# Install codeigniter related dependencies
RUN bitnami-pkg install php-7.0.10-0 --checksum 5f2ec47fcfb2fec5197af6760c5053dd5dee8084d70a488fd5ea77bd4245c6b9
RUN bitnami-pkg install mariadb-10.1.14-4 --checksum 4a75f4f52587853d69860662626c64a4540126962cd9ee9722af58a3e7cfa01b
RUN bitnami-pkg install mysql-client-10.1.13-4 --checksum 14b45c91dd78b37f0f2366712cbe9bfdf2cb674769435611955191a65dbf4976


# Install codeigniter module
RUN bitnami-pkg install codeigniter-3.1.0-0 --checksum 0e85ce8e75f327910b6647c25105f0ea2e4846c58dd560d97586b517fd575edc -- --applicationDirectory /projects

EXPOSE 8000

WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:8000:ref=codeigniter che:server:8000:protocol=http

ENV TERM=xterm

CMD ["harpoon", "start", "--foreground", "mariadb"]