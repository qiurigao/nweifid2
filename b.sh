#!/bin/bash

###/tmp/alist -conf /overlay/data/alist/config.json
PATH=$PATH:/home/lenovo/openwrt-sdk-21.02.2-ramips-mt7621_gcc-8.4.0_musl.Linux-x86_64/staging_dir/toolchain-mipsel_24kc_gcc-8.4.0_musl/bin
export STAGING_DIR=/home/lenovo/openwrt-sdk-21.02.2-ramips-mt7621_gcc-8.4.0_musl.Linux-x86_64/staging_dir/toolchain-mipsel_24kc_gcc-8.4.0_musl/bin:$STAGING_DIR

appName="alist"
  builtAt="$(date +'%F %T %z')"
  goVersion=$(go version | sed 's/go version //')
  gitAuthor=$(git show -s --format='format:%aN <%ae>' HEAD)
  gitCommit=$(git log --pretty=format:"%h" -1)
  gitTag=$(git describe --long --tags --dirty --always)
  webTag=$(wget -qO- -t1 -T2 "https://api.github.com/repos/alist-org/alist-web/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
  ldflags="\
-w -s \
-X 'github.com/Xhofe/alist/conf.BuiltAt=$builtAt' \
-X 'github.com/Xhofe/alist/conf.GoVersion=$goVersion' \
-X 'github.com/Xhofe/alist/conf.GitAuthor=$gitAuthor' \
-X 'github.com/Xhofe/alist/conf.GitCommit=$gitCommit' \
-X 'github.com/Xhofe/alist/conf.GitTag=$gitTag' \
-X 'github.com/Xhofe/alist/conf.WebTag=$webTag' \
  "
	  export GOOS=linux
      export GOARCH=mipsle 
	  export CXX=mipsel-openwrt-linux-musl-g++
      export CC=mipsel-openwrt-linux-musl-gcc
      export CGO_ENABLED=1
	  export GOMIPS=softfloat
      go build -o ./build/$appName-$os_arch -ldflags="$ldflags" -tags=jsoniter alist.go
	  
########### /tmp/PanIndex -c=/overlay/data/PanIndex/config.json

ldflags="\
  -w -s \
  -X 'github.com/libsgh/PanIndex/module.VERSION=${RELEASE_TAG}' \
  -X 'github.com/libsgh/PanIndex/module.BUILD_TIME=$(date "+%F %T")' \
  -X 'github.com/libsgh/PanIndex/module.GO_VERSION=$(go version)' \
  -X 'github.com/libsgh/PanIndex/module.GIT_COMMIT_SHA=$(git show -s --format=%H)' \
  "
  export CGO_ENABLED=1 
  export GOOS=linux
  export GOARCH=mipsle 
  export CC=mipsel-openwrt-linux-musl-gcc 
  export GOMIPS=softfloat
  go build -o ./dist/PanIndex -ldflags="$ldflags" -tags=jsoniter .



  PATH=$PATH:/root/openwrt-sdk-22.03.5-ramips-mt7621_gcc-11.2.0_musl.Linux-x86_64/staging_dir/toolchain-mipsel_24kc_gcc-11.2.0_musl/bin
export STAGING_DIR=/root/openwrt-sdk-22.03.5-ramips-mt7621_gcc-11.2.0_musl.Linux-x86_64/staging_dir/toolchain-mipsel_24kc_gcc-11.2.0_musl/bin:$STAGING_DIR

export CGO_ENABLED=0
  export GOOS=linux
  export GOARCH=mipsle 
  export CC=mipsel-openwrt-linux-musl-gcc 
  export CXX=mipsel-openwrt-linux-musl-g++
  export GOMIPS=softfloat



go build -ldflags '-s -w --extldflags "-static -fpic"'


CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"'
	  
	  
