Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62F5BBD5A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIRKDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiIRKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:02:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFC613CDF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:02:27 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oZr84-0008J5-PT; Sun, 18 Sep 2022 12:02:24 +0200
Message-ID: <a169ec3c-b8c1-7be9-fbbf-3424fb6dbf99@leemhuis.info>
Date:   Sun, 18 Sep 2022 12:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Regression in v5.19-rc4 Sound Distortion #forregzbot
Content-Language: en-US, de-DE
To:     Daniel Exner <dex@dragonslave.de>
References: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
 <9404d20b-1abc-78dc-d257-521c80f48b3a@dragonslave.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <9404d20b-1abc-78dc-d257-521c80f48b3a@dragonslave.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663495347;d2a0e210;
X-HE-SMSGID: 1oZr84-0008J5-PT
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[trimmed the list of recipients]

On 16.09.22 22:34, Daniel Exner wrote:
>
> Something in between 6.0.0-rc3 and 6.0.0-rc4 fixed this issue for me.

Thx for letting us know!

#regzbot invalid: fixed Something in between 6.0.0-rc3 and 6.0.0-rc4
fixed this issue

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

>> Hi everyone,
>>
>>
>> (please keep me CC as I am currently not subscribed to LKML)
>>
>>
>> Since  v5.19-rc4 this box got some *loud* distorting sound on boot and
>> after some time without any sound if something plays sound again from
>> the integrated speakers in my monitor.
>>
>>
>> I managed to bisect this down to:
>>
>>> commit 202773260023b56e868d09d13d3a417028f1ff5b
>>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Date:   Fri Jun 17 15:24:02 2022 +0300
>>>
>>>    PM: hibernate: Use kernel_can_power_off()
>>>
>>
>> Reverting that commit on top of v5.19-rc6 does indeed fix the problem
>> here.
>>
>> Any ideas?
>>
>>
>> Greetings,
>>
>> Daniel
>>
> 
> 
