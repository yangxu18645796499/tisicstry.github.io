+++
date = '2026-02-15T12:47:19+08:00'
draft = true
title = 'Rust_learning2'
+++
# 一个简单的Rust程序剖析
- main函数
- 从rust标准库导入
- 与命令行交互

## hello world！
- 定义函数
  - 没有参数，没有返回
- main函数很特别：他是每个rust可执行程序最先运行的代码
- println!是一个rust macro
  - 如果是函数的话，就没有!
- 代码以;结尾
## 编译和运行是单独的两步
## hello cargo
    cargo是构建系统和包管理工具
- 创建项目：cargo new hello_cargo
## cargo.toml
toml (Tom's Obvious, Minimal Language)格式，是cargo的配置格式
[pacakge],表示下方内容是用来配置包的
- name
- version
- authors
- edition
[dependencies]
rust中，代码中的包称作crate
## cargo 操作
cargo build
cargo run(构建运行)
cargo check 检查代码，确保通过编译，不是编译
cargo build --release
尽量用cargo