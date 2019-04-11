*** Variables ***

# oauth setting
${OAUTH_USER}               client
${OAUTH_PASSWORD}           secret
${OAUTH_API_URL}            https://xxxx/oauth/token

#  database setting
${DB_DRIVER}                com.mysql.jdbc.Driver
${DB_URL}                   jdbc:mysql://xxxx:3306/xxx?useUnicode=true&characterEncoding=UTF-8
${DB_USER}                  xxx
${DB_PASSWORD}              xxx

# service setting
${BASE_API_URL}   http://localhost:8080