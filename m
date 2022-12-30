Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D530659724
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiL3KPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3KPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:15:00 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C61B101D6;
        Fri, 30 Dec 2022 02:14:59 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pBCPh-0003yK-Na; Fri, 30 Dec 2022 11:14:57 +0100
Message-ID: <0cf0fddb-f2e7-80b8-1c08-cf9919a391bd@leemhuis.info>
Date:   Fri, 30 Dec 2022 11:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [linus:master] [kbuild] 3bc753c06d: xfstests.generic.454.fail
 #forregzbot
Content-Language: en-US, de-DE
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <202212291509.704a11c9-oliver.sang@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <202212291509.704a11c9-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672395299;f1484e7f;
X-HE-SMSGID: 1pBCPh-0003yK-Na
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

On 29.12.22 09:49, kernel test robot wrote:
> 
> please be noted we felt quite strange why this change could cause
>   xfstests.generic.454.fail
> but even by rebuild and rerun, the issue seems persistent while keeping clean
> on parent
> 
> daf4218bf8dd9750 3bc753c06dd02a3517c9b498e38
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :10         100%          10:10    xfstests.generic.454.fail
> 
> so we just report out FYI to seek any insights about this.
> 
> 
> Greeting,
> 
> FYI, we noticed xfstests.generic.454.fail due to commit (built with gcc-11):
> 
> commit: 3bc753c06dd02a3517c9b498e3846ebfc94ac3ee ("kbuild: treat char as always unsigned")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]
> 
> in testcase: xfstests
> version: xfstests-x86_64-fb6575e-1_20221226
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: ext4
> 	test: generic-group-22
> 

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 3bc753c06dd02a
#regzbot title ext4/acls: xfstests.generic.454 suddenly fails for the
kernel test robot
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
