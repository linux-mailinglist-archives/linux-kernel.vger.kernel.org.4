Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A042A68007F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjA2RmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2RmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:42:14 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97286EB5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:42:12 -0800 (PST)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pMBgx-0001tu-7v; Sun, 29 Jan 2023 18:42:11 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-01-29]
Date:   Sun, 29 Jan 2023 17:42:10 +0000
Message-Id: <167501403214.1314424.14370223374691112185@leemhuis.info>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675014132;35e26bb8;
X-HE-SMSGID: 1pMBgx-0001tu-7v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below you'll find regzbot's report about regression from this
cycle me or someone else told the bot about. Today with an extra from the department of “fixes are ready and in next for a while, but not mainlined”:

* Andrew afaics didn’t sent a revert[1] from Vlastimir your way that the latter ideally would have liked to see in -rc5[2] already [3], as it fixes a regression that bugs people in 6.1 (he just reminded me about it on IRC shortly after I had written this paragraph and expressed that he *really* would like to see it merged for rc6). There was some discussion this week about a proper solution[4], but the consensus afaics was to apply the revert, which spend quite some time in -next by now
[1] https://lore.kernel.org/all/20230113173345.9692-1-vbabka@suse.cz/
[2] https://lore.kernel.org/all/f47f69f9-7378-f18c-399b-b277c753532e@suse.cz/
[3] https://lore.kernel.org/all/8ec65f01-89fe-bd6f-a2c2-f4dfc0555cc2@leemhuis.info/
[4] https://lore.kernel.org/all/20230125134434.18017-1-mgorman@techsingularity.net/

* A fix[1] for a stack_depot/kmemleak issue is in next for a while already too[2]; Boris recently ran into this and bisected it again – this made me wonder if it would be good to get this fixed rather sooner than later before even more people waste time on this.
[1] https://lore.kernel.org/all/1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com/
[2] https://lore.kernel.org/all/20230119224022.80752C433F0@smtp.kernel.org/
[3] https://lore.kernel.org/all/Y9UweHxSfPiAqgZx@zn.tnic/

