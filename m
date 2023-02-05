Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAEC68B139
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBESio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBESim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:38:42 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8B1C5AB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:38:40 -0800 (PST)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pOjuR-0003Fk-7C; Sun, 05 Feb 2023 19:38:39 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-02-05]
Date:   Sun,  5 Feb 2023 18:38:38 +0000
Message-Id: <167562163001.1743361.7332568307990617200@leemhuis.info>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675622321;5bb48a7d;
X-HE-SMSGID: 1pOjuR-0003Fk-7C
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Below you'll find regzbot's report about regression from this
cycle me or someone else told the bot about. 

Let me highlight three issues you might want to know about:

 * There is a long and ongoing discussion about problems with the NFS
client where there is some disagreement if this qualifies as
regression, as it's a old problem that is more likely to happen now. Not
sure where this heads, a proper fix seems unlikely to emerge quickly. At
least it *currently* looks like this doesn't affect a lot of users.
https://lore.kernel.org/linux-nfs/9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com/

 * The "Black screen when amdgpu started during 6.2-rc1 boot with AMD
IOMMU enabled" issue was stalled, but there is some movement now;
hopefully some agreement will be found there, too. It *currently* looks
like this doesn't affect a lot of users.
https://lore.kernel.org/lkml/20230114073420.759989-1-baolu.lu@linux.intel.com/

 * Waiman and Will are still discussing the "sched: incorrectly set
affinity masks and performance regression on arm64" issue, but I'm
optimistic that the involved parties soon will agree on how to fix this.
https://lore.kernel.org/lkml/20230131221719.3176-1-will@kernel.org/

And one more for the general audience than for Linus, in case anyone has
similar issues: one user reported that Chrome was crashing with the
recent -rc releases, but until now it's the only such report I've seen;
and it's not bisected yet.
https://lore.kernel.org/lkml/CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 12 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.1.. aka v6.2-rc), culprit identified
======================================================


[ *NEW* ] xen/usb(?): External USB disks not recognized anymore under Xen
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/
https://lore.kernel.org/lkml/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/

By Christian Kujau; 6 days ago; 11 activities, latest 0 days ago.
Introduced in 90b926e68f50 (v6.2-rc4)

Recent activities from: Christian Kujau (7), Borislav Petkov (1), Linus
  Torvalds (1), Juergen Gross (1), Greg KH (1)

One patch associated with this regression:
* Re: External USB disks not recognized with v6.1.8 when using Xen
  https://lore.kernel.org/lkml/Y9%2BtDmLAlqg37TS%2B@zn.tnic/
  0 days ago, by Borislav Petkov


[ *NEW* ] nfs: failures during the git regression suite on all NFS versions
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com/
https://lore.kernel.org/linux-nfs/9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com/

By Chuck Lever III; 4 days ago; 25 activities, latest 0 days ago.
Introduced in 85aa8ddc3818 (v6.2-rc1)

Recent activities from: Benjamin Coddington (9), Chuck Lever III (7),
  Trond Myklebust (5), Hugh Dickins (2), Jeff Layton (1), Thorsten
  Leemhuis (1)


Black screen when amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216865/
https://bugzilla.kernel.org/show_bug.cgi?id=216865
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

By Matt Fagnani and Matt Fagnani; 37 days ago; 55 activities, latest 1 days ago.
Introduced in 201007ef707a (v6.2-rc1)

Recent activities from: Jason Gunthorpe (6), Bjorn Helgaas (6), Baolu
  Lu (6), Jonathan Cameron (1), Vasant Hegde (1)

