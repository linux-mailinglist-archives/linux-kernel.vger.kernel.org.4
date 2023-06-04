Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D564E7216C9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFDMOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjFDMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:14:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786BDB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 05:14:00 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1q5mcQ-0000ae-KU; Sun, 04 Jun 2023 14:13:58 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-06-04]
Date:   Sun,  4 Jun 2023 12:13:57 +0000
Message-Id: <168588069830.1422846.3733273600224627850@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685880840;2afbaffd;
X-HE-SMSGID: 1q5mcQ-0000ae-KU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Nothing much to report for mainline, all business as usual. I
had hoped Mauro would sent a pull with the media fixes, as they would
contain one fix[1] for a bug that at least two people hit, but I guess
it can wait another week.

Ohh, and in case you care: the Logitech HID bug[3] from the 6.3 cycle
was not really fixed[4] by commit 6199d23c91c or we dealt with two
problems all the time (I guess it's the latter). But that will take a
few days to sort out.

[1] 14b4bd01f8e ("media: verisilicon: Additional fix for the crash when
opening the driver")
[2] https://lore.kernel.org/lkml/4995215.LvFx2qVVIh@bagend/ and
https://lore.kernel.org/all/20230516091209.3098262-1-m.tretter@pengutronix.de/
[3] https://bugzilla.kernel.org/show_bug.cgi?id=217412
[4] https://bugzilla.kernel.org/show_bug.cgi?id=217523

Ciao, Thorsten

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


[ *NEW* ] rcu: "spinlock bad magic" BUG when the SRCU notifier was ever used
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/6549da46-dddc-67ac-73c4-966965addad7@nvidia.com/
https://lore.kernel.org/lkml/6549da46-dddc-67ac-73c4-966965addad7@nvidia.com/

By Jon Hunter; 3 days ago; 10 activities, latest 0 days ago.
Introduced in 95433f726301 (v6.4-rc1)

Fix incoming:
* notifier: Initialize new struct srcu_usage field
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=cf193e74990d3b66d8b1c07232b8d42b316529ae


[ *NEW* ] Networking pull for v6.4 causes full system lockup on RTL8111/8168/8411
---------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/217519/
https://bugzilla.kernel.org/show_bug.cgi?id=217519
https://lore.kernel.org/lkml/9f12c322-fb62-26f0-46d1-61936a419468@gmail.com/

By SamW and SamW; 2 days ago; 6 activities, latest 1 days ago.
Introduced in 6e98b09da931 (v6.4-rc1)

Recent activities from: SamW (3), Bagas Sanjaya (2), Heiner Kallweit (1)


[ *NEW* ] USB typec quirk for Asus Zenbook UM325 triggers system freeze on Acer ConceptD 7
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/217517/
https://bugzilla.kernel.org/show_bug.cgi?id=217517
https://lore.kernel.org/lkml/e6124947-bc60-660b-a41f-e09256bc5232@gmail.com/

By Stephan Bolten and Stephan Bolten; 2 days ago; 5 activities, latest 1 days ago.
Introduced in 326e1c208f3f (v6.4-rc1)

Recent activities from: Stephan Bolten (4), Heikki Krogerus (1)

One patch associated with this regression:
* bugzilla.kernel.org bug 217517: new comment(#1)
  https://bugzilla.kernel.org/show_bug.cgi?id=217517#c1
  1 days ago, by Heikki Krogerus


regulator: qcom-rpmh: Dragonboard 845c broken due to asynchronous probe
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/

By Amit Pundir; 21 days ago; 22 activities, latest 1 days ago.
Introduced in ad44ac082fd (v6.4-rc1)

Recent activities from: Amit Pundir (7), Mark Brown (2), Doug
  Anderson (1)

One patch associated with this regression:
* Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
  https://lore.kernel.org/lkml/552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org/
  20 days ago, by Caleb Connolly

Noteworthy links:
* [PATCH] Revert "regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS""
  https://lore.kernel.org/lkml/20230515145323.1693044-1-amit.pundir@linaro.org/
  19 days ago, by Amit Pundir; thread monitored.
* [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
  https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/
  1 days ago, by Amit Pundir; thread monitored.


[ *NEW* ] media: dvb-core: DVB card sometimes does not initialize
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/da5382ad-09d6-20ac-0d53-611594b30861@lio96.de/
https://lore.kernel.org/lkml/da5382ad-09d6-20ac-0d53-611594b30861@lio96.de/

By Thomas Voegtle; 5 days ago; 1 activities, latest 5 days ago.
Introduced in 6769a0b7ee0c (v6.4-rc3)

Recent activities from: Thomas Voegtle (1)


[ *NEW* ] media: verisilicon: null pointer dereference in try_fmt
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4995215.LvFx2qVVIh@bagend/
https://lore.kernel.org/lkml/4995215.LvFx2qVVIh@bagend/
https://lore.kernel.org/lkml/20230523162515.993862-1-benjamin.gaignard@collabora.com/

By Diederik de Haas and Benjamin Gaignard; 15 days ago; 8 activities, latest 5 days ago.
Introduced in db6f68b51e5c (v6.4-rc1)

Fix incoming:
* media: verisilicon: Additional fix for the crash when opening the driver
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=14b4bd01f8e5d663a41ef8cec5857db874b66e88


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168468791405.573950.5461774961481617442@leemhuis.info

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
