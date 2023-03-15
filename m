Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA666BAE52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCOK5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjCOK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:57:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B3E7FD6F;
        Wed, 15 Mar 2023 03:57:05 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pcOoa-0000aX-95; Wed, 15 Mar 2023 11:57:04 +0100
Message-ID: <0968796e-c6a7-0340-09ec-222f2f9b325a@leemhuis.info>
Date:   Wed, 15 Mar 2023 11:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] Bug 216371 - acpi wake up with black screen with msg
 "amd_gpio AMDI0030:00: failed to get iomux index" #forregzbot
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <849a07ba-a53c-3f10-e2ec-25421c1e40ee@leemhuis.info>
 <b6aeaf85-c88f-c526-30c8-e040b99c66ea@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b6aeaf85-c88f-c526-30c8-e040b99c66ea@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678877826;82843baa;
X-HE-SMSGID: 1pcOoa-0000aX-95
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 18.09.22 18:24, Thorsten Leemhuis wrote:
> On 25.08.22 11:42, Thorsten Leemhuis wrote:
> 
>> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216371 :
>>
>>>  neoe 2022-08-17 01:50:41 UTC
>>>
>>> just upgrade from 5.18 to 6.0.0-rc1
>>>
>>> `acpitool -s` 
>>> to set to sleep, it seems a little slow.
>>>
>>> then wake up, black screen,
>>>
>>> everything works fine before.
>>>
>>> AMD 3900X
>>>
>>> [reply] [−] Comment 1 neoe 2022-08-22 02:39:12 UTC
>>>
>>> dmesg
>>>
>>> amd_gpio AMDI0030:00: failed to get iomux index
>> See the ticket for details.
> 
> #regzbot backburner: likely bad bisect and reporter apparently ignoring
> the issue for now

#regzbot inconclusive: likely bad bisect and reporter MIA

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
