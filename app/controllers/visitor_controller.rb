class VisitorController < ApplicationController
  require 'open-uri'
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
  def search
    @home_url = "http://tv.naver.com"
    temp = "#{@home_url}/search/clip?query=#{params[:search]}&isTag=false"
    @url = URI.encode(temp)
    doc = Nokogiri::HTML(open(@url), nil, 'utf-8')
    @title = doc.css('dt > a')
    @thumnail = doc.css('a.cds_thm > img')
  end
end
