Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5637466B236
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjAOPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAOPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:52:53 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75DF75F
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:52:51 -0800 (PST)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pH5JS-0004vM-33; Sun, 15 Jan 2023 16:52:50 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-01-15]
Date:   Sun, 15 Jan 2023 15:52:49 +0000
Message-Id: <167379759525.730024.5229816811013521088@leemhuis.info>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673797971;7d18089a;
X-HE-SMSGID: 1pH5JS-0004vM-33
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below you'll find regzbot's report about regression from this
cycle me or someone else told the bot about. Things are slowly becoming
normal again, but we're not there yet, as some fixes are only in -next
because reviews were late; but I guess next week it will look better again.

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 13 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.1.. aka v6.2-rc), culprit identified
======================================================


[ *NEW* ] pci: sriov_numvfs missing after removal of EfiMemoryMappedIO from E820 map (possible duplicate)
---------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAPH51bc1ZoP2ukJJh8nfrNY1FCp1nk7AP0jGGCvoskq2XbmAoA@mail.gmail.com/
https://lore.kernel.org/linux-pci/CAPH51bc1ZoP2ukJJh8nfrNY1FCp1nk7AP0jGGCvoskq2XbmAoA@mail.gmail.com/

By Peifeng Qiu; 0 days ago; 1 activities, latest 0 days ago.
Introduced in 07eab0901ed (v6.2-rc1)

Recent activities from: Peifeng Qiu (1)


[ *NEW* ] GM20B probe fails after commit 2541626cfb79
-----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20221228144914.z7t7a4fdwvbblnak@wslaptop/
https://lore.kernel.org/dri-devel/20221228144914.z7t7a4fdwvbblnak@wslaptop/

By Diogo Ivo; 18 days ago; 5 activities, latest 0 days ago.
Introduced in 2541626cfb79 (v6.2-rc1)

Recent activities from: Diogo Ivo (3), Karol Herbst (2)


[ *NEW* ] v6.2-rc1 on Turris Omnia: DSA switch ports stuck in NO-CARRIER state
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f24474e70c1a4e9692bd596ef6d97ceda9511245.camel@gmail.com/
https://lore.kernel.org/linux-arm-kernel/f24474e70c1a4e9692bd596ef6d97ceda9511245.camel@gmail.com/

By Klaus Kudielka; 17 days ago; 13 activities, latest 0 days ago.
Introduced in c4de4667f15d (v6.2-rc1)

Fix incoming:
* Revert "ARM: dts: armada-38x: Fix compatible string for gpios"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=75b58cf5ce21650c1b3b88d8310f3415ce905018


[ *NEW* ] Black screen when amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216865/
https://bugzilla.kernel.org/show_bug.cgi?id=216865
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

By Matt Fagnani and Matt Fagnani; 16 days ago; 30 activities, latest 1 days ago.
Introduced in 201007ef707a (v6.2-rc1)

Recent activities from: Baolu Lu (7), Jason Gunthorpe (7), Christian
  König (6), Matt Fagnani (5), Lu Baolu (3), Tian, Kevin (1), Bjorn
  Helgaas (1)

