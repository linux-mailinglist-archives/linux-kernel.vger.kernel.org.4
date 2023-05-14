Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF3701DD6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjENOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjENOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:24:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E941BFE
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 07:24:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pyCe2-0005vl-UA; Sun, 14 May 2023 16:24:19 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-05-14]
Date:   Sun, 14 May 2023 14:24:18 +0000
Message-Id: <168407416011.74685.9039980276616254723@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684074260;5830079a;
X-HE-SMSGID: 1pyCe2-0005vl-UA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Sorry, I'm a bit behind with staying on top wrt to regressions
in recent cycles. But for 6.4 there is nothing much to report afaics.
Yes, there are a few regressions on my radar (see below), but most as of
now are business as usual (except the iwlwifi one, but I'll poke that
tomorrow) and not noteworthy.

One of the exceptions is a slightly urgent s2idle regression for amd
family 19h model 78h cpus[1], but you already have a pull request from
Boris in your inbox with the fixes.

[1] https://lore.kernel.org/lkml/20230427053338.16653-1-mario.limonciello@amd.com/
https://lore.kernel.org/all/MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com/

What I can't see yet though is a pull request from Russell with a fix
from Ard[2] (in next as 2b951b0efbaa) for boot issues[3] that apparently
break a lot of arm32 configs, which among others lead to "tons of
different boot time errors on the syzbot arm32 qemu instance"[4]. That
sounds like someone that might be worth fixing rather sooner than later,
but maybe the patch is already on the way to you and I just missed it.

[2] https://lore.kernel.org/all/20230506161325.223362-1-ardb@kernel.org/
[3] https://lore.kernel.org/lkml/ZFs6DNgzBHNarr6D@euler/
[4] https://lore.kernel.org/lkml/CANp29Y4Q-VWEWeHmZu0f9tLLik1Va8oDF-s8hAeVkBZbX4K0gg@mail.gmail.com/

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 9 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.3.. aka v6.4-rc), culprit identified
======================================================


[ *NEW* ] arm32: tons of different boot time errors
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/ZFs6DNgzBHNarr6D@euler/
https://lore.kernel.org/lkml/ZFs6DNgzBHNarr6D@euler/

By Colin Foster; 4 days ago; 9 activities, latest 0 days ago.
Introduced in c76c6c4ecbec (v6.4-rc1)

Fix incoming:
* ARM: 9297/1: vfp: avoid unbalanced stack on 'success' return path
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=2b951b0efbaa6c805854b60c11f08811054d50cd


[ *NEW* ] regulator: qcom-rpmh: Dragonboard 845c broken due to asynchronous probe
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/

By Amit Pundir; 0 days ago; 2 activities, latest 0 days ago.
Introduced in ad44ac082fd (v6.4-rc1)

Recent activities from: Caleb Connolly (1), Amit Pundir (1)

One patch associated with this regression:
* Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
  https://lore.kernel.org/lkml/552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org/
  0 days ago, by Caleb Connolly


[ *NEW* ] USB gadget regression on v6.4-rc1 and v6.1.28
-------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/
https://lore.kernel.org/stable/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/

By Francesco Dolcini; 2 days ago; 13 activities, latest 1 days ago.
Introduced in 0db213ea8eed (v6.4-rc1)

Recent activities from: Francesco Dolcini (9), Bagas Sanjaya (2), Luca
  Weiss (1), Stephan Gerhold (1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH v1 2/2] Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only when started"
  https://lore.kernel.org/stable/20230512131435.205464-3-francesco@dolcini.it/
  2 days ago, by Francesco Dolcini

Noteworthy links:
* USB gadget regression on v6.4-rc1 and v6.1.28
  https://lore.kernel.org/stable/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/
  2 days ago, by Francesco Dolcini; thread monitored.
* [PATCH v1 0/2] usb: gadget: udc: core: fix hang during configuration
  https://lore.kernel.org/stable/20230512131435.205464-1-francesco@dolcini.it/
  2 days ago, by Francesco Dolcini; thread monitored.


[ *NEW* ] Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net/
https://lore.kernel.org/lkml/7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net/

By Guenter Roeck; 8 days ago; 10 activities, latest 2 days ago.
Introduced in 310e782a99c7 (v6.4-rc1)

Fix incoming:
* hwmon: (k10temp) Add PCI ID for family 19, model 78h
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=7d8accfaa0ab65e4282c8e58950f7d688342cd86


[ *NEW* ] ext4: adv test cases of kvm-xfstests fail
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64/
https://lore.kernel.org/linux-ext4/ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64/

By Eric Whitney; 4 days ago; 2 activities, latest 4 days ago.
Introduced in e360c6ed7274 (v6.4-rc1)

Recent activities from: Jan Kara (1), Eric Whitney (1)


[ *NEW* ] powerpc: boot issues on PASEMI Nemo board
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/301595ad-0edf-2113-b55f-f5b8051ed24c@xenosoft.de/
https://lore.kernel.org/linuxppc-dev/301595ad-0edf-2113-b55f-f5b8051ed24c@xenosoft.de/

By Christian Zigotzky; 12 days ago; 20 activities, latest 5 days ago.
Introduced in e4ab08be5b49 (v6.4-rc1)

Fix incoming:
* powerpc/isa-bridge: Fix ISA mapping when "ranges" is not present
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=79de36042eecb684e0f748d17ba52f365fde0d65


[ *NEW* ] system hang on start-up (irq or mlx5 problem?)
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com/
https://lore.kernel.org/netdev/A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com/

By Chuck Lever III; 11 days ago; 8 activities, latest 7 days ago.
Introduced in bbac70c74183 (v6.4-rc1)

Recent activities from: Eli Cohen (3), Chuck Lever III (3), Jason
  Gunthorpe (1), Leon Romanovsky (1)


[ *NEW* ] iwlwifi broken on 6.4 merge window
--------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com/
https://lore.kernel.org/lkml/CAAJw_ZueYAHQtM%2B%2B4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com/

By Jeff Chua; 15 days ago; 7 activities, latest 13 days ago.
Introduced in 1ae78a14516b (v6.4-rc1)

Fix incoming:
* wifi: iwlwifi: mvm: rfi: disable RFI feature
  https://lore.kernel.org/lkml/b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168226876591.2194644.7877001821155596037@leemhuis.info

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
