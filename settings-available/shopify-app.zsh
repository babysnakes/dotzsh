function shopify-app-env() {
    chruby jruby-1.7.3
    export JAVA_OPTS="-Xmx1536m -XX:MaxPermSize=512m"
}
