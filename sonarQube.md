# SONARQUBE <!-- omit in toc -->


https://www.sonarsource.com/products/sonarcloud/

Try free Sonar Cloud

Sync Github app

Admin - Analysis_Method - Github actions

Github actions steps
```yaml
      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  # Needed to get PR information, if any
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

      - name: Check SonarCloud status
        run: |
          sudo apt install jq
          echo "SONAR_STATUS=$(curl -s -u ${{ secrets.SONAR_TOKEN }}: 'https://sonarcloud.io/api/qualitygates/project_status?projectKey=<PROJECT>' | jq -r '.projectStatus.status')" >>
					$GITHUB_ENV

					# --header 'Authorization: Bearer 2c7be4574e7cc53a90e5e2ae2c820727334dce5a'

      - name: Sonar Status
        run: echo ${{ env.SONAR_STATUS }}

      - name: Stop if SonarCloud test failed
        if: ${{ env.SONAR_STATUS }} == 'ERROR'
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
