Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B00636435
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiKWPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiKWPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:43:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A7272108
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:43:44 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oxruY-0006tm-Dd; Wed, 23 Nov 2022 16:43:42 +0100
Message-ID: <038cecb9-aab2-bcd7-f003-46ca637942d8@leemhuis.info>
Date:   Wed, 23 Nov 2022 16:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Regression bisected: drm/display/dp_mst: Move all payload info
 into the atomic state #forregzbot
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <ghwn827862.fsf@gouders.net>
 <45ca4839-fa2a-9511-fd47-2d75fa3766cd@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <45ca4839-fa2a-9511-fd47-2d75fa3766cd@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669218224;d86dd60e;
X-HE-SMSGID: 1oxruY-0006tm-Dd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

On 13.11.22 10:28, Thorsten Leemhuis wrote:
> On 10.11.22 23:32, Dirk Gouders wrote:
>>
>> I noticed a regression with Linus' current tree and bisected it to
>> 4d07b0bc403403 (drm/display/dp_mst: Move all payload info into the atomic state):
>>
>> I have two monitors connected to my laptop's USB-C port and since this
>> patch, one of the monitors remains dark.
>>
>> Please let me know if I can provide additional information that could help
>> to investigate this problem.
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot introduced 4d07b0bc403403 ^
> https://gitlab.freedesktop.org/drm/amd/-/issues/2171
> #regzbot title drm: amdgpu: No payload for [MST PORT:0000000006da5d29]
> found in mst state 00000000b0e556d6" on system resume with TBT dock
> connected.
> #regzbot ignore-activity

#regzbot fixed-by: d60b82aa
