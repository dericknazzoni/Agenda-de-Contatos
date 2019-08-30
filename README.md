# Agenda de Contatos (Swift)
Projeto feito durante o programa de estágio na BRQ. O desafio era utilizar todos os conhecimentos adquiridos no google para fazer um aplicativo aonde você podia adicionar, editar e apagar contatos do seu celular. E também listava todos os contatos com nome e número. Pegava alguns contatos de uma api feita em Node.js aonde o aplicativo consumia de modo nativa.

## Frameworks e funcionalidades do site:
Listagem de Contatos (Requisição GET com Swift)<br>
Filtro por nome (Todos os contatos que contém o texto digitado pelo nome ou numero de telefone escolhida)<br>
Seleção de Contato (Detalhes de cada contato, em outra tela com nome e telefone)<br>
Adição de Contato(Tela para adicionar um contato, dando nome e telefone para ele)<br>
Edição de Contato(Tela para poder editar o nome ou telefone do contato escolhido)<br>
Remoção de Contato(Animação para deletar contato)

## Necessário para usar:
<ol>
  <li>Ter o Xcode na maquina </li>
  <li>Ter o node instalado na maquina </li>
  <li>Ter o express e body parcer do node </li>
  <li>Antes de simular, subir o servidor no terminal (utilizando o comando node API.js)</li>
 </ol>

## Fluxo de telas do Aplicativo:
<div> Launch Screen: Tela de início <br> 
<img src="https://user-images.githubusercontent.com/42249434/64039218-7eef6e00-cb30-11e9-8223-ebc3348c5ec0.png" width="150" height="250"> 
</div> 
<p> Tela de listagem de contatos, com a opção de adicionar <br>   <img width="150" height="250" alt="Captura de Tela 2019-08-30 às 13 43 47" src="https://user-images.githubusercontent.com/42249434/64039586-59169900-cb31-11e9-93d7-2a487192a1c1.png"> </p> 
<p>  Arrastando o contato para o lado, abre a opção para deletar o contato <br> 
<img width="150" height="250" alt="Captura de Tela 2019-08-30 às 13 44 03" src="https://user-images.githubusercontent.com/42249434/64039647-7ba8b200-cb31-11e9-9e54-c710e17d78ad.png"> 
</p>
<p> Após decidir deletar abre uma alerta para o usuário confirma a ação <br> 
<img width="150" height="250" alt="Captura de Tela 2019-08-30 às 13 44 14" src="https://user-images.githubusercontent.com/42249434/64039877-11444180-cb32-11e9-9632-a42cc73a0b89.png"> 
</p>
<p> Tela de detalhe de contato, tendo a opção de "editar"  <br> 
  <img width="150" height="250" alt="Captura de Tela 2019-08-30 às 13 44 28" src="https://user-images.githubusercontent.com/42249434/64039911-2de07980-cb32-11e9-897a-f7a5edea4a65.png"> 
</p>
<p> Tela de editagem de contato <br> 
<img width="150" height="250" alt="Captura de Tela 2019-08-30 às 13 44 38" src="https://user-images.githubusercontent.com/42249434/64039971-48b2ee00-cb32-11e9-87d9-4e9989758386.png">
</p>
<p> Tela de adição de contato <br>
<img width="150" height="250" alt="Captura de Tela 2019-08-30 às 13 45 00" src="https://user-images.githubusercontent.com/42249434/64040025-697b4380-cb32-11e9-8ca1-186d673e8acd.png"> 
</p>

## Resumo de Aplicativo:
Um aplicativo feito com Swift, utilizando uma api feita em node.js. Aonde lista contatos, trazendo da api. Com todos os elementos de um CRUD o usuário pode Adicionar, Editar, Apagar, Listar os seus contatos. Chamada de api feito de modo nativo sem utilização de algum POD.





