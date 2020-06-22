FROM lambci/lambda:build-provided
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup install stable
WORKDIR /build-dir
COPY . /build-dir
RUN cargo build --release
CMD ["/bin/bash"]
