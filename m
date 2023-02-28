Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830BE6A5B71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjB1PMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB1PMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:12:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B528864;
        Tue, 28 Feb 2023 07:11:56 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pX1dy-00083M-0G; Tue, 28 Feb 2023 16:11:54 +0100
Message-ID: <5671584b-011c-f0a1-a013-e05e388c9f1f@leemhuis.info>
Date:   Tue, 28 Feb 2023 16:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [regression] Bug 216946 - Toshiba satellite click mini l9w-b:
 touchscreen: no touch events with kernel 6.1.4
Content-Language: en-US, de-DE
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Hans De Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?G=c3=a9_Koerkamp?= <ge.koerkamp@gmail.com>
References: <32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info>
 <abb495f7-f973-4614-846b-d3922dc0fe25@leemhuis.info>
 <CAO-hwJJ2OMFgpmrXK_Z43z0ddujaS1fNjaAJSWwao4qQN+pJ6w@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAO-hwJJ2OMFgpmrXK_Z43z0ddujaS1fNjaAJSWwao4qQN+pJ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677597116;74fe23a5;
X-HE-SMSGID: 1pX1dy-00083M-0G
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.23 14:26, Benjamin Tissoires wrote:
> On Tue, Feb 28, 2023 at 12:32 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 19.01.23 16:06, Linux kernel regression tracking (Thorsten Leemhuis)
>> wrote:
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>> kernel developer don't keep an eye on it, I decided to forward it by
>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216946 :
>>
>> The reporter recently confirmed in the ticket that the issue still
>> happens with 6.2.
>>
>> There wasn't any reply from any of the input developers here or in
>> bugzilla afaics. :-/ Hmmm. Could someone from that camp maybe please
>> take a minute and at least briefly look into this as answer something
>> like "that might be due to a problem in subsystem 'foo'", "maybe ask bar
>> for an option", or "we have no idea what might cause this, this needs to
>> be bisected"? That would help a lot.
> 
> The working dmesg shows a line with:
> hid-generic 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00 Device
> [SIS0817:00 0457:10FB] on i2c-SIS0817:00
> and then
> hid-multitouch 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00
> Device [SIS0817:00 0457:10FB] on i2c-SIS0817:00
> 
> But these 2 lines do not appear on the 6.1.4 logs.
> 
> So the device is not properly enumerated by ACPI or I2C. Hans might
> have an idea on how to debug/solve that issue.
> 
> Also there were no changes between v5.15 and v5.16 in i2c-hid.ko, so
> it's unlikely to be an issue there (unless '5.16' means '5.16.x').

Great, many thx for your help!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>>>  Gé Koerkamp 2023-01-17 20:21:51 UTC
>>>>
>>>> Created attachment 303619 [details]
>>>> Kernel configuration for v6.1.4/ journalctl (dmesg)/ ACPIdump/lsmod
>>>>
>>>> Overview:
>>>> The touchscreen does not react on touch events.
>>>> Touchscreen display and touchpad are working.
>>>>
>>>> Step to reproduce:
>>>> Open any UI page
>>>> Try to use touch on relevant UI controls (buttons etc.)
>>>>
>>>> Result:
>>>> No reaction on screen touches
>>>>
>>>> Expected result:
>>>> Reaction on touched control, same as when using the touch pad or connected mouse (which do work).
>>>>
>>>> Build information:
>>>> The error happens with kernel version 6.1.4
>>>> After rebuilding with different kernel versions, it appears that it first fails with kernel 5.16
>>>>
>>>> Additional builds:
>>>> The click mini l9w-b still works with kernel 5.10.y LTS and 5.15.y LTS.
>>>>
>>>> Important remark:
>>>> Touchscreen still works fine with kernel 6.1.4 using
>>>> - an HP x2 detachable 10-p0xx or
>>>> - a Lenovo yoga 520-14ikb
>>>>
>>>> So it could be a hardware dependent issue
>>>
>>> See the ticket for more details.
>>>
>>>
>>> [TLDR for the rest of this mail: I'm adding this report to the list of
>>> tracked Linux kernel regressions; the text you find below is based on a
>>> few templates paragraphs you might have encountered already in similar
>>> form.]
>>>
>>> BTW, let me use this mail to also add the report to the list of tracked
>>> regressions to ensure it's doesn't fall through the cracks:
>>>
>>> #regzbot introduced: v5.15..v5.16
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216946
>>> #regzbot title: hid: touchscreen broken with Toshiba satellite click
>>> mini l9w-b
>>> #regzbot ignore-activity
>>>
>>> This isn't a regression? This issue or a fix for it are already
>>> discussed somewhere else? It was fixed already? You want to clarify when
>>> the regression started to happen? Or point out I got the title or
>>> something else totally wrong? Then just reply and tell me -- ideally
>>> while also telling regzbot about it, as explained by the page listed in
>>> the footer of this mail.
>>>
>>> Developers: When fixing the issue, remember to add 'Link:' tags pointing
>>> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
>>> this thread sees some discussion). See page linked in footer for details.
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>> --
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.
>>
> 
> 
> 
