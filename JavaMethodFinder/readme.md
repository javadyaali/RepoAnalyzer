
**RepoAnalyzer**

Here we want to implemet a task that analyses all the commits in that repository and finds commits that have added a parameter to an existing method. This task includes three main parts, read a Java repository and extracts its classes and methods, analyzing commits that add parameter in methods and check that if commited methods are in existing methods or not and if yes, report them as a csv file.


**How it works?**
1. Allow setup.sh to be executed via command line
```
chmod +x setup.sh

```
2. Run setup.sh with repository URL and name that you like to analyzed
```
./setup.sh <repo URL> <repoName>

```
3. Go to result directory in your downloaded repository
4. Open finalOutput.csv to see result

We use two repositories for testing and its result is in "Test Report" directory:

1. [strman-java](https://github.com/shekhargulati/strman-java)

2. [bootique](https://github.com/bootique/bootique)


*Good luck*
