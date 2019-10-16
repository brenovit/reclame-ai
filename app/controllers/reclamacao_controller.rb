class ReclamacaoController < ApplicationController

    def index
        @reclamacao = Reclamacao.all
    end
    
    def new
        @reclamacao = Reclamacao.new
    end

    def create
        @reclamacao = Reclamacao.new(reclamacao_params)
        @reclamacao.ip = get_ip

        responseIp = Faraday.get 'http://extreme-ip-lookup.com/json/' + @reclamacao.ip

        cep = get_cep_data(@reclamacao.cep)
        if cep.nil?
            flash[:mensagem] = "CEP invalido"
            redirect_to request.referrer
        else
            if cep["localidade"] == JSON.parse(responseIp.body)["city"]
                @reclamacao.suspeito = 'N'
            else
                @reclamacao.suspeito = 'S'
            end

            if @reclamacao.save
                flash[:mensagem] = "Reclamação realizada com sucesso. Ticket #" + @reclamacao.id.to_s
            else
                flash[:mensagem] = "Erro ao cadastrara a reclamação. Entre em contato com o suporte"
            end
            redirect_to :controller => 'reclamacao', action: 'index'
        end
    end
    
    def show
        begin  
            @reclamacao = Reclamacao.find(params[:id])
        rescue ActiveRecord::RecordNotFound  => e
            flash[:mensagem] = "Reclamação não encontrada"
            redirect_to :controller => 'reclamacao', action: 'index'
        end
    end

    private
        def reclamacao_params
            params.require(:reclamacao).permit(:nome, :cep, :email, :telefone, :cod_pedido, :titulo, :descricao, :suspeito)
        end

    private
        def get_cep_data(cep)            
            response = Faraday.get 'https://viacep.com.br/ws/'+cep.to_s+'/json/'
            if response.status == 200
                JSON.parse(response.body)
            else
                nil
            end
        end

    private
        def get_ip
            if request.local?
                '127.0.0.1'
            else
                request.remote_ip
            end
        end
end
