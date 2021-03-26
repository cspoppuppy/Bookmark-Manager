require 'tag'

describe Tag do
  describe '.add' do
    it 'adds tag to database' do
      tag = "tag1"
      sql = "INSERT INTO tags (content) VALUES ('#{tag}') RETURNING id, content;"
      expect(DB).to receive(:query).with(sql).and_return([{ "id" => "1", "content" => tag }])
      Tag.add(tag)
    end
  end
end
