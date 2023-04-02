Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A96D3975
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDBRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBRea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:34:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B7974F
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:34:29 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pj1b1-0001Ty-Hs; Sun, 02 Apr 2023 19:34:27 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-04-02]
Date:   Sun,  2 Apr 2023 17:34:26 +0000
Message-Id: <168045676522.992122.1074253542608037015@leemhuis.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680456869;87439c5a;
X-HE-SMSGID: 1pj1b1-0001Ty-Hs
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. The list of tracked 6.3 regressions is still quite short (see
below) and there is nothing noteworthy.

But there is a 6.2 regression that annoys me. It's one of the two in the
media driver venus I mentioned a few times already in earlier reports.

First it took quite some time to get a simple revert reviewed, merged,
and forwarded by a sub-maintainer. Then after even more time about two
weeks ago Mauro merged it, but now the revert is getting even older in
the fixes branch of the media tree as well as in linux-next (as
b0d944bc47ce ("media: Revert "venus: firmware: Correct non-pix start and
end addresses"")). And apparently it's something that is annoying
people, as can be seen by this mail from yesterday:
https://lore.kernel.org/lkml/a2fec0a5855150966fa5a920216c205032965f98@lausen.nl/
(this mentions both regressions in the venus driver; reg. the second
one, see my reply there)

I forgot to prod Mauro about this last week, but he OTOH should be aware
of this due to earlier mails like this one:
https://lore.kernel.org/all/7ef0357c-1bd8-7598-4c4e-9d795b5f0abd@leemhuis.info/

Fun fact: the revert itself by now is nine weeks old:
https://lore.kernel.org/all/20230207102254.1446461-1-javierm@redhat.com/

This is kind of frustrating, as similar things happen all the time, the
timing is just not that bad.

Sometimes I wonder if we should have a stable-kernel rule like "changes
introduced in the last devel cycle are allowed to be reverted without
being reverted in mainline first" to fix such regressions more quickly.
But then again something in me yells quite loudly "no, that's wrong, as
some of those regression will be forgotten to get fixed and then will
resurface the next mainline release. Even worse, users of mainline
pre-releases will run into them and thus might bisect them again -- or
we loose those as testers, as they become annoyed and switch back to a
working version".

#sigh

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 5 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.2.. aka v6.3-rc), culprit identified
======================================================


[ *NEW* ] pci: / net: igb: hangs during boot on PowerEdge R620
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/m2fs9lgndw.fsf@gmail.com/
https://lore.kernel.org/lkml/m2fs9lgndw.fsf@gmail.com/

By Donald Hunter; 2 days ago; 3 activities, latest 1 days ago.
Introduced in 6fffbc7ae137 (v6.3-rc1)

Recent activities from: Donald Hunter (2), Bjorn Helgaas (1)


[ *NEW* ] net: mlx5: InfiniBand devices were no longer present
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAHC9VhQ7A4+msL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com/
https://lore.kernel.org/netdev/CAHC9VhQ7A4%2BmsL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com/

By Paul Moore; 4 days ago; 3 activities, latest 3 days ago.
Introduced in fe998a3c77b9 (v6.3-rc1)

Recent activities from: Paul Moore (2), Saeed Mahameed (1)


arm: vfp: random Warning backtraces in calls from ct_nmi_enter()
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net/
https://lore.kernel.org/lkml/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net/

By Guenter Roeck; 20 days ago; 16 activities, latest 13 days ago.
Introduced in 62b95a7b44d1 (v6.3-rc1)

Fix incoming:
* ARM: vfp: Fix broken softirq handling with instrumentation enabled
  https://lore.kernel.org/lkml/73b7867a-8a1f-d521-d290-77bc7fcb2226@leemhuis.info/


==================================================
current cycle (v6.2.. aka v6.3-rc), unkown culprit
==================================================


[ *NEW* ] iwlwifi: frequent drops between v6.2-rc3 and v6.3-rc1
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com/
https://lore.kernel.org/linux-wireless/9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com/

By Vegard Nossum; 16 days ago; 3 activities, latest 7 days ago.
Introduced in e8f60cd7db24..2eb29d59ddf0 (v6.2-rc3..v6.3-rc1)

Recent activities from: Alexander Wetzel (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167924702564.240621.4560988031596715318@leemhuis.info

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
