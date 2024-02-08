module UpuS10Generator
	class Base
		attr_accessor :service_indicator, :sequence, :country_code

		def initialize(service_indicator, sequence, country_code)
			@service_indicator = service_indicator
			@sequence = sequence
			@country_code = country_code
		end

		def generate
			validate_params
		    check_digit = generate_check_digit
    		serial_number = @sequence + check_digit

    		return @service_indicator + serial_number + @country_code
    	end

    	def generate_check_digit
		    weighting = [8,6,4,2,3,5,9,7]

		    total = 0
		    @sequence.chars.to_a.zip(weighting).each do |(a,b)|
		      total += a.to_i * b.to_i
		    end

		    remainder = total % 11
		    check = case remainder
		    when 1
		      0
		    when 0
		      5
		    else
		      11 - remainder
		    end

		    return check.to_s
		end

		def validate_params
			validate_service_indicator
			validate_sequence
			validate_country_code
		end

		def validate_service_indicator
			if @service_indicator.length != 2
				raise Exception.new "Service Indicator length should be 2"
			end
		end

		def validate_sequence
			if @sequence.length != 12
				raise Exception.new "Sequence length should be 12"
			end
		end

		def validate_country_code
			if @country_code.length != 2
				raise Exception.new "Country code length should be 2"
			elsif not ISOCountries.key?(@country_code)
				raise Exception.new "Country code does not exist"
			end
		end

		SICodes = [
		  {['AV','AZ'],'domestic, bilateral, multilateral use only, identifing RFID-tracked e-commerce items'},
		  {['BA','BZ'],'domestic, bilateral, multilateral use only'},
		  {['CA','CZ'],'Parcel post; the use of CZ requires bilateral agreement. It is not required to use CV for insured parcels but if the service indicator CV is used, then it is recommended that it be used only on insured parcels.'},
		  {['DA','DZ'],'for domestic, bilateral, multilateral use only'},
		  {['EA','EZ'],'EMS; the use of EX-EZ requires bilateral agreement'},
		  {['GA','GA'],'for domestic, bilateral, multilateral use only'},
		  {['GD','GD'],'for domestic, bilateral, multilateral use only'},
		  {['HA','HZ'],'e-commerce parcels; the use of HX-HY requires multilateral agreement; the use of HZ requires bilateral agreement'},
		  {['JA','JZ'],'reserved; cannot be assigned as valid service indicator values'},
		  {['KA','KZ'],'reserved; cannot be assigned as valid service indicator values'},
		  {['LA','LZ'],'Letter post express; the use of LZ requires bilateral agreement'},
		  {['MA','MZ'],'Letter post: M bags'},
		  {['NA','NZ'],'for domestic, bilateral, multilateral use only'},
		  {['PA','PZ'],'for domestic, bilateral, multilateral use only'},
		  {['QA','QM'],'Letter post: IBRS (International Business Reply Service)'},
		  {['RA','RZ'],'Letter post: registered, but not insured delivery. The use of RZ requires bilateral agreement.'},
		  {['SA','SZ'],'reserved; cannot be assigned as valid service indicator values'},
		  {['TA','TZ'],'reserved; cannot be assigned as valid service indicator values'},
		  {['UA','UZ'],'Letter post: items other than LA-LZ (Express), MA-MZ (M bags), QA-QM (IBRS), RA-RZ (registered), VA-VZ (insured), subject to customs control, i.e. bearing a CN 22 or CN 23'},
		  {['VA','VZ'],'Letter post insured; the use of VZ requires bilateral agreement'},
		  {['WA','WZ'],'reserved; cannot be assigned as valid service indicator values'},
		  {['ZA','ZZ'],'domestic, bilateral, multilateral use only'}
		];

		ISOCountries = {
		  'AF' => 'Afghanistan',
		  'AX' => 'Aland Islands',
		  'AL' => 'Albania',
		  'DZ' => 'Algeria',
		  'AS' => 'American Samoa',
		  'AD' => 'Andorra',
		  'AO' => 'Angola',
		  'AI' => 'Anguilla',
		  'AQ' => 'Antarctica',
		  'AG' => 'Antigua And Barbuda',
		  'AR' => 'Argentina',
		  'AM' => 'Armenia',
		  'AW' => 'Aruba',
		  'AU' => 'Australia',
		  'AT' => 'Austria',
		  'AZ' => 'Azerbaijan',
		  'BS' => 'Bahamas',
		  'BH' => 'Bahrain',
		  'BD' => 'Bangladesh',
		  'BB' => 'Barbados',
		  'BY' => 'Belarus',
		  'BE' => 'Belgium',
		  'BZ' => 'Belize',
		  'BJ' => 'Benin',
		  'BM' => 'Bermuda',
		  'BT' => 'Bhutan',
		  'BO' => 'Bolivia',
		  'BA' => 'Bosnia And Herzegovina',
		  'BW' => 'Botswana',
		  'BV' => 'Bouvet Island',
		  'BR' => 'Brazil',
		  'IO' => 'British Indian Ocean Territory',
		  'BN' => 'Brunei Darussalam',
		  'BG' => 'Bulgaria',
		  'BF' => 'Burkina Faso',
		  'BI' => 'Burundi',
		  'KH' => 'Cambodia',
		  'CM' => 'Cameroon',
		  'CA' => 'Canada',
		  'CV' => 'Cape Verde',
		  'KY' => 'Cayman Islands',
		  'CF' => 'Central African Republic',
		  'TD' => 'Chad',
		  'CL' => 'Chile',
		  'CN' => 'China',
		  'CX' => 'Christmas Island',
		  'CC' => 'Cocos (Keeling) Islands',
		  'CO' => 'Colombia',
		  'KM' => 'Comoros',
		  'CG' => 'Congo',
		  'CD' => 'Congo, Democratic Republic',
		  'CK' => 'Cook Islands',
		  'CR' => 'Costa Rica',
		  'CI' => 'Cote D\'Ivoire',
		  'HR' => 'Croatia',
		  'CU' => 'Cuba',
		  'CY' => 'Cyprus',
		  'CZ' => 'Czech Republic',
		  'DK' => 'Denmark',
		  'DJ' => 'Djibouti',
		  'DM' => 'Dominica',
		  'DO' => 'Dominican Republic',
		  'EC' => 'Ecuador',
		  'EG' => 'Egypt',
		  'SV' => 'El Salvador',
		  'GQ' => 'Equatorial Guinea',
		  'ER' => 'Eritrea',
		  'EE' => 'Estonia',
		  'ET' => 'Ethiopia',
		  'FK' => 'Falkland Islands (Malvinas)',
		  'FO' => 'Faroe Islands',
		  'FJ' => 'Fiji',
		  'FI' => 'Finland',
		  'FR' => 'France',
		  'GF' => 'French Guiana',
		  'PF' => 'French Polynesia',
		  'TF' => 'French Southern Territories',
		  'GA' => 'Gabon',
		  'GM' => 'Gambia',
		  'GE' => 'Georgia',
		  'DE' => 'Germany',
		  'GH' => 'Ghana',
		  'GI' => 'Gibraltar',
		  'GR' => 'Greece',
		  'GL' => 'Greenland',
		  'GD' => 'Grenada',
		  'GP' => 'Guadeloupe',
		  'GU' => 'Guam',
		  'GT' => 'Guatemala',
		  'GG' => 'Guernsey',
		  'GN' => 'Guinea',
		  'GW' => 'Guinea-Bissau',
		  'GY' => 'Guyana',
		  'HT' => 'Haiti',
		  'HM' => 'Heard Island & Mcdonald Islands',
		  'VA' => 'Holy See (Vatican City State)',
		  'HN' => 'Honduras',
		  'HK' => 'Hong Kong',
		  'HU' => 'Hungary',
		  'IS' => 'Iceland',
		  'IN' => 'India',
		  'ID' => 'Indonesia',
		  'IR' => 'Iran, Islamic Republic Of',
		  'IQ' => 'Iraq',
		  'IE' => 'Ireland',
		  'IM' => 'Isle Of Man',
		  'IL' => 'Israel',
		  'IT' => 'Italy',
		  'JM' => 'Jamaica',
		  'JP' => 'Japan',
		  'JE' => 'Jersey',
		  'JO' => 'Jordan',
		  'KZ' => 'Kazakhstan',
		  'KE' => 'Kenya',
		  'KI' => 'Kiribati',
		  'KR' => 'Korea',
		  'KW' => 'Kuwait',
		  'KG' => 'Kyrgyzstan',
		  'LA' => 'Lao People\'s Democratic Republic',
		  'LV' => 'Latvia',
		  'LB' => 'Lebanon',
		  'LS' => 'Lesotho',
		  'LR' => 'Liberia',
		  'LY' => 'Libyan Arab Jamahiriya',
		  'LI' => 'Liechtenstein',
		  'LT' => 'Lithuania',
		  'LU' => 'Luxembourg',
		  'MO' => 'Macao',
		  'MK' => 'Macedonia',
		  'MG' => 'Madagascar',
		  'MW' => 'Malawi',
		  'MY' => 'Malaysia',
		  'MV' => 'Maldives',
		  'ML' => 'Mali',
		  'MT' => 'Malta',
		  'MH' => 'Marshall Islands',
		  'MQ' => 'Martinique',
		  'MR' => 'Mauritania',
		  'MU' => 'Mauritius',
		  'YT' => 'Mayotte',
		  'MX' => 'Mexico',
		  'FM' => 'Micronesia, Federated States Of',
		  'MD' => 'Moldova',
		  'MC' => 'Monaco',
		  'MN' => 'Mongolia',
		  'ME' => 'Montenegro',
		  'MS' => 'Montserrat',
		  'MA' => 'Morocco',
		  'MZ' => 'Mozambique',
		  'MM' => 'Myanmar',
		  'NA' => 'Namibia',
		  'NR' => 'Nauru',
		  'NP' => 'Nepal',
		  'NL' => 'Netherlands',
		  'AN' => 'Netherlands Antilles',
		  'NC' => 'New Caledonia',
		  'NZ' => 'New Zealand',
		  'NI' => 'Nicaragua',
		  'NE' => 'Niger',
		  'NG' => 'Nigeria',
		  'NU' => 'Niue',
		  'NF' => 'Norfolk Island',
		  'MP' => 'Northern Mariana Islands',
		  'NO' => 'Norway',
		  'OM' => 'Oman',
		  'PK' => 'Pakistan',
		  'PW' => 'Palau',
		  'PS' => 'Palestinian Territory, Occupied',
		  'PA' => 'Panama',
		  'PG' => 'Papua New Guinea',
		  'PY' => 'Paraguay',
		  'PE' => 'Peru',
		  'PH' => 'Philippines',
		  'PN' => 'Pitcairn',
		  'PL' => 'Poland',
		  'PT' => 'Portugal',
		  'PR' => 'Puerto Rico',
		  'QA' => 'Qatar',
		  'RE' => 'Reunion',
		  'RO' => 'Romania',
		  'RU' => 'Russian Federation',
		  'RW' => 'Rwanda',
		  'BL' => 'Saint Barthelemy',
		  'SH' => 'Saint Helena',
		  'KN' => 'Saint Kitts And Nevis',
		  'LC' => 'Saint Lucia',
		  'MF' => 'Saint Martin',
		  'PM' => 'Saint Pierre And Miquelon',
		  'VC' => 'Saint Vincent And Grenadines',
		  'WS' => 'Samoa',
		  'SM' => 'San Marino',
		  'ST' => 'Sao Tome And Principe',
		  'SA' => 'Saudi Arabia',
		  'SN' => 'Senegal',
		  'RS' => 'Serbia',
		  'SC' => 'Seychelles',
		  'SL' => 'Sierra Leone',
		  'SG' => 'Singapore',
		  'SK' => 'Slovakia',
		  'SI' => 'Slovenia',
		  'SB' => 'Solomon Islands',
		  'SO' => 'Somalia',
		  'ZA' => 'South Africa',
		  'GS' => 'South Georgia And Sandwich Isl.',
		  'ES' => 'Spain',
		  'LK' => 'Sri Lanka',
		  'SD' => 'Sudan',
		  'SR' => 'Suriname',
		  'SJ' => 'Svalbard And Jan Mayen',
		  'SZ' => 'Swaziland',
		  'SE' => 'Sweden',
		  'CH' => 'Switzerland',
		  'SY' => 'Syrian Arab Republic',
		  'TW' => 'Taiwan',
		  'TJ' => 'Tajikistan',
		  'TZ' => 'Tanzania',
		  'TH' => 'Thailand',
		  'TL' => 'Timor-Leste',
		  'TG' => 'Togo',
		  'TK' => 'Tokelau',
		  'TO' => 'Tonga',
		  'TT' => 'Trinidad And Tobago',
		  'TN' => 'Tunisia',
		  'TR' => 'Turkey',
		  'TM' => 'Turkmenistan',
		  'TC' => 'Turks And Caicos Islands',
		  'TV' => 'Tuvalu',
		  'UG' => 'Uganda',
		  'UA' => 'Ukraine',
		  'AE' => 'United Arab Emirates',
		  'GB' => 'United Kingdom',
		  'US' => 'United States',
		  'UM' => 'United States Outlying Islands',
		  'UY' => 'Uruguay',
		  'UZ' => 'Uzbekistan',
		  'VU' => 'Vanuatu',
		  'VE' => 'Venezuela',
		  'VN' => 'Viet Nam',
		  'VG' => 'Virgin Islands, British',
		  'VI' => 'Virgin Islands, U.S.',
		  'WF' => 'Wallis And Futuna',
		  'EH' => 'Western Sahara',
		  'YE' => 'Yemen',
		  'ZM' => 'Zambia',
		  'ZW' => 'Zimbabwe'
		}

	end
end