* a fix for a spi issue[1] is also sitting in next for two weeks now :-( #sigh
[1] https://lore.kernel.org/all/20230116144149.305560-1-brgl@bgdev.pl/

Apart from those it’s mostly business as usual afaics. Will and Waiman are busy debating a scheduler issue, but hopefully at some point will come to some agreement on how to fix it[1]. 

 [1] https://lore.kernel.org/lkml/20230127015527.466367-1-longman@redhat.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 11 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.1.. aka v6.2-rc), culprit identified
======================================================


[ *NEW* ] mm: stack_depot: Failure during Stack Depot allocating hash table
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/53c2d558-c6a1-38e5-5739-28fff023558d@alu.unizg.hr/
https://lore.kernel.org/lkml/53c2d558-c6a1-38e5-5739-28fff023558d@alu.unizg.hr/

By Mirsad Todorovac; 16 days ago; 19 activities, latest 0 days ago.
Introduced in 56a61617dd22 (v6.2-rc1)

Fix incoming:
* mm: use stack_depot_early_init for kmemleak
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=d6e77c306f20863ee9bf323690692d8cd66c822d


Black screen when amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216865/
https://bugzilla.kernel.org/show_bug.cgi?id=216865
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

By Matt Fagnani and Matt Fagnani; 30 days ago; 35 activities, latest 0 days ago.
Introduced in 201007ef707a (v6.2-rc1)

Recent activities from: Baolu Lu (1), Tian, Kevin (1), Bjorn
  Helgaas (1), Linux kernel regression tracking (Thorsten Leemhuis) (1),
  Jason Gunthorpe (1)

Noteworthy links:
* [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled on upstream path"
  https://lore.kernel.org/linux-pci/20230111085745.401710-1-christian.koenig@amd.com/
  18 days ago, by Christian König; thread monitored.
* [PATCH 1/1] PCI: Add translated request only opt-in for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230112084629.737653-1-baolu.lu@linux.intel.com
  17 days ago, by Lu Baolu; thread monitored.
* [PATCH v2 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230113014409.752405-1-baolu.lu@linux.intel.com
  16 days ago, by Lu Baolu; thread monitored.
* [PATCH v3 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230114073420.759989-1-baolu.lu@linux.intel.com
  15 days ago, by Lu Baolu; thread monitored.


[ *NEW* ] sched: incorrectly set affinity masks and performance regression on arm64
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230117160825.GA17756@willie-the-truck/
https://lore.kernel.org/lkml/20230117160825.GA17756@willie-the-truck/

By Will Deacon; 12 days ago; 20 activities, latest 1 days ago.
Introduced in 8f9ea86fdf99 (v6.2-rc1)

Recent activities from: Waiman Long (11), Will Deacon (7), kernel test
  robot (1), Peter Zijlstra (1)

One patch associated with this regression:
* Re: [PATCH v10 2/5] sched: Use user_cpus_ptr for saving user provided cpumask in sched_setaffinity()
  https://lore.kernel.org/lkml/Y9QZxVPLYpH%2FsrMw@hirez.programming.kicks-ass.net/
  1 days ago, by Peter Zijlstra

Noteworthy links:
* [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
  https://lore.kernel.org/lkml/20230121021749.55313-1-longman@redhat.com/
  8 days ago, by Waiman Long; thread monitored.
* [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
  https://lore.kernel.org/lkml/20230127015527.466367-1-longman@redhat.com/
  2 days ago, by Waiman Long; thread monitored.


[ *NEW* ] drm: nouveau: hangs on poweroff/reboot
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com/
https://lore.kernel.org/lkml/b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com/

By Chris Clayton; 10 days ago; 10 activities, latest 1 days ago.
Introduced in 0e44c2170876 (v6.2-rc1)

Recent activities from: Chris Clayton (6), Linux kernel regression
  tracking (Thorsten Leemhuis) (2), Karol Herbst (1), Hans de Goede (1)


GM20B probe fails after commit 2541626cfb79
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20221228144914.z7t7a4fdwvbblnak@wslaptop/
https://lore.kernel.org/dri-devel/20221228144914.z7t7a4fdwvbblnak@wslaptop/

By Diogo Ivo; 32 days ago; 15 activities, latest 2 days ago.
Introduced in 2541626cfb79 (v6.2-rc1)

Recent activities from: Diogo Ivo (4), Nicolas Chauvet (3), Ben
  Skeggs (2), David Airlie (1)


nfs: NULL pointer dereference since NFS_V4_2_READ_PLUS is enabled by default
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/
https://lore.kernel.org/lkml/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/

By Krzysztof Kozlowski; 22 days ago; 14 activities, latest 6 days ago.
Introduced in 7fd461c47 (v6.2-rc1)

Recent activities from: Krzysztof Kozlowski (1), Anna Schumaker (1)


[ *NEW* ] spi: spidev: recursive locking error
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com/
https://lore.kernel.org/lkml/Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com/

By Francesco Dolcini; 13 days ago; 11 activities, latest 11 days ago.
Introduced in a720416d9463 (v6.2-rc4)

Fix incoming:
* spi: spidev: fix a recursive locking error
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=9bab63a3e9498afd6a29cd3a43cf3ad4a4612b85


==================================================
current cycle (v6.1.. aka v6.2-rc), unkown culprit
==================================================


ptdma: kernel panic during host shutdown
----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216856/
https://bugzilla.kernel.org/show_bug.cgi?id=216856
https://lore.kernel.org/lkml/0e77436c-9f0a-15b6-697a-7b879e4abc4a@leemhuis.info/

By Eric Pilmore and Eric Pilmore; 32 days ago; 3 activities, latest 1 days ago.
Introduced in v6.1..v6.2-rc1

Recent activities from: Eric Pilmore (1), The Linux kernel's regression
  tracker (Thorsten Leemhuis) (1)


net: r8169: NETDEV WATCHDOG: enp6s0 (r8169): transmit queue 0 timed out
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216884/
https://bugzilla.kernel.org/show_bug.cgi?id=216884
https://lore.kernel.org/regressions/f5b100c0-cdeb-59d1-5c82-e1df59ee3773@leemhuis.info/

By HougeLangley and HougeLangley; 25 days ago; 11 activities, latest 22 days ago.
Introduced in v6.1..v6.2-rc2

Fix incoming:
* PCI: loongson: Improve the MRRS quirk for LS7A
  https://lore.kernel.org/regressions/2a9140bb-8c4f-dda8-cf43-92db792a29db@leemhuis.info/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167379759525.730024.5229816811013521088@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
