Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8C68AF5C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBEKkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 05:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 05:40:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2C21291
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:40:03 -0800 (PST)
Received: from [2001:67c:1810:f055:bde0:6d5b:d664:e19a]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pOcRE-0008GF-PU; Sun, 05 Feb 2023 11:40:00 +0100
Message-ID: <87a0dd2b-9fb3-5587-7617-efbe21eb321e@leemhuis.info>
Date:   Sun, 5 Feb 2023 11:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
Content-Language: en-US, de-DE
To:     Christian Kujau <lists@nerdbynature.de>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info>
 <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675593603;9214ef34;
X-HE-SMSGID: 1pOcRE-0008GF-PU
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 31.01.23 23:50, Christian Kujau wrote:
> [Leaving the full quote below for reference and adding more appropriate people.]
> 
> After a far too long round of git-bisect I narrowed it down to:
> 
>   c1c59538337ab6d45700cb4a1c9725e67f59bc6e is the first bad commit
> 
>     x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case
>     commit 90b926e68f500844dff16b5bcea178dc55cf580a upstream.
> 
> And indeed, reverting this single commit from v6.1.8 (stable) makes the 
> disks appear again.
> [...]

In that case let me update the tracking state:

#regzbot introduced: 90b926e68f500844dff16b5bcea178dc55cf5
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
