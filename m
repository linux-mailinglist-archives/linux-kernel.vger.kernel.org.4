Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1C612BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 17:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ3Qyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Qyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 12:54:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDCBF1A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 09:54:40 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1opBa3-0008Re-8k; Sun, 30 Oct 2022 17:54:39 +0100
Message-ID: <0d4c6064-4869-f841-0c46-399264474f94@leemhuis.info>
Date:   Sun, 30 Oct 2022 17:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Regression: starting powertop crashes my machine hard since
 838d9bb62d13 ("perf: Use sample_flags for raw_data") #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <6e7f32f2-5397-e0cf-4271-a9826d318996@leemhuis.info>
In-Reply-To: <6e7f32f2-5397-e0cf-4271-a9826d318996@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667148880;f006a150;
X-HE-SMSGID: 1opBa3-0008Re-8k
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

On 25.10.22 20:40, Thorsten Leemhuis wrote:
> Hi! Since 838d9bb62d13 ("perf: Use sample_flags for raw_data") starting
> powertop makes my machine crash hard: keyboard is dead, Sysrq does not
> work, and most of the time there is not even a error message on the
> screen; only once in maybe ~20 cases I got the line "kernel NULL pointer
> dereference, address: 0000000000000010", but nothing else.
>  
> #regzbot introduced 838d9bb62d13

#regzbot fixed-by: 4b66ff46f2e18
