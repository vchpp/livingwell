class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update destroy ]
  before_action :set_page, only: [:show]

  # GET /messages or /messages.json
  def index
    @messages = Message.where(nil)
      .send("with_attached_#{I18n.locale}_images".downcase)
      .with_attached_images
      .order('created_at ASC')
    @admin_messages = @messages.sort_by(&:category)
    @messages = @messages.where(archive: false)
    set_message_categories
    @messages = @messages.filter_by_category(params[:category]) if (params[:category].present?)
    # if @message.empty? redirect to new_message_path
    respond_to do |format|
      format.html
      format.csv { send_data @messages.to_csv, filename: "Messages-#{Date.today}.csv" } if current_user.try(:admin?)
    end
  end

  # GET /messages/1 or /messages/1.json
  def show
    if @message.archive?
      if current_user.try(:admin?)
        flash.now[:alert] = "Message is currently archived"
      else
        redirect_to messages_url, alert: "Message not available."
      end
    end
    @likes = @message.likes.all.order('rct::integer ASC')
    @all_comments = @message.comments
    @admin_comments = @all_comments.order('rct::integer ASC')
    @comments = @all_comments.order(created_at: :desc).limit(10).offset((@page.to_i - 1) * 10)
    @page_count = (@all_comments.count / 10) + 1
    @message_name = @message.send("#{I18n.locale}_name".downcase)
    @message_content = @message.send("#{I18n.locale}_content".downcase)
    @message_external_rich_links = @message.send("#{I18n.locale}_external_rich_links".downcase)
    @message_action_item = @message.send("#{I18n.locale}_action_item".downcase)
    @audio = @message.send("#{I18n.locale}_audio".downcase)
    up_likes
    down_likes
    respond_to do |format|
      format.html
      format.csv do
        if (params[:format_data] == 'comments')
          send_data @message.comments_to_csv, filename: "Message##{@message.id}-Comments-#{Date.today}.csv" if current_user.try(:admin?)
        elsif (params[:format_data] == 'likes')
          send_data @message.likes_to_csv, filename: "Message##{@message.id}-Likes-#{Date.today}.csv" if current_user.try(:admin?) 
        end
      end
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message[:external_links] = params[:message][:external_links].first.split("\r\n").map(&:strip) if params[:message][:external_links].present?
    @message.images.attach(params[:message][:images]) if params[:images].present?
    @message.en_images.attach(params[:message][:en_images]) if params[:en_images].present?
    @message.vi_images.attach(params[:message][:vi_images]) if params[:vi_images].present?
    @message.zh_cn_images.attach(params[:message][:zh_cn_images]) if params[:zh_cn_images].present?
    @message.zh_tw_images.attach(params[:message][:zh_tw_images]) if params[:zh_tw_images].present?
    @message.hmn_images.attach(params[:message][:hmn_images]) if params[:hmn_images].present?
    @message.hmn_audio.attach(params[:message][:hmn_audio]) if params[:hmn_audio].present?
    @message.en_audio.attach(params[:message][:en_audio]) if params[:en_audio].present?
    @message.vi_audio.attach(params[:message][:vi_audio]) if params[:vi_audio].present?
    @message.zh_tw_audio.attach(params[:message][:zh_tw_audio]) if params[:zh_tw_audio].present?
    @message.zh_cn_audio.attach(params[:message][:zh_cn_audio]) if params[:zh_cn_audio].present?

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
        logger.warn("#{current_user.email} created Message #{@message.id} with title #{@message.en_name}")
        audit! :created_message, @message, payload: message_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    @message[:external_links] = params[:message][:external_links].first.split("\r\n").map(&:strip) if params[:message][:external_links].present?
    @message.images.purge if params[:images].present?
    @message.en_images.purge if params[:en_images].present?
    @message.zh_tw_images.purge if params[:zh_tw_images].present?
    @message.zh_cn_images.purge if params[:zh_cn_images].present?
    @message.vi_images.purge if params[:vi_images].present?
    @message.hmn_images.purge if params[:hmn_images].present?
    @message.hmn_audio.purge if params[:hmn_audio].present? || params[:hmn_audio_purge].present?
    @message.vi_audio.purge if params[:vi_audio].present? || params[:vi_audio_purge].present?
    @message.en_audio.purge if params[:en_audio].present? || params[:en_audio_purge].present?
    @message.zh_tw_audio.purge if params[:zh_tw_audio].present? || params[:zh_tw_audio_purge].present?
    @message.zh_cn_audio.purge if params[:zh_cn_audio].present? || params[:zh_cn_audio_purge].present?
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
        logger.warn("#{current_user.email} updated Message #{@message.id} with title #{@message.en_name}")
        audit! :updated_message, @message, payload: message_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.images.purge
    @message.en_images.purge
    @message.zh_tw_images.purge
    @message.zh_cn_images.purge
    @message.vi_images.purge
    @message.hmn_images.purge
    @message.hmn_audio.purge
    @message.vi_audio.purge
    @message.en_audio.purge
    @message.zh_tw_audio.purge
    @message.zh_cn_audio.purge
    audit! :destroyed_message, @message, payload: @message.attributes
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.with_attached_images.friendly.find(params[:id])
  end

  def set_page
    @page = params[:page] || 1
  end

  def set_message_categories
    @message_categories = []
    @messages.each do |message|
      @message_categories << message.category
    end
    @message_categories = @message_categories.uniq
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:en_name,
                                    :en_content,
                                    :en_action_item,
                                    :zh_tw_name,
                                    :zh_tw_content,
                                    :zh_tw_action_item,
                                    :zh_cn_name,
                                    :zh_cn_content,
                                    :zh_cn_action_item,
                                    :vi_name,
                                    :vi_content,
                                    :vi_action_item,
                                    :hmn_name,
                                    :hmn_content,
                                    :hmn_action_item,
                                    :external_links,
                                    :en_external_rich_links,
                                    :zh_tw_external_rich_links,
                                    :zh_cn_external_rich_links,
                                    :vi_external_rich_links,
                                    :hmn_external_rich_links,
                                    :survey_link,
                                    :category,
                                    :archive,
                                    :en_audio,
                                    :hmn_audio,
                                    :vi_audio,
                                    :zh_tw_audio,
                                    :zh_cn_audio,
                                    :en_audio_purge,
                                    :vi_audio_purge,
                                    :hmn_audio_purge,
                                    :zh_tw_audio_purge,
                                    :zh_cn_audio_purge,
                                    images: [],
                                    en_images: [],
                                    vi_images: [],
                                    zh_tw_images: [],
                                    zh_cn_images: [],
                                    hmn_images: [],
                                  )
  end

  def up_likes
    likes = @message.likes.all
    up = likes.map do |like| like.up end
    @up_likes = up.map(&:to_i).reduce(0, :+)
  end

  def down_likes
    likes = @message.likes.all
    down = likes.map do |like| like.down end
    @down_likes = down.map(&:to_i).reduce(0, :+)
  end
end
