Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54F6A9240
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCCIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCCIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:17:28 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C851F88
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:17:12 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pY0bG-0004AA-Q4; Fri, 03 Mar 2023 09:17:10 +0100
Message-ID: <19284aff-436a-5130-5126-8ccdd1af476d@leemhuis.info>
Date:   Fri, 3 Mar 2023 09:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [regression] Bug 217084 - Roland VS-100 non working (snd_usb_audio)
 since kernel 5.11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677831432;ada9b5d3;
X-HE-SMSGID: 1pY0bG-0004AA-Q4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217084 :

>  Alberto Zin 2023-02-24 18:11:31 UTC
> 
> The issue I encountered is on a Roland VS-100:
> 
> https://www.roland.com/global/products/v-studio_100/
> 
> it seems that snd_usb_audio module has broken the compatibility with the VS-100 at around kernel 5.11 time. After that kernel the interface is recognized only as a midi interface, on recent kernels there is only dummy audio device and no sound at all. 
> 
> I have two alsa-info reports, on the same desktop pc:
> 
> working (my current setup, linux kernel 5.6.0-1055-oem):
> http://alsa-project.org/db/?f=a3378ecb0a258b4745827c693f4c0045fdb83847
> 
> non working (live, avlinux, 6.0.x):
> http://alsa-project.org/db/?f=99bcdd5a60281110a93317d09a11b9f4831f9701 
> 
> in the non working case the interface is recognised by "lsusb", it is seen by "aconnect -l" but not by "aplay -l".
> 
> I'm willing to help testing as much as I can.
> Alberto

See the ticket for more details. There you noticed that Alberto retried
with a vanilla kernel later and the problem happens there, too.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.4.59..v5.4.233
https://bugzilla.kernel.org/show_bug.cgi?id=217084
#regzbot title: alsa: Roland VS-100 stopped working
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
