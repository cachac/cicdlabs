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
        # id: sonar_status
        run: |
          sudo apt install jq
          echo "SONAR_STATUS=$(curl -s -u ${{ secrets.SONAR_TOKEN }}: 'https://sonarcloud.io/api/qualitygates/project_status?projectKey=<PROJECT>' | jq -r '.projectStatus.status')" >> $GITHUB_ENV

      - name: Sonar Status
        run: echo ${{ env.SONAR_STATUS }}

      - name: Stop if SonarCloud test failed
        if: ${{ env.SONAR_STATUS }} == 'ERROR'
        run: exit 1
```
