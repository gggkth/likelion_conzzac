class User < ActiveRecord::Base
  has_many :scraps
  has_many :scraped_clips, through: :scraps, source: :clip
  has_many :frequents
  has_many :frequent_clips, through: :frequents, source: :clip
  has_many :keywords
  has_many :likes
  has_many :liked_clips, through: :likes, source: :clip
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  recommends :clips
  
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # user와 identity가 nil이 아니라면 받는다

    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    # user가 nil이라면 새로 만든다.

    if user.nil?

      # 이미 있는 이메일인지 확인한다.

      email = auth.info.email
      user = User.where(:email => email).first

      unless self.where(email: auth.info.email).exists?
        # 없다면 새로운 데이터를 생성한다.

        if user.nil?
          # 카카오는 email을 제공하지 않음

          if auth.provider == "kakao"
            # provider(회사)별로 데이터를 제공해주는 hash의 이름이 다릅니다.

            # 각각의 omnaiuth별로 auth hash가 어떤 경로로, 어떤 이름으로 제공되는지 확인하고 설정해주세요.

            user = User.new(
              profile_img: auth.info.image,
              # 이 부분은 AWS S3와 연동할 때 프로필 이미지를 저장하기 위해 필요한 부분입니다.

              # remote_profile_img_url: auth.info.image.gsub('http://','https://'),

              password: Devise.friendly_token[0,20]
            )

          else
            user = User.new(
              email: auth.info.email,
              profile_img: auth.info.image,
              # remote_profile_img_url: auth.info.image.gsub('http://','https://'),

              password: Devise.friendly_token[0,20]
            )
          end
          user.save!
        end
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user

  end

  # email이 없어도 가입이 되도록 설정

  def email_required?
    false
  end
  
  def view_this?(clip)
    Frequent.find_by(user_id: self.id, clip_id: clip.id).present?
  end
  
  def scrap_this?(clip)
    Scrap.find_by(user_id: self.id, clip_id: clip.id).present?
  end
  
  def like_this?(clip)
    Like.find_by(user_id: self.id, clip_id: clip.id).present?
  end
  
  def searched_this?(keyword)
    self.keywords.find_by(content: keyword.content).present?
  end
  
  def increse_keyword_frequency(keyword)
    key = self.keywords.find_by(content: keyword.content)
    key.frequency = key.frequency+1
    key.save
  end
  
  def create_keyword(keyword)
    Keyword.create(user_id: self.id, content: keyword, frequency: "1")
  end 
  
  def increse_frequent_frequency(clip)
    frequent = Frequent.find_by(user_id: self.id, clip_id: clip.id)
    frequent.frequency = frquent.frequency+1
    frequent.save
  end
  
  def create_frequent(clip)
    Frequent.create(user_id: self.id, clip_id: clip.id, frequency: "1")
  end
end