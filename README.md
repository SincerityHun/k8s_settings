# k8s_settings
Stored setting for k8s

1. [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

2. [Skaffold](https://github.com/GoogleContainerTools/skaffold/releases)

3. [Helm](https://github.com/helm/helm/releases)

    ```shell
    tar -xzf helm-v3.16.3-darwin-arm64.tar.gz
    sudo mv darwin-arm64/helm /usr/local/bin/helm
    chmod +x /usr/local/bin/helm
    ```

4. [Istio-System](https://istio.io/latest/docs/setup/install/helm/)
    
    - Install via Helm
        * istio/istiod 
        * istio/gateway

5. [HTTPbin](https://github.com/istio/istio/blob/master/samples/httpbin/httpbin.yaml)

    - Test for Istio Ingress
        * change Istio-ingressgateway to NodePort
    
    - Kindcc
        * Control Plane Port (0.0.0.0:30000-30001->30000-30001/tcp)
        * Istio Ingress Port (80:30000/TCP) 
        * Httpbin Ingress Gateway/VirtualService (80->8000)
        * Httpbin Service/Deployment (8000->8080)
        * (localhost)[http://localhost:30000]

6. [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus)

    - Monitoring
        
        * ```curl -L -o kube-prometheus.v0.14.0.tar.gz https://github.com/prometheus-operator/kube-prometheus/archive/refs/tags/v0.14.0.tar.gz```
        * ```tar -xzf kube-prometheus.v0.14.0.tar.gz```
        * ```cd kube-prometheus.v0.14.0.tar.gz```
        * ```kubectl apply --server-side -f manifests/setup```
        * ```kubectl wait --for condition=Established --all CustomResourceDefinition --namespace=monitoring```
        * ```kubectl apply -f manifests/```

7. [Kiali](https://kiali.io/docs/installation/installation-guide/install-with-helm/)

    - kiali
        * Install Kiali operator

            ```
                 helm install \
                    --set cr.create=true \
                    --set cr.namespace=istio-system \
                    --set cr.spec.auth.strategy="anonymous" \
                    --namespace kiali-operator \
                    --create-namespace \
                    kiali-operator \
                    kiali/kiali-operator
            ```
        * [Creating and updating the Kiali CR](https://kiali.io/docs/configuration/kialis.kiali.io/)
        
        * Fix manifests/prometheus-networkPolicy.yaml for allowing network ingress traffic from istio-system

        * Fix manifests/grafana-networkPolicy.yaml for allowing network ingress traffic from istio-system
