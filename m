Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B86A9276
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCCIbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:31:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6294C1C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:31:48 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pY0pL-0005rW-So; Fri, 03 Mar 2023 09:31:43 +0100
Message-ID: <3bcbba4f-6f40-51d0-10ed-692e32f630e4@leemhuis.info>
Date:   Fri, 3 Mar 2023 09:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] mmap with MAP_32BIT randomly fails since 6.1
Content-Language: en-US, de-DE
To:     Snild Dolkow <snild@sony.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677832308;21d8e093;
X-HE-SMSGID: 1pY0pL-0005rW-So
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 02.03.23 16:32, Snild Dolkow wrote:
> After upgrading a machine from 5.17.4 to 6.1.12 a couple of weeks ago, I
> started getting (inconsistent) failures when building Android:
> [...]
> I have checked a more recent master commit (ee3f96b1, from March 1st),
> and the problem is still there. Bisecting shows that e15e06a8 is the
> last good commit, and that 524e00b3 is the first one failing in this
> way. The 10 or so commits in between run into a page fault BUG down in
> vma_merge() instead.
> 
> This range of commits is about the same as mentioned in
> https://lore.kernel.org/lkml/0b9f5425-08d4-8013-aa4c-e620c3b10bb2@leemhuis.info/, so I assume that my problem, too, was introduced with the Maple Tree changes. Sending this to the same people and lists.
> 

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced e15e06a8..524e00b3
#regzbot title mm: mmap with MAP_32BIT randomly fails since 6.1
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
