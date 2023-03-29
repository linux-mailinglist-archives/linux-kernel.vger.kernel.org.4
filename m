Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDDC6CDA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjC2NUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjC2NUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:20:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C060F524C;
        Wed, 29 Mar 2023 06:20:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F132660316F;
        Wed, 29 Mar 2023 14:20:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680096013;
        bh=+Gb3T+OEiFKZw1D3ileVDi0PJW+B0xgdY2yBBexB2kQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EQg2hrbHd2UgsF/MuOS04eS04qrxSgCIoOjtW8jKFlx6/tXsYGNgqrroAbdITFtv5
         qwnUi5sMeEeiQJ4K41mPAMBFa5BPAJ39958ujfG5/R/YyF3XpH6OlB1rUuM2JKXJDf
         vgX3uCLdhBCwEGWlBfAIcelGLe+aLRcW8kfk30iu6efnqmSLbPm1vBqHCxahExt4Lw
         jKDi9xDAb7WBo0LeXc9ZsiAZAtNAptf/kblThg2ZhQ8NhVrbphFU+rJs9O9SvZIOIA
         HLNGS/jb/AaIfWwWHJjE/GXmgOqTwsCKXTG3G/x6UlVwqJFxlRS9IO3Z7L0DTnC+eZ
         oGGEzMKOIKdFA==
Message-ID: <f963453f-ef7e-1bec-66ae-4bb0354914c8@collabora.com>
Date:   Wed, 29 Mar 2023 15:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 07/17] arm64: dts: mediatek: add mt6357 PMIC support
 for mt8365-evk
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-7-0003e80e0095@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v3-7-0003e80e0095@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/23 10:54, Alexandre Mergnat ha scritto:
> This power management system chip integration helps to manage regulators
> and keys.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> index fc7f6d8ae173..2f88562c638a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -12,6 +12,7 @@
>   #include <dt-bindings/input/input.h>
>   #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
>   #include "mt8365.dtsi"
> +#include "mt6357.dtsi"
>   
>   / {
>   	model = "MediaTek MT8365 Open Platform EVK";
> @@ -96,6 +97,13 @@ &i2c0 {
>   	#size-cells = <0>;
>   };
>   
> +&mt6357_pmic {
> +	interrupt-parent = <&pio>;
> +	interrupts = <145 IRQ_TYPE_LEVEL_HIGH>;

Please... use:
	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;

Cheers,
Angelo


