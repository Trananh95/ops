perl -pi.bak -e "s/(?<=($IMAGE_NAME:)).*/$IMAGE_TAG/g" docker-compose.yml

