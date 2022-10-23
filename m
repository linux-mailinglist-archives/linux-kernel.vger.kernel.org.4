Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B260956E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJWSW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:22:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE5D3A4AB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:22:25 -0700 (PDT)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1omfc7-0003sn-JN; Sun, 23 Oct 2022 20:22:23 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-10-23]
Date:   Sun, 23 Oct 2022 18:22:22 +0000
Message-Id: <166654892458.2211781.4685104302005471754@leemhuis.info>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666549345;756b8485;
X-HE-SMSGID: 1omfc7-0003sn-JN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below is a slightly edited report from regzbot listing all
regression from this cycle that the bot and I are currently aware of.

For two of those five regressions a patch was accepted by the
maintainer, but is not even yet in linux-next afaics.

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 5 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.0.. aka v6.1-rc), culprit identified
======================================================


[ *NEW* ] mm: sparc64: dpkg fails on sparc64 since "mm/thp: Carry over dirty bit when thp splits on pmd)"
---------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20221021160603.GA23307@u164.east.ru/
https://lore.kernel.org/lkml/20221021160603.GA23307@u164.east.ru/

By Anatoly Pugachev; 2 days ago; 1 activities, latest 2 days ago.
Introduced in 0ccf7f168e17 (v6.1-rc1)

Recent activities from: Anatoly Pugachev (1)


[ *NEW* ] drm: amdgpu: some games (Cyberpunk 2077, Forza Horizon 4/5) hang at start
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CABXGCsOeQ7VYm98jRVaYp6KaNsFVsAnSb33ZT8JvZxcTcEGW0w@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsOeQ7VYm98jRVaYp6KaNsFVsAnSb33ZT8JvZxcTcEGW0w@mail.gmail.com/

By Mikhail Gavrilov; 2 days ago; 3 activities, latest 2 days ago.
Introduced in dd80d9c8eeca (v6.1-rc1)

Recent activities from: Mikhail Gavrilov (2), Christian König (1)


[ *NEW* ] v6.1-rc1: Regression in notification of sethostname changes
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com/
https://lore.kernel.org/lkml/0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com/

By Torsten Hilbrich; 4 days ago; 6 activities, latest 3 days ago.
Introduced in bfca3dd3d0 (v6.1-rc1)

Fix incoming:
* https://lore.kernel.org/regressions/e910961b-2a8a-9d50-5842-54632aa05cd4@leemhuis.info/


[ *NEW* ] Reboot failure on big endian mips systems
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20221009163942.GA630814@roeck-us.net/
https://lore.kernel.org/lkml/20221009163942.GA630814@roeck-us.net/

By Guenter Roeck; 14 days ago; 12 activities, latest 5 days ago.
Introduced in 72a95859728a (v6.1-rc1)

Recent activities from: Andy Shevchenko (4), Lee Jones (3), Jason A.
  Donenfeld (3), Guenter Roeck (1), Linus Torvalds (1)

One patch associated with this regression:
* [PATCH] Revert "mfd: syscon: Remove repetition of the regmap_get_val_endian()"
  https://lore.kernel.org/lkml/20221008154700.404837-1-Jason@zx2c4.com/
  15 days ago, by Jason A. Donenfeld

Noteworthy links:
* Re: [GIT PULL] MFD for v6.1
  https://lore.kernel.org/lkml/Y0GZwkDwnak2ReTt@zx2c4.com/
  15 days ago, by Jason A. Donenfeld; thread monitored.


[ *NEW* ] mm: Observed memory leak in hugetlb_reserve_pages
-----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAKXUXMxf7OiCwbxib7MwfR4M1b5+b3cNTU7n5NV9Zm4967=FPQ@mail.gmail.com/
https://lore.kernel.org/lkml/CAKXUXMxf7OiCwbxib7MwfR4M1b5%2Bb3cNTU7n5NV9Zm4967=FPQ@mail.gmail.com/

By Lukas Bulwahn; 6 days ago; 3 activities, latest 5 days ago.
Introduced in bbff39cc6cbc (v6.1-rc1)

Recent activities from: Mike Kravetz (2), Lukas Bulwahn (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/166473157744.1194655.10375853755031619713@leemhuis.info

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
