Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16BD64732F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLHPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiLHPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:34:36 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A550F1F2EE;
        Thu,  8 Dec 2022 07:32:56 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3It3-0000za-DD; Thu, 08 Dec 2022 16:32:37 +0100
Message-ID: <8bcbbce3-13ce-9b5e-38c2-235a93bd18e2@leemhuis.info>
Date:   Thu, 8 Dec 2022 16:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [REGESSION] Bug 216502 - slow crng initialization on Rockchip
 3399 (Friendyarm NanoPi M4) #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org
References: <4deaa04b-f103-9cc4-7946-9ea69afd94d0@leemhuis.info>
In-Reply-To: <4deaa04b-f103-9cc4-7946-9ea69afd94d0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670513578;1afddac2;
X-HE-SMSGID: 1p3It3-0000za-DD
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 18.09.22 14:17, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it my
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216502 :
> 
>> Crng initialization time has significantly increased on Rockchip
>> 3399-based Friendyarm NanoPi M4 in v6.0.0-rc5 compared to v5.18.0 (from
>> 2.36s since rootfs mounted to 8.55s since rootfs mounted). Bisection
>> points at 78c768e619fb ("random: vary jitter iterations based on cycle
>> counter speed"). Manually reverting that commit on top of v6.0.0-rc5
>> fixes the issue. Attached dmesg logs correspond to vanilla v6.0.0-rc5
>> ("bad") and v6.0.0-rc5 with 78c768e619fb reverted ("good").
> See the ticket for more details. Apologies if I forwarded it to the
> wrong folks, I cover a lot of ground and thus sometimes get things
> wrong. :-/
> 
> BTW, I'd also like to add the report to the list of tracked regressions
> to ensure it's doesn't fall through the cracks in the end:
> 
> #regzbot introduced: 78c768e619fb
> https://bugzilla.kernel.org/show_bug.cgi?id=216502
> #regzbot ignore-activity

#regzbot inconclusive: a proper RNG driver for the soc afaics should fix
this, which apparently satisfies the reporter
