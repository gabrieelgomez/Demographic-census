Mime::Type.register_alias 'text/excel', :xls

# Array of Hashes support
# [{ name: 'ruby', version: '2.1.0' }, { name: 'rails', version: '4.1.0' }].to_xls

# ActiveRecords to save as .xls
# if Habitant.table_exists?
#   @habitants = Habitant.all
#   @habitants.to_xls(
#     only: %i[identification full_name phone email address],
#     except: [:id],
#     header: false,
#     prepend: [['Col 0, Row 0', 'Col 1, Row 0'], ['Col 0, Row 1']],
#     column_width: [17, 15, 15, 40, 25, 37]
#   )
#   @habitants.to_xls do |column, value|
#     column == :salutation ? t(value) : value
#   end
# end
