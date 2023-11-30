# Módulo: Docker
## Atividade: Desafio Go

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

```
docker build -t <seu-user>/fullcycle .
```
Teste a imagem localmente executando (é esperado imprimir "Full Cycle Rocks!!" no terminal):
```
docker run <seu-user>/fullcycle
```
Após testar localmente, para fazer o pull da imagem criada para o Docker Hub executar:
```
docker login
docker push <seu-user>/fullcycle
```


