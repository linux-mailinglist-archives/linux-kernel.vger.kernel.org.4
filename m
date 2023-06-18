Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F77346AF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFROvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFROv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:51:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1308BC5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 07:51:28 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qAtkU-0001Hm-CR; Sun, 18 Jun 2023 16:51:26 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-06-18]
Date:   Sun, 18 Jun 2023 14:51:25 +0000
Message-Id: <168709975910.455445.13798099813754443067@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687099888;72848d7e;
X-HE-SMSGID: 1qAtkU-0001Hm-CR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Things look mostly normal on the regression front. But as we
are nearing the final a few more words from my side than usual:

* I already mentioned in an earlier mail that there is a series of mm
reverts in next where my brain said "hmmm, Andrew merged those more than
a week ago to mm-hotfixes-unstable and -rc7 is due today; I don't see a
PR from him and wonder if these revert are something that better should
be in rc7 to help preventing a rc8?" so I thought I mention it here so
that you can take a look yourself if you got curious:
https://lore.kernel.org/all/20230609081518.3039120-1-qi.zheng@linux.dev/
(for the backstory see the two links in that mail)

* it's afaics nothing that will bother many people, but switching to
asynchronous probe broke the Dragonboard 845c (SDM845). People are still
discussing how to properly fix this:
https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
https://lore.kernel.org/lkml/fbe5138f-fe97-11ee-a14a-4bb447c0972a@linaro.org/

* Currently looks a lot like a regression in 9p that causes MPTCP tests
to be unstable won't be fixed within the next week or two:
https://lore.kernel.org/regressions/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/
https://lore.kernel.org/regressions/CAFkjPTnAV6Rngwn6voCF332CX%2BeUyeJd7U0GcYn9BbkBqcTkHA@mail.gmail.com/

* a tpm/ppc/kexec issue reported a few days ago is investigated:
https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/

* for completeness: I expect you will get "tick/common: Align tick
period during sched_timer setup" from the tip folks today.
https://lore.kernel.org/all/20230615091830.RxMV2xf_@linutronix.de/
https://lore.kernel.org/lkml/20230613134105.GA10301@redhat.com/

Ciao, Thorsten

P.S. Sorry, I didn't got around to send a regression report last week, I
was on a short vacation and came back home one day later than expected.

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 6 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.3.. aka v6.4-rc), culprit identified
======================================================


[ *NEW* ] mm: problems with the SRCU changeover (two reverts pending)
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/202305230837.db2c233f-yujie.liu@intel.com/
https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/

By kernel test robot; 26 days ago; 33 activities, latest 0 days ago.
Introduced in f95bdb700bc6 (v6.4-rc1)

Fix incoming:
* Revert "mm: vmscan: make global slab shrink lockless"
  https://lore.kernel.org/lkml/d8e0e211-6e2c-6aba-9ffd-84833872f559@leemhuis.info/


regulator: qcom-rpmh: Dragonboard 845c broken due to asynchronous probe
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/

By Amit Pundir; 35 days ago; 48 activities, latest 1 days ago.
Introduced in ad44ac082fd (v6.4-rc1)

Recent activities from: Amit Pundir (9), Krzysztof Kozlowski (7), Doug
  Anderson (7), Mark Brown (2), Linux regression tracking (Thorsten
  Leemhuis) (1)

One patch associated with this regression:
* Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
  https://lore.kernel.org/lkml/552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org/
  35 days ago, by Caleb Connolly

Noteworthy links:
* [PATCH] Revert "regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS""
  https://lore.kernel.org/lkml/20230515145323.1693044-1-amit.pundir@linaro.org/
  33 days ago, by Amit Pundir; thread monitored.
* [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
  https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/
  15 days ago, by Amit Pundir; thread monitored.


[ *NEW* ] sched/clock: printk.time causes rare kernel boot hangs
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230613134105.GA10301@redhat.com/
https://lore.kernel.org/lkml/20230613134105.GA10301@redhat.com/

By Richard W.M. Jones; 5 days ago; 44 activities, latest 3 days ago.
Introduced in f31dcb152a3d (v6.4-rc1)

Fix incoming:
* tick/common: Align tick period during sched_timer setup
  https://lore.kernel.org/lkml/1413638e-9614-056e-cfc5-5f9c8bf8af00@leemhuis.info/


[ *NEW* ] tpm/ppc: crash during a kexec
---------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/

By Sachin Sant; 3 days ago; 3 activities, latest 3 days ago.
Introduced in bd8621ca1510 (v6.4-rc1)

Recent activities from: Sachin Sant (2), Michael Ellerman (1)

One patch associated with this regression:
* Re: [6.4-rc6] Crash during a kexec operation (tpm_amd_is_rng_defective)
  https://lore.kernel.org/lkml/87o7lhfmoh.fsf@mail.lhotse/
  3 days ago, by Michael Ellerman


[ *NEW* ] 9p: MPTCP tests regressions due to new 9p features in v6.4
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/
https://lore.kernel.org/regressions/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/

By Matthieu Baerts; 12 days ago; 5 activities, latest 4 days ago.
Introduced in d9bc0d11e33b (v6.4-rc1)

Recent activities from: Matthieu Baerts (3), Eric Van Hensbergen (1),
  evanhensbergen@icloud.com (1)


=======================================================
on back burner, but with activity since the last report
=======================================================


[ *NEW* ] mm: performance regression on shell-heavy workloads
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230608111408.s2minsenlcjow7q3@quack3/
https://lore.kernel.org/lkml/20230608111408.s2minsenlcjow7q3@quack3/

By Jan Kara; 10 days ago; 6 activities, latest 9 days ago.
Introduced in f1a7941243c (v6.2-rc1)

Recent activities from: Shakeel Butt (2), Jan Kara (2), Dennis Zhou (1),
  Yu Zhao (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168588069830.1422846.3733273600224627850@leemhuis.info

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
