#! /bin/bash
VERSION="$1"
GIT_TOKEN="$2"
DATE=$(date +'%Y-%m-%dT%H:%M:%S%:z')

#Downloading jq to manipulate response
curl -s -L -o jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux32

chmod -R 755 ./jq
set -e

# Get Commit ID of master
commit=$(curl -s -H "Authorization:token ${GIT_TOKEN}" https://api.github.com/repos/argeualcantara/maven-spring-helloworld/commits/master)
COMMIT_ID=$(echo "$commit" | ./jq '.sha' | sed 's/"//g')
DATE=
# Get the full message associated with this tag
message=$(echo "$commit" | ./jq '.commit.message'  | sed 's/"//g')

echo "Creating tag"
tag=$(curl -s -X POST -H "Authorization:token ${GIT_TOKEN}" --data "{\"tag\": \"${VERSION}\", \"object\": \"${COMMIT_ID}\", \"message\": \"$message\", \"type\": \"commit\", \"tagger\": { \"name\": \"Jenkins\", \"email\": \"bot@jenkins.com\", \"date\": \"${DATE}\" }}" https://api.github.com/repos/argeualcantara/maven-spring-helloworld/git/tags)
echo "$tag" 
tag_sha=$(echo "$tag" | ./jq '.object.sha' | sed 's/"//g')
echo "$tag_sha" 
tag_ref=$(curl -s -X POST -H "Authorization:token ${GIT_TOKEN}" --data "{\"ref\": \"refs/tags/${VERSION}\", \"sha\": \"${tag_sha}\" }" https://api.github.com/repos/argeualcantara/maven-spring-helloworld/git/refs)
echo "Finished tag"

# Get the title and the description as separated variables
name="${VERSION}"
echo "$name" 

# Create a release
echo "Creating RELEASE"
release=$(curl -X POST -s -H "Authorization:token ${GIT_TOKEN}" --data "{\"tag_name\": \"${VERSION}\", \"target_commitish\": \"master\", \"name\": \"$name\", \"body\": \"$message\", \"draft\": false, \"prerelease\": false}" https://api.github.com/repos/argeualcantara/maven-spring-helloworld/releases)
echo "$release" 
# Extract the id of the release from the creation response
id=$(echo "$release" | sed -n -e 's/"id":\ \([0-9]\+\),/\1/p' | head -n 1 | sed 's/[[:blank:]]//g')

# Upload the artifact
echo "Uploading artifacts"
curl -X POST -s -o /dev/null -H "Authorization:token ${GIT_TOKEN}" -H "Content-Type:application/octet-stream" --data-binary @Dockerfile https://uploads.github.com/repos/argeualcantara/maven-spring-helloworld/releases/$id/assets?name=Dockerfile
echo "Finish release.sh"