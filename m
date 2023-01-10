Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98272663B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjAJIlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbjAJIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:41:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC4DCD;
        Tue, 10 Jan 2023 00:41:15 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFABy-0001qE-SY; Tue, 10 Jan 2023 09:41:10 +0100
Message-ID: <0078a5ff-2bc5-4b14-2735-1641feb46544@leemhuis.info>
Date:   Tue, 10 Jan 2023 09:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
Content-Language: en-US, de-DE
To:     Felix Fietkau <nbd@nbd.name>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, spasswolf@web.de
References: <252b1fe4-ccc2-4ea8-1da5-9a60f7378fd6@leemhuis.info>
 <BD7074C5-20BE-4D70-824B-0994892C995D@nbd.name>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <BD7074C5-20BE-4D70-824B-0994892C995D@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673340075;8c646eff;
X-HE-SMSGID: 1pFABy-0001qE-SY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.01.23 09:00, Felix Fietkau wrote:
> 
>> On 10. Jan 2023, at 08:17, Linux kernel regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> ﻿[CCing spasswolf@web.de]
>>
>>> On 09.01.23 08:32, Linux kernel regression tracking (Thorsten Leemhuis)
>>> wrote:
>>>> On 04.01.23 15:20, Thorsten Leemhuis wrote:
>>>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>>>> to make this easily accessible to everyone.
>>>>
>>>> Felix, Lorenzo, did below fix for the regression
>>>
>>> There is another report about an issue with mediatek wifi in 6.2-rc:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216901
>>
>> FWIW, "spasswolf" in that ticket posted a patch that according to the
>> reporter of that bug fixes the issue:
>> https://bugzilla.kernel.org/show_bug.cgi?id=216901#c5
>>
>> I only took a brief look, but it seems it does a subset of what Felix
>> patch does.
>>
>>> To me this looks like a duplicate of the report that started this thread.
>>>
>>> (side note: there was another, earlier report that might be a dupe, too:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216829 )>
>>>> Mikhail reported make
>>>> any progress to get mainlined? It doesn't look like it from here, but I
>>>> suspect I missed something, that's why I'm asking.
>>>
>>> No reply. :-((
>>
>> Still no reply. I wonder if I'm holding things wrong. But well, let's
>> wait one more day before escalating this further.
> 
> Johannes told me on IRC that he will review my patch soon. He simply has too many things to do at the moment.

Great, thx. And sorry for prodding so much, but that is part of the job
when it takes so long to fix regressions -- even in cases where that's
mainly caused by a holiday season (which I took into account, otherwise
I likely would have made more noise earlier already).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
