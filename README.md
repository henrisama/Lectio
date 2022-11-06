# Trabalho Final (Lectio)

### Sobre:

Trabalho final da matéria de dispositivos móveis _(2022.2)_ UFMS.

### Autor(es):

- Pedro H. P. Flores

### Descrição:

O sistema Lectio trata de um livro razão onde uma pessoa poderá registrar todas as leituras feita pela mesma. A pessoa poderá acompanhar suas leituras e ser notificada pelo aplicativo com o objetivo de incentivar o hábito de ler. A pessoa também poderá separar suas leituras, e buscar com filtros atráves do menu de busca.

### Classes:

- Usuário: Pessoa que poderá organizar suas leituras através do aplicativo.
- Leitura: Livros, HQ, mangás, poemas, etc, registrado pelo usuário .

### Requisitos Funcionais:

- RF01 - O sistema deve permitir a inlcução, remoção e alteração de usuários, com
  os seguintes atributos: nome, data de nascimento, sexo e foto.

- RF02 - O sistema deve permitir a inlcução, remoção e alteração de leitura, com os seguintes atributos: tipo, titulo, nome do autor, status (Lido, Lendo, Ainda Para Ler), score de 1 a 5 (opcional), data de abertura e data de fechamento.

- RF03 - O sistema deve exigir que o usuário faça login.

- RF04 - O Sistema deve exibir mensagem de erro no ato de cadastrar usuário ou fazer o login do usuário caso alguma infomação esteja inválida.

- RF05 - O sistema deve listar todas as leituras incluidas pelo usuário.

- RF06 - O sistema deve notificar o usuário pré setado pelo mesmo com uma mensagem de lembrete.

- RF07 - O sistema deve exibir graficamente a quantidade de leituras pelo usuário com o status como lido, anualmente, semestralmente e mensalmente.

### Requisitos não Funcionais:

- RNF01 - O sistema deve criptografar todas as senhas.

- RNF02 - O sistema deve ter modo escuro.

- RNF03 - O sistema deve ser capaz de armanezar dados em base de dados sqlite.
