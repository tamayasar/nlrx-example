library(nlrx)

Sys.setenv(JAVA_HOME = "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/")

netlogopath <- file.path("/Users/esrayasar/Desktop/NetLogo 6.0.3/")
modelpath <- file.path("/Users/esrayasar/Desktop/NetLogo 6.0.3/models/Sample Models/Social Science/Voting.nlogo")
outpath <- file.path("/Users/esrayasar/Desktop/ciktilar/")

nl <- nl(nlversion = "6.0.3",
         nlpath = netlogopath,
         modelpath = modelpath,
         jvmmem = 1024)

nl@experiment <- experiment(expname="voting",
                            outpath=outpath,
                            repetition=1,
                            tickmetrics="true",
                            idsetup="setup",
                            idgo="go",
                            runtime=50,
                            evalticks=seq(0, 50),
                            metrics=c("count patches with [pcolor = blue]", "count patches with [pcolor = green]"),
                            variables = list(),
                            constants = list(
                              "change-vote-if-tied?" = "false",
                              "award-close-calls-to-loser?" = "false"
                            ))

nl@simdesign <- simdesign_simple(nl=nl,
                              nseeds=3)

eval_variables_constants(nl)
print(nl)

results <- run_nl_all(nl)

setsim(nl, "simoutput") <- results	

write_simoutput(nl)

analyze_nl(nl)
