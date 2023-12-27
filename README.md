# Módulo: Docker
## Atividade: Desafio Go

O presente exercício é relacionado ao desenvolvimento de software, uso do Docker e da linguagem de programação Go (Go Lang). Segue as instruções para a realização do exercício:

1. Publicar uma imagem no Docker Hub: Deve ser criada e publida uma imagem Docker na plataforma Docker Hub. O Docker Hub é um serviço de registro de imagens Docker, onde você pode hospedar e compartilhar imagens de container.

2. Execução do Comando: O comando `docker run <seu-user>/fullcycle` sugere que, após a publicação da sua imagem no Docker Hub, ela deve ser executável usando o Docker. O `<seu-user>` é um placeholder para o seu nome de usuário no Docker Hub.

3. Resultado Esperado - "Full Cycle Rocks!!": Ao executar a imagem Docker, ela deve exibir a mensagem "Full Cycle Rocks!!". Isso implica que a aplicação dentro do container Docker, provavelmente escrita em Go, deve imprimir essa mensagem na saída padrão (stdout).

4. Referência à Go Lang: A menção da Go Lang sugere que deve ser escrito um programa simples em Go, tal como um "Olá Mundo", mas que, ao invés disso, imprima "Full Cycle Rocks!!".

5. Imagens Oficiais da Go Lang no Docker Hub: Usar uma imagem oficial da Go Lang disponível no Docker Hub como base para o projeto. Isso facilita o processo de configuração do ambiente de desenvolvimento e execução.

6. Restrição de Tamanho da Imagem: A imagem Docker do projeto Go deve ter menos de 2MB.

7. Repositório Git Remoto: Após desenvolver o projeto, subir o mesmo para um repositório Git remoto.

8. Compartilhar Links: Deve ser fornecido o link do repositório Git e da imagem no Docker Hub para que o projeto possa ser avaliado.

Em resumo, o exercício requer a criação de uma aplicação simples em Go que imprime uma mensagem específica, a construção de uma imagem Docker leve contendo essa aplicação, e a publicação tanto do código-fonte quanto da imagem Docker para revisão.

## Solução:

Primeiro foi criado o script `main.go` que imprime "Full Cycle Rocks!!" em Go na raíz do repositório.

```go
package main

import "fmt"

func main() {
    fmt.Println("Full Cycle Rocks!!")
}
```

Em seguida foi criado o Dockerfile para construir a imagem do Docker. Como a imagem precisa ter menos de 2MB, foi utilizada uma imagem base multi-estágio. Primeiro o código Go é compilado em um contêiner temporário, em seguida o executável é copiado para um contêiner mínimo baseado em scratch.

```Dockerfile
FROM golang:alpine as builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o fullcycle .

FROM scratch
COPY --from=builder /app/fullcycle .
CMD ["./fullcycle"]
```
Isso compila o código Go e cria um executável `fullcycle`, que é então copiado para um contêiner baseado em scratch, o qual é muito leve.

Para fazer o build da imagem criada:

```shell
$ docker build -t <seu-user>/fullcycle .
```

Teste a imagem localmente executando (é esperado imprimir "Full Cycle Rocks!!" no terminal):

```shell
$ docker run <seu-user>/fullcycle
```

Após testar localmente, para fazer o pull da imagem criada para o Docker Hub executar:

```shell
$ docker login
$ docker push <seu-user>/fullcycle
```

É esperado que a imagem seja disponibilizada em:

```
https://hub.docker.com/repository/docker/<seu-user>/fullcycle/general
```

No caso do presente exercício, a imagem criada está disponível em: 

https://hub.docker.com/repository/docker/plbalmeida85/fullcycle/general
