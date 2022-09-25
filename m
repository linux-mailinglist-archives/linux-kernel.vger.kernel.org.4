Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF025E9168
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 09:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiIYHVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIYHVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 03:21:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF13AE43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 00:21:29 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ocLx7-0008VJ-5R; Sun, 25 Sep 2022 09:21:25 +0200
Message-ID: <646ff571-81b1-346d-97ba-3e85e6805af1@leemhuis.info>
Date:   Sun, 25 Sep 2022 09:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: v6.0-rc6 - arm64 / rock960 : kernel panic #forregzbot
In-Reply-To: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664090489;b5012f8e;
X-HE-SMSGID: 1ocLx7-0008VJ-5R
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 24.09.22 19:43, Daniel Lezcano wrote:
> Hi,
> 
> there is a kernel panic on a rock960 board:
> 
> After git bisecting, I have:
> 
> commit 14facbc1871ae15404666747b5319c08e04b875a
> Merge: f5c97da8037b 32346491ddf2
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Mon Jul 11 08:32:58 2022 +0200
> 
>     Merge 5.19-rc6 into char-misc-next
> 
>     We need the misc driver fixes in here as well.
> 
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Any clue?

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 14facbc1871ae154046
#regzbot title arm64 / rock960 : kernel panic (NULL pointer dereference)
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> [    2.377386] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000005
> [    2.377390] Mem abort info:
> [    2.377392]   ESR = 0x0000000096000004
> [    2.379529]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    2.379994]   SET = 0, FnV = 0
> [    2.380263]   EA = 0, S1PTW = 0
> [    2.380538]   FSC = 0x04: level 0 translation fault
> [    2.380964] Data abort info:
> [    2.381217]   ISV = 0, ISS = 0x00000004
> [    2.381343] mmc2: SDHCI controller on fe330000.mmc [fe330000.mmc]
> using ADMA
> [    2.381558]   CM = 0, WnR = 0
> [    2.382426] [0000000000000005] user address but active_mm is swapper
> [    2.382981] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    2.383468] Modules linked in:
> [    2.383740] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc6+ #728
> [    2.384311] Hardware name: 96boards Rock960 (DT)
> [    2.384715] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    2.385323] pc : pinctrl_lookup_state+0x20/0xc0
> [    2.385729] lr : rockchip_i2s_probe+0x1a8/0x54c
> [    2.386130] sp : ffff80000804bb30
> [    2.386420] x29: ffff80000804bb30 x28: 0000000000000000 x27:
> ffff800009f204c8
> [    2.387048] x26: ffff800009fc1060 x25: ffff800009fc1078 x24:
> ffff000002691b68
> [    2.387673] x23: ffff800009967938 x22: ffffffffffffffed x21:
> ffff800009e1e0e8
> [    2.388299] x20: ffffffffffffffed x19: ffff000002597480 x18:
> ffffffffffffffff
> [    2.388924] x17: 000000040044ffff x16: 00400034b5503510 x15:
> ffff80008804b787
> [    2.389550] x14: 0000000000000000 x13: 6c7274636e697020 x12:
> 73326920646e6966
> [    2.390176] x11: 206f742064656c69 x10: 6166203a7332692e x9 :
> 656c696166203a73
> [    2.390801] x8 : 32692e3030303061 x7 : 205d363238363733 x6 :
> ffff000001657880
> [    2.391425] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> 0000000000000000
> [    2.392051] x2 : 0000000000000000 x1 : ffff800009e1e0e8 x0 :
> ffffffffffffffed
> [    2.392677] Call trace:
> [    2.392892]  pinctrl_lookup_state+0x20/0xc0
> [    2.393261]  rockchip_i2s_probe+0x1a8/0x54c
> [    2.393629]  platform_probe+0x68/0xe0
> [    2.393954]  really_probe.part.0+0x9c/0x2ac
> [    2.394321]  __driver_probe_device+0x98/0x144
> [    2.394703]  driver_probe_device+0xac/0x140
> [    2.395070]  __driver_attach+0xf8/0x1a0
> [    2.395407]  bus_for_each_dev+0x70/0xd0
> [    2.395746]  driver_attach+0x24/0x30
> [    2.396063]  bus_add_driver+0x150/0x200
> [    2.396401]  driver_register+0x78/0x130
> [    2.396737]  __platform_driver_register+0x28/0x34
> [    2.397150]  rockchip_i2s_driver_init+0x1c/0x28
> [    2.397550]  do_one_initcall+0x50/0x1c0
> [    2.397890]  kernel_init_freeable+0x208/0x28c
> [    2.398274]  kernel_init+0x28/0x13c
> [    2.398583]  ret_from_fork+0x10/0x20
> [    2.398901] Code: aa0003f4 a9025bf5 aa0003f6 aa0103f5 (f8418e93)
> [    2.399435] ---[ end trace 0000000000000000 ]---
> [    2.399887] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    2.400555] SMP: stopping secondary CPUs
> [    2.400984] Kernel Offset: 0x80000 from 0xffff800008000000
> [    2.401463] PHYS_OFFSET: 0x0
> [    2.401716] CPU features: 0x800,00127811,00001082
> [    2.402128] Memory Limit: none
> [    2.402406] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
> 
> 
