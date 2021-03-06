#! /bin/bash
OS=$(awk -F= '/^ID/{print $2}' /etc/os-release | head -1 | awk '{print tolower($0)}')

set -ex
(
useradd -p $(openssl passwd -1 taco1130@) taco -m
mkdir -p /home/taco/.ssh

cat > /home/taco/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgQsADPxAlHA5pH7g2ll8KwNCGzMGazEc2iSQpqmuSMNvK0jHt1yY4/tr7YGkd/0xeJ/zr2u+/OclmAzrDt7ICVoX2dR5AmwHpt0znFvBtmqdrHAFx6q9BkaBoCEUjebopYqoTRWqDDmcL+GeTGFpElZnJxrM7bLn73Df6zwUpPLRs/eNpPfLfW3ARGqFt+6k3gwLILKwu43+dwvex4/2v+dSxCJvlClSmMORMQHQJL3oEkBQECFLipVjRQ3UeHxWZAmq9gbqFDNbn7QX6AFiV3UXTEoz6YSFAu/4AhC6UuQedGz3sBMYkKffLWjNDjKtMFEAOxR99KdqN9TJHwecr root@master01.cicd.stg.taco
EOF

mkdir -p /etc/docker/certs.d/registry.cicd.stg.taco
cat > /etc/docker/certs.d/registry.cicd.stg.taco/ca.crt <<EOF
-----BEGIN CERTIFICATE-----
MIIB+DCCAZ6gAwIBAgIUA1dN6Z3t/hNh795tcQD94mvgWGIwCgYIKoZIzj0EAwIw
WjELMAkGA1UEBhMCS1IxDjAMBgNVBAgTBVNlb3VsMRAwDgYDVQQHEwdKdW5nLWd1
MQwwCgYDVQQKEwNTS1QxDjAMBgNVBAsTBU9TTGFiMQswCQYDVQQDEwJDQTAeFw0x
NzA4MjgwNzU2MDBaFw0yMjA4MjcwNzU2MDBaMFoxCzAJBgNVBAYTAktSMQ4wDAYD
VQQIEwVTZW91bDEQMA4GA1UEBxMHSnVuZy1ndTEMMAoGA1UEChMDU0tUMQ4wDAYD
VQQLEwVPU0xhYjELMAkGA1UEAxMCQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNC
AAQhT71hyWXgZ0JKgSISZXxBw4kCSVYbdwG75/UB+pdn44txbfoQwowO5krucEmN
GXr5VW+MlYKIYWheUbxkPu8Zo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUB5Mph3QGdJR76x12pAnYN8EYUY4wCgYIKoZIzj0E
AwIDSAAwRQIgc8/FlbbRyw22kt1ILAtqhYKdfibC/FjTqT4bQQ+cFb4CIQCpSBxE
bAIZhGrI5HT/a4dq3GPZWo1ybJs5RliBnPUtRg==
-----END CERTIFICATE-----
EOF

mkdir -p /etc/docker/certs.d/registry-rel.cicd.stg.taco
cat > /etc/docker/certs.d/registry-rel.cicd.stg.taco/ca.crt <<EOF
-----BEGIN CERTIFICATE-----
MIIDXDCCAkQCCQDBxFFeS5IQnzANBgkqhkiG9w0BAQsFADBwMQswCQYDVQQGEwJL
TzENMAsGA1UECAwETm9uZTEOMAwGA1UEBwwFU2VvdWwxDDAKBgNVBAoMA1NLVDEP
MA0GA1UECwwGVlMgTGFiMSMwIQYDVQQDDBpyZWdpc3RyeS1yZWwuY2ljZC5zdGcu
dGFjbzAeFw0xOTA2MDMwNzQxMjVaFw0yMDA2MDIwNzQxMjVaMHAxCzAJBgNVBAYT
AktPMQ0wCwYDVQQIDAROb25lMQ4wDAYDVQQHDAVTZW91bDEMMAoGA1UECgwDU0tU
MQ8wDQYDVQQLDAZWUyBMYWIxIzAhBgNVBAMMGnJlZ2lzdHJ5LXJlbC5jaWNkLnN0
Zy50YWNvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5YZigpq2DF/e
UaC7iPyLu2MIYHYvOsNs4ktskSgUKePnwk7/olgBU/jPsNDb1WiznBdA6ml2wJ2X
YO8KylpxJq/RIVZJ6z77Gdzt0mjPe26cjpLqm2xEpKLpdsd6Vb5M4bhDZidA1Ayi
CepU7DWH3s+Xz7yNfhBqLuTuBGZBku98fFTtZUMTxaxx39ucWFdn+olyJqwVLY/i
zzjozwyRKqxdzPnWUKkB323aOb5Mm1ciCEAaGU+YACD4XiZGaPvR3aAau109bwEZ
ZwUE34rNTAn9LXq8OzvSmXU3fcxSmOYYjlyWEmzQucsBaF9PRlJ3BJezKHgraObj
AooElitV7wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAry44uvw9qpCu3hRz/IzKD
SBGH7o+Vm0m4JU66SDVxy/O5JyvCKEmNSq8Y03KmKX3LSYum0WXV/Q/Tw4NDPlgU
q0wBcaO9AuH9qy7duyYhTl5iuX3f6A43UWNgITlBIKLDirUH93bICoBWTSPp0Jmq
SCbyvGyMyEguBNdTo8w0juAOvjAYzIRihDhCAxX5JfIZRJOtfRWRrGBddT4CtOtt
OnlLHy529DFSTmOg2/R+szz6CC8lPJfiGfmjBhlGYUtKOw9vWxnQMJNVUUG8YZjJ
wmK7opHgY7SA9bGeuUzblNjfjVrsL3a7hO5Zeco+hOFdV2uOjPlSFcoSEVyZVmfG
-----END CERTIFICATE-----
EOF

chown -R taco:taco /home/taco

echo "taco ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/taco
echo "192.168.54.30 registry.cicd.stg.taco registry-rel.cicd.stg.taco" >> /etc/hosts

sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart sshd

/sbin/dhclient

until [ -n "$net0_stat" ] && [ -n "$net1_stat" ]
do
  sleep 3
  if [ "$OS" = "ubuntu" ]; then
    net0_stat=$(ip a | grep ens3 | grep 172.16)
    net1_stat=$(ip a | grep ens4 | grep 172.16)
  fi
done

if echo $net0_stat | grep 172.16.50
then
  gateway='172.16.50.1'
else
  echo "Something went wrong! Exiting.."
  exit 1
fi

# Chanage a default python interpreter to python3.6
update-alternatives --install /usr/bin/python python /usr/bin/python3 1

touch /tmp/.vm_ready
) 2>&1 | tee /var/log/startup.log
