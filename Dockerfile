# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# builder image
FROM golang:1.15 as builder

WORKDIR /sigs.k8s.io/external-dns

COPY . .
RUN make build.amd64

# final image
FROM docker.io/bitnami/external-dns:0.7.6-debian-10-r0

USER root
COPY --from=builder /sigs.k8s.io/external-dns/build/external-dns /opt/bitnami/external-dns/bin/external-dns
USER 1001
