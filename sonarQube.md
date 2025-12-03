# SONARQUBE <!-- omit in toc -->


> > [](https://www.sonarsource.com/products/sonarcloud/)

- Try free Sonar Cloud

- Sync Github app

- Admin - Analysis_Method - Github actions

Github actions steps: MAIN branch
```yaml
      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  # Needed to get PR information, if any
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

      - name: Check SonarCloud status
        run: |
					echo "SONAR_STATUS=$(curl  --header 'Authorization: Bearer ${{ secrets.SONAR_TOKEN}}' https://sonarcloud.io/api/qualitygates/project_status\?projectKey\=${{ secrets.PROJECT_KEY }} | jq -r '.projectStatus.status')" >> $GITHUB_ENV

				# secrets.PROJECT_KEY= sonar-project.properties (sonar.projectKey)

        # Optional: curl -u
				# echo "SONAR_STATUS=$(curl -s -u ${{ secrets.SONAR_TOKEN }}: 'https://sonarcloud.io/api/qualitygates/project_status?projectKey=<PROJECT>' | jq -r '.projectStatus.status')" >>

      - name: Sonar Status
        run: echo ${{ env.SONAR_STATUS }}

      - name: Stop if SonarCloud test failed
        if: ${{ env.SONAR_STATUS == 'ERROR' }}
        run: exit 1
```

# Force JS Errors
```js
var unusedVariable = 42;

function multiply(a, b) {
  return a * b;
}

multiply(2); // Missing the second argument

try {
  // Some code that may throw an exception
} catch (error) {
  // Empty catch block
}

var regex = /^(a+)+$/;
```
