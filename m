Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796F96271D6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiKMSxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiKMSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:53:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13DB2DEC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:53:48 -0800 (PST)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ouI71-0005oS-76; Sun, 13 Nov 2022 19:53:47 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-11-13]
Date:   Sun, 13 Nov 2022 18:53:46 +0000
Message-Id: <166836521992.605503.16264140239924937400@leemhuis.info>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668365628;85bd6f90;
X-HE-SMSGID: 1ouI71-0005oS-76
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below is a slightly edited report from regzbot listing all
regression from this cycle that the bot and I are currently aware of.

3 of the tracked regressions were just reported in the past 3 days.

The fourth issue ("drm: amdgpu: some games hang at start") looks
stalled, will inquiry tomorrow what's up there; maybe I just missed a
patch to fix this (should have done that on Friday, sorry :-/ ).

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 55 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.0.. aka v6.1-rc), culprit identified
======================================================


[ *NEW* ] usb: devices are not powered anymore and sometimes reset
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/fd0f2d56-495e-6fdd-d1e8-ff40b558101e@axentia.se/
https://lore.kernel.org/linux-usb/fd0f2d56-495e-6fdd-d1e8-ff40b558101e@axentia.se/

By Peter Rosin; 0 days ago; 1 activities, latest 0 days ago.
Introduced in bf7571c00dca (v6.1-rc1)

Recent activities from: Peter Rosin (1)


[ *NEW* ] drm: msm: DSI controller being switched off before the panel unprepare hook is called
-----------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1892d0af-8aa4-dc03-887a-e44bb623b836@linaro.org/
https://lore.kernel.org/dri-devel/1892d0af-8aa4-dc03-887a-e44bb623b836@linaro.org/

By Caleb Connolly; 2 days ago; 2 activities, latest 0 days ago.
Introduced in 007ac0262b0d (v6.1-rc1)

Recent activities from: Dmitry Baryshkov (1), Caleb Connolly (1)


[ *NEW* ] drm: amdgpu: No payload for [MST PORT:0000000006da5d29] found in mst state 00000000b0e556d6" on system resume with TBT dock connected.
------------------------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/ghwn827862.fsf@gouders.net/
https://lore.kernel.org/lkml/ghwn827862.fsf@gouders.net/
https://gitlab.freedesktop.org/drm/amd/-/issues/2171

By Dirk Gouders and Unkown; 2 days ago; 3 activities, latest 1 days ago.
Introduced in 4d07b0bc4034 (v6.1-rc1)

Recent activities from: Dirk Gouders (2), Lyude Paul (1)


drm: amdgpu: some games (Cyberpunk 2077, Forza Horizon 4/5) hang at start
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CABXGCsOeQ7VYm98jRVaYp6KaNsFVsAnSb33ZT8JvZxcTcEGW0w@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsOeQ7VYm98jRVaYp6KaNsFVsAnSb33ZT8JvZxcTcEGW0w@mail.gmail.com/

By Mikhail Gavrilov; 23 days ago; 8 activities, latest 11 days ago.
Introduced in dd80d9c8eeca (v6.1-rc1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/166776472694.309600.9987230244979099462@leemhuis.info

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
