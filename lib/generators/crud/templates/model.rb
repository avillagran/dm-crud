class <%= class_name %><%= "< #{options[:parent].classify}" if options[:parent] %>
<% unless options[:parent] -%>
    include DataMapper::Resource
    include DataMapper::Timestamp
    #include DataMapper::Historylog

    property :id, Serial
<% end %>
<% attributes.each do |attribute| -%>
    property :<%= attribute.name -%>, <%= typeclass(attribute) %>
<% end %>
    timestamps :at
    property :deleted_at, ParanoidDateTime

end