Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @login_page.open
  @login_page.with(email, password)

  # Checkpoint para garantir que estamos no Dashboard
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulário de cadastrado de anúncios") do
  @dash_page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento:") do |table|
  @anuncio = table.rows_hash

  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastrado desse item") do
  @equipos_page.create(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter a mensagem de alerta: {string}") do |expect_alert|
  expect(@alert.dark).to have_text expect_alert
end

# Remover Anúncios
Dado("que eu tenho um anúncio indesejado:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")
  log user_id

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")
  equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:name],
    category: table.rows_hash[:category],
    price: table.rows_hash[:price],
  }
  EquiposService.new.create(equipo, user_id)
end

Quando("eu solicito a exclusão desse item") do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando("confirmo a exclusão") do
  pending # Write code here that turns the phrase above into concrete actions
end

Então("não devo ver esse item no meu Dashboard") do
  pending # Write code here that turns the phrase above into concrete actions
end
