class VisitorController < ApplicationController
  require 'open-uri'
  before_action :authenticate_user!, only: [:mypage, :mypage_search]
  def main
    @home_url = "http://tv.naver.com"
    @url = "#{@home_url}/search/clip?query=%EC%BF%A1%EB%B0%A9&isTag=false"
    doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @title = doc.css('dt > a')
    @thumnail = doc.css('a.cds_thm > img')
    #@new_link = link.map{|link| link.text}
  end
  
  def main2
    @home_url = "http://tv.naver.com"
    @url = "#{@home_url}/search/clip?query=%EC%BF%A1%EB%B0%A9&isTag=false"
    doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @title = doc.css('dt > a')
    @thumnail = doc.css('a.cds_thm > img')
    #@new_link = link.map{|link| link.text}
  end
  
  def mypage
    
    #@new_link = link.map{|link| link.text}
    
    #카테고리 골라서 변수에 저장
    #마이페이지 탭에서 카테고리를 선택할 때마다 category 변수의 값이 변해야 한다
    
    if params[:name]
      @category = params[:name]
      if @category=="쿡방"
        @categoryEnglish="Cooking"
      elsif @category=="먹방"
        @categoryEnglish="Eating"
      elsif @category=="게임"
        @categoryEnglish="Game"
      elsif @category=="힐링"
        @categoryEnglish="Healing"
      elsif @category=="홈트레이닝"
        @categoryEnglish="Home Training"
      elsif @category=="뷰티"
        @categoryEnglish="Beauty"
      else
        @categoryEnglish="Pet"
      end
      #나중에지우기
        @home_url = "http://tv.naver.com"
        temp = "#{@home_url}/search/clip?query=#{@category}&isTag=false"
        @url = URI.encode(temp)
        doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
        @title = doc.css('dt > a')
        @thumnail = doc.css('a.cds_thm > img')
      #지우기 끝
      category = Category.find_by(name: params[:name])
      if category
        @scraped_clips = current_user.scraped_clips.where(category_id: category.id)
      end
    elsif
      @scraped_clips = current_user.scraped_clips
      #나중에지우기
        @home_url = "http://tv.naver.com"
        @url = "#{@home_url}/search/clip?query=%EC%BF%A1%EB%B0%A9&isTag=false"
        doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
        @title = doc.css('dt > a')
        @thumnail = doc.css('a.cds_thm > img')
      #지우기 끝
    end
  end

  def mypage_search
    @keyword = params[:search]
    @clips = current_user.scraped_clips.search(@keyword)
    if current_user.searched_this?(@keyword)
      current_user.increse_keyword_frequency(@keyword)
    else
      current_user.create_keyword(@keyword)
    end
    @home_url = "http://tv.naver.com"
    temp = "#{@home_url}/search/clip?query=#{params[:search]}&isTag=false"
    @url = URI.encode(temp)
    doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @title = doc.css('dt > a')
    @thumnail = doc.css('a.cds_thm > img')
  end  
  
>>>>>>> 1dece93717170a594d0d3c764cdc0197e1d51288
  def search
    @home_url = "http://tv.naver.com"
    temp = "#{@home_url}/search/clip?query=#{params[:search]}&isTag=false"
    @url = URI.encode(temp)
    doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @title = doc.css('dt > a')
    @thumnail = doc.css('a.cds_thm > img')
  end
end