One patch associated with this regression:
* Re: [PATCH v3 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://lore.kernel.org/lkml/b75a5a94-a962-f88e-149e-7d23982a7ad2@linux.intel.com/
  3 days ago, by Baolu Lu

Noteworthy links:
* [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled on upstream path"
  https://lore.kernel.org/linux-pci/20230111085745.401710-1-christian.koenig@amd.com/
  25 days ago, by Christian König; thread monitored.
* [PATCH 1/1] PCI: Add translated request only opt-in for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230112084629.737653-1-baolu.lu@linux.intel.com
  24 days ago, by Lu Baolu; thread monitored.
* [PATCH v2 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230113014409.752405-1-baolu.lu@linux.intel.com
  23 days ago, by Lu Baolu; thread monitored.
* [PATCH v3 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230114073420.759989-1-baolu.lu@linux.intel.com
  22 days ago, by Lu Baolu; thread monitored.


sched: incorrectly set affinity masks and performance regression on arm64
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230117160825.GA17756@willie-the-truck/
https://lore.kernel.org/lkml/20230117160825.GA17756@willie-the-truck/

By Will Deacon; 19 days ago; 48 activities, latest 2 days ago.
Introduced in 8f9ea86fdf99 (v6.2-rc1)

Recent activities from: Waiman Long (15), Peter Zijlstra (6), Will
  Deacon (4), Tejun Heo (2), Hillf Danton (1)

One patch associated with this regression:
* Re: [PATCH v10 2/5] sched: Use user_cpus_ptr for saving user provided cpumask in sched_setaffinity()
  https://lore.kernel.org/lkml/Y9QZxVPLYpH%2FsrMw@hirez.programming.kicks-ass.net/
  8 days ago, by Peter Zijlstra

Noteworthy links:
* [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
  https://lore.kernel.org/lkml/20230121021749.55313-1-longman@redhat.com/
  15 days ago, by Waiman Long; thread monitored.
* [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
  https://lore.kernel.org/lkml/20230127015527.466367-1-longman@redhat.com/
  9 days ago, by Waiman Long; thread monitored.
* [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter offline CPUs
  https://lore.kernel.org/lkml/20230131221719.3176-2-will@kernel.org/
  4 days ago, by Will Deacon; thread monitored.


drm: nouveau: hangs on poweroff/reboot
--------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com/
https://lore.kernel.org/lkml/b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com/

By Chris Clayton; 17 days ago; 16 activities, latest 2 days ago.
Introduced in 0e44c2170876 (v6.2-rc1)

Recent activities from: Chris Clayton (4), Ben Skeggs (2)


[ *NEW* ] meida: venus: firmware: AOSS doesn't seel anymore on at least sc7180 and sc7280
-----------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y9LSMap+jRxbtpC8@google.com/
https://lore.kernel.org/lkml/Y9LSMap%2BjRxbtpC8@google.com/

By Matthias Kaehlcke; 9 days ago; 2 activities, latest 3 days ago.
Introduced in a837e5161cff (v6.2-rc1)

Recent activities from: Matthias Kaehlcke (1)


[ *NEW* ] usb: gadget: USB network interface is recognized, but 'ip link' sees it as 'NO-CARRIER'
-------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net/
https://lore.kernel.org/lkml/f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net/

By Paul Cercueil; 4 days ago; 1 activities, latest 4 days ago.
Introduced in 321b59870f85 (v6.2-rc1)

Recent activities from: Paul Cercueil (1)


spi: spidev: recursive locking error
------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com/
https://lore.kernel.org/lkml/Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com/

By Francesco Dolcini; 20 days ago; 12 activities, latest 6 days ago.
Introduced in a720416d9463 (v6.2-rc4)

Fix incoming:
* spi: spidev: fix a recursive locking error
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=eede42c9459b58b71edc99303dad65216a655810


nfs: NULL pointer dereference since NFS_V4_2_READ_PLUS is enabled by default
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/
https://lore.kernel.org/lkml/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/

By Krzysztof Kozlowski; 29 days ago; 14 activities, latest 13 days ago.
Introduced in 7fd461c47 (v6.2-rc1)


==================================================
current cycle (v6.1.. aka v6.2-rc), unkown culprit
==================================================


net: r8169: NETDEV WATCHDOG: enp6s0 (r8169): transmit queue 0 timed out
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216884/
https://bugzilla.kernel.org/show_bug.cgi?id=216884
https://lore.kernel.org/regressions/f5b100c0-cdeb-59d1-5c82-e1df59ee3773@leemhuis.info/

By HougeLangley and HougeLangley; 32 days ago; 21 activities, latest 2 days ago.
Introduced in v6.1..v6.2-rc2

Fix incoming:
* PCI: loongson: Improve the MRRS quirk for LS7A
  https://lore.kernel.org/regressions/2a9140bb-8c4f-dda8-cf43-92db792a29db@leemhuis.info/


[ *NEW* ] chrome crashes
------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com/
https://lore.kernel.org/lkml/CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com/

By Chris McGimpsey-Jones; 8 days ago; 1 activities, latest 8 days ago.
Introduced in v6.1..v6.2-rc5


ptdma: kernel panic during host shutdown
----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216856/
https://bugzilla.kernel.org/show_bug.cgi?id=216856
https://lore.kernel.org/lkml/0e77436c-9f0a-15b6-697a-7b879e4abc4a@leemhuis.info/

By Eric Pilmore and Eric Pilmore; 39 days ago; 3 activities, latest 9 days ago.
Introduced in v6.1..v6.2-rc1


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167501403214.1314424.14370223374691112185@leemhuis.info

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
