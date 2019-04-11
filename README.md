# Api Autotest Example
Provide some cases that coding with keywords defined in api-autotest-keyword project.

## Getting Started
### Add keywords dependency
Edit `pom.xml`, add the dependency:
```xml
<dependency>
	<groupId>com.github.lilyhu2014</groupId>
	<artifactId>api-autotest-keyword</artifactId>
	<version>${keyword.version}</version>
</dependency>
```
### Database Keywords
We also provide some keywords that can interact with MySql DB.
- Connect To Database   ${dbName}   ${dbDriver}  ${url}    ${dbUser}    ${dbPassword}
- Disconnect From Database   ${dbName}
- Set Sql Resource   ${sqlFilePath}
- Get DB Values  ${sqlStatementKey}
- Get DB Value  ${sqlStatementKey}.${queryField}

## Run cases in Example
Download or clone example codes [api-autotest-example](https://github.com/lilyhu2014/api-autotest-example).
Open up `api-autotest-example` workspace directory.

### Start api service
- navigate to `api-autotest-example` root directory
- run command`java -jar service/api-autotest-example-service-0.0.1-SNAPSHOT.jar` to start api service
- if service started, run command `curl http://localhost:8080/greeting`, we will see result `{"content":"Hello, World!"}`

### run cases
- navigate to `api-autotest-example` root directory
- run command `mvn package robotframework:run`
