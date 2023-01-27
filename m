Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAB67E50F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjA0MXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjA0MWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:22:38 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DD7EFF2;
        Fri, 27 Jan 2023 04:20:02 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pLN21-0002rS-UX; Fri, 27 Jan 2023 12:36:33 +0100
Message-ID: <37e7c161-fb66-b49c-78c6-c6349774800a@leemhuis.info>
Date:   Fri, 27 Jan 2023 12:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
 #forregzbot
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
To:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <7910b036-d639-0e1f-4638-fce5497487a7@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <7910b036-d639-0e1f-4638-fce5497487a7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674822002;021dca91;
X-HE-SMSGID: 1pLN21-0002rS-UX
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 22.12.22 13:36, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 21.12.22 02:10, Mikhail Gavrilov wrote:
>> Hi,
>> The kernel 6.2 preparation cycle has begun.
>> And after the kernel was updated on my laptop, the wifi stopped working.
>>
>> Bisecting blames this commit:
>> cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae is the first bad commit
>> commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
>> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>> Date:   Sat Nov 12 16:40:35 2022 +0100
>>
>>     wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf
>>
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot introduced cd372b8c99c5a5 ^
> https://bugzilla.kernel.org/show_bug.cgi?id=216829
> #regzbot title wifi: mt76: wifi stopped working
> #regzbot ignore-activity
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

Regzbot for some reason missed to notice the fix properly, so point to
it manually:

#regzbot fix 953519b35227
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

