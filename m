Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219265B8823
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiINMXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiINMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:23:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E6880507;
        Wed, 14 Sep 2022 05:23:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E79E8660201C;
        Wed, 14 Sep 2022 13:23:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663158211;
        bh=Zyj8UOwqqdMNifAcdEPJzAn/naWDZ+dbMV3i/enh2GA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RZlfeTJxpxw4WHbV/mgUK1ywQDuLu3cltTMWV6CLt9ZS5CupVvjjp/Aj6DeJG4HkP
         UcU2RLeiRZm33bBfs64EAdXt7kVXy632JhG6hQyhK2pA63t82ai2DKZbQzCs83KPvP
         yWI6uOoxd/Jrcj67sEvo2/LjErWB9Q7nBtm1iTit0to03euwjNIdclE0RUFc+PFGtY
         OO9CBxMaVa1MP2FAork2noAqTH7jUz4ADQQ3Cm//47fc4DobPXdw8UzTUnM/nWR9EB
         o8G5IZGJW7ip8Fhb3MYKEqiwVlMsIqSEYNtLF1Vot/3Bag6mPX25wBS9IulgcaOZJJ
         ru6tuY7o7kLxA==
Message-ID: <064cd527-a975-a12f-a00b-3e6da3dbecb5@collabora.com>
Date:   Wed, 14 Sep 2022 14:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9,5/7] arm64: dts: mt8195: Add efuse node to mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-6-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220817080757.352021-6-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/08/22 10:07, bchihi@baylibre.com ha scritto:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> Add efuse node.
> This will be required by the thermal driver to get the calibration data.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 066c14989708..95967a0196d8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -733,6 +733,18 @@ u2_intr_p3: usb2-intr-p3@189,2 {
>   				reg = <0x189 0x2>;
>   				bits = <7 5>;
>   			};
> +
> +			lvts_efuse_data1: lvts1-calib@1bc {
> +				reg = <0x1bc 0x14>;
> +			};
> +
> +			lvts_efuse_data2: lvts2-calib@1d0 {
> +				reg = <0x1d0 0x38>;
> +			};
> +
> +			svs_calibration: calib@580 {

The SVS calibration efuse is for the SVS driver, not for the LVTS.
Moreover, you're not using it later when you add the LVTS nodes, so, please
drop this one.

Regards,
Angelo

