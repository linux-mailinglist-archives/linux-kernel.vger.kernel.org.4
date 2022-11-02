Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315C615F59
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiKBJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKBJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:14:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6627FD5;
        Wed,  2 Nov 2022 02:13:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53B9766015E4;
        Wed,  2 Nov 2022 09:13:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667380398;
        bh=yddB8YzbDqd9GZ4u8pL6Zol8d3iPlUtOe1y4r884crs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jhctdhIkhVmddWdje6jcB76l5ca/7YUVPZs61kGwkJO/cVz37YWfDHEQSuK9YFGzC
         7+IT0gHZC3aBoS2M+/NwNHePwRSV5dGRhhUU90yrfC4KS4w9fDSQQ50dmgTCkMl3lX
         98yLtzUOTA8yZebHdWo2Q9qd72HMjMGAxkCA0Eg3wOEqB/RndIpxJsZJnlYMoCSAX8
         8/nShXz+TBvnTZ7/Niu8zrTcL60yviUi9+uCKQUTjHa5khNmLElHyy9Aw/fdZ2C4OL
         l8RY33ATCTYDNCf5XV5OnYtGNAxzxI+Db+Z1bgGSqoFosXFTR4jaHrd21u1C0hwgNv
         +yNPSVRrSEghg==
Message-ID: <1f0bb630-20b0-160e-a530-05fae7572b10@collabora.com>
Date:   Wed, 2 Nov 2022 10:13:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 1/2] dt-bindings: dsp: mediatek: Add default clock
 sources for mt8186 dsp
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yaochun Hung <yc.hung@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221101061137.25731-1-tinghan.shen@mediatek.com>
 <20221101061137.25731-2-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221101061137.25731-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/11/22 07:11, Tinghan Shen ha scritto:
> Add the default clock sources used by mt8186 dsp.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   .../devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> index 3e63f79890b4..4cc0634c876b 100644
> --- a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> @@ -35,11 +35,15 @@ properties:
>       items:
>         - description: mux for audio dsp clock
>         - description: mux for audio dsp local bus
> +      - description: default clock source for dsp local bus
> +      - description: default clock source for dsp core
>   
>     clock-names:
>       items:
>         - const: audiodsp
>         - const: adsp_bus
> +      - const: mainpll_d2_d2
> +      - const: clk26m
>   
>     power-domains:
>       maxItems: 1
> @@ -82,9 +86,11 @@ examples:
>                 <0x1068f000 0x1000>;
>           reg-names = "cfg", "sram", "sec", "bus";
>           clocks = <&topckgen CLK_TOP_AUDIODSP>,
> -                 <&topckgen CLK_TOP_ADSP_BUS>;
> -        clock-names = "audiodsp",
> -                      "adsp_bus";
> +                 <&topckgen CLK_TOP_ADSP_BUS>,
> +                 <&topckgen CLK_TOP_MAINPLL_D2_D2>,
> +                 <&clk26m>;
> +        clock-names = "audiodsp", "adsp_bus",
> +                      "mainpll_d2_d2", "clk26m";

You are assigning those clocks just to be able to call clk_set_parent() in
the DSP mt8186-clk driver... and that's not necessary, nor it is the best
way of doing what you're trying to.

In reality, you don't need to add new clocks and you don't need to manage
that into the driver, as you can simply assign clock parents in devicetree
... like:

assigned-clocks = <&topckgen CLK_TOP_AUDIODSP>, <&topckgen CLK_TOP_ADSP_BUS>;
assigned-clock-parents = <&clk26m>, <&topckgen CLK_TOP_MAINPLL_D2_D2>;

without any clk_set_parent() call in the driver.

When the driver will call clk_prepare_enable() for top_audiodsp and/or for
top_adsp_bus, the assigned parents' refcount will also be increased (and
if the parent clock is not enabled, the clk framework will enable it).

Regards,
Angelo

