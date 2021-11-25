Este repositório está sendo criado com o intuito de provisionar um ambiente de laboratório kubernetes na AWS utilizando apenas recursos do plano free tier.

Alguns passos precisam ser realizados antes da execução desse repositório

1° Passo
Criar um usuário IAM com permissões administrativas e adicionar no seu cli da AWS. (detalhar os passos)

2° Passo
Criar chave publica e privada para importar na AWS. (Detalhar os passos)


TO DO
- Adicionar ip publico local nas regras de acesso SSH
- Popular o hosts do ansible com os ips e nome recolhidos do AWS


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
