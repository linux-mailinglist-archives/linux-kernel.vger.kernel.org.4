Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A486B6A5D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCLS6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:58:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505E222D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:58:42 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pbQDU-0000Yt-Et; Sun, 12 Mar 2023 19:14:44 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-03-12]
Date:   Sun, 12 Mar 2023 18:14:40 +0000
Message-Id: <167864480635.3972286.12282059674664387990@leemhuis.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678647523;36a6f97e;
X-HE-SMSGID: 1pbQDU-0000Yt-Et
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. The list of tracked regressions is still quite short.

Seems quite a few people have run into an issue Hector reported on
Saturday: WPA auth is entirely broken on brcmfmac in mainline and some
stable trees, as the culprit was already backported. He submitted a
partial revert here:
https://lore.kernel.org/all/20230311141914.24444-1-marcan@marcan.st/

Fixes for two build problems Guenter reported are floating around, but
haven't reached you yet.

The fix for the TPM regression (which made a HW/firmware issue happen
more freqently) from the 6.1 cycle (
https://lore.kernel.org/all/20230228024439.27156-1-mario.limonciello@amd.com/
) is still not mainlined, but after a recent discussion (I CCed you
recently) it should hopefully reach you soon now.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 3 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.2.. aka v6.3-rc), culprit identified
======================================================


Build failures for sparc64:allmodconfig and parisc:allmodconfig with gcc 11.x+
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230222025918.GA1651385@roeck-us.net/
https://lore.kernel.org/linux-btrfs/20230222025918.GA1651385@roeck-us.net/

By Guenter Roeck; 18 days ago; 5 activities, latest 0 days ago.
Introduced in 1ec49744ba83 (v6.3-rc1)

Fix incoming:
* btrfs: fix compilation error on sparc/parisc
  https://lore.kernel.org/linux-btrfs/caed9824-c05d-19a9-d321-edefab17c4f0@roeck-us.net/


Build error in drivers/media/i2c/imx290.c if PM support is disabled
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230227175245.GA3728693@roeck-us.net/
https://lore.kernel.org/linux-media/20230227175245.GA3728693@roeck-us.net/

By Guenter Roeck; 13 days ago; 4 activities, latest 0 days ago.
Introduced in 02852c01f654 (v6.3-rc1)

Fix incoming:
* media: i2c: imx290: fix conditional function defintions
  https://lore.kernel.org/linux-media/79488ad7-5709-235b-14b4-1518e989c7a3@leemhuis.info/


[ *NEW* ] Patch broke WPA auth: Re: [PATCH v2] wifi: cfg80211: Fix use after free for wext
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d6851c2b-7966-6cb4-a51c-7268c60e0a86@marcan.st/
https://lore.kernel.org/lkml/d6851c2b-7966-6cb4-a51c-7268c60e0a86@marcan.st/

By Hector Martin; 1 days ago; 13 activities, latest 1 days ago.
Introduced in 015b8cc5e7c4 (v6.3-rc1)

Recent activities from: Hector Martin (3), Alexander Wetzel (3), Eric
  Curtin (1), Janne Grunau (1), Joan Bruguera (1), Greg Kroah-
  Hartman (1), Hans de Goede (1)

One patch associated with this regression:
* [PATCH] wifi: cfg80211: Partial revert "wifi: cfg80211: Fix use after free for wext"
  https://lore.kernel.org/lkml/20230311141914.24444-1-marcan@marcan.st/
  1 days ago, by Hector Martin

=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167802672375.3551148.2619236429318783591@leemhuis.info

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
