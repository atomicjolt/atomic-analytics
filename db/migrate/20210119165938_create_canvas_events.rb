class CreateCanvasEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :canvas_events do |t|
			t.string :event_type
			t.string :asset_name
			t.string :asset_type
			t.string :asset_subtype
			t.string :user_id
			t.string :context_id
			t.timestamp :event_time
    end
		add_index :canvas_events, :user_id
		add_index :canvas_events, :context_id
		add_index :canvas_events, [:context_id, :event_time]
		add_index :canvas_events, [:context_id, :event_time, :asset_type]
  end
end

=begin
{
    "metadata": {
        "root_account_uuid": "VicYj3cu5BIFpoZhDVU4DZumnlBrWi1grgJEzADs",
        "root_account_id": "21070000000000001",
        "root_account_lti_guid": "7db438071375c02373713c12c73869ff2f470b68.oxana.instructure.com",
        "user_login": "oxana@example.com",
        "user_account_id": "21070000000000001",
        "user_sis_id": "456-T45",
        "user_id": "21070000000000001",
        "time_zone": "America/New_York",
        "context_type": "Group",
        "context_id": "21070000000000144",
        "context_sis_source_id": "2017.100.101.101-1",
        "context_account_id": "21070000000000079",
        "context_role": "GroupMembership",
        "request_id": "1dd9dc6f-2fb0-4c19-a6c5-7ee1bf3ed295",
        "session_id": "ef686f8ed684abf78cbfa1f6a58112b5",
        "hostname": "oxana.instructure.com",
        "http_method": "GET",
        "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36",
        "client_ip": "93.184.216.34",
        "url": "https://oxana.instructure.com/groups/144/conferences",
        "referrer": "https://oxana.instructure.com/groups/144/conferences",
        "producer": "canvas",
        "event_name": "asset_accessed",
        "event_time": "2019-11-01T00:09:07.150Z"
    },
    "body": {
        "asset_name": "MATH 101 Group 1",
        "asset_type": "group",
        "asset_id": "21070000000000144",
        "asset_subtype": "conferences",
        "category": "conferences",
        "role": "GroupMembership",
        "level": null
    }
}
=end
