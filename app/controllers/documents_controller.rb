#encoding:UTF-8
class DocumentsController < ApplicationController
  before_filter :check_profile_completeness
  
  def index
    unless current_user.admin?
      @documents = current_user.documents.order('doctype asc')
    else
      @documents = Document.all
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.build(params[:document])
    @document_by_type = Document.find_all_by_doctype(@document.doctype)
    unless @document_by_type.empty?
      @document.update_attributes(:dispatch_number => Document.order('dispatch_number asc').find_all_by_doctype(@document.doctype).last.dispatch_number + 1, :status => "Upload pendente")
    else
      @document.update_attributes(:dispatch_number => 1, :status => "Upload pendente")
    end
    if @document.save
      redirect_to documents_path, :notice => "Número gerado com sucesso: <span class=\"big-number\">#{@document.dispatch_number}</span><br />Por favor, não se esqueça de fazer o upload de uma cópia do documento assinado após o envio.".html_safe
    else
      render :action => 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params[:document])
      if !@document.pdf_file.blank? && @document.status != "Finalizado"
        @document.update_attributes(:status => "Finalizado")
        redirect_to documents_path, :notice  => "Documento finalizado com sucesso. Obrigado!"
      else
        redirect_to @document, :notice  => "Documento atualizado com sucesso."
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url, :notice => "Documento destruído com sucesso."
  end

  def cancel
    @document = Document.find(params[:id])
    @document.update_attributes(:status => "Cancelado")
    if @document.update_attributes(params[:document])
      redirect_to @document, :notice => "Documento cancelado com sucesso"
    else
      render :action => 'show'
      flash.now[:error] = "Seu documento não foi cancelado. Por favor tente novamente."
    end
  end
end
