Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411E74C65B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGIQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGIQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 12:01:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3DE9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 09:01:02 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qIWqL-0007uC-28; Sun, 09 Jul 2023 18:01:01 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-07-09]
Date:   Sun,  9 Jul 2023 16:00:59 +0000
Message-Id: <168891835223.2415011.16827771958379610758@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688918463;59144b44;
X-HE-SMSGID: 1qIWqL-0007uC-28
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus. A quick regression report for mainline ahead of the -rc1 release:

* No progress so far wrt the iwlwifi regression I mentioned on Friday[1]
that I suspect quite a few people will run into. Sounds like someone who
knows that code well with a bit of luck might be able to look into the
issue in the next few days. Larry's quick shot at a patch did not help[2].

[1] https://lore.kernel.org/all/a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info/

[2] https://lore.kernel.org/all/CAAJw_ZvBUpMMC886CDdsLFW6bUG69X78zVfre7gCfu=aTR1xGQ@mail.gmail.com/
https://lore.kernel.org/all/4153ce0aac6dc760a3a9c7204c5c9141b60839a4.camel@intel.com/


* A few fixes for build warnings or errors are available, but haven't
reached you yet afaics (but it's easy to miss something here; maybe some
of those are not needed anymore):

[PATCH] sparc: mark __arch_xchg() as __always_inline
https://lore.kernel.org/lkml/20230628094938.2318171-1-arnd@kernel.org/
Reported here:
https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/

[PATCH] objtool: initialize all of struct elf
https://lore.kernel.org/all/20230629102051.42E8360467@lion.mk-sys.cz/
Reported here:
https://lore.kernel.org/lkml/20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz/

[PATCH] scsi: aacraid: avoid -Warray-bounds warning
https://lore.kernel.org/all/20230703114851.1194510-1-arnd@kernel.org/
(in -next as 2ed218a4fa5)
Reported here:
https://lore.kernel.org/lkml/ZJ2M4yqnOCqqGWH0@debian/

Ciao, Thorsten


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 9 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v6.4.. aka v6.4-post), culprit identified
========================================================


[ *NEW* ] objtool: build failure
--------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz/
https://lore.kernel.org/lkml/20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz/

By Michal Kubecek; 11 days ago; 12 activities, latest 0 days ago.
Introduced in eb0481bbc4ce

Fix incoming:
* objtool: initialize all of struct elf
  https://lore.kernel.org/lkml/fb93d107-c834-1849-2b14-1dd33c4f9955@leemhuis.info/


[ *NEW* ] sh4: Boot stall with qemu emulations
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net/
https://lore.kernel.org/lkml/fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net/

By Guenter Roeck; 3 days ago; 27 activities, latest 0 days ago.
Introduced in a8ac2961148e

Recent activities from: Guenter Roeck (9), John Paul Adrian
  Glaubitz (9), Sergey Shtylyov (5), Geert Uytterhoeven (4)

One patch associated with this regression:
* Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
  https://lore.kernel.org/lkml/cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru/
  0 days ago, by Sergey Shtylyov

Noteworthy links:
* [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL demux
  https://lore.kernel.org/lkml/2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert%2Brenesas@glider.be/
  0 days ago, by Geert Uytterhoeven; thread monitored.


[ *NEW* ] drm/bridge: lt9611: Dragonboard 845c (SDM845) devboard broken when running AOSP
-----------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
https://lore.kernel.org/dri-devel/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/

By Amit Pundir; 4 days ago; 14 activities, latest 0 days ago.
Introduced in 8ddce13ae69

Recent activities from: Marek Vasut (4), Dmitry Baryshkov (3), Neil
  Armstrong (2), Amit Pundir (2), Jagan Teki (2), Abhinav Kumar (1)


[ *NEW* ] blk-mq: NFS workload leaves nfsd threads in D state
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/
https://lore.kernel.org/linux-block/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/

By Chuck Lever III; 0 days ago; 1 activities, latest 0 days ago.
Introduced in 615939a2ae73

Recent activities from: Chuck Lever III (1)


[ *NEW* ] dma-iommu.c:693 __iommu_dma_unmap bug trace due to 22000.c split
--------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217622/
https://bugzilla.kernel.org/show_bug.cgi?id=217622
https://lore.kernel.org/netdev/a5cdc7f8-b340-d372-2971-0d24b01de217@gmail.com/
https://lore.kernel.org/lkml/b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com/

By Niklāvs Koļesņikovs, Niklāvs Koļesņikovs, and Zhang, Rui; 7 days ago; 10 activities, latest 1 days ago.
Introduced in 19898ce9cf8a

Recent activities from: Niklāvs Koļesņikovs (5), The Linux kernel's
  regression tracker (Thorsten Leemhuis) (2), Johnathon Weare (2),
  Thorsten Leemhuis (1)


[ *NEW* ] locking/atomic: build error on sparc64:allmodconfig
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net/
https://lore.kernel.org/lkml/32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net/

By Guenter Roeck; 11 days ago; 9 activities, latest 1 days ago.
Introduced in d12157efc8e0

Recent activities from: Guenter Roeck (3), Mark Rutland (2), Linux
  regression tracking (Thorsten Leemhuis) (1), Andi Shyti (1), Sam
  Ravnborg (1), Arnd Bergmann (1)

Noteworthy links:
* [PATCH] sparc: mark __arch_xchg() as __always_inline
  https://lore.kernel.org/lkml/20230628094938.2318171-1-arnd@kernel.org/
  11 days ago, by Arnd Bergmann; thread monitored.


[ *NEW* ] mainline build failure due to df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
----------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZJ2M4yqnOCqqGWH0@debian/
https://lore.kernel.org/lkml/ZJ2M4yqnOCqqGWH0@debian/

By Sudip Mukherjee (Codethink); 10 days ago; 6 activities, latest 1 days ago.
Introduced in df8fc4e934c1

Fix incoming:
* scsi: aacraid: Avoid -Warray-bounds warning
  https://lore.kernel.org/lkml/7493c624-431c-a67d-3cbd-10f29a8c33dd@leemhuis.info/


[ *NEW* ] Bluetooth: Dragonboard 845c (SDM845) devboard broken
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com/

By Amit Pundir; 2 days ago; 3 activities, latest 2 days ago.
Introduced in 6945795bc81

Recent activities from: Amit Pundir (2), Johan Hovold (1)


[ *NEW* ] net: phylink: mv88e6060 dsa driver broken
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/
https://lore.kernel.org/netdev/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/

By Sergei Antonov; 5 days ago; 1 activities, latest 5 days ago.
Introduced in de5c9bf40c45

Recent activities from: Sergei Antonov (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168770105071.1044236.16811678381872089646@leemhuis.info

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
