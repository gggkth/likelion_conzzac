class ClipController < ApplicationController
  
  #동영상 출력하는 곳
  def index
    
    #검색했을 경우
    if params[:search]
      @keyword = params[:search]
      
      #user가 해당 키워드로 서치한 적이 있는경우 vs 없는 경우
      if current_user.searched_this?(@keyword)
        current_user.increse_keyword_frequency(@keyword)
      else
        current_user.create_keyword(@keyword)
      end
      
      @clilps = Clip.search(params[:search]).reverse
    
    #카테고리 선택했을 경우
    elsif params[:category]
      @clips = Clips.where(category: params[:category])
    end  
    
  end
  
  #Frequent 모델 create vs update
  def create
    
    #유저가 해당동영상 클릭했을 시, (현재유저가 현재동영상을 본)회수 create vs update
    @clip = Clips.find(params[:id])
    if current_user.view_this?(@clip)
      current_user.increse_frequent_frequency(@clip)
    else
      current_user.create_frequent(@clip)
    end 
    redirect_to @clip.clip_url
 
  end  
  
  #동영상 스크랩
  def scrap_toggle
    @clip = Clips.find(params[:id])
    if current_user.scrap_this?(@clip)
      Scrap.find_by(user_id: current_user.id, clip_id: clip.id).destroy
    else
      Scrap.create(user_id: current_user, clip_id: @clip.id)
    end 
    redirect_to :back
  end  
  
end
