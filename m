Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCBC65D521
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbjADOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239557AbjADOJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:09:09 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A11EC5E;
        Wed,  4 Jan 2023 06:08:57 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pD4Rp-00044n-Do; Wed, 04 Jan 2023 15:08:53 +0100
Message-ID: <5db65fd1-575f-df19-0de3-b3e32e4bf1d1@leemhuis.info>
Date:   Wed, 4 Jan 2023 15:08:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] spi: mediatek: Enable irq before the spi registration
Content-Language: en-US, de-DE
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221225-mtk-spi-fixes-v1-0-bb6c14c232f8@chromium.org>
 <167214860344.446872.17166503994226712534.b4-ty@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <167214860344.446872.17166503994226712534.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672841337;3790397a;
X-HE-SMSGID: 1pD4Rp-00044n-Do
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

On 27.12.22 14:43, Mark Brown wrote:
> On Sun, 25 Dec 2022 09:37:12 +0100, Ricardo Ribalda wrote:
>> If the irq is enabled after the spi si registered, there can be a race
>> with the initialization of the devices on the spi bus.
>>
>> Eg:
>> mtk-spi 1100a000.spi: spi-mem transfer timeout
>> spi-nor: probe of spi0.0 failed with error -110
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 0000000000000010
>> ...
>> Call trace:
>>  mtk_spi_can_dma+0x0/0x2c
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: mediatek: Enable irq before the spi registration
>       commit: b24cded8c065d7cef8690b2c7b82b828cce57708
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> [...]

Quick question: why did you queue this for the next merge window? This
change *afaics* is fixing a reported regression (a kernel oops)
introduced this cycle:
https://lore.kernel.org/lkml/Y6dL2ZWgd1BD6kew@makrotopia.org/

Or have I missed or confused something?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot poke
