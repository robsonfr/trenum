require 'spec_helper'

describe LoginController do
    render_views
    
    it "deveria pegar o titulo de eleitor e a senha para ser autenticada pela classe de modelo"
    it "deveria autenticar o usuario e manda-lo para a pagina inicial de documentos, com a sessao atualizada"
    it "deveria mandar para a pagina de login se a senha estiver incorreta"
end
