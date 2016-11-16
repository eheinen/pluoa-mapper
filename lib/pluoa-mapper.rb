module PluoaMapper
    def get_mapping(page, field_name)
        path = ENV['PAGES_MAPPING_PATH']
        raise "You need include your path in your env.rb using ENV['PAGES_MAPPING_PATH']" if path.nil?
        page_mapped = YAML.load_file(path + format_page_to_file(page) + '.yml')
        field_mapped = page_mapped[field_name]
        raise "The field name #{field_name} was not mapped in #{page}" if field_name.nil?
        return field_mapped
    rescue
        puts "There is no page called #{page} in path #{path} "
    end

    private

    def format_page_to_file(page)
        unless page.nil?
            page = page.class == String ? page : page.class.to_s
            names = page.to_s.scan(/([A-Z][a-z]+)/)
            file_name = ''
            names.each_with_index do |_name, _index|
                file_name += _index > 0 ? '_' + _name[0] : _name[0]
            end
            file_name.downcase
        end
    end
end
