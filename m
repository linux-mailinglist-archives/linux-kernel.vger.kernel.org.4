Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57817743C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjF3NF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3NFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:05:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC135B0;
        Fri, 30 Jun 2023 06:05:54 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qFDou-00048d-Qv; Fri, 30 Jun 2023 15:05:52 +0200
Message-ID: <fed91877-6b55-efc1-76b3-e562f4c6914d@leemhuis.info>
Date:   Fri, 30 Jun 2023 15:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ACPI: resource: Add IRQ override for MECHREV Jiaolong17KS
Content-Language: en-US, de-DE
To:     Li Chen <me@linux.beauty>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <1890c3fa24c.d101fdf01298845.3731868257024939195@linux.beauty>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <1890c3fa24c.d101fdf01298845.3731868257024939195@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688130354;f58e8b8a;
X-HE-SMSGID: 1qFDou-00048d-Qv
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing mario and the regressions list]

On 30.06.23 14:20, Li Chen wrote:
> Fix a regression introduced by commit 9946e39fe8d0 ("ACPI: resource: skip
> IRQ override on AMD Zen platforms") on MECHREV Jiaolong17KS, which
> causes the built-in keyboard to not work. This restores the functionality
> by adding an IRQ override.
> 
> I have personally tested this on the 17" model but I'm not sure if this
> issue is present on the 16 model.
> 
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
> Signed-off-by: Li Chen <me@linux.beauty>

Not my area of expertise (so take this with a gain of salt), but I'm
aware of something that afaics concerns this:

A few days ago a patch was merged to mainline that afaics hopefully
might make a change like your unnecessary.  See a9c4a912b7d ("ACPI:
resource: Remove "Zen" specific match and quirks") in mainline or here:
https://lore.kernel.org/all/20230601221151.670-1-mario.limonciello@amd.com/

Might be worth giving a try.

There is a rough plan to backport this to stable kernels, unless
problems show up.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
