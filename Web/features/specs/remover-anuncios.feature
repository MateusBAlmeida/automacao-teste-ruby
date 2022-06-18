#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anúnciante que possui um equipamento indesejado
    Quero poder remover esse Anúncios
    Para que eu possa manter o meu dashboard atualizado

    Contexto: Login
        * Login com "spider@hotmail.com" e "pwd123"

    @temp
    Cenario: Remover anúncio

        Dado que eu tenho um anúncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | Cordas         |
            | preco     | 200            |
        Quando eu solicito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu Dashboard

    Cenario: Desistir da exclusão

        Dado que eu tenho um anúncio indesejado:
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 200       |
        Quando eu solicito a exclusão desse item
            Mas não confirmo a solicitação
        Então devo ver esse item no meu Dashboard
