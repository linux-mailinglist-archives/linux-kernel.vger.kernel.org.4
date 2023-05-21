Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BAF70AF19
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjEURAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjEUQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:59:50 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C9A3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 09:57:17 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1q0mMn-0005sz-At; Sun, 21 May 2023 18:57:09 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-05-21]
Date:   Sun, 21 May 2023 16:57:08 +0000
Message-Id: <168468791405.573950.5461774961481617442@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684688237;91fa7947;
X-HE-SMSGID: 1q0mMn-0005sz-At
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Nothing much to report, so without further ado find regzbot's
report below. Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 7 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.3.. aka v6.4-rc), culprit identified
======================================================


[ *NEW* ] SPI NOR bank divide by zero on Lenovo ThinkPad X1 Titanium
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/217448/
https://bugzilla.kernel.org/show_bug.cgi?id=217448
https://lore.kernel.org/lkml/b984f839-cf0a-fc25-41d5-656171774e4e@gmail.com/

By Todd Brandt and Todd Brandt; 4 days ago; 11 activities, latest 2 days ago.
Introduced in 9d6c5d64f028 (v6.4-rc1)

Fix incoming:
* mtd: spi-nor: Fix divide by zero for spi-nor-generic flashes
  https://lore.kernel.org/lkml/ZGYp4jnJxZJlfpeB@debian.me/


[ *NEW* ] vhost: ps output changed and suspend fails when VMs are running
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com/
https://lore.kernel.org/lkml/aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com/

By Nicolas Dichtel; 16 days ago; 28 activities, latest 3 days ago.
Introduced in 6e890c5d502 (v6.4-rc1)

Recent activities from: Linus Torvalds (5), Mike Christie (4), Oleg
  Nesterov (4), Christian Brauner (3), Eric W. Biederman (2), Jens
  Axboe (1)

3 patch postings are associated with this regression, the latest is this:
* Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
  https://lore.kernel.org/lkml/8bfb7d1d-f7d0-94ca-4777-e31a2003027a@oracle.com/
  5 days ago, by Mike Christie


regulator: qcom-rpmh: Dragonboard 845c broken due to asynchronous probe
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/

By Amit Pundir; 7 days ago; 7 activities, latest 4 days ago.
Introduced in ad44ac082fd (v6.4-rc1)

Recent activities from: Doug Anderson (2), Amit Pundir (2), Mark
  Brown (1)

One patch associated with this regression:
* Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
  https://lore.kernel.org/lkml/552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org/
  7 days ago, by Caleb Connolly


system hang on start-up (irq or mlx5 problem?)
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com/
https://lore.kernel.org/netdev/A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com/

By Chuck Lever III; 18 days ago; 9 activities, latest 4 days ago.
Introduced in bbac70c74183 (v6.4-rc1)

Recent activities from: Chuck Lever III (1)


ext4: adv test cases of kvm-xfstests fail
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64/
https://lore.kernel.org/linux-ext4/ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64/

By Eric Whitney; 11 days ago; 2 activities, latest 11 days ago.
Introduced in e360c6ed7274 (v6.4-rc1)


powerpc: boot issues on PASEMI Nemo board
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/301595ad-0edf-2113-b55f-f5b8051ed24c@xenosoft.de/
https://lore.kernel.org/linuxppc-dev/301595ad-0edf-2113-b55f-f5b8051ed24c@xenosoft.de/

By Christian Zigotzky; 19 days ago; 20 activities, latest 12 days ago.
Introduced in e4ab08be5b49 (v6.4-rc1)

Fix incoming:
* powerpc/isa-bridge: Fix ISA mapping when "ranges" is not present
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=79de36042eecb684e0f748d17ba52f365fde0d65


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168407416011.74685.9039980276616254723@leemhuis.info

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
