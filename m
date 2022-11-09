Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566B46228FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiKIKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKIKsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:48:24 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1EB9F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:48:22 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1osid3-0002Wm-8p; Wed, 09 Nov 2022 11:48:21 +0100
Message-ID: <7ebd090d-4a6c-1a26-6e31-b0554c627e83@leemhuis.info>
Date:   Wed, 9 Nov 2022 11:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: INFO: rcu_preempt detected expedited stalls on CPUs/tasks
 (6.1.0-rc3): in cat /sys/kernel/debug/kmemleak #forregzbot
Content-Language: en-US, de-DE
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <e048a5c5-dea5-a31a-1022-1b007e022adb@alu.unizg.hr>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e048a5c5-dea5-a31a-1022-1b007e022adb@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667990902;73b09c28;
X-HE-SMSGID: 1osid3-0002Wm-8p
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

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 04.11.22 23:01, Mirsad Goran Todorovac wrote:
> 
> When investigating thermald kmemleak, it occurred that the "cat
> /sys/kernel/debug/kmemleak"
> and "tail -20 /sys/kernel/debug/kmemleak" commands take unusual amount
> of time.
> 
> Dmesg output showed expedited stalls that the commands caused NMIs and
> NMI backtraces:
> 
> [ 8123.263464] rcu: INFO: rcu_preempt detected expedited stalls on
> CPUs/tasks: { 0-.... } 26 jiffies s: 3829 root: 0x1/.
> [ 8123.263500] rcu: blocking rcu_node structures (internal RCU debug):
> [ 8123.263508] Sending NMI from CPU 7 to CPUs 0:
> [ 8123.263528] NMI backtrace for cpu 0
> [ 8123.263539] CPU: 0 PID: 27898 Comm: cat Not tainted 6.1.0-rc3 #1
> [ 8123.263552] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN34WW
> 03/08/2022

#regzbot ^introduced 28b3ae426598e
#regzbot title rcu: thermald causes a kmemleak
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
