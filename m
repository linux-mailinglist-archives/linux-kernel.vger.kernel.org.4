Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78886C037C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCSRbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:31:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B063419C51
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:31:02 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pdws0-00020x-5l; Sun, 19 Mar 2023 18:31:00 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-03-19]
Date:   Sun, 19 Mar 2023 17:30:59 +0000
Message-Id: <167924702564.240621.4560988031596715318@leemhuis.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679247062;e41cfc06;
X-HE-SMSGID: 1pdws0-00020x-5l
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. The list of regressions from the 6.3 cycle I track is still
quite short. See below for details, but let me mention a few things:

A fix from Arnd for one of the build problems Guenter reported early
this cycle sadly doesn't make any progress since more than a month now;
I should have prodded here:
https://lore.kernel.org/linux-media/20230207161316.293923-1-arnd@kernel.org/

Another patch for one of Guenter build problems hopefully should sooner
or later go towards you with the btrfs updates:
https://lore.kernel.org/all/dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me/

The fix for the random warning backtraces in calls from ct_nmi_enter
Guenter reported in reply to 6.3-rc2 announcement is still in the works:
https://lore.kernel.org/all/20230316082007.652669-1-ardb@kernel.org/

While at it let me briefly mentioned one 6.2 issue: a revert for a
change that causes a regression after a long review phase was accepted
by a maintainer and sent for merging to Mauro about two weeks ago – but
he afaics didn't pick it up yet and my prodding didn't help. #sigh Is
this a situation where you might be willing to help out?
https://lore.kernel.org/linux-media/20230302060413.67239-1-stanimir.k.varbanov@gmail.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 4 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.2.. aka v6.3-rc), culprit identified
======================================================


[ *NEW* ] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck reboots
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230314230004.961993-1-alexey.klimov@linaro.org/
https://lore.kernel.org/lkml/20230314230004.961993-1-alexey.klimov@linaro.org/

By Alexey Klimov; 4 days ago; 5 activities, latest 2 days ago.
Introduced in 0c5ffc3d7b15 (v6.3-rc1)

Recent activities from: Alexey Klimov (3), Peter Zijlstra (1), Bart Van
  Assche (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck reboots
  https://lore.kernel.org/lkml/20230315111606.GB2006103@hirez.programming.kicks-ass.net/
  4 days ago, by Peter Zijlstra


Build failures for sparc64:allmodconfig and parisc:allmodconfig with gcc 11.x+
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230222025918.GA1651385@roeck-us.net/
https://lore.kernel.org/linux-btrfs/20230222025918.GA1651385@roeck-us.net/

By Guenter Roeck; 25 days ago; 6 activities, latest 4 days ago.
Introduced in 1ec49744ba83 (v6.3-rc1)

Fix incoming:
* btrfs: fix compilation error on sparc/parisc
  https://lore.kernel.org/linux-btrfs/caed9824-c05d-19a9-d321-edefab17c4f0@roeck-us.net/


[ *NEW* ] arm: vfp: random Warning backtraces in calls from ct_nmi_enter()
--------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net/
https://lore.kernel.org/lkml/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net/

By Guenter Roeck; 6 days ago; 15 activities, latest 5 days ago.
Introduced in 62b95a7b44d1 (v6.3-rc1)

Fix incoming:
* ARM: vfp: Fix broken softirq handling with instrumentation enabled
  https://lore.kernel.org/lkml/73b7867a-8a1f-d521-d290-77bc7fcb2226@leemhuis.info/


Build error in drivers/media/i2c/imx290.c if PM support is disabled
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230227175245.GA3728693@roeck-us.net/
https://lore.kernel.org/linux-media/20230227175245.GA3728693@roeck-us.net/

By Guenter Roeck; 19 days ago; 4 activities, latest 7 days ago.
Introduced in 02852c01f654 (v6.3-rc1)

Fix incoming:
* media: i2c: imx290: fix conditional function defintions
  https://lore.kernel.org/linux-media/79488ad7-5709-235b-14b4-1518e989c7a3@leemhuis.info/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167864480635.3972286.12282059674664387990@leemhuis.info

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
