Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62EB673D13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjASPG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjASPGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:06:52 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0045C0F5;
        Thu, 19 Jan 2023 07:06:48 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pIWV4-0001HO-Tw; Thu, 19 Jan 2023 16:06:46 +0100
Message-ID: <32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info>
Date:   Thu, 19 Jan 2023 16:06:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        =?UTF-8?Q?G=c3=a9_Koerkamp?= <ge.koerkamp@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 216946 - Toshiba satellite click mini l9w-b:
 touchscreen: no touch events with kernel 6.1.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674140808;d6e636b7;
X-HE-SMSGID: 1pIWV4-0001HO-Tw
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
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216946 :

>  Gé Koerkamp 2023-01-17 20:21:51 UTC
> 
> Created attachment 303619 [details]
> Kernel configuration for v6.1.4/ journalctl (dmesg)/ ACPIdump/lsmod
> 
> Overview: 
> The touchscreen does not react on touch events.
> Touchscreen display and touchpad are working.
> 
> Step to reproduce:
> Open any UI page
> Try to use touch on relevant UI controls (buttons etc.)
> 
> Result:
> No reaction on screen touches
> 
> Expected result:
> Reaction on touched control, same as when using the touch pad or connected mouse (which do work).
> 
> Build information:
> The error happens with kernel version 6.1.4
> After rebuilding with different kernel versions, it appears that it first fails with kernel 5.16
> 
> Additional builds:
> The click mini l9w-b still works with kernel 5.10.y LTS and 5.15.y LTS.
> 
> Important remark:
> Touchscreen still works fine with kernel 6.1.4 using  
> - an HP x2 detachable 10-p0xx or
> - a Lenovo yoga 520-14ikb
> 
> So it could be a hardware dependent issue

See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.15..v5.16
https://bugzilla.kernel.org/show_bug.cgi?id=216946
#regzbot title: hid: touchscreen broken with Toshiba satellite click
mini l9w-b
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
