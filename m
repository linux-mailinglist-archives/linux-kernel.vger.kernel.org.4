Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA6744901
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGAMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 08:43:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826913C07
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 05:43:23 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qFZwY-0008Rn-Ao; Sat, 01 Jul 2023 14:43:14 +0200
Message-ID: <74014a7a-7d91-0854-8002-faf32d9c65e1@leemhuis.info>
Date:   Sat, 1 Jul 2023 14:43:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: commit 9df9d2f0471b causes boot failure in pre-rc1 6.5
 kernel
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <4d9fb4a9-6c48-600c-f625-8ef66208090a@gmail.com>
 <ZKAboYIj6pAd9CMO@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZKAboYIj6pAd9CMO@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688215403;a88872ab;
X-HE-SMSGID: 1qFZwY-0008Rn-Ao
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.23 14:27, Bagas Sanjaya wrote:
> On Wed, Jun 28, 2023 at 09:06:22PM +0700, Bagas Sanjaya wrote:
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> [....]
>> See Bugzilla for the full thread.
>>
>> The reporter can't provide requested dmesg due to this is early
>> boot failure, unfortunately.
>>
>> Nevertheless, this regression has already been taken care of on
>> Bugzilla, but to ensure it is tracked and doesn't get fallen through
>> cracks unnoticed, I'm adding it to regzbot:
>>
>> #regzbot introduced: 9df9d2f0471b https://bugzilla.kernel.org/show_bug.cgi?id=217602
>> #regzbot title: early arch_cpu_finalize_init() cause immediate boot failure
> 
> #regzbot fix: 0303c9729afc40

Bagas, FWIW, there was no need for this at all. Regzbot would have
noticed that patch automatically due to the "Link:
https://bugzilla.kernel.org/show_bug.cgi?id=217602" in the patch
description (thx for this, tglx) once it landed in next or mainline
(just like it noticed
https://lore.kernel.org/lkml/168813193932.404.2885732890333911092.tip-bot2@tip-bot2/
earlier).

Ciao, Thorsten

