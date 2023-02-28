Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2666A5821
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjB1Lcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB1Lct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:32:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DE131;
        Tue, 28 Feb 2023 03:32:46 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pWyDt-0001z7-Fu; Tue, 28 Feb 2023 12:32:45 +0100
Message-ID: <abb495f7-f973-4614-846b-d3922dc0fe25@leemhuis.info>
Date:   Tue, 28 Feb 2023 12:32:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [regression] Bug 216946 - Toshiba satellite click mini l9w-b:
 touchscreen: no touch events with kernel 6.1.4
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        =?UTF-8?Q?G=c3=a9_Koerkamp?= <ge.koerkamp@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info>
In-Reply-To: <32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677583967;aaf6d2ae;
X-HE-SMSGID: 1pWyDt-0001z7-Fu
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.23 16:06, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216946 :

The reporter recently confirmed in the ticket that the issue still
happens with 6.2.

There wasn't any reply from any of the input developers here or in
bugzilla afaics. :-/ Hmmm. Could someone from that camp maybe please
take a minute and at least briefly look into this as answer something
like "that might be due to a problem in subsystem 'foo'", "maybe ask bar
for an option", or "we have no idea what might cause this, this needs to
be bisected"? That would help a lot.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
>>  Gé Koerkamp 2023-01-17 20:21:51 UTC
>>
>> Created attachment 303619 [details]
>> Kernel configuration for v6.1.4/ journalctl (dmesg)/ ACPIdump/lsmod
>>
>> Overview: 
>> The touchscreen does not react on touch events.
>> Touchscreen display and touchpad are working.
>>
>> Step to reproduce:
>> Open any UI page
>> Try to use touch on relevant UI controls (buttons etc.)
>>
>> Result:
>> No reaction on screen touches
>>
>> Expected result:
>> Reaction on touched control, same as when using the touch pad or connected mouse (which do work).
>>
>> Build information:
>> The error happens with kernel version 6.1.4
>> After rebuilding with different kernel versions, it appears that it first fails with kernel 5.16
>>
>> Additional builds:
>> The click mini l9w-b still works with kernel 5.10.y LTS and 5.15.y LTS.
>>
>> Important remark:
>> Touchscreen still works fine with kernel 6.1.4 using  
>> - an HP x2 detachable 10-p0xx or
>> - a Lenovo yoga 520-14ikb
>>
>> So it could be a hardware dependent issue
> 
> See the ticket for more details.
> 
> 
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: v5.15..v5.16
> https://bugzilla.kernel.org/show_bug.cgi?id=216946
> #regzbot title: hid: touchscreen broken with Toshiba satellite click
> mini l9w-b
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
