class CreateReclamacaos < ActiveRecord::Migration[6.0]
  def change
    create_table :reclamacaos do |t|
      t.string :nome
      t.string :cep
      t.string :email
      t.string :telefone
      t.string :cod_pedido
      t.string :titulo
      t.text :descricao
      t.string :suspeito
      t.string :ip

      t.timestamps
    end
  end
end
