Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096166EC138
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDWQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDWQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 12:53:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEB395
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 09:53:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pqcy1-00033n-QS; Sun, 23 Apr 2023 18:53:37 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-04-23]
Date:   Sun, 23 Apr 2023 16:53:37 +0000
Message-Id: <168226876591.2194644.7877001821155596037@leemhuis.info>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682268820;10bf312b;
X-HE-SMSGID: 1pqcy1-00033n-QS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Just for completeness: nothing much to report.

There are still two regressions from the 6.3 cycle that I and regzbot
are aware of and worth mentioning.

One is a performance regression with PostgreSQL that Mathieu after some
back and forth was able to fix. But the fix afaics is nothing for 6.3,
as it's big and wasn't even yet in next, as it only landed in tip
sched/core on Saturday:
https://lore.kernel.org/lkml/168214940343.404.10896712987516429042.tip-bot2@tip-bot2/

The other is a "fairly obscure bug" with VESA format selection occurring
on some x86 system with legacy BIOSes:
https://lore.kernel.org/lkml/40075ac685423d46663dd6a4038add90.squirrel@mail.panix.com/

HTH, Ciao, Thorsten

P.S.: BTW, thx for reverting the 6.2 change that causes the wake-on-lan
and directly picking up Toke's ath9k fix directly; also thx for the
messages you send to the list in those cases, they will be a handy
reference I can pull up in my future efforts trying to convince
developers to "do the right thing"(tm).


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 2 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.2.. aka v6.3-rc), culprit identified
======================================================


sched: PostgreSQL performance regression introduced by mm_cid
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230327080502.GA570847@ziqianlu-desk2/
https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/

By Aaron Lu; 27 days ago; 100 activities, latest 1 days ago.
Introduced in af7f588d8f73 (v6.3-rc1)

Recent activities from: Mathieu Desnoyers (14), Aaron Lu (10), tip-bot2
  for Mathieu Desnoyers (1)

9 patch postings are associated with this regression, the latest is this:
* Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230420143910.GB154815@ziqianlu-desk2/
  3 days ago, by Aaron Lu

Noteworthy links:
* [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
  https://lore.kernel.org/lkml/20230330230911.228720-1-mathieu.desnoyers@efficios.com/
  23 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230403181342.210896-1-mathieu.desnoyers@efficios.com/
  19 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Fix performance regression introduced by mm_cid (v2)
  https://lore.kernel.org/lkml/20230405121535.3891327-1-mathieu.desnoyers@efficios.com/
  18 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v3] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230405162635.225245-1-mathieu.desnoyers@efficios.com/
  18 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v4] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230410150150.2179062-1-mathieu.desnoyers@efficios.com/
  13 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Rate limit migrations
  https://lore.kernel.org/lkml/20230411214116.361016-1-mathieu.desnoyers@efficios.com/
  11 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v5] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230413140248.230479-1-mathieu.desnoyers@efficios.com/
  10 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v6] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230413223356.17195-1-mathieu.desnoyers@efficios.com/
  9 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v7] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230416223217.191261-1-mathieu.desnoyers@efficios.com/
  6 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v8] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230417150831.264780-1-mathieu.desnoyers@efficios.com/
  6 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v9 2/2] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230419155012.63901-2-mathieu.desnoyers@efficios.com/
  4 days ago, by Mathieu Desnoyers; thread monitored.
* [PATCH v10] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230420145548.232747-1-mathieu.desnoyers@efficios.com/
  3 days ago, by Mathieu Desnoyers; thread monitored.
* [tip: sched/core] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/168214940343.404.10896712987516429042.tip-bot2@tip-bot2/
  1 days ago, by tip-bot2 for Mathieu Desnoyers; thread monitored.


firmware/sysfb: wrong mode and display garbled on 16-year old i686 laptop
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4Psm6B6Lqkz1QXM@panix3.panix.com/
https://lore.kernel.org/dri-devel/4Psm6B6Lqkz1QXM@panix3.panix.com/

By pa@panix.com; 17 days ago; 43 activities, latest 2 days ago.
Introduced in f35cd3fa7729 (v6.3-rc1)

Recent activities from: Pierre Asselin (7), Thomas Zimmermann (7),
  Javier Martinez Canillas (3), Linux regression tracking (Thorsten
  Leemhuis) (1), kernel test robot (1)

4 patch postings are associated with this regression, the latest is this:
* Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is calculated
  https://lore.kernel.org/lkml/87o7nsuumt.fsf@minerva.mail-host-address-is-not-set/
  10 days ago, by Javier Martinez Canillas

Noteworthy links:
* [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is calculated
  https://lore.kernel.org/lkml/20230412150225.3757223-1-javierm@redhat.com/
  11 days ago, by Javier Martinez Canillas; thread monitored.
* [PATCH] firmware/sysfb: Fix VESA format selection
  https://lore.kernel.org/lkml/20230418183325.2327-1-pa@panix.com/
  4 days ago, by Pierre Asselin; thread monitored.
* [PATCH v2] firmware/sysfb: Fix VESA format selection
  https://lore.kernel.org/lkml/20230419044834.10816-1-pa@panix.com/
  4 days ago, by Pierre Asselin; thread monitored.
* [PATCH v3] firmware/sysfb: Fix VESA format selection
  https://lore.kernel.org/lkml/20230420155705.21463-1-pa@panix.com/
  3 days ago, by Pierre Asselin; thread monitored.


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168166781352.1843526.278570500979918184@leemhuis.info

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
