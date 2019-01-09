# encoding: UTF-8
# frozen_string_literal: true

class Transfer < ActiveRecord::Base
  # Define has_many relation with Operations::{Asset,Expense,Liability,Revenue}.
  ::Operation::TYPES.map(&:pluralize).each do |op_t|
    has_many op_t.to_sym,
             class_name: "::Operations::#{op_t.to_s.singularize.camelize}",
             as: :reference
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
