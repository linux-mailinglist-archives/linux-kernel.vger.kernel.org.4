Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F396562D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiLZNT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:19:26 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806B21BE;
        Mon, 26 Dec 2022 05:19:25 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p9nNz-00041d-7W; Mon, 26 Dec 2022 14:19:23 +0100
Message-ID: <fdc65b23-df50-cce0-35ad-4b6ec6527321@leemhuis.info>
Date:   Mon, 26 Dec 2022 14:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] spi: mediatek: Enable irq when pdata is ready #forregzbot
Content-Language: en-US, de-DE
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221128-spi-mt65xx-v1-0-509266830665@chromium.org>
 <166965653185.677424.5326738316899525692.b4-ty@kernel.org>
 <Y6dL2ZWgd1BD6kew@makrotopia.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y6dL2ZWgd1BD6kew@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672060765;c8656021;
X-HE-SMSGID: 1p9nNz-00041d-7W
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

Hi, this is your Linux kernel regression tracker.

On 24.12.22 20:02, Daniel Golle wrote:

>> [1/1] spi: mediatek: Enable irq when pdata is ready
>>       commit: c6f7874687f7027d7c4b2f53ff6e4d22850f915d
>>
> 
> Testing next-20221220 on the BananaPi BPi-R3 MT7986 board it turns
> out that this commit is *causing* a kernel oops and strack trace output
> actually quite similar to what is described in the commit message:

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced c6f7874687f7027d7c4b2f53ff6e4d228
#regzbot title spi: mediatek: oops due to race
#regzbot monitor:
https://lore.kernel.org/all/Y6hZA19rWuDkGJa2@makrotopia.org/
#regzbot fix: spi: mediatek: Enable irq before the spi registration
#regzbot ignore-activity


Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