Noteworthy links:
* [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled on upstream path"
  https://lore.kernel.org/linux-pci/20230111085745.401710-1-christian.koenig@amd.com/
  4 days ago, by Christian König; thread monitored.
* [PATCH 1/1] PCI: Add translated request only opt-in for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230112084629.737653-1-baolu.lu@linux.intel.com
  3 days ago, by Lu Baolu; thread monitored.
* [PATCH v2 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230113014409.752405-1-baolu.lu@linux.intel.com
  2 days ago, by Lu Baolu; thread monitored.
* [PATCH v3 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230114073420.759989-1-baolu.lu@linux.intel.com
  1 days ago, by Lu Baolu; thread monitored.


wifi: mt76: wifi stopped working
--------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre%2BXJS_s5FgVteYA@mail.gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=216829

By Mikhail Gavrilov and Mike Lothian; 25 days ago; 16 activities, latest 2 days ago.
Introduced in cd372b8c99c5 (v6.2-rc1)

Recent activities from: Linux kernel regression tracking (Thorsten
  Leemhuis) (2), Thorsten Leemhuis (2), Kalle Valo (1), Mikhail
  Gavrilov (1), Felix Fietkau (1)

4 patch postings are associated with this regression, the latest is this:
* Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
  https://lore.kernel.org/lkml/3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name/
  24 days ago, by Felix Fietkau


[ *NEW* ] net: wifi: most packets are dropped instead of transmitted
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org/
https://lore.kernel.org/lkml/19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org/

By Bryan O'Donoghue; 5 days ago; 9 activities, latest 2 days ago.
Introduced in a790cc3a4fad (v6.2-rc1)

Fix incoming:
* wifi: mac80211: Proper mark iTXQs for resumption
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=4444bc2116aecdcde87dce80373540adc8bd478b


[ *NEW* ] net: wifi: brcmfmac stopped working as firmware is not loaded anymore
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216894/
https://bugzilla.kernel.org/show_bug.cgi?id=216894
https://lore.kernel.org/lkml/ef8861dc-33df-0e35-4205-c8c666a3f4ba@leemhuis.info/

By Christian Marillat and Christian Marillat; 9 days ago; 16 activities, latest 3 days ago.
Introduced in 2aca4f3734bd (v6.2-rc1)

Recent activities from: Arend van Spriel (7), Christian Marillat (6),
  Artem S. Tashkinov (2), Kalle Valo (1)

One patch associated with this regression:
* bugzilla.kernel.org bug 216894: new comment(#7)
  https://bugzilla.kernel.org/show_bug.cgi?id=216894#c7
  6 days ago, by Arend van Spriel

Noteworthy links:
* [PATCH for-6.2] wifi: brcmfmac: fix regression for Broadcom PCIe wifi devices
  https://lore.kernel.org/linux-wireless/20230109095020.412475-1-arend.vanspriel@broadcom.com/
  6 days ago, by Arend van Spriel; thread monitored.
* [PATCH V2] wifi: brcmfmac: fix regression for Broadcom PCIe wifi devices
  https://bugzilla.kernel.org/show_bug.cgi?id=20230111112419.24185-1-arend.vanspriel@broadcom.com
  4 days ago, by Arend van Spriel; thread monitored.


[ *NEW* ] net: wifi: WLAN broken on Nokia N900
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y6tTLPvsxh/Im4Ed@tp440p.steeds.sam/
https://lore.kernel.org/linux-wireless/Y6tTLPvsxh%2FIm4Ed@tp440p.steeds.sam/

By Sicelo; 18 days ago; 9 activities, latest 3 days ago.
Introduced in a790cc3a4fad (v6.2-rc1)

Fix incoming:
* wifi: mac80211: Proper mark iTXQs for resumption
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=4444bc2116aecdcde87dce80373540adc8bd478b


[ *NEW* ] nvme: resume broken on apple nvme controller
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230110174745.GA3576@jannau.net/
https://lore.kernel.org/linux-nvme/20230110174745.GA3576@jannau.net/

By Janne Grunau; 4 days ago; 11 activities, latest 4 days ago.
Introduced in c76b8308e4c9 (v6.2-rc1)

Recent activities from: Hector Martin (6), Christoph Hellwig (4), Janne
  Grunau (1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH 2/2] nvme: Handle shut down controllers during initialization
  https://lore.kernel.org/lkml/20230111043614.27087-3-marcan@marcan.st/
  4 days ago, by Hector Martin

Noteworthy links:
* [PATCH 0/2] nvme-apple: Fix suspend-resume regression
  https://lore.kernel.org/lkml/20230111043614.27087-1-marcan@marcan.st/
  4 days ago, by Hector Martin; thread monitored.


[ *NEW* ] nfs: NULL pointer dereference since NFS_V4_2_READ_PLUS is enabled by default
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/
https://lore.kernel.org/lkml/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/

By Krzysztof Kozlowski; 7 days ago; 12 activities, latest 5 days ago.
Introduced in 7fd461c47 (v6.2-rc1)

Recent activities from: Chuck Lever III (4), Krzysztof Kozlowski (4),
  Trond Myklebust (3), Anna Schumaker (1)


[ *NEW* ] ext4/acls: xfstests.generic.454 suddenly fails for the kernel test robot
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/202212291509.704a11c9-oliver.sang@intel.com/
https://lore.kernel.org/lkml/202212291509.704a11c9-oliver.sang@intel.com/

By kernel test robot; 17 days ago; 5 activities, latest 13 days ago.
Introduced in 3bc753c06dd0 (v6.2-rc1)

Recent activities from: Thorsten Leemhuis (1), Christian Brauner (1),
  Jason A. Donenfeld (1), Linus Torvalds (1), kernel test robot (1)


==================================================
current cycle (v6.1.. aka v6.2-rc), unkown culprit
==================================================


[ *NEW* ] net: r8169: NETDEV WATCHDOG: enp6s0 (r8169): transmit queue 0 timed out
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216884/
https://bugzilla.kernel.org/show_bug.cgi?id=216884
https://lore.kernel.org/regressions/f5b100c0-cdeb-59d1-5c82-e1df59ee3773@leemhuis.info/

By HougeLangley and HougeLangley; 10 days ago; 11 activities, latest 8 days ago.
Introduced in v6.1..v6.2-rc2

Fix incoming:
* PCI: loongson: Improve the MRRS quirk for LS7A
  https://lore.kernel.org/regressions/2a9140bb-8c4f-dda8-cf43-92db792a29db@leemhuis.info/


[ *NEW* ] ptdma: kernel panic during host shutdown
--------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216856/
https://bugzilla.kernel.org/show_bug.cgi?id=216856
https://lore.kernel.org/lkml/0e77436c-9f0a-15b6-697a-7b879e4abc4a@leemhuis.info/

By Eric Pilmore and Eric Pilmore; 18 days ago; 1 activities, latest 18 days ago.
Introduced in v6.1..v6.2-rc1

Recent activities from: Eric Pilmore (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167179914593.1360994.17503278527422432544@leemhuis.info

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
