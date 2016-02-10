class WodsController < ApplicationController
  require 'feedjira'
  before_action :set_wod, only: [:show, :edit, :update, :destroy]
  @WOTD_RSS_FEED='http://dictionary.reference.com/wordoftheday/wotd.rss'

  # GET /wods
  # GET /wods.json
  def index
    @wods = Wod.all
  end

  # GET /wods/1
  # GET /wods/1.json
  def show
  end

  def display

    @wods = Wod.where("DATE(date) = ? " ,Date.today  )
    logger.debug "Entries on Wods table #{@wods.first}"
    @wod = @wods.first
    if !@wod
      @wods = Feed.where("DATE(date) = ? " ,Date.today  )
      logger.debug "Entries on Feeds table #{@wods.first}"
      @wod = @wods.first
      if !@wod
         @wod = fetch_save_from_dictionary
      end
    end
   render "show" 
  end


  def fetch_save_from_dictionary
   url = ENV['feed_url']
   url = 'http://dictionary.reference.com/wordoftheday/wotd.rss'
  feed = Feedjira::Feed.fetch_and_parse url
  logger.debug "Feed type ... #{ENV['feed_type']}"
  if ENV['feed_type'] == 'dictionary'
   word = feed.entries.first.title.split(':')[0]
   meaning =  feed.entries.first.summary.split(':')[1]
 else
  word =  feed.entries.first.title
  meaning = feed.entries.first.description 
 end  
 
  wod = Feed.new do |u|
  u.title = word
  u.meaning = meaning
  u.date = Date.today
  end
  wod.save
  wod
  end

  # GET /wods/new
  def new
    @wod = Wod.new
  end

  # GET /wods/1/edit
  def edit
  end

  # POST /wods
  # POST /wods.json
  def create
    @wod = Wod.new(wod_params)

    respond_to do |format|
      if @wod.save
        format.html { redirect_to @wod, notice: 'Wod was successfully created.' }
        format.json { render :show, status: :created, location: @wod }
      else
        format.html { render :new }
        format.json { render json: @wod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wods/1
  # PATCH/PUT /wods/1.json
  def update
    respond_to do |format|
      if @wod.update(wod_params)
        format.html { redirect_to @wod, notice: 'Wod was successfully updated.' }
        format.json { render :show, status: :ok, location: @wod }
      else
        format.html { render :edit }
        format.json { render json: @wod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wods/1
  # DELETE /wods/1.json
  def destroy
    @wod.destroy
    respond_to do |format|
      format.html { redirect_to wods_url, notice: 'Wod was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wod
      @wod = Wod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wod_params
      params.require(:wod).permit(:title, :meaning, :date)
    end
     def feed_params
      params.require(:feed).permit(:title, :description, :date)
    end
end
