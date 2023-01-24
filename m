Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA66795C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjAXKxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjAXKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:53:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC9CE07E;
        Tue, 24 Jan 2023 02:53:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A82A36602E2A;
        Tue, 24 Jan 2023 10:52:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674557580;
        bh=NWmvmgqxjDN/jBCODDrbg9zNDiVikX7EO6ENO6c0Zic=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SNGCsNsHMDAFLtYIBRduuK0sPohTqsI2e0iD9w9vTLgyTcecBXdCzzSuyYX5oYdws
         5lS2QTvUq6tENa2iDq84UgIT5m147bmipMRolxkbBv9s2LYDScN5l9sgUptByyUSP2
         jzZPMOB9EpnWofduuZr/9SA7ZKT0KMb5xu32LcOhWZOSV7807S30YW93T7lLFF5If8
         xOTowb3FWCsrWLUEOeQsfmz72K4+jptuFr3OGPd/u26uz5Idbidx5l5YH5/ymm1vHi
         0p6Y3eQ2sB9bGfi5sluVrRxGqFlwvr+8QO4riFTTvrNiN7VhU7ud+IKPvrcjeiNbZl
         6GxNtpeSeN4GA==
Message-ID: <dec754f9-e79d-e1ce-e3ef-5a7eb4385dd7@collabora.com>
Date:   Tue, 24 Jan 2023 11:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 9/9] arm64: dts: mediatek: Initial mt8365-evk support
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        andrew@lunn.ch, gtk3@inbox.ru, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20230123163833.1007181-1-bero@baylibre.com>
 <20230123163833.1007181-10-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230123163833.1007181-10-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/01/23 17:38, Bernhard Rosenkränzer ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add CPU cache layout, add systimer, fix GIC]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 169 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 378 ++++++++++++++++++++
>   3 files changed, 548 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi
> 

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> new file mode 100644
> index 0000000000000..04c666cab506a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * (C) 2018 MediaTek Inc.
> + * Copyright (C) 2022 BayLibre SAS
> + * Fabien Parent <fparent@baylibre.com>
> + * Bernhard Rosenkränzer <bero@baylibre.com>
> + */
> +#include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/thermal/thermal.h>

thermal.h is unused... please remove it for now and add it back in a commit
where you add the thermal node.

Otherwise,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


