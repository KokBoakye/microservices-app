# 📎 Microservices Demo on AWS EKS

This project is a complete microservices-based application deployed on **Amazon EKS**, with infrastructure provisioned using **Terraform**, container images pushed to **AWS ECR**, and deployments automated via **GitHub Actions CI/CD**.


## Architecture

**Online Boutique** is composed of 11 microservices written in different
languages that talk to each other over gRPC.

[![Architecture of
microservices](/docs/img/architecture-diagram.png)](/docs/img/architecture-diagram.png)

Find **Protocol Buffers Descriptions** at the [`./protos` directory](/protos).

| Service                                              | Language      | Description                                                                                                                       |
| ---------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| [frontend](/src/frontend)                           | Go            | Exposes an HTTP server to serve the website. Does not require signup/login and generates session IDs for all users automatically. |
| [cartservice](/src/cartservice)                     | C#            | Stores the items in the user's shopping cart in Redis and retrieves it.                                                           |
| [productcatalogservice](/src/productcatalogservice) | Go            | Provides the list of products from a JSON file and ability to search products and get individual products.                        |
| [currencyservice](/src/currencyservice)             | Node.js       | Converts one money amount to another currency. Uses real values fetched from European Central Bank. It's the highest QPS service. |
| [paymentservice](/src/paymentservice)               | Node.js       | Charges the given credit card info (mock) with the given amount and returns a transaction ID.                                     |
| [shippingservice](/src/shippingservice)             | Go            | Gives shipping cost estimates based on the shopping cart. Ships items to the given address (mock)                                 |
| [emailservice](/src/emailservice)                   | Python        | Sends users an order confirmation email (mock).                                                                                   |
| [checkoutservice](/src/checkoutservice)             | Go            | Retrieves user cart, prepares order and orchestrates the payment, shipping and the email notification.                            |
| [recommendationservice](/src/recommendationservice) | Python        | Recommends other products based on what's given in the cart.                                                                      |
| [adservice](/src/adservice)                         | Java          | Provides text ads based on given context words.                                                                                   |
| [loadgenerator](/src/loadgenerator)                 | Python/Locust | Continuously sends requests imitating realistic user shopping flows to the frontend.                                              |

## Screenshots

| Home Page                                                                                                         | Checkout Screen                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [![Screenshot of store homepage](/docs/img/online-boutique-frontend-1.png)](/docs/img/online-boutique-frontend-1.png) | [![Screenshot of checkout screen](/docs/img/online-boutique-frontend-2.png)](/docs/img/online-boutique-frontend-2.png) |


---

## 📌 Project Overview

* ✅ Microservices loosely coupled via REST APIs
* ✅ Dockerized services
* ✅ Infrastructure as Code with Terraform
* ✅ Images stored in Amazon ECR
* ✅ Deployed to Amazon EKS
* ✅ CI/CD pipeline using GitHub Actions

---

## 💠 Tech Stack

| Layer              | Tool/Service            |
| ------------------ | ----------------------- |
| Cloud Provider     | AWS                     |
| Container Runtime  | Docker                  |
| Container Registry | AWS ECR                 |
| Orchestration      | Amazon EKS (Kubernetes) |
| Infrastructure     | Terraform               |
| CI/CD              | GitHub Actions          |
| Networking         | AWS VPC, Subnets        |

---

## 📂 Project Structure

