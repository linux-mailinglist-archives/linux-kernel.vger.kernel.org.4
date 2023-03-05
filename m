Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2886AB10E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCEOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCEOdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:33:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD67ABA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 06:33:08 -0800 (PST)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pYpQA-0006bo-Ra; Sun, 05 Mar 2023 15:33:06 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-03-05]
Date:   Sun,  5 Mar 2023 14:33:06 +0000
Message-Id: <167802672375.3551148.2619236429318783591@leemhuis.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678026788;4357b53c;
X-HE-SMSGID: 1pYpQA-0006bo-Ra
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. There is nothing much to report wrt to regressions,
nevertheless let me give a quick status update.

As of now I only track two afaik unfixed build problems that were
introduced this cycle. Both were reported by Guenter (he even added them
to regzbot's tracking himself, yeah!). See below for details.

Apart from those there are two more issues I don't track (yet) and only
have a loose eye on, as I had assumed the maintainers would send fixes
for them in before -rc1. But that afaics didn't happen, so let me
quickly mention the fixes here:

* media: Fix building pdfdocs
https://lore.kernel.org/linux-media/20230208082916.68377-1-tomi.valkeinen@ideasonboard.com/
[looks like this is needed in mainline, but it's not entirely clear]

* clk: Mark a fwnode as initialized when using CLK_OF_DECLARE* macros
https://lore.kernel.org/lkml/20230301012506.1401883-1-saravanak@google.com/

I also had hoped a fix for a TPM regression from the 6.1 cycle would
reach your before -rc1, as it would prevent stuttering on some Ryzen
systems that more than just a user or two currently has to deal with
(due to a hw issue that happens more often due to a change in 6.1).
That's why some of the involved developers would have liked to see the
fix merged for 6.2 already. Well, that didn't happen. Luckily that patch
since a few days is at least in Linux-next now (currently as 8699d5244e):
https://lore.kernel.org/all/20230228024439.27156-1-mario.limonciello@amd.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 2 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v6.2.. aka v6.2-post), culprit identified
========================================================


[ *NEW* ] Build error in drivers/media/i2c/imx290.c if PM support is disabled
-----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230227175245.GA3728693@roeck-us.net/
https://lore.kernel.org/linux-media/20230227175245.GA3728693@roeck-us.net/

By Guenter Roeck; 5 days ago; 1 activities, latest 5 days ago.
Introduced in 02852c01f654

Recent activities from: Guenter Roeck (1)


[ *NEW* ] Build failures for sparc64:allmodconfig and parisc:allmodconfig with gcc 11.x+
----------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230222025918.GA1651385@roeck-us.net/
https://lore.kernel.org/linux-btrfs/20230222025918.GA1651385@roeck-us.net/

By Guenter Roeck; 11 days ago; 4 activities, latest 8 days ago.
Introduced in 1ec49744ba83

Recent activities from: Guenter Roeck (3), David Sterba (1)

One patch associated with this regression:
* Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
  https://lore.kernel.org/linux-btrfs/6c308ddc-60f8-1b4d-28da-898286ddb48d@roeck-us.net/
  10 days ago, by Guenter Roeck


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167613641114.2124708.9785978428796571420@leemhuis.info

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
