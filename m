Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C26400A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiLBGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiLBGnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:43:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C89E44D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:43:19 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p0zlV-0000PL-Kq; Fri, 02 Dec 2022 07:43:17 +0100
Message-ID: <8d2dbbb5-5816-c1e9-e98c-6c64a8d85f81@leemhuis.info>
Date:   Fri, 2 Dec 2022 07:43:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
 #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <202210181535.7144dd15-yujie.liu@intel.com>
 <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
 <84964891-5a39-adb2-3093-54b716ca94ae@leemhuis.info>
In-Reply-To: <84964891-5a39-adb2-3093-54b716ca94ae@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669963399;c9588390;
X-HE-SMSGID: 1p0zlV-0000PL-Kq
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.22 09:59, Thorsten Leemhuis wrote:
> [Note: this mail is primarily send for documentation purposes and/or for
> regzbot, my Linux kernel regression tracking bot. That's why I removed
> most or all folks from the list of recipients, but left any that looked
> like a mailing lists. These mails usually contain '#forregzbot' in the
> subject, to make them easy to spot and filter out.]
> 
> On 20.10.22 06:23, Nathan Chancellor wrote:
>> [...]
>> For what it's worth, I just bisected a massive and visible performance
>> regression on my Threadripper 3990X workstation to commit f35b5d7d676e
>> ("mm: align larger anonymous mappings on THP boundaries"), which seems
>> directly related to this report/analysis. I initially noticed this
>> because my full set of kernel builds against mainline went from 2 hours
>> and 20 minutes or so to over 3 hours. Zeroing in on x86_64 allmodconfig,
>> which I used for the bisect:
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced f35b5d7d676e59e4
> #regzbot title performance: mm: building Linux with clang takes a lot
> longer (~27 %)
> #regzbot ignore-activity

#regzbot fix: revert "mm: align larger anonymous mappings on THP boundaries"

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
