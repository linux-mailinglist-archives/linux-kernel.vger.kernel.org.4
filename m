Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E065BBF77
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIRTGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 15:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIRTGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 15:06:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBFF12D08
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:06:51 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oZzcv-0007pJ-Lv; Sun, 18 Sep 2022 21:06:49 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-09-18]
Date:   Sun, 18 Sep 2022 19:06:48 +0000
Message-Id: <166352773747.517659.4028966645485480297@leemhuis.info>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663528011;13b3aec0;
X-HE-SMSGID: 1oZzcv-0007pJ-Lv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below is a slightly edited report from regzbot listing all
regression from this cycle that the bot and I are currently aware of.

Many of the regressions I have been tracking that were introduced this
cycle got resolved in the last week or two. There is just one that
likely will be addressed by the network folks soon, and two that were
reported in the past few days that need to be looked at closer by
developers or reporters.

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 48 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v5.19.. aka v6.0-rc), culprit identified
=======================================================


[ *NEW* ] Graphical issues on Lenovo Yoga 7 14ARB7 laptop since v6.0-rc1 (bisected)
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se/
https://lore.kernel.org/lkml/c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se/

By August Wikerfors; 1 days ago; 1 activities, latest 1 days ago.
Introduced in 7cc191ee7621 (v6.0-rc1)

Recent activities from: August Wikerfors (1)


[ *NEW* ] introduced in 5.10.140 causes drives to drop from LSI SAS controller (Bisected to 6d17a112e9a63ff6a5edffd1676b99e0ffbcd269)
-------------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CADy0EvLGJmZe-x9wzWSB6+tDKNuLHd8Km3J5MiWWYQRR2ctS3A@mail.gmail.com/
https://lore.kernel.org/stable/CADy0EvL2XuWTjUdWHUHTpW3ZYaLWn0ftR-nUBioUqh-n-N=dXQ@mail.gmail.com/

By Jason Wittlin-Cohen and Jason Wittlin-Cohen; 3 days ago; 3 activities, latest 3 days ago.
Introduced in 6d17a112e9a6 (v6.0-rc3)

Recent activities from: Greg KH (1), Bart Van Assche (1), Jason Wittlin-
  Cohen (1)


[ *NEW* ] net: fec: backtrace: BUG: sleeping function called from invalid context at drivers/clk/imx/clk-pllv3.c
----------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220914145317.GA1868385@roeck-us.net/
https://lore.kernel.org/netdev/20220914145317.GA1868385@roeck-us.net/

By Guenter Roeck; 4 days ago; 19 activities, latest 4 days ago.
Introduced in b353b241f1eb (v6.0-rc5)

Recent activities from: Marc Kleine-Budde (6), Francesco Dolcini (5),
  Bence Csókás (3), Csókás Bence (2), Andrew Lunn (2), Guenter Roeck (1)

4 patch postings are associated with this regression, the latest is this:
* Re: [PATCH 1/2] Revert "net: fec: Use a spinlock to guard `fep->ptp_clk_on`"
  https://lore.kernel.org/netdev/20220912103818.j2u6afz66tcxvnr6@pengutronix.de/
  6 days ago, by Marc Kleine-Budde

Noteworthy links:
* [PATCH net 0/2] Revert fec PTP changes
  https://lore.kernel.org/lkml/20220912070143.98153-1-francesco.dolcini@toradex.com/
  6 days ago, by Francesco Dolcini; thread monitored.
* [PATCH 1/2] Revert "net: fec: Use a spinlock to guard `fep->ptp_clk_on`"
  https://lore.kernel.org/netdev/20220912073106.2544207-1-bence98@sch.bme.hu/
  6 days ago, by Bence Csókás; thread monitored.


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/166231521235.1982292.2102689915618920245@leemhuis.info

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
