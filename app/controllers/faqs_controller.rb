class FaqsController < ApplicationController
  before_action :set_faq, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update destroy ]
  # GET /faqs or /faqs.json
  def index
    @faqs = Faq.where(nil).order('category ASC') # creates an anonymous scope
    @admin_faqs = @faqs.sort_by(&:category)
    @faqs = @faqs.where(archive: false)
    @faqs = @faqs.filter_by_search(params[:search]) if (params[:search].present?)
  end

  # GET /faqs/1 or /faqs/1.json
  def show
    if @faq.archive?
      if current_user.try(:admin?)
        flash.now[:alert] = "FAQ is currently archived"
      else
        redirect_to faqs_url, alert: "FAQ not available."
      end
    end
  end

  # GET /faqs/new
  def new
    @faq = Faq.new
  end

  # GET /faqs/1/edit
  def edit
  end

  # POST /faqs or /faqs.json
  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html { redirect_to @faq, notice: "Faq was successfully created." }
        format.json { render :show, status: :created, location: @faq }
        logger.info "#{current_user.email} created FAQ #{@faq.id} with title #{@faq.en_question}"
        audit! :created_faq, @faq, payload: faq_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faqs/1 or /faqs/1.json
  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to @faq, notice: "Faq was successfully updated." }
        format.json { render :show, status: :ok, location: @faq }
        logger.info "#{current_user.email} updated FAQ #{@faq.id} with title #{@faq.en_question}"
        audit! :updated_faq, @faq, payload: faq_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1 or /faqs/1.json
  def destroy
    audit! :destroyed_faq, @faq, payload: @faq.attributes
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to faqs_url, notice: "Faq was successfully destroyed." }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_faq
    @faq = Faq.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def faq_params
    params.require(:faq).permit(:en_question, :en_answer, :zh_tw_question, :zh_tw_answer, :zh_cn_question, :zh_cn_answer, :hmn_question, :hmn_answer, :vi_question, :vi_answer, :category, :archive, :search, :en_audio, :vi_audio, :zh_tw_audio, :zh_cn_audio, :hmn_audio)
  end
end
