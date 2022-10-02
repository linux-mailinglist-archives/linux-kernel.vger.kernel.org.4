Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95745F2448
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJBRdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJBRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:33:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7E2E693
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 10:33:03 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1of2pp-0006g2-6v; Sun, 02 Oct 2022 19:33:01 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-10-02]
Date:   Sun,  2 Oct 2022 17:33:00 +0000
Message-Id: <166473157744.1194655.10375853755031619713@leemhuis.info>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664731983;95360988;
X-HE-SMSGID: 1of2pp-0006g2-6v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below is a slightly edited report from regzbot listing all
regression from this cycle that the bot and I are currently aware of.

Nothing really new since Friday. The fix for a NULL pointer dereference
on the arm64/rock960 (f340ed8664a5 ("phy: rockchip-inno-usb2: Return
zero after otg sync")) didn't make it to you yet afaics.

The Turris Omnia (Armada 385) issue apparently needs more time to debug.

The discussion about the kernel change that exposed a iomap bug in Qemu
is ongoing, not sure if a revert here would be the right solution for
now; check the thread for details.

There is a bug in 5.19.y that seems to cause trouble for quite some
people on the latest Framework laptops (
http://lore.kernel.org/all/55905860-adf9-312c-69cc-491ac8ce1a8b@cern.ch/
). Apparently the problem is caused by a backport of a recent mainline
commit, but one user reported that mainline is working fine.

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 3 regressions in linux-mainline that were
introduced this cycle. Find the current status below and the
latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v5.19.. aka v6.0-rc), culprit identified
=======================================================


[ *NEW* ] Commit 'iomap: add support for dma aligned direct-io' causes qemu/KVM boot failures
---------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com/
https://lore.kernel.org/lkml/fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com/

By Maxim Levitsky; 3 days ago; 8 activities, latest 0 days ago.
Introduced in bf8d08532bc1 (v6.0-rc1)

Recent activities from: Keith Busch (3), Maxim Levitsky (3), Paolo
  Bonzini (1), Christoph Hellwig (1)


[ *NEW* ] arm: Turris Omnia (Armada 385) hangs shortly after init is run,
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20220930151028.0e518421@dellmb/
https://lore.kernel.org/linux-arm-kernel/20220930151028.0e518421@dellmb/

By Marek Behún; 2 days ago; 6 activities, latest 1 days ago.
Introduced in ae626eb97376 (v6.0-rc1)

Recent activities from: Marek Behún (4), Robin Murphy (2)


arm64 / rock960 : kernel panic (NULL pointer dereference)
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4f398e4c-973b-7843-2f75-27324d109277@linaro.org/
https://lore.kernel.org/lkml/4f398e4c-973b-7843-2f75-27324d109277@linaro.org/

By Daniel Lezcano; 7 days ago; 10 activities, latest 2 days ago.
Introduced in 8dc60f8da22f (v6.0-rc1)

Fix incoming:
* phy: rockchip-inno-usb2: Return zero after otg sync
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=f340ed8664a55a467850ec1689996e63d9ee971a


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/166412229677.822304.14973265664331660600@leemhuis.info

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
