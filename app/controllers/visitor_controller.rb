class VisitorController < ApplicationController
  require 'open-uri'
  $page = 1
  $last_page = 1
  def main
    @home_url = "http://tv.naver.com"
    @url = "#{@home_url}/search/clip?query=%EC%BF%A1%EB%B0%A9&isTag=false"
    doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @title = doc.css('dt > a')
    @thumnail = doc.css('a.cds_thm > img')
    #@new_link = link.map{|link| link.text}
  end
  def search
    if(params[:page].to_i == 1)
      $page = params[:page].to_i
    end
    @home_url = "http://tv.naver.com"
      # $search = params[:search]
      temp = "#{@home_url}/search/clip?query=#{params[:search]}&sort=playcount&page=#{$page}&isTag=false"
      @url = URI.encode(temp)
      doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @thumnail = doc.css('a.cds_thm > img')
    @title = doc.css('dt > a')
    # @content = doc.css('')
    @view = doc.css('span.cds_ifc.cnp')
    #@clip_url = "#{@home_url}#{@title["href"]}"
    @uploader_id = doc.css('span.ch_txt')
    # @source_id = doc.css('address > a')["href"]
    @playtime = doc.css('span.tm_b')
    if (doc.css('a._click.next.next_end')[0] != nil)
      $last_page = doc.css('a._click.next.next_end')[0]["data-page"].to_i
    end
    @title.each_with_index do |title, index|
      @clip = Clip.find_or_create_by(title: @title[index]["title"])
      @clip.thumbnail_url = @thumnail[index]
      @clip.title = @title[index]["title"]
      # @clip.content = @content[index]
      @clip.view = @view[index].text
      @clip.clip_url = "#{@home_url}#{@title[index]["href"]}"
      @clip.uploader_id = Uploader.find_or_create_by(name: @uploader_id[index].text).id
      @clip.source_id = 3
      @clip.save
    end
    
    def next_page
      $page += 1
      redirect_to action: "search", search: "#{params[:search]}"
    end
    
    def prev_page
      if ($page > 1)
        $page -= 1
        redirect_to action: "search", search: "#{params[:search]}"
      else
        redirect_to action: "search", search: "#{params[:search]}"
      end
    end
    
    # doc.each do |doc|
    #   @clip = Clip.new
    #   @clip.thumbnail_url = doc.css('a.cds_thm > img')
    #   @clip.title = doc.css('dt > a')
    #   @clip.content = doc.css('')
    #   @clip.view = doc.css('span.cds_ifc cnp')
    #   @clip.clip_url = "#{@home_url}#{@clip.title["href"]}"
    #   uploader_tmp = doc.css('span.ch_txt')
    #   source_tmp = doc.css('address > a')["href"]
    #   @clip.uploader_id = Uploader.find_or_create_by(name:uploader_tmp)
    #   @clip.source_id = Source.find_or_create_by(name:source_tmp)
    #   @clip.save
    # end
  end
end
