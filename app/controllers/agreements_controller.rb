class AgreementsController < ApplicationController
  # No Before Action nós adicionamos também o export para que ele consiga pegar o agreement correto
  before_action :set_agreement, only: [:show, :edit, :update, :destroy, :export]
  # Nós incluimos aqui a lib que vamos criar chamada generate_pdf.rb
  require './lib/generate_pdf'
 
  # GET /agreements
  # GET /agreements.json
  def index
    @agreements = Agreement.all
  end
 
  # GET /agreements/1
  # GET /agreements/1.json
  def show
  end
 
  # GET /agreements/new
  def new
    @agreement = Agreement.new
  end
 
  # GET /agreements/1/edit
  def edit
  end
 
  # POST /agreements
  # POST /agreements.json
  def create
    @agreement = Agreement.new(agreement_params)
 
    respond_to do |format|
      if @agreement.save
        format.html { redirect_to @agreement, notice: 'Agreement was successfully created.' }
        format.json { render :show, status: :created, location: @agreement }
      else
        format.html { render :new }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # PATCH/PUT /agreements/1
  # PATCH/PUT /agreements/1.json
  def update
    respond_to do |format|
      if @agreement.update(agreement_params)
        format.html { redirect_to @agreement, notice: 'Agreement was successfully updated.' }
        format.json { render :show, status: :ok, location: @agreement }
      else
        format.html { render :edit }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # DELETE /agreements/1
  # DELETE /agreements/1.json
  def destroy
    @agreement.destroy
    respond_to do |format|
      format.html { redirect_to agreements_url, notice: 'Agreement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  # Criamos este método que vai chamar nossa lib para gerar o PDF e depois redirecionar o user para o arquivo PDF
  def export
    GeneratePdf::agreement(@agreement.client_name, @agreement.description, @agreement.price)
    redirect_to '/agreement.pdf'
  end
 
  private
    def set_agreement
      @agreement = Agreement.find(params['id'])
    end
 
    def agreement_params
      params.require(:agreement).permit(:client_name, :description, :price)
    end
end