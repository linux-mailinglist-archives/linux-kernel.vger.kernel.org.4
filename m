Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74AF6992CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBPLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjBPLKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:10:37 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D1CA5F1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:10:30 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSc9k-0002AL-T1; Thu, 16 Feb 2023 12:10:28 +0100
Message-ID: <e503afb9-df36-5b98-6b1b-e1ad3a9d13a7@leemhuis.info>
Date:   Thu, 16 Feb 2023 12:10:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Latest RC causing web browser crash
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Chris McGimpsey-Jones <chrisjones.unixmen@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com>
 <ee9518a8-64ce-142d-ecfd-f560978352b0@leemhuis.info>
In-Reply-To: <ee9518a8-64ce-142d-ecfd-f560978352b0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676545830;39f020fa;
X-HE-SMSGID: 1pSc9k-0002AL-T1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.23 11:11, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> On 28.01.23 02:14, Chris McGimpsey-Jones wrote:
>> Is anyone else with the latest RC having issues with Google Chrome
>> browser, causing it to crash after a couple of minutes?
> FWIW, this is unlikely to get any traction: nearly nobody reads the LKML
> anymore, hence it's unlikely that someone that can help will see it.

FWIW, I pointed to this problem in my weekly reports, but there was no
reaction. That sound like this is something rare which might only happen
on your machine.

Is the problem actually still occuring?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> I reverted (temporarily) back to Linux 6.1.0 and it's fine.
>> Tested a couple of times, the issue can be reproduced.
> 
> Are there any crash dumps that might indicate what might cause the problem?
> 
>> I don't know of the relationship between the kernel and web browser
>> and it seems odd the kernel would cause this problem, but there's no
>> disputing it is the cause as I can reproduce the issue.
> 
> Well, things like this don't happen frequently, but they do happen.
> Without more data it's just very hard to get to the root of this issue,
> as it could be caused by all sorts of things (mm and drm are two most
> likely suspects, but it could be something totally different).
> 
> Could you try to bisect the issue? There are various pages on the net
> that explain how to do that.
