require 'db_setup'

module StudiosTest
  account1 = Account.create
  account2 = Account.create
  m_user1 = UserWithMixin.create(account: account1)
  m_user2 = UserWithMixin.create(account: account2)
  m_user3 = UserWithMixin.create(account: account1)
  um_user1 = UserWithoutMixin.create(account: account1)
  um_user2 = UserWithoutMixin.create(account: account2)

  describe "mixed-in models" do
    it "sets a default scope" do
      expect(UserWithMixin.default_scopes.count).to eq(1)
    end

    it "returns all models for Model.all with no tenant set" do
      StudioApartment.current_tenant = nil

      expect(UserWithMixin.all).to eq([m_user1, m_user2, m_user3])
    end

    it "returns models by tenant for Model.all with a tenant set" do
      StudioApartment.current_tenant = account2

      expect(UserWithMixin.all).to eq([m_user2])
    end

    it "returns all models for Model.all with a tenant set when unscoped" do
      StudioApartment.current_tenant = account2

      expect(UserWithMixin.unscoped.all).to eq([m_user1, m_user2, m_user3])
    end
  end

  describe "unmixed-in models" do
    it "does not set a default scope" do
      expect(UserWithoutMixin.default_scopes.count).to eq(0)
    end

    it "returns all models for Model.all even if tenant set" do
      StudioApartment.current_tenant = account2

      expect(UserWithoutMixin.all).to eq([um_user1, um_user2])
    end  
  end
end