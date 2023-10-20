# faster_cmake_paddle
通过脚本将 `cmake` 需要拉取的 `github` 地址替换为 `gitclone`。

### Step 1

将 `faster.sh` 拷贝到 `/Paddle/build` 目录下，也就是编译需要的文件夹。

### Step 2

赋予 `faster.sh` 可执行权限

``` shell
$> chmod +x faster.sh
```

### Step 3

通过 `faster.sh` 执行 `cmake` 命令，如：

``` shell
./faster.sh time cmake .. -DPY_VERSION=3.8 -DWITH_GPU=OFF -DWITH_TESTING=ON
```

脚本会先 `patch` `github` 地址，然后执行后面的 `cmake` 命令，命令执行完之后再 `restore` 修改的文件。

也可以单独 `patch` `restore`，如：

``` shell
$> ./faster.sh patch
$> ./faster.sh restore
```



