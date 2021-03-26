require 'user'

describe User do
  describe '.create' do
    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')
      User.create('test@example.com', 'password123')
    end

    it 'creates a new user' do
      user = User.create('test@example.com', 'password123')
      # persisted_data = persisted_data(user, user.id)
      expect(user).to be_a User
      # expect(user.id).to eq persisted_data.first['id']
      expect(user.email).to eq 'test@example.com'
    end
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = User.create('test@example.com', 'password123')
      result = User.find(user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
  end

  describe '.sign_in' do
    it 'returns a user give correct email and password' do
      user = User.create('test2@example.com', 'password123')
      auth_user = User.sign_in('test2@example.com', 'password123')

      expect(auth_user.id).to eq user.id
    end

    it 'returns nil with wrong email' do
      User.create('test@example.com', 'password123')
      expect(User.sign_in('notrightemail@example.com', 'password123')).to be_nil
    end

    it 'returns nil with wrong email' do
      User.create('test@example.com', 'password123')
      expect(User.sign_in('test@example.com', 'wrongpass')).to be_nil
    end
  end
end
