Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D006B289B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCIPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCIPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:21:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D318213C;
        Thu,  9 Mar 2023 07:21:34 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB598660304C;
        Thu,  9 Mar 2023 15:21:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678375293;
        bh=9nQJQnCKbrb4KyGEURRImR/OMn2QuOxR8XFtRl35qr8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=eCxYuAvDoUj6hHpZC5PYkYWMWUiG7uhp9zBZFfhSggOZvJ2PI3d/ct+eiTMkLCG7I
         rO989CP+wpq9ukZjjY6x7wRayNpanPHLt/3Ew6A0uRhmbr65Vane5p0BlKVGi0z4bK
         Y/hN8zryvtqjjIEplsuf+Jvd1oO6Jer9IJzh4OmM8ctWLHvqK8gHxB4JtFyjTk+uWg
         CaWIUMivoOqf0or3Uk8V1p6Pk0Xk58W8mA3dkiB1RYe0czYTYlNLWnBF/ecTzDigpu
         076PhgAa9jRPoOrZq7isygKz62/clJFhaTqazvkNlbUIcLa+VzFwpY3ST2365Gqr2j
         Lg6CSOT1bZtpg==
Message-ID: <42e0c0fe-3ee5-91df-302a-20193ec64bd3@collabora.com>
Date:   Thu, 9 Mar 2023 16:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 3/3] arm64: dts: mediatek: Initial mt8365-evk support
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        maz@kernel.org, tglx@linutronix.de
References: <20230309143459.401783-1-bero@baylibre.com>
 <20230309143459.401783-4-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230309143459.401783-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/03/23 15:34, Bernhard Rosenkränzer ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add CPU cache layout, add systimer, fix GIC]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> [aouledameur@baylibre.com: Fix systimer properties]
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 168 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 377 ++++++++++++++++++++
>   3 files changed, 546 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi
> 

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> new file mode 100644
> index 0000000000000..5d6763ebcf869
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -0,0 +1,377 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * (C) 2018 MediaTek Inc.
> + * Copyright (C) 2022 BayLibre SAS
> + * Fabien Parent <fparent@baylibre.com>
> + * Bernhard Rosenkränzer <bero@baylibre.com>
> + */

..snip..

> +
> +	systimer: timer@10017000 {
> +		compatible = "mediatek,mt8365-systimer", "mediatek,mt6795-timer";

You mean "mediatek,67 -> 6 <- 5-timer", right? :-P

Cheers,
Angelo

> +		reg = <0 0x10017000 0 0x100>;
> +		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&system_clk>;
> +		clock-names = "clk13m";
> +	};
> +};

