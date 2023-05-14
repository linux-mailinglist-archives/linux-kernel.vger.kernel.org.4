Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC86701D91
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjENNPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:15:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6EB26B9
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:15:04 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pyBYx-0002s7-Ao; Sun, 14 May 2023 15:14:59 +0200
Message-ID: <f2176adc-cc2f-4752-2c7e-102b73b55696@leemhuis.info>
Date:   Sun, 14 May 2023 15:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Kernel 6.4-rc1 ARM boot fails
Content-Language: en-US, de-DE
To:     Colin Foster <colin.foster@in-advantage.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZFs6DNgzBHNarr6D@euler>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <ZFs6DNgzBHNarr6D@euler>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684070104;7292f688;
X-HE-SMSGID: 1pyBYx-0002s7-Ao
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 10.05.23 08:30, Colin Foster wrote:
> 
> I just wanted to give a heads up. I tested 6.4-rc1 on a Beaglebone Black
> and kept getting boot hangs. A bisect led me to commit c76c6c4ecbec ("ARM:
> 9294/2: vfp: Fix broken softirq handling with instrumentation enabled").
>
> The dying message is "Run /sbin/init as init process"
> 
> I'm not sure if this has already been reported. I was able to revert this
> patch and confirm things work again.
> [...]

Thanks for the report. I know a fix is incoming, but to be sure the
issue doesn't fall through the cracks unnoticed, I'm adding it to
regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced c76c6c4ecbec
#regzbot title arm32: tons of different boot time errors
#regzbot ignore-activity
#regzbot monitor:
https://lore.kernel.org/all/000000000000d3001a05faf979c8@google.com/
#regzbot fix ARM: 9297/1: vfp: avoid unbalanced stack on 'success'
return path
#regzbot monitor:
https://lore.kernel.org/all/20230506161325.223362-1-ardb@kernel.org/


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
