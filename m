Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74F76DC0E4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 19:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDIRlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 13:41:18 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D535B0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:41:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1plZ2Q-000117-OZ; Sun, 09 Apr 2023 19:41:14 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-04-09]
Date:   Sun,  9 Apr 2023 17:41:13 +0000
Message-Id: <168106197596.1411382.4633915108737130144@leemhuis.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681062076;f9ed7509;
X-HE-SMSGID: 1plZ2Q-000117-OZ
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. The list of tracked 6.3 regressions is slowly growing longer
(see below), but there is nothing much to worry about afaics.

There is another fix for a media regression (that due to backports is
present is a few stable trees as well) that looks somewhat stalled, but
I'm not sure if it is ready for merging. If you want to judge yourself,
take a look at this thread:

https://lore.kernel.org/all/4b1bc0d5-808b-816d-d7de-5baa8851e74f@xs4all.nl/

Reports and and earlier fix:
https://bugzilla.redhat.com/show_bug.cgi?id=2180107
https://lore.kernel.org/linux-media/20230327091051.404184-1-hpa@redhat.com/
https://bugzilla.kernel.org/show_bug.cgi?id=217252

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 8 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.2.. aka v6.3-rc), culprit identified
======================================================


arm: vfp: random Warning backtraces in calls from ct_nmi_enter()
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net/
https://lore.kernel.org/lkml/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net/

By Guenter Roeck; 27 days ago; 17 activities, latest 0 days ago.
Introduced in 62b95a7b44d1 (v6.3-rc1)

Fix incoming:
* ARM: vfp: Fix broken softirq handling with instrumentation enabled
  https://lore.kernel.org/lkml/73b7867a-8a1f-d521-d290-77bc7fcb2226@leemhuis.info/


[ *NEW* ] firmware/sysfb: wrong mode and display garbled on 16-year old i686 laptop
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4Psm6B6Lqkz1QXM@panix3.panix.com/
https://lore.kernel.org/dri-devel/4Psm6B6Lqkz1QXM@panix3.panix.com/

By pa@panix.com; 3 days ago; 2 activities, latest 1 days ago.
Introduced in f35cd3fa7729 (v6.3-rc1)

Recent activities from: Pierre Asselin (1), pa@panix.com (1)


[ *NEW* ] sched: PostgreSQL performance regression introduced by mm_cid
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230327080502.GA570847@ziqianlu-desk2/
https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/

By Aaron Lu; 13 days ago; 35 activities, latest 1 days ago.
Introduced in af7f588d8f73 (v6.3-rc1)

Recent activities from: Mathieu Desnoyers (11), Peter Zijlstra (6),
  Aaron Lu (1)

3 patch postings are associated with this regression, the latest is this:
* Re: [RFC PATCH v3] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/3b4684ea-5c0d-376b-19cf-195684ec4e0e@efficios.com/
  1 days ago, by Mathieu Desnoyers

Noteworthy links:
* [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
  https://lore.kernel.org/lkml/20230330230911.228720-1-mathieu.desnoyers@efficios.com/
  9 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230403181342.210896-1-mathieu.desnoyers@efficios.com/
  5 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Fix performance regression introduced by mm_cid (v2)
  https://lore.kernel.org/lkml/20230405121535.3891327-1-mathieu.desnoyers@efficios.com/
  4 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v3] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230405162635.225245-1-mathieu.desnoyers@efficios.com/
  4 days ago, by Mathieu Desnoyers; thread monitored.


[ *NEW* ] net: bgmac: bootrr.deferred-probe-empty test fails in KernelCi on sun8i-h3-libretech-all-h3-cc
--------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230404134613.wtikjp6v63isofoc@rcn-XPS-13-9305/
https://lore.kernel.org/netdev/20230404134613.wtikjp6v63isofoc@rcn-XPS-13-9305/

By Ricardo Cañuelo; 5 days ago; 3 activities, latest 4 days ago.
Introduced in f99e6d7c4ed3 (v6.3-rc2)

Recent activities from: Florian Fainelli (1), Rafał Miłecki (1), Ricardo
  Cañuelo (1)


pci: / net: igb: hangs during boot on PowerEdge R620
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/m2fs9lgndw.fsf@gmail.com/
https://lore.kernel.org/lkml/m2fs9lgndw.fsf@gmail.com/

By Donald Hunter; 9 days ago; 4 activities, latest 6 days ago.
Introduced in 6fffbc7ae137 (v6.3-rc1)

Recent activities from: Bjorn Helgaas (1)


media: Unknown pixelformat 0x00000000
-------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/217252/
https://bugzilla.kernel.org/show_bug.cgi?id=217252
https://lore.kernel.org/lkml/dc8e5276-ef88-648f-9f0d-10151ea62c90@leemhuis.info/

By sander44 and sander44; 13 days ago; 10 activities, latest 9 days ago.
Introduced in 50459f103edf (v6.3-rc1)

Fix incoming:
* media: usb: uvc: fill in description for unknown pixelformats
  https://lore.kernel.org/lkml/1bd64a7f-9bcb-3057-4c51-7144122370fc@leemhuis.info/


net: mlx5: InfiniBand devices were no longer present
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAHC9VhQ7A4+msL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com/
https://lore.kernel.org/netdev/CAHC9VhQ7A4%2BmsL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com/

By Paul Moore; 11 days ago; 3 activities, latest 10 days ago; poked 0 days ago.
Introduced in fe998a3c77b9 (v6.3-rc1)


==================================================
current cycle (v6.2.. aka v6.3-rc), unkown culprit
==================================================


iwlwifi: frequent drops between v6.2-rc3 and v6.3-rc1
-----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com/
https://lore.kernel.org/linux-wireless/9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com/

By Vegard Nossum; 23 days ago; 3 activities, latest 14 days ago.
Introduced in e8f60cd7db24..2eb29d59ddf0 (v6.2-rc3..v6.3-rc1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168045676522.992122.1074253542608037015@leemhuis.info

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
