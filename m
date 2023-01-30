Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE89E680865
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjA3JWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjA3JWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:22:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F162114227;
        Mon, 30 Jan 2023 01:22:18 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pMQMj-0007zj-6n; Mon, 30 Jan 2023 10:22:17 +0100
Message-ID: <2f4dc626-5287-6ec7-a31d-335e5dbb9119@leemhuis.info>
Date:   Mon, 30 Jan 2023 10:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        jessegodfroy@gmail.com
To:     Jiri Kosina <jikos@kernel.org>,
        "Benjamin Tissoires <benjamin.tissoires"@redhat.com
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 216977 - asus t100 touchpad registered but not
 working
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675070539;b0e883af;
X-HE-SMSGID: 1pMQMj-0007zj-6n
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
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216977 :

>  jessegodfroy@gmail.com 2023-01-29 15:44:34 UTC
> 
> After upgrading the kernel from 6.0 series to the 6.1 the touchpad on my asus t100 no longer works. 
> 
> The device is registered in dmesg. I believe hid_asus is responsible for the keyboard and touchpad.  The keyboard continues to function, but the touchpad does not. 
> 
> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0001: input,hidraw0: USB HID v1.11 Keyboard [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input0
> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0002: Fixing up Asus T100 keyb report descriptor
> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0002: input,hiddev96,hidraw1: USB HID v1.11 Device [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input1
> Jan 29 09:29:53 t100ta-white kernel: asus 0003:0B05:17E0.0003: input,hiddev97,hidraw2: USB HID v1.11 Mouse [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input2
> 
> I do not see any changes to hid_asus that should be responsible for the change in performance.
See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.0..v6.1
https://bugzilla.kernel.org/show_bug.cgi?id=216977
#regzbot title: input: hid: asus t100 touchpad registered but not working
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
