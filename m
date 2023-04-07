Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2B6DA928
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbjDGG7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjDGG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F877ED5;
        Thu,  6 Apr 2023 23:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AEB964F09;
        Fri,  7 Apr 2023 06:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53201C4339B;
        Fri,  7 Apr 2023 06:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680850747;
        bh=6bQMsaag/8RMtodYrSbGD3QPkfdn9ox50RbVRIp5JiM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NvXlPqI2kWT7MZvV/5BeBDBKAk6CaxXVKlpObQ0r9AeWn7yWA/QC2uz5qVbLFAj+g
         ERQdD1wpGBlekKdSG/EwD0/4xgFk2hScLx5PAxUIadlr1nvY+N1H4v9o9/ZnfZF1B4
         vZsf8OQLEjog5LV6TYMZ3YCaKS6Ux5JS7d/dzeeRzMucGW+q2q8OaCKTxWz+9wkpMY
         iz8ENaIFFeGxFc2u5pKfjwSP8XLD5NSXkV1WRg3EiXOCkDzAfjMTzbK+gCHnljFzbC
         PLmiYmVl4Qgfns7a4iTXp0l3QkKsLzNgtfqry223WAMWNTikKjvvXURViimZtl6EsS
         G+kyTr3XStETQ==
Message-ID: <ef8c686b-dcc7-c423-cc9a-009d10056134@kernel.org>
Date:   Fri, 7 Apr 2023 08:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] [RESEND] ARM: dts: meson8b: correct uart_B and uart_C
 clock references
Content-Language: en-US
To:     hfdevel@gmx.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <trinity-76c5c0b4-a6f7-4679-a1ef-74e745649355-1680811577008@3c-app-gmx-bap69>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <trinity-76c5c0b4-a6f7-4679-a1ef-74e745649355-1680811577008@3c-app-gmx-bap69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 22:06, hfdevel@gmx.net wrote:
> Resending this patch with proper subject line, corrected distribution and reference to what the patch fixes. Thanks, Neil and Martin, for your guidance!
> 
> commit b3b6a88d2347d2ec9075603920e616836cb46750
> Author: Hans-Frieder Vogt <hfdevel@gmx.net>
> Date:   Thu Apr 6 10:21:49 2023 +0200
> 
>     [PATCH] correct uart_B and uart_C clock references for meson8b

That's not correct patch format. All this above is not part of patch.

> 
> with the current device tree for meson8b, uarts B (e.g. available on pins 8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because they are relying on incorrect clocks.

Start sentences with capital letter.

> This trivial patch changes the references of pclk to the correct CLKID, which allows to use the two uarts.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Fixes: 3375aa77135f ("ARM: dts: meson8b: Fix the UART device-tree schema validation")
> 

Drop blank line

> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  meson8b.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Best regards,
Krzysztof

