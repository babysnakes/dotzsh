function k8comp() {
    which kubectl >&/dev/null && source <(kubectl completion zsh)
    which minikube >&/dev/null && source <(minikube completion zsh)
    which helm >&/dev/null && source <(helm completion zsh)
    alias k=kubectl
}
