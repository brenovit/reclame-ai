class ReclamacaoController < ApplicationController

    before_action :current_reclamacao, only: [:show]

    def index
        @reclamacaos = Reclamacao.all
    end
    
    def new
        @reclamacao = Reclamacao.new
    end

    def create
        @reclamacao = Reclamacao.new(reclamacao_params)
        redirect_to @reclamacao
    end
    
    def show
    end

    private
        def reclamacao_params
            # params.require(:reclamacao).permit(:nome, :cep, :email, :telefone, :cod_pedido, :titulo, :descricao, :suspeito, :ip)
            params.require(:reclamacao).permit(:nome, :cep, :email, :telefone, :cod_pedido, :titulo, :descricao)
        end

        def current_reclamacao
            @reclamacao = Reclamacao.find(params[:id])
        end
end
