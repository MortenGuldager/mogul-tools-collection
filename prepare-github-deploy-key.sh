#!/bin/bash

set -e

GITHUB_REPO=$1

if [[ $GITHUB_REPO =~ ^git\@github\.com:(.+/.+)\.git$ ]]
then
    REPO_NAME=`echo ${BASH_REMATCH[1]}`
else
    echo bad repo. use the compete github reponame, in the ssh variant
    echo Usage $0 '<github uri>'
    echo something like: git@github.com:ExampleOrg/exmaple-repo.git
    exit
fi

REPO_NAME_CLEAN=`echo ${REPO_NAME} | tr '[:upper:]' '[:lower:]' |tr / _ |tr -dc '[[:alpha:]-_]'`

ssh-keygen -f ~/.ssh/$REPO_NAME_CLEAN-id_rsa -P "" -q

echo -e "\nThis is your public ssh key, copy-paste is as a deploy key in github:\n"

cat ~/.ssh/$REPO_NAME_CLEAN-id_rsa.pub


echo -e "\nTo do so visit:\n"
echo https://github.com/$REPO_NAME/settings/keys/new

echo -e "\nAnd this is how to clone the repo once the deploy key is installed:\n"

echo "git clone git@github.com-$REPO_NAME_CLEAN:$REPO_NAME.git"

echo $REPO_NAME_CLEAN >> ~/.ssh/repo-list
sort -u  ~/.ssh/repo-list >  ~/.ssh/repo-list.tmp
mv ~/.ssh/repo-list.tmp ~/.ssh/repo-list

cat ~/.ssh/repo-list | while read REPO_NAME_CLEAN
do
    cat  <<TXT
Host github.com-$REPO_NAME_CLEAN
    Hostname github.com
    IdentityFile=~/.ssh/$REPO_NAME_CLEAN-id_rsa

TXT
done > ~/.ssh/config-dep-keys
chmod og-rwx ~/.ssh/config-dep-keys
touch ~/.ssh/config
grep -q 'include config-dep-keys' ~/.ssh/config || echo 'include config-dep-keys' >> ~/.ssh/config
