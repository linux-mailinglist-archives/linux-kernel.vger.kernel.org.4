Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AAA744985
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGAOLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGAOLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:11:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389A1FE7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 07:10:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qFbJR-0003hS-LL; Sat, 01 Jul 2023 16:10:57 +0200
Message-ID: <ef88e1e0-1276-971d-6302-13890cec9cac@leemhuis.info>
Date:   Sat, 1 Jul 2023 16:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: commit 9df9d2f0471b causes boot failure in pre-rc1 6.5
 kernel
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4d9fb4a9-6c48-600c-f625-8ef66208090a@gmail.com>
 <ZKAboYIj6pAd9CMO@debian.me>
 <74014a7a-7d91-0854-8002-faf32d9c65e1@leemhuis.info>
 <e65bf45f-72c5-7239-6caa-609f3c9f24d2@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <e65bf45f-72c5-7239-6caa-609f3c9f24d2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688220659;b5a69f8f;
X-HE-SMSGID: 1qFbJR-0003hS-LL
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropping people from CC that likely don't care]

On 01.07.23 15:42, Bagas Sanjaya wrote:
> On 7/1/23 19:43, Linux regression tracking #update (Thorsten Leemhuis) wrote:
>> On 01.07.23 14:27, Bagas Sanjaya wrote:
>>> On Wed, Jun 28, 2023 at 09:06:22PM +0700, Bagas Sanjaya wrote:
>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>> [....]
>>>> See Bugzilla for the full thread.
>>>>
>>>> #regzbot introduced: 9df9d2f0471b https://bugzilla.kernel.org/show_bug.cgi?id=217602
>>>> #regzbot title: early arch_cpu_finalize_init() cause immediate boot failure
>>> #regzbot fix: 0303c9729afc40
>>
>> Bagas, FWIW, there was no need for this at all. Regzbot would have
>> noticed that patch automatically due to the "Link:
>> https://bugzilla.kernel.org/show_bug.cgi?id=217602" in the patch
>> description (thx for this, tglx) once it landed in next or mainline
>> (just like it noticed
>> https://lore.kernel.org/lkml/168813193932.404.2885732890333911092.tip-bot2@tip-bot2/
>> earlier).
> 
> OK, thanks for another tip! I was doing above because at the time
> regzbot doesn't mark the regression as solved, so I had to manually
> told it.

regzbot could notice this sooner by monitoring all the for-linus and
for-next subsystem development trees. But I'm not sure if that's worth
it, because normally things that land there show up in -next within 24
hours anyway.

Ciao, Thorsten

