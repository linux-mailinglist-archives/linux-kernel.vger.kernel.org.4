Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063825E9879
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 06:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiIZElD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 00:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIZElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 00:41:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BAF22533
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:41:00 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ocfvL-00013U-Ev; Mon, 26 Sep 2022 06:40:55 +0200
Message-ID: <10c29d1e-4048-acb8-891e-dcd5103ab355@leemhuis.info>
Date:   Mon, 26 Sep 2022 06:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: v6.0-rc6 - arm64 / rock960 : kernel panic #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
 <646ff571-81b1-346d-97ba-3e85e6805af1@leemhuis.info>
In-Reply-To: <646ff571-81b1-346d-97ba-3e85e6805af1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664167260;0b27b3d1;
X-HE-SMSGID: 1ocfvL-00013U-Ev
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.22 09:21, Thorsten Leemhuis wrote:
> TWIMC: this mail is primarily send for documentation purposes and for
> regzbot, my Linux kernel regression tracking bot. These mails usually
> contain '#forregzbot' in the subject, to make them easy to spot and filter.
> 
> [TLDR: I'm adding this regression report to the list of tracked
> regressions; all text from me you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.]
> 
> Hi, this is your Linux kernel regression tracker.
> 
> On 24.09.22 19:43, Daniel Lezcano wrote:
>> Hi,
>>
>> there is a kernel panic on a rock960 board:
>>
>> After git bisecting, I have:
>>
>> commit 14facbc1871ae15404666747b5319c08e04b875a
>> Merge: f5c97da8037b 32346491ddf2
>> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Date:   Mon Jul 11 08:32:58 2022 +0200
>>
>>     Merge 5.19-rc6 into char-misc-next
>>
>>     We need the misc driver fixes in here as well.
>>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Any clue?
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 14facbc1871ae154046

Per
https://lore.kernel.org/all/CAMdYzYrqVSNmOASDUXK0MaJVy56gmRkHweb9Bs7J76O4HZn2NQ@mail.gmail.com/
and its parent:

#regzbot introduced: 8dc60f8da22fdb
#regzbot fixed-by: f340ed8664a55a4

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
