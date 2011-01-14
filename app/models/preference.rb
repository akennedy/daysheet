class Preference < ActiveRecord::Base
  belongs_to :user
  
  #-------------------------------------------------------------------
  Preference::PERPAGE = ['10', '20', '30', '40', '50']

  #-------------------------------------------------------------------
  def [] (name)
    return super(name) if name.to_s == "user_id" # get the value of belongs_to

    preference = Preference.find_by_name_and_user_id(name.to_s, self.user.id)
    preference ? Marshal.load(Base64.decode64(preference.value)) : nil
  end

  #-------------------------------------------------------------------
  def []= (name, value)
    return super(name, value) if name.to_s == "user_id" # set the value of belongs_to

    encoded = Base64.encode64(Marshal.dump(value))
    preference = Preference.find_by_name_and_user_id(name.to_s, self.user.id)
    if preference
      preference.update_attribute(:value, encoded)
    else
      Preference.create(:user => self.user, :name => name.to_s, :value => encoded)
    end
    value
  end

end
