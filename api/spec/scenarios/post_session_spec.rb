describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "betao@hotmail.com", password: "pwd123" }
      @result = Sessions.new.login(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  # examples = [
  #   {
  #     name: "senha inválida",
  #     payload: { email: "mateus@yahoo.com", password: "123456" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     name: "usuário nao existe",
  #     payload: { email: "404@yahoo.com", password: "123456" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     name: "email em branco",
  #     payload: { email: "", password: "123456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     name: "sem email",
  #     payload: { password: "123456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     name: "senha em branco",
  #     payload: { email: "mateus@yahoo.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     name: "sem senha",
  #     payload: { email: "mateus@yahoo.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  examples = Helpers::get_fixture("login")
  examples.each do |e|
    context "#{e[:name]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end
      it "valida erro" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
