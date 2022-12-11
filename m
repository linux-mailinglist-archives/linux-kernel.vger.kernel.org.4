Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1192E64951D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLKQm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 11:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLKQmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 11:42:55 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18B5595
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 08:42:53 -0800 (PST)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1p4PPf-0002SD-T5; Sun, 11 Dec 2022 17:42:51 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-12-11]
Date:   Sun, 11 Dec 2022 16:42:51 +0000
Message-Id: <167077682369.767290.4323979751797298970@leemhuis.info>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670776973;e2b23450;
X-HE-SMSGID: 1p4PPf-0002SD-T5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below you'll find regzbot's report about regression from this
cycle the bot and I became aware of. Most of the issue I had on the list
last weeks were resolved, only a few problems that showed up in the past
few days remain. One of them is the bisected BPF issue you already are
aware of Jiri is looking into; the other two need more debugging and
afaics will only show up in special, not that common setups...

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 44 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.0.. aka v6.1-rc), culprit identified
======================================================


[ *NEW* ] net/bpf: BUG: unable to handle kernel paging request in bpf_dispatcher_xdp
------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CACkBjsYioeJLhJAZ=Sq4CAL2O_W+5uqcJynFgLSizWLqEjNrjw@mail.gmail.com/
https://lore.kernel.org/lkml/CACkBjsYioeJLhJAZ=Sq4CAL2O_W%2B5uqcJynFgLSizWLqEjNrjw@mail.gmail.com/

By Hao Sun; 5 days ago; 26 activities, latest 1 days ago.
Introduced in c86df29d11df (v6.1-rc6)

Recent activities from: Jiri Olsa (14), Alexei Starovoitov (3), Jakub
  Kicinski (3), Daniel Borkmann (2), Hao Sun (2), Paul E. McKenney (1),
  Yonghong Song (1)

4 patch postings are associated with this regression, the latest is this:
* Re: BUG: unable to handle kernel paging request in bpf_dispatcher_xdp
  https://lore.kernel.org/lkml/Y5PNeFYJrC6D4P9p@krava/
  1 days ago, by Jiri Olsa


==================================================
current cycle (v6.0.. aka v6.1-rc), unkown culprit
==================================================


[ *NEW* ] resume from suspend broken on Asus UX305FA after PCI/PTM changes in kernel 6.1-rc1
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216782/
https://bugzilla.kernel.org/show_bug.cgi?id=216782
https://lore.kernel.org/regressions/5e8317f7-170a-588b-7a94-e0a546fbc9f3@leemhuis.info/

By Tasev Nikola and Tasev Nikola; 4 days ago; 13 activities, latest 2 days ago.
Introduced in v6.0..v6.1-rc1

Recent activities from: Tasev Nikola (9), Bjorn Helgaas (2), Thorsten
  Leemhuis (1), The Linux kernel's regression tracker (Thorsten
  Leemhuis) (1)


[ *NEW* ] bcache: memcpy: detected field-spanning write...
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216785/
https://bugzilla.kernel.org/show_bug.cgi?id=216785
https://lore.kernel.org/lkml/19200730-a3ba-6f4f-bb81-71339bdbbf73@leemhuis.info/

By Alexandre Pereira and Alexandre Pereira; 3 days ago; 1 activities, latest 3 days ago.
Introduced in v6.0..v6.1-rc8

Recent activities from: Alexandre Pereira (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167016324121.413036.10816787460130337195@leemhuis.info

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
