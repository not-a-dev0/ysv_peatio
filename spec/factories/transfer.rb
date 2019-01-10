# encoding: UTF-8
# frozen_string_literal: true

FactoryBot.define do
  sequence :transfer_key do
    Faker::Number.number(5).to_i
  end
  sequence :transfer_kind do |n|
    %w[referral-payoff token-distribution member-transfer].sample + "-#{n}"
  end

  factory :transfer do
    key  { generate(:transfer_key) }
    kind { generate(:transfer_kind) }
    desc { "#{kind} for #{Time.now.to_date}" }

    trait :with_assets do
      after(:create) do |t|
        assets_number = Faker::Number.between(1, 5).to_i
        create_list(:asset, assets_number, reference: t)
      end
    end

    trait :with_expenses do
      after(:create) do |t|
        expense_number = Faker::Number.between(1, 5).to_i
        create_list(:expense, expense_number, reference: t)
      end
    end

    trait :with_liabilities do
      after(:create) do |t|
        liabilities_number = Faker::Number.between(1, 5).to_i
        create_list(:liability, liabilities_number, reference: t)
      end
    end

    trait :with_revenues do
      after(:create) do |t|
        revenues_number = Faker::Number.between(1, 5).to_i
        create_list(:revenue, revenues_number, reference: t)
      end
    end

    trait :with_operations do
      with_assets
      with_expenses
      with_liabilities
      with_revenues
    end

    factory :transfer_with_operations, traits: %i[with_operations]
  end

end


# == Schema Information
# Schema version: 20181226170925
#
# Table name: transfers
#
#  id         :integer          not null, primary key
#  key        :integer          not null
#  kind       :string(30)       not null
#  desc       :string(255)      default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_transfers_on_key   (key) UNIQUE
#  index_transfers_on_kind  (kind)
#
