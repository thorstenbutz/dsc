## Interview with Gael Colas

<img src="gael_4197.jpg"     alt="Gael in Antwerp 2024"     align="right"  width="236" />Gael Colas is a member of the DSC Working Group, a group of  Microsoft employees and Community members that discuss and  influence DSCv3's direction and priorities. As an independent expert, Gael has developed numerous DSC resources and has been advocating for the further development and adaptation of the technology for years as the voice of the DSC community. 

**Question: DSC Version 3: Destined for greatness or madness?**

Only time will tell, but for sure it's a colossal task, right when Puppet and Chef seem to be in decline. I'm convinced there is still is a need for configuration management, but DSC v3 is not an evolution, just a different take on the same problem.

**Question: Technologically, they are making a complete fresh start. They are decoupling DSC from PowerShell and the Windows Management Framework.**

DSCv3 is a complete rewrite, and it's so different from PSDSC that it should  have been named something else. The community did ask for a different  name but was unsuccessful. I guess it was easier to present it as an evolution than introducing a new  "product" attempting to do the same thing again but better.

**Question: A few years ago, I asked Jeffrey Snover about the shortcomings of the technology – specifically, shouldn't DSC resources be provided by the
 relevant product groups?** 

It's the age-old  problem true for PowerShell modules and for DSC resources across the  Microsoft ecosystem. Great products with great features, but sometimes  the management story is an afterthought. It's always been the challenge and it's a well known problem for the PowerShell or WinGet team.

One of the challenge is that the product teams wait for user demand to  acknoledge the need, but there's no demand because there's no official  DSC resources for products, and everyone is used to roll their own  solution.

We must recognise that it's one of the motivation from the PowerShell team to support any language or command in DSCv3. They want other Product  Teams to be able to write the DSC resources for their software in the language of their  choosing, to remove any obstacle.

**Question : You maintain numerous DSC community resources.  What changes can we expect for future community resources?**

We're still discussing how to best support traditional PSDSC resources in DSCv3 while also  supporting the many new features offered in v3. As for changes  expected for community resources, for now we're still experimenting how  to best write a PowerShell resource for DSCv3, but we hope that we can  introduce some authoring tools to help with the transition.



**Question: Things often appear distorted when viewed from within one's own bubble. I always thought that DSC was overly complex and elitist. Will this change with DSCv3?**

I'd argue that it's  not specific to DSC, but more the Configuration Management and  Management as Code space that are niche (in our ecosystem) compared to  the broader domain of PowerShell automation. But if people have put the effort of building this, it's because there was and still  is a need. Some system administrator probably said the same of PowerShell before it became mainstream in their field.

I don't think DSCv3 can change that learning curve because it's a  different mindset compared to imperative scripting, but the biggest  drawback for DSCv3 at the moment is its lack of higher order tool. DSCv3 is just the utility running on a node, there is no orchestration, service, central management or reporting like we had  with PSDSC and the pull server.

**Question: You and other DSC enthusiasts invest a lot of time in the DSC community. Do you think that Microsoft and other manufacturers invest the same level of passion in their technology?**

I think us DSC enthusiasts get into this from a need, or the curiosity of solving problems.

**Question: One final question: will DSCv3 become a significant factor in the Linux world? Perhaps through its ongoing integration into products such as Puppet or Chef?**

Indeed, DSCv3 could be used to effect changes to systems managed by Puppet, Chef or other  solutions, and open the door to more linux nodes using it. But I don't  think that's the primary target. Linux nodes have had a more mature and automated ecosystem for decades, and for now I  don't see a problem that would be solved by adding DSCv3 in the mix.  DSCv3 is still in its early days, but I think in the future it can be  used to manage systems that are configured via an API, such as cloud services, something we're already doing with PSDSC  despite the limitations of the old design.

**Thanks so much for the interview.**



