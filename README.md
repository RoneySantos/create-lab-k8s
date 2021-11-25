Este repositório está sendo criado com o intuito de provisionar um ambiente de laboratório kubernetes na AWS utilizando apenas recursos do plano free tier.

Alguns passos precisam ser realizados antes da execução desse repositório

1° Passo
Criar um usuário IAM com permissões administrativas e adicionar no seu cli da AWS. (detalhar os passos)

2° Passo
Criar chave publica e privada para importar na AWS. (Detalhar os passos)


TO DO
- Adicionar ip publico local nas regras de acesso SSH - OK
- Popular o hosts do ansible com os ips e nome recolhidos do AWS
- Adicionar saida para security groups
- Alterar hostname das maquinas (interno via ansible)
- adicionar nas regras de entrada do master, acesso total do proprio grupo


------------------------------------------------------

Detalhes da criação do ambiente para ser feito

1 Criar as 3 maquinas, 1 master e duas slave
Maquina Ubuntu t2 micro

Portas para o MASTER

10250 Kubelet API
6443  Kubernetes API server
2379 - 2380 etcd server client API
10251 kube scheduler
10252 kube controller manager

Portas Workers

6783 - 6784 whatever
10250 Kubelet API
30000 - 32767 NodePort


-----------------------------------------------------

Instalacao do K8S para ser feito via Ansible

1 - Criar arquivo /etc/modules-load.d/k8s.conf com o conteudo abaixo:

br_netfilter
ip_vs
ip_vs_rr
ip_vs_sh
ip_vs_wrr
nf_conntrack_ipv4

2 - Atualiza essa bagaca

sudo apt update

sudo apt upgrade -y


3 - Instalar Docker

curl -fsSL https://get.docker.com | bash

4 - Configurar o Docker para rodar no systemd

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

5 - Criar diretorio do systemd

sudo mkdir -p /etc/systemd/system/docker.service.d

6 - Reinicia o docker e o daemon para validar a conf

sudo systemctl daemon-reload
sudo systemctl restart docker

docker info | grep -i cgroup


7 Adicionar repositorios do K8S e instalar o kubeadm

sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

8 - Desativa SWAP

sudo swapoff -a

=== PAREI EM INICIALIZACAO DO CLUSTER ===


#MASTER
1 - baixando imagens que serao usadas no master
sudo kubeadm config images pull

2 - Iniciando o kubeadm ignorando numero de CPU e memoria

kubeadm init --ignore-preflight-errors=NumCPU,Mem

3 - saida do k8s

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

4 - Restart os servicos

sudo systemctl daemon-reload
sudo systemctl restart kubelet

==== INSTALACAO NO WORKER ---


====== instalando modulos de redes =====

1 - Carregando modulos caso nao tenha reiniciado
sudo modprobe br_netfilter ip_vs_rr ip_vs_wrr ip_vs_sh nf_conntrack_ipv4 ip_vs

2 - instalando o weave net
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

3 - verificando se foi instalado
kubectl get pods -n kube-system

==== testando e instalando coisitas ===

completion
sudo apt install -y bash-completion
kubectl completion bash > /etc/bash_completion.d/kubectl





