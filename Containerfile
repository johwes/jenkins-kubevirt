FROM registry.redhat.io/ocp-tools-4/jenkins-agent-base-rhel8@sha256:9eeb361a3aaa745cd30efa8034bd2d34c7eba87a95b567dc212deae061e0e3e7


ADD usr usr
ADD .ssh /home/jenkins/.ssh/

USER 1001

#ENTRYPOINT ["/usr/bin/go-init", "-main", "/usr/local/bin/run-jnlp-client"]
ENTRYPOINT ["/usr/bin/go-init", "-pre", "/usr/local/bin/pre.sh", "-main", "/usr/local/bin/main.sh", "-post", "/usr/local/bin/post.sh"]
#ENTRYPOINT ["/usr/bin/sleep", "infinity"]