```
.
├── LICENSE
├── README.md
├── cloudbuild.yaml
├── docs
│   ├── cloudshell-tutorial.md
│   ├── deploystack.md
│   ├── development-guide.md
│   ├── img
│   │   ├── architecture-diagram.png
│   │   ├── memorystore.png
│   │   ├── online-boutique-frontend-1.png
│   │   └── online-boutique-frontend-2.png
│   ├── product-requirements.md
│   ├── purpose.md
│   └── releasing
│       ├── README.md
│       ├── license_header.txt
│       ├── make-docker-images.sh
│       ├── make-helm-chart.sh
│       ├── make-release-artifacts.sh
│       └── make-release.sh
├── helm-chart
│   ├── Chart.yaml
│   ├── README.md
│   ├── templates
│   │   ├── NOTES.txt
│   │   ├── adservice.yaml
│   │   ├── cartservice.yaml
│   │   ├── checkoutservice.yaml
│   │   ├── common.yaml
│   │   ├── currencyservice.yaml
│   │   ├── emailservice.yaml
│   │   ├── frontend.yaml
│   │   ├── loadgenerator.yaml
│   │   ├── opentelemetry-collector.yaml
│   │   ├── paymentservice.yaml
│   │   ├── productcatalogservice.yaml
│   │   ├── recommendationservice.yaml
│   │   └── shippingservice.yaml
│   └── values.yaml
├── istio-1.26.3
│   ├── LICENSE
│   ├── README.md
│   ├── bin
│   │   └── istioctl
│   ├── manifest.yaml
│   ├── manifests
│   │   ├── charts
│   │   │   ├── README.md
│   │   │   ├── UPDATING-CHARTS.md
│   │   │   ├── base
│   │   │   │   ├── Chart.yaml
│   │   │   │   ├── README.md
│   │   │   │   ├── files
│   │   │   │   │   ├── crd-all.gen.yaml
│   │   │   │   │   ├── profile-ambient.yaml
│   │   │   │   │   ├── profile-compatibility-version-1.23.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.24.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.25.
yaml                                                       │   │   │   │   │   ├── profile-demo.yaml
│   │   │   │   │   ├── profile-platform-gke.yaml
│   │   │   │   │   ├── profile-platform-k3d.yaml
│   │   │   │   │   ├── profile-platform-k3s.yaml
│   │   │   │   │   ├── profile-platform-microk8s.yaml
│   │   │   │   │   ├── profile-platform-minikube.yaml
│   │   │   │   │   ├── profile-platform-openshift.yaml
│   │   │   │   │   ├── profile-preview.yaml
│   │   │   │   │   ├── profile-remote.yaml
│   │   │   │   │   └── profile-stable.yaml
│   │   │   │   ├── templates
│   │   │   │   │   ├── NOTES.txt
│   │   │   │   │   ├── crds.yaml
│   │   │   │   │   ├── defaultrevision-validatingadmission
policy.yaml                                                │   │   │   │   │   ├── defaultrevision-validatingwebhookco
nfiguration.yaml                                           │   │   │   │   │   ├── reader-serviceaccount.yaml
│   │   │   │   │   └── zzz_profile.yaml
│   │   │   │   └── values.yaml
│   │   │   ├── default
│   │   │   │   ├── Chart.yaml
│   │   │   │   ├── files
│   │   │   │   │   ├── profile-ambient.yaml
│   │   │   │   │   ├── profile-compatibility-version-1.23.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.24.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.25.
yaml                                                       │   │   │   │   │   ├── profile-demo.yaml
│   │   │   │   │   ├── profile-platform-gke.yaml
│   │   │   │   │   ├── profile-platform-k3d.yaml
│   │   │   │   │   ├── profile-platform-k3s.yaml
│   │   │   │   │   ├── profile-platform-microk8s.yaml
│   │   │   │   │   ├── profile-platform-minikube.yaml
│   │   │   │   │   ├── profile-platform-openshift.yaml
│   │   │   │   │   ├── profile-preview.yaml
│   │   │   │   │   ├── profile-remote.yaml
│   │   │   │   │   └── profile-stable.yaml
│   │   │   │   ├── templates
│   │   │   │   │   ├── mutatingwebhook.yaml
│   │   │   │   │   ├── validatingwebhook.yaml
│   │   │   │   │   └── zzz_profile.yaml
│   │   │   │   └── values.yaml
│   │   │   ├── gateway
│   │   │   │   ├── Chart.yaml
│   │   │   │   ├── README.md
│   │   │   │   ├── files
│   │   │   │   │   ├── profile-ambient.yaml
│   │   │   │   │   ├── profile-compatibility-version-1.23.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.24.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.25.
yaml                                                       │   │   │   │   │   ├── profile-demo.yaml
│   │   │   │   │   ├── profile-platform-gke.yaml
│   │   │   │   │   ├── profile-platform-k3d.yaml
│   │   │   │   │   ├── profile-platform-k3s.yaml
│   │   │   │   │   ├── profile-platform-microk8s.yaml
│   │   │   │   │   ├── profile-platform-minikube.yaml
│   │   │   │   │   ├── profile-platform-openshift.yaml
│   │   │   │   │   ├── profile-preview.yaml
│   │   │   │   │   ├── profile-remote.yaml
│   │   │   │   │   └── profile-stable.yaml
│   │   │   │   ├── templates
│   │   │   │   │   ├── NOTES.txt
│   │   │   │   │   ├── _helpers.tpl
│   │   │   │   │   ├── deployment.yaml
│   │   │   │   │   ├── hpa.yaml
│   │   │   │   │   ├── poddisruptionbudget.yaml
│   │   │   │   │   ├── role.yaml
│   │   │   │   │   ├── service.yaml
│   │   │   │   │   ├── serviceaccount.yaml
│   │   │   │   │   └── zzz_profile.yaml
│   │   │   │   ├── values.schema.json
│   │   │   │   └── values.yaml
│   │   │   ├── gateways
│   │   │   │   ├── istio-egress
│   │   │   │   │   ├── Chart.yaml
│   │   │   │   │   ├── NOTES.txt
│   │   │   │   │   ├── files
│   │   │   │   │   │   ├── profile-ambient.yaml
│   │   │   │   │   │   ├── profile-compatibility-version-1
.23.yaml                                                   │   │   │   │   │   │   ├── profile-compatibility-version-1
.24.yaml                                                   │   │   │   │   │   │   ├── profile-compatibility-version-1
.25.yaml                                                   │   │   │   │   │   │   ├── profile-demo.yaml
│   │   │   │   │   │   ├── profile-platform-gke.yaml
│   │   │   │   │   │   ├── profile-platform-k3d.yaml
│   │   │   │   │   │   ├── profile-platform-k3s.yaml
│   │   │   │   │   │   ├── profile-platform-microk8s.yaml
│   │   │   │   │   │   ├── profile-platform-minikube.yaml
│   │   │   │   │   │   ├── profile-platform-openshift.yaml
│   │   │   │   │   │   ├── profile-preview.yaml
│   │   │   │   │   │   ├── profile-remote.yaml
│   │   │   │   │   │   └── profile-stable.yaml
│   │   │   │   │   ├── templates
│   │   │   │   │   │   ├── _affinity.tpl
│   │   │   │   │   │   ├── autoscale.yaml
│   │   │   │   │   │   ├── deployment.yaml
│   │   │   │   │   │   ├── injected-deployment.yaml
│   │   │   │   │   │   ├── poddisruptionbudget.yaml
│   │   │   │   │   │   ├── role.yaml
│   │   │   │   │   │   ├── rolebindings.yaml
│   │   │   │   │   │   ├── service.yaml
│   │   │   │   │   │   ├── serviceaccount.yaml
│   │   │   │   │   │   └── zzz_profile.yaml
│   │   │   │   │   └── values.yaml
│   │   │   │   └── istio-ingress
│   │   │   │       ├── Chart.yaml
│   │   │   │       ├── NOTES.txt
│   │   │   │       ├── files
│   │   │   │       │   ├── profile-ambient.yaml
│   │   │   │       │   ├── profile-compatibility-version-1
.23.yaml                                                   │   │   │   │       │   ├── profile-compatibility-version-1
.24.yaml                                                   │   │   │   │       │   ├── profile-compatibility-version-1
.25.yaml                                                   │   │   │   │       │   ├── profile-demo.yaml
│   │   │   │       │   ├── profile-platform-gke.yaml
│   │   │   │       │   ├── profile-platform-k3d.yaml
│   │   │   │       │   ├── profile-platform-k3s.yaml
│   │   │   │       │   ├── profile-platform-microk8s.yaml
│   │   │   │       │   ├── profile-platform-minikube.yaml
│   │   │   │       │   ├── profile-platform-openshift.yaml
│   │   │   │       │   ├── profile-preview.yaml
│   │   │   │       │   ├── profile-remote.yaml
│   │   │   │       │   └── profile-stable.yaml
│   │   │   │       ├── templates
│   │   │   │       │   ├── _affinity.tpl
│   │   │   │       │   ├── autoscale.yaml
│   │   │   │       │   ├── deployment.yaml
│   │   │   │       │   ├── injected-deployment.yaml
│   │   │   │       │   ├── poddisruptionbudget.yaml
│   │   │   │       │   ├── role.yaml
│   │   │   │       │   ├── rolebindings.yaml
│   │   │   │       │   ├── service.yaml
│   │   │   │       │   ├── serviceaccount.yaml
│   │   │   │       │   └── zzz_profile.yaml
│   │   │   │       └── values.yaml
│   │   │   ├── install-OpenShift.md
│   │   │   ├── istio-cni
│   │   │   │   ├── Chart.yaml
│   │   │   │   ├── README.md
│   │   │   │   ├── files
│   │   │   │   │   ├── profile-ambient.yaml
│   │   │   │   │   ├── profile-compatibility-version-1.23.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.24.
yaml                                                       │   │   │   │   │   ├── profile-compatibility-version-1.25.
yaml                                                       │   │   │   │   │   ├── profile-demo.yaml
│   │   │   │   │   ├── profile-platform-gke.yaml
│   │   │   │   │   ├── profile-platform-k3d.yaml
│   │   │   │   │   ├── profile-platform-k3s.yaml
│   │   │   │   │   ├── profile-platform-microk8s.yaml
│   │   │   │   │   ├── profile-platform-minikube.yaml
│   │   │   │   │   ├── profile-platform-openshift.yaml
│   │   │   │   │   ├── profile-preview.yaml
│   │   │   │   │   ├── profile-remote.yaml
│   │   │   │   │   └── profile-stable.yaml
│   │   │   │   ├── templates
│   │   │   │   │   ├── NOTES.txt
│   │   │   │   │   ├── _helpers.tpl
│   │   │   │   │   ├── clusterrole.yaml
│   │   │   │   │   ├── clusterrolebinding.yaml
│   │   │   │   │   ├── configmap-cni.yaml
│   │   │   │   │   ├── daemonset.yaml
│   │   │   │   │   ├── network-attachment-definition.yaml
│   │   │   │   │   ├── resourcequota.yaml
│   │   │   │   │   ├── serviceaccount.yaml
│   │   │   │   │   ├── zzy_descope_legacy.yaml
│   │   │   │   │   └── zzz_profile.yaml
│   │   │   │   └── values.yaml
│   │   │   ├── istio-control
│   │   │   │   └── istio-discovery
│   │   │   │       ├── Chart.yaml
│   │   │   │       ├── README.md
│   │   │   │       ├── files
│   │   │   │       │   ├── gateway-injection-template.yaml
│   │   │   │       │   ├── grpc-agent.yaml
│   │   │   │       │   ├── grpc-simple.yaml
│   │   │   │       │   ├── injection-template.yaml
│   │   │   │       │   ├── kube-gateway.yaml
│   │   │   │       │   ├── profile-ambient.yaml
│   │   │   │       │   ├── profile-compatibility-version-1
.23.yaml                                                   │   │   │   │       │   ├── profile-compatibility-version-1
.24.yaml                                                   │   │   │   │       │   ├── profile-compatibility-version-1
.25.yaml                                                   │   │   │   │       │   ├── profile-demo.yaml
│   │   │   │       │   ├── profile-platform-gke.yaml
│   │   │   │       │   ├── profile-platform-k3d.yaml
│   │   │   │       │   ├── profile-platform-k3s.yaml
│   │   │   │       │   ├── profile-platform-microk8s.yaml
│   │   │   │       │   ├── profile-platform-minikube.yaml
│   │   │   │       │   ├── profile-platform-openshift.yaml
│   │   │   │       │   ├── profile-preview.yaml
│   │   │   │       │   ├── profile-remote.yaml
│   │   │   │       │   ├── profile-stable.yaml
│   │   │   │       │   └── waypoint.yaml
│   │   │   │       ├── templates
│   │   │   │       │   ├── NOTES.txt
│   │   │   │       │   ├── _helpers.tpl
│   │   │   │       │   ├── autoscale.yaml
│   │   │   │       │   ├── clusterrole.yaml
│   │   │   │       │   ├── clusterrolebinding.yaml
│   │   │   │       │   ├── configmap-jwks.yaml
│   │   │   │       │   ├── configmap-values.yaml
│   │   │   │       │   ├── configmap.yaml
│   │   │   │       │   ├── deployment.yaml
│   │   │   │       │   ├── gateway-class-configmap.yaml
│   │   │   │       │   ├── istiod-injector-configmap.yaml
│   │   │   │       │   ├── mutatingwebhook.yaml
│   │   │   │       │   ├── poddisruptionbudget.yaml
│   │   │   │       │   ├── reader-clusterrole.yaml
│   │   │   │       │   ├── reader-clusterrolebinding.yaml
│   │   │   │       │   ├── remote-istiod-endpoints.yaml
│   │   │   │       │   ├── remote-istiod-service.yaml
│   │   │   │       │   ├── revision-tags.yaml
│   │   │   │       │   ├── role.yaml
│   │   │   │       │   ├── rolebinding.yaml
│   │   │   │       │   ├── service.yaml
│   │   │   │       │   ├── serviceaccount.yaml
│   │   │   │       │   ├── validatingadmissionpolicy.yaml
│   │   │   │       │   ├── validatingwebhookconfiguration.
yaml                                                       │   │   │   │       │   ├── zzy_descope_legacy.yaml
│   │   │   │       │   └── zzz_profile.yaml
│   │   │   │       └── values.yaml
│   │   │   └── ztunnel
│   │   │       ├── Chart.yaml
│   │   │       ├── README.md
│   │   │       ├── files
│   │   │       │   ├── profile-ambient.yaml
│   │   │       │   ├── profile-compatibility-version-1.23.
yaml                                                       │   │   │       │   ├── profile-compatibility-version-1.24.
yaml                                                       │   │   │       │   ├── profile-compatibility-version-1.25.
yaml                                                       │   │   │       │   ├── profile-demo.yaml
│   │   │       │   ├── profile-platform-gke.yaml
│   │   │       │   ├── profile-platform-k3d.yaml
│   │   │       │   ├── profile-platform-k3s.yaml
│   │   │       │   ├── profile-platform-microk8s.yaml
│   │   │       │   ├── profile-platform-minikube.yaml
│   │   │       │   ├── profile-platform-openshift.yaml
│   │   │       │   ├── profile-preview.yaml
│   │   │       │   ├── profile-remote.yaml
│   │   │       │   └── profile-stable.yaml
│   │   │       ├── templates
│   │   │       │   ├── NOTES.txt
│   │   │       │   ├── _helpers.tpl
│   │   │       │   ├── daemonset.yaml
│   │   │       │   ├── rbac.yaml
│   │   │       │   ├── resourcequota.yaml
│   │   │       │   └── zzz_profile.yaml
│   │   │       └── values.yaml
│   │   └── profiles
│   │       ├── ambient.yaml
│   │       ├── default.yaml
│   │       ├── demo.yaml
│   │       ├── empty.yaml
│   │       ├── minimal.yaml
│   │       ├── openshift-ambient.yaml
│   │       ├── openshift.yaml
│   │       ├── preview.yaml
│   │       ├── remote.yaml
│   │       └── stable.yaml
│   ├── samples
│   │   ├── README.md
│   │   ├── addons
│   │   │   ├── README.md
│   │   │   ├── extras
│   │   │   │   ├── prometheus-operator.yaml
│   │   │   │   ├── skywalking.yaml
│   │   │   │   └── zipkin.yaml
│   │   │   ├── grafana.yaml
│   │   │   ├── jaeger.yaml
│   │   │   ├── kiali.yaml
│   │   │   ├── loki.yaml
│   │   │   └── prometheus.yaml
│   │   ├── ambient-argo
│   │   │   ├── README.md
│   │   │   ├── application
│   │   │   │   ├── application.yaml
│   │   │   │   ├── bookinfo-versions.yaml
│   │   │   │   ├── details-waypoint.yaml
│   │   │   │   ├── details.yaml
│   │   │   │   ├── ingress-gateway.yaml
│   │   │   │   ├── namespace.yaml
│   │   │   │   ├── productpage.yaml
│   │   │   │   ├── ratings.yaml
│   │   │   │   ├── reviews-waypoint.yaml
│   │   │   │   ├── reviews.yaml
│   │   │   │   └── route-reviews-90-10.yaml
│   │   │   ├── documentation
│   │   │   ├── istio
│   │   │   │   ├── cni.yaml
│   │   │   │   ├── control-plane-appset.yaml
│   │   │   │   ├── extras.yaml
│   │   │   │   ├── tags.yaml
│   │   │   │   └── ztunnel.yaml
│   │   │   ├── meta-application.yaml
│   │   │   └── tag-chart
│   │   │       ├── Chart.yaml
│   │   │       ├── templates
│   │   │       │   ├── mutatingwebhooks.yaml
│   │   │       │   ├── shimservice.yaml
│   │   │       │   └── validatingwebhook.yaml
│   │   │       └── values.yaml
│   │   ├── bookinfo
│   │   │   ├── README.md
│   │   │   ├── demo-profile-no-gateways.yaml
│   │   │   ├── gateway-api
│   │   │   │   ├── bookinfo-gateway.yaml
│   │   │   │   ├── route-all-v1.yaml
│   │   │   │   ├── route-reviews-50-v3.yaml
│   │   │   │   ├── route-reviews-90-10.yaml
│   │   │   │   ├── route-reviews-v1.yaml
│   │   │   │   └── route-reviews-v3.yaml
│   │   │   ├── networking
│   │   │   │   ├── bookinfo-gateway.yaml
│   │   │   │   ├── certmanager-gateway.yaml
│   │   │   │   ├── destination-rule-all-mtls.yaml
│   │   │   │   ├── destination-rule-all.yaml
│   │   │   │   ├── destination-rule-reviews.yaml
│   │   │   │   ├── egress-rule-google-apis.yaml
│   │   │   │   ├── fault-injection-details-v1.yaml
│   │   │   │   ├── virtual-service-all-v1.yaml
│   │   │   │   ├── virtual-service-details-v2.yaml
│   │   │   │   ├── virtual-service-ratings-db.yaml
│   │   │   │   ├── virtual-service-ratings-mysql-vm.yaml
│   │   │   │   ├── virtual-service-ratings-mysql.yaml
│   │   │   │   ├── virtual-service-ratings-test-abort.yaml
│   │   │   │   ├── virtual-service-ratings-test-delay.yaml
│   │   │   │   ├── virtual-service-reviews-50-v3.yaml
│   │   │   │   ├── virtual-service-reviews-80-20.yaml
│   │   │   │   ├── virtual-service-reviews-90-10.yaml
│   │   │   │   ├── virtual-service-reviews-jason-v2-v3.yam
l                                                          │   │   │   │   ├── virtual-service-reviews-test-v2.yaml
│   │   │   │   ├── virtual-service-reviews-v2-v3.yaml
│   │   │   │   └── virtual-service-reviews-v3.yaml
│   │   │   ├── platform
│   │   │   │   └── kube
│   │   │   │       ├── README.md
│   │   │   │       ├── bookinfo-certificate.yaml
│   │   │   │       ├── bookinfo-db.yaml
│   │   │   │       ├── bookinfo-details-dualstack.yaml
│   │   │   │       ├── bookinfo-details-v2.yaml
│   │   │   │       ├── bookinfo-details.yaml
│   │   │   │       ├── bookinfo-dualstack.yaml
│   │   │   │       ├── bookinfo-ingress.yaml
│   │   │   │       ├── bookinfo-mysql.yaml
│   │   │   │       ├── bookinfo-psa.yaml
│   │   │   │       ├── bookinfo-ratings-discovery-dualstac
k.yaml                                                     │   │   │   │       ├── bookinfo-ratings-discovery.yaml
│   │   │   │       ├── bookinfo-ratings-dualstack.yaml
│   │   │   │       ├── bookinfo-ratings-v2-mysql-vm.yaml
│   │   │   │       ├── bookinfo-ratings-v2-mysql.yaml
│   │   │   │       ├── bookinfo-ratings-v2.yaml
│   │   │   │       ├── bookinfo-ratings.yaml
│   │   │   │       ├── bookinfo-reviews-v2.yaml
│   │   │   │       ├── bookinfo-versions.yaml
│   │   │   │       ├── bookinfo.yaml
│   │   │   │       ├── cleanup.sh
│   │   │   │       └── productpage-nodeport.yaml
│   │   │   ├── policy
│   │   │   │   └── productpage_envoy_ratelimit.yaml
│   │   │   ├── src
│   │   │   │   ├── build-services.sh
│   │   │   │   ├── details
│   │   │   │   ├── mongodb
│   │   │   │   │   ├── ratings_data.json
│   │   │   │   │   └── script.sh
│   │   │   │   ├── mysql
│   │   │   │   ├── productpage
│   │   │   │   │   ├── requirements.txt
│   │   │   │   │   ├── static
│   │   │   │   │   │   ├── img
│   │   │   │   │   │   └── tailwind
│   │   │   │   │   ├── templates
│   │   │   │   │   ├── test-requirements.txt
│   │   │   │   │   └── tests
│   │   │   │   │       └── unit
│   │   │   │   ├── ratings
│   │   │   │   │   └── package.json
│   │   │   │   └── reviews
│   │   │   │       ├── reviews-application
│   │   │   │       │   └── src
│   │   │   │       │       ├── main
│   │   │   │       │       │   ├── java
│   │   │   │       │       │   │   └── application
│   │   │   │       │       │   │       └── rest
│   │   │   │       │       │   └── webapp
│   │   │   │       │       │       └── WEB-INF
│   │   │   │       │       └── test
│   │   │   │       │           └── java
│   │   │   │       │               └── test
│   │   │   │       └── reviews-wlpcfg
│   │   │   │           ├── servers
│   │   │   │           │   └── LibertyProjectServer
│   │   │   │           ├── shared
│   │   │   │           └── src
│   │   │   │               └── test
│   │   │   │                   └── java
│   │   │   │                       └── it
│   │   │   │                           └── rest
│   │   │   └── swagger.yaml
│   │   ├── builder
│   │   │   └── README.md
│   │   ├── certs
│   │   │   ├── README.md
│   │   │   ├── ca-cert-alt-2.pem
│   │   │   ├── ca-cert-alt.pem
│   │   │   ├── ca-cert.pem
│   │   │   ├── ca-key-alt-2.pem
│   │   │   ├── ca-key-alt.pem
│   │   │   ├── ca-key.pem
│   │   │   ├── cert-chain-alt-2.pem
│   │   │   ├── cert-chain-alt.pem
│   │   │   ├── cert-chain.pem
│   │   │   ├── generate-workload.sh
│   │   │   ├── leaf-workload-bar-cert.pem
│   │   │   ├── leaf-workload-foo-cert.pem
│   │   │   ├── root-cert-alt.pem
│   │   │   ├── root-cert-combined-2.pem
│   │   │   ├── root-cert-combined.pem
│   │   │   ├── root-cert.pem
│   │   │   ├── workload-bar-cert.pem
│   │   │   ├── workload-bar-key.pem
│   │   │   ├── workload-bar-root-certs.pem
│   │   │   ├── workload-foo-cert.pem
│   │   │   ├── workload-foo-key.pem
│   │   │   └── workload-foo-root-certs.pem
│   │   ├── cicd
│   │   │   └── skaffold
│   │   │       ├── README.md
│   │   │       └── skaffold.yaml
│   │   ├── curl
│   │   │   ├── README.md
│   │   │   └── curl.yaml
│   │   ├── custom-bootstrap
│   │   │   ├── README.md
│   │   │   ├── custom-bootstrap.yaml
│   │   │   └── example-app.yaml
│   │   ├── extauthz
│   │   │   ├── README.md
│   │   │   ├── cmd
│   │   │   │   └── extauthz
│   │   │   ├── docker
│   │   │   ├── ext-authz.yaml
│   │   │   └── local-ext-authz.yaml
│   │   ├── external
│   │   │   ├── README.md
│   │   │   ├── aptget.yaml
│   │   │   ├── github.yaml
│   │   │   └── pypi.yaml
│   │   ├── grpc-echo
│   │   │   ├── README.md
│   │   │   └── grpc-echo.yaml
│   │   ├── health-check
│   │   │   ├── liveness-command.yaml
│   │   │   └── liveness-http-same-port.yaml
│   │   ├── helloworld
│   │   │   ├── README.md
│   │   │   ├── gateway-api
│   │   │   │   ├── README.md
│   │   │   │   ├── helloworld-gateway.yaml
│   │   │   │   ├── helloworld-route.yaml
│   │   │   │   └── helloworld-versions.yaml
│   │   │   ├── gen-helloworld.sh
│   │   │   ├── helloworld-dual-stack.yaml
│   │   │   ├── helloworld-gateway.yaml
│   │   │   ├── helloworld.yaml
│   │   │   ├── loadgen.sh
│   │   │   └── src
│   │   │       └── requirements.txt
│   │   ├── httpbin
│   │   │   ├── README.md
│   │   │   ├── gateway-api
│   │   │   │   └── httpbin-gateway.yaml
│   │   │   ├── httpbin-gateway.yaml
│   │   │   ├── httpbin-nodeport.yaml
│   │   │   ├── httpbin.yaml
│   │   │   └── sample-client
│   │   │       └── fortio-deploy.yaml
│   │   ├── jwt-server
│   │   │   ├── jwt-server.yaml
│   │   │   ├── src
│   │   │   │   └── Makefile
│   │   │   └── testdata
│   │   ├── kind-lb
│   │   │   ├── README.md
│   │   │   └── setupkind.sh
│   │   ├── multicluster
│   │   │   ├── README.md
│   │   │   ├── expose-istiod-https.yaml
│   │   │   ├── expose-istiod.yaml
│   │   │   ├── expose-services.yaml
│   │   │   └── gen-eastwest-gateway.sh
│   │   ├── open-telemetry
│   │   │   ├── als
│   │   │   │   └── README.md
│   │   │   ├── loki
│   │   │   │   ├── REAME.md
│   │   │   │   ├── iop.yaml
│   │   │   │   ├── otel.yaml
│   │   │   │   └── telemetry.yaml
│   │   │   ├── otel.yaml
│   │   │   └── tracing
│   │   │       ├── README.md
│   │   │       └── telemetry.yaml
│   │   ├── proxy-coredump
│   │   │   ├── README.md
│   │   │   └── daemonset.yaml
│   │   ├── ratelimit
│   │   │   ├── local-rate-limit-service.yaml
│   │   │   └── rate-limit-service.yaml
│   │   ├── security
│   │   │   ├── psp
│   │   │   │   └── sidecar-psp.yaml
│   │   │   └── spire
│   │   │       ├── README.md
│   │   │       ├── clusterspiffeid.yaml
│   │   │       ├── curl-spire.yaml
│   │   │       ├── istio-spire-config.yaml
│   │   │       ├── sleep-spire.yaml
│   │   │       └── spire-quickstart.yaml
│   │   ├── sleep
│   │   │   ├── README.md
│   │   │   └── sleep.yaml
│   │   ├── tcp-echo
│   │   │   ├── README.md
│   │   │   ├── gateway-api
│   │   │   │   ├── tcp-echo-20-v2.yaml
│   │   │   │   └── tcp-echo-all-v1.yaml
│   │   │   ├── src
│   │   │   ├── tcp-echo-20-v2.yaml
│   │   │   ├── tcp-echo-all-v1.yaml
│   │   │   ├── tcp-echo-dual-stack.yaml
│   │   │   ├── tcp-echo-ipv4.yaml
│   │   │   ├── tcp-echo-ipv6.yaml
│   │   │   ├── tcp-echo-services.yaml
│   │   │   └── tcp-echo.yaml
│   │   ├── wasm_modules
│   │   │   ├── README.md
│   │   │   └── header_injector
│   │   │       └── Makefile
│   │   └── websockets
│   │       ├── README.md
│   │       ├── app.yaml
│   │       └── route.yaml
│   └── tools
│       ├── _istioctl
│       ├── certs
│       │   ├── Makefile.k8s.mk
│       │   ├── Makefile.selfsigned.mk
│       │   ├── README.md
│       │   └── common.mk
│       └── istioctl.bash
├── istio-manifests
│   ├── allow-egress-googleapis.yaml
│   ├── frontend-gateway.yaml
│   └── frontend.yaml
├── kubernetes-manifests
│   ├── README.md
│   ├── adservice.yaml
│   ├── cartservice.yaml
│   ├── checkoutservice.yaml
│   ├── currencyservice.yaml
│   ├── emailservice.yaml
│   ├── frontend.yaml
│   ├── kustomization.yaml
│   ├── loadgenerator.yaml
│   ├── paymentservice.yaml
│   ├── productcatalogservice.yaml
│   ├── recommendationservice.yaml
│   └── shippingservice.yaml
├── kustomize
│   ├── README.md
│   ├── base
│   │   ├── adservice.yaml
│   │   ├── cartservice.yaml
│   │   ├── checkoutservice.yaml
│   │   ├── currencyservice.yaml
│   │   ├── emailservice.yaml
│   │   ├── frontend.yaml
│   │   ├── kustomization.yaml
│   │   ├── loadgenerator.yaml
│   │   ├── paymentservice.yaml
│   │   ├── productcatalogservice.yaml
│   │   ├── recommendationservice.yaml
│   │   └── shippingservice.yaml
│   ├── components
│   │   ├── alloydb
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── container-images-registry
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── container-images-tag
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── container-images-tag-suffix
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── custom-base-url
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── cymbal-branding
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── google-cloud-operations
│   │   │   ├── README.md
│   │   │   ├── collector-model.png
│   │   │   ├── kustomization.yaml
│   │   │   └── otel-collector.yaml
│   │   ├── memorystore
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── network-policies
│   │   │   ├── README.md
│   │   │   ├── kustomization.yaml
│   │   │   ├── network-policy-adservice.yaml
│   │   │   ├── network-policy-cartservice.yaml
│   │   │   ├── network-policy-checkoutservice.yaml
│   │   │   ├── network-policy-currencyservice.yaml
│   │   │   ├── network-policy-deny-all.yaml
│   │   │   ├── network-policy-emailservice.yaml
│   │   │   ├── network-policy-frontend.yaml
│   │   │   ├── network-policy-loadgenerator.yaml
│   │   │   ├── network-policy-paymentservice.yaml
│   │   │   ├── network-policy-productcatalogservice.yaml
│   │   │   ├── network-policy-recommendationservice.yaml
│   │   │   ├── network-policy-redis.yaml
│   │   │   └── network-policy-shippingservice.yaml
│   │   ├── non-public-frontend
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── service-mesh-istio
│   │   │   ├── README.md
│   │   │   ├── allow-egress-googleapis.yaml
│   │   │   ├── frontend-gateway.yaml
│   │   │   ├── frontend.yaml
│   │   │   └── kustomization.yaml
│   │   ├── shopping-assistant
│   │   │   ├── README.md
│   │   │   ├── kustomization.yaml
│   │   │   ├── scripts
│   │   │   │   ├── 1_deploy_alloydb_infra.sh
│   │   │   │   ├── 2_create_populate_alloydb_tables.sh
│   │   │   │   └── generate_sql_from_products.py
│   │   │   └── shoppingassistantservice.yaml
│   │   ├── single-shared-session
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   ├── spanner
│   │   │   ├── README.md
│   │   │   └── kustomization.yaml
│   │   └── without-loadgenerator
│   │       ├── README.md
│   │       ├── delete-loadgenerator.patch.yaml
│   │       └── kustomization.yaml
│   ├── kustomization.yaml
│   └── tests
│       ├── README.md
│       ├── memorystore-with-all-components
│       │   └── kustomization.yaml
│       ├── service-mesh-istio-with-all-components
│       │   └── kustomization.yaml
│       └── spanner-with-all-components
│           └── kustomization.yaml
├── protos
│   ├── demo.proto
│   └── grpc
│       └── health
│           └── v1
│               └── health.proto
├── release
│   ├── istio-manifests.yaml
│   └── kubernetes-manifests.yaml
├── skaffold.yaml
├── src
│   ├── adservice
│   │   ├── Dockerfile
│   │   ├── README.md
│   │   ├── build.gradle
│   │   ├── genproto.sh
│   │   ├── gradle
│   │   │   └── wrapper
│   │   │       ├── gradle-wrapper.jar
│   │   │       └── gradle-wrapper.properties
│   │   ├── gradlew
│   │   ├── gradlew.bat
│   │   ├── settings.gradle
│   │   └── src
│   │       └── main
│   │           ├── java
│   │           │   └── hipstershop
│   │           │       ├── AdService.java
│   │           │       └── AdServiceClient.java
│   │           ├── proto
│   │           │   └── demo.proto
│   │           └── resources
│   │               └── log4j2.xml
│   ├── cartservice
│   │   ├── cartservice.sln
│   │   ├── src
│   │   │   ├── Dockerfile
│   │   │   ├── Dockerfile.debug
│   │   │   ├── Program.cs
│   │   │   ├── Startup.cs
│   │   │   ├── appsettings.json
│   │   │   ├── cartservice.csproj
│   │   │   ├── cartstore
│   │   │   │   ├── AlloyDBCartStore.cs
│   │   │   │   ├── ICartStore.cs
│   │   │   │   ├── RedisCartStore.cs
│   │   │   │   └── SpannerCartStore.cs
│   │   │   ├── protos
│   │   │   │   └── Cart.proto
│   │   │   └── services
│   │   │       ├── CartService.cs
│   │   │       └── HealthCheckService.cs
│   │   └── tests
│   │       ├── CartServiceTests.cs
│   │       └── cartservice.tests.csproj
│   ├── checkoutservice
│   │   ├── Dockerfile
│   │   ├── README.md
│   │   ├── genproto
│   │   │   ├── demo.pb.go
│   │   │   └── demo_grpc.pb.go
│   │   ├── genproto.sh
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── main.go
│   │   └── money
│   │       ├── money.go
│   │       └── money_test.go
│   ├── currencyservice
│   │   ├── Dockerfile
│   │   ├── client.js
│   │   ├── data
│   │   │   └── currency_conversion.json
│   │   ├── genproto.sh
│   │   ├── package-lock.json
│   │   ├── package.json
│   │   ├── proto
│   │   │   ├── demo.proto
│   │   │   └── grpc
│   │   │       └── health
│   │   │           └── v1
│   │   │               └── health.proto
│   │   └── server.js
│   ├── emailservice
│   │   ├── Dockerfile
│   │   ├── demo_pb2.py
│   │   ├── demo_pb2_grpc.py
│   │   ├── email_client.py
│   │   ├── email_server.py
│   │   ├── genproto.sh
│   │   ├── logger.py
│   │   ├── requirements.in
│   │   ├── requirements.txt
│   │   └── templates
│   │       └── confirmation.html
│   ├── frontend
│   │   ├── Dockerfile
│   │   ├── README.md
│   │   ├── deployment_details.go
│   │   ├── genproto
│   │   │   ├── demo.pb.go
│   │   │   └── demo_grpc.pb.go
│   │   ├── genproto.sh
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── handlers.go
│   │   ├── main.go
│   │   ├── middleware.go
│   │   ├── money
│   │   │   ├── money.go
│   │   │   └── money_test.go
│   │   ├── packaging_info.go
│   │   ├── rpc.go
│   │   ├── static
│   │   │   ├── favicon-cymbal.ico
│   │   │   ├── favicon.ico
│   │   │   ├── icons
│   │   │   │   ├── Cymbal_NavLogo.svg
│   │   │   │   ├── Hipster_Advert2.svg
│   │   │   │   ├── Hipster_CartIcon.svg
│   │   │   │   ├── Hipster_CheckOutIcon.svg
│   │   │   │   ├── Hipster_CurrencyIcon.svg
│   │   │   │   ├── Hipster_DownArrow.svg
│   │   │   │   ├── Hipster_FacebookIcon.svg
│   │   │   │   ├── Hipster_GooglePlayIcon.svg
│   │   │   │   ├── Hipster_HelpIcon.svg
│   │   │   │   ├── Hipster_HeroLogo.svg
│   │   │   │   ├── Hipster_HeroLogoMaroon.svg
│   │   │   │   ├── Hipster_InstagramIcon.svg
│   │   │   │   ├── Hipster_KitchenwareOffer.svg
│   │   │   │   ├── Hipster_NavLogo.svg
│   │   │   │   ├── Hipster_PinterestIcon.svg
│   │   │   │   ├── Hipster_ProfileIcon.svg
│   │   │   │   ├── Hipster_SearchIcon.svg
│   │   │   │   ├── Hipster_TwitterIcon.svg
│   │   │   │   ├── Hipster_UpDownControl.svg
│   │   │   │   ├── Hipster_WandIcon.svg
│   │   │   │   └── Hipster_YoutubeIcon.svg
│   │   │   ├── images
│   │   │   │   ├── Advert2BannerImage.png
│   │   │   │   ├── AdvertBannerImage.png
│   │   │   │   ├── HeroBannerImage.png
│   │   │   │   ├── HeroBannerImage2.png
│   │   │   │   ├── VRHeadsets.png
│   │   │   │   ├── credits.txt
│   │   │   │   ├── folded-clothes-on-white-chair-wide.jpg
│   │   │   │   └── folded-clothes-on-white-chair.jpg
│   │   │   ├── img
│   │   │   │   └── products
│   │   │   │       ├── bamboo-glass-jar.jpg
│   │   │   │       ├── candle-holder.jpg
│   │   │   │       ├── hairdryer.jpg
│   │   │   │       ├── loafers.jpg
│   │   │   │       ├── mug.jpg
│   │   │   │       ├── salt-and-pepper-shakers.jpg
│   │   │   │       ├── sunglasses.jpg
│   │   │   │       ├── tank-top.jpg
│   │   │   │       └── watch.jpg
│   │   │   └── styles
│   │   │       ├── bot.css
│   │   │       ├── cart.css
│   │   │       ├── order.css
│   │   │       └── styles.css
│   │   ├── templates
│   │   │   ├── ad.html
│   │   │   ├── assistant.html
│   │   │   ├── cart.html
│   │   │   ├── error.html
│   │   │   ├── footer.html
│   │   │   ├── header.html
│   │   │   ├── home.html
│   │   │   ├── order.html
│   │   │   ├── product.html
│   │   │   └── recommendations.html
│   │   └── validator
│   │       ├── validator.go
│   │       └── validator_test.go
│   ├── loadgenerator
│   │   ├── Dockerfile
│   │   ├── locustfile.py
│   │   ├── requirements.in
│   │   └── requirements.txt
│   ├── paymentservice
│   │   ├── Dockerfile
│   │   ├── charge.js
│   │   ├── genproto.sh
│   │   ├── index.js
│   │   ├── logger.js
│   │   ├── package-lock.json
│   │   ├── package.json
│   │   ├── proto
│   │   │   ├── demo.proto
│   │   │   └── grpc
│   │   │       └── health
│   │   │           └── v1
│   │   │               └── health.proto
│   │   └── server.js
│   ├── productcatalogservice
│   │   ├── Dockerfile
│   │   ├── README.md
│   │   ├── catalog_loader.go
│   │   ├── genproto
│   │   │   ├── demo.pb.go
│   │   │   └── demo_grpc.pb.go
│   │   ├── genproto.sh
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── product_catalog.go
│   │   ├── product_catalog_test.go
│   │   ├── products.json
│   │   └── server.go
│   ├── recommendationservice
│   │   ├── Dockerfile
│   │   ├── client.py
│   │   ├── demo_pb2.py
│   │   ├── demo_pb2_grpc.py
│   │   ├── genproto.sh
│   │   ├── logger.py
│   │   ├── recommendation_server.py
│   │   ├── requirements.in
│   │   └── requirements.txt
│   ├── shippingservice
│   │   ├── Dockerfile
│   │   ├── README.md
│   │   ├── genproto
│   │   │   ├── demo.pb.go
│   │   │   └── demo_grpc.pb.go
│   │   ├── genproto.sh
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── main.go
│   │   ├── quote.go
│   │   ├── shippingservice_test.go
│   │   └── tracker.go
│   └── shoppingassistantservice
│       ├── Dockerfile
│       ├── requirements.in
│       ├── requirements.txt
│       └── shoppingassistantservice.py
└── terraform1
    ├── ecr.tf
    └── terraform.tfstate




## 🚀 Deployment Workflow

### ✅ 1. Prerequisites

* AWS account with EKS access
* IAM permissions to manage ECR, VPC, and EKS
* Terraform installed
* `kubectl` installed and configured
* Docker installed

---

### ✅ 2. Infrastructure Setup with Terraform

From the `terraform/` directory:

```bash
terraform init
terraform apply
```

This provisions:

* VPC and subnets
* EKS cluster
* ECR repositories for each microservice

---

### ✅ 3. Microservices Architecture

The application includes the following services:

* `frontend`
* `cartservice`
* `checkoutservice`
* `productcatalogservice`
* `recommendationservice`
* `currencyservice`
* `emailservice`
* `paymentservice`
* `shippingservice`
* `adservice`

Each service is Dockerized and lives in its own directory under `src/`.

---

### ✅ 4. CI/CD Pipeline (GitHub Actions)

On every push to `main`:

* Each microservice is built as a Docker image
* Tagged and pushed to AWS ECR
* Kubernetes manifests in `release/` are applied to EKS

The pipeline file: `.github/workflows/deploy.yml`

---

### ✅ 5. Kubernetes Deployment

Once Terraform provisions the cluster and GitHub Actions pushes the images:

```bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
kubectl get pods
kubectl get services
```

All services are deployed and discoverable via Kubernetes networking.

---

## 🧪 Testing & Validation

* Use `kubectl logs` to debug pods
* Access frontend via LoadBalancer service (if exposed)
* Inspect ECR in AWS Console to verify pushed images
* Monitor pipeline execution in GitHub → Actions tab

---

## 📖 To-Do / Improvements

* [ ] Add Helm charts for easier templating
* [ ] Add Prometheus + Grafana monitoring
* [ ] Add autoscaling (HPA)
* [ ] Use versioned image tags (e.g., Git SHA)
* [ ] Add canary/staged deployments

---

## 📜 License

MIT — feel free to use and modify for learning or production.
