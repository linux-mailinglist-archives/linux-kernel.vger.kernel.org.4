Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA56C1F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCTSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCTSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:24:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDEE3347B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:17:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so50365959edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679336256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqGMNpSipRdw8b7apACOFeIJhF2ZQ6XFL4UFhdRmF+g=;
        b=lK2MANal4tGXZhZKtbwxNpYuaIxXP80lnIUqRmeI6tM4jNqHnMrEQ4RgAvzryFYH9X
         v2Iw/xhqQ/k18W/US5lxoaCSJf/FdMbLZf8q2oICuglzCKfApDUmlE2B9HJVKO3UWng9
         XC4d04UaO0dITzy6u+HkTg5XHyEC3vGO7QGbHts3QZUKoascyrnkSKq0Wb079VwT6Asd
         hMcc2dOFb6V+zQDu0AyE4f1t+iFb55Z8zV0S/tCD/RrPwhG0b0kU/1ZrpoK1YKV7vTMc
         DHDV8fQZmQVfzF7nc03y4ev7Ju8gfRJTfbXPp7maJrOb+UnMZHVwF+Ga7F6Y/zBIFdpn
         nH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqGMNpSipRdw8b7apACOFeIJhF2ZQ6XFL4UFhdRmF+g=;
        b=ZFVpuIb6+7EqgxQ7AxW9EzA1QmeI9sllfZBd+WuTnh08X8CYeF6lbvesc6dd1nDg42
         M54zuQxiQcbLjW/m+2WHb5ZF5RM7fayJTyeNvrX3YOD3qNpx2eYcAlmDqy8pKHK7HXTA
         /Lfv1CMlziBOwHMelyc7EK5cAqyhJ5SK+ZbuDFbAVcXU0JIPfbhz9fYOxZJ09A868Swl
         uOg5DDOARffIxcKs1CYXHL+mcdUEfBjOsF4lpq3BkqwigsYO4P3JnTHHKRijNEe3r6y4
         F1mXSFhVfpmwtp1tS57fv3Cj+nARLZPvNekIn0X7ChZde02nPc5uBbSYKpkCNcHgfNza
         7ipw==
X-Gm-Message-State: AO0yUKWMcdPFAEp3oLY2oSZBPW5dCGdrgvdBmpgGODzrP+5TAJBkuWf7
        1dQb18h+QB7i9ilheVAje8Susg==
X-Google-Smtp-Source: AK7set+jAxInWPfvKmfjeCoZgX+UENXYh0g85MPxYm3aRy8olqD8AUQWKYAOvbqHO1Llh2UldffmbA==
X-Received: by 2002:aa7:d7c7:0:b0:4fa:e1fd:5a30 with SMTP id e7-20020aa7d7c7000000b004fae1fd5a30mr529020eds.19.1679336256291;
        Mon, 20 Mar 2023 11:17:36 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id w3-20020a50c443000000b004ac54d4da22sm5302952edf.71.2023.03.20.11.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:17:35 -0700 (PDT)
Message-ID: <da49e690-326d-4a94-b4c7-58de25159c6d@linaro.org>
Date:   Mon, 20 Mar 2023 18:17:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: nvmem: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org
References: <20230317233640.3968821-1-robh@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230317233640.3968821-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2023 23:36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Applied thanks,

--srini
> ---
>   .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml      | 2 +-
>   Documentation/devicetree/bindings/nvmem/apple,efuses.yaml       | 2 +-
>   Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml         | 2 +-
>   Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 2 +-
>   Documentation/devicetree/bindings/nvmem/imx-iim.yaml            | 2 +-
>   Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml          | 2 +-
>   .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml         | 2 +-
>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml     | 2 +-
>   .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml       | 2 +-
>   Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml          | 2 +-
>   Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml       | 2 +-
>   Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml        | 2 +-
>   Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml     | 2 +-
>   Documentation/devicetree/bindings/nvmem/rmem.yaml               | 2 +-
>   Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml     | 2 +-
>   .../devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml     | 2 +-
>   Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml     | 2 +-
>   .../devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml         | 2 +-
>   18 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> index 14c170c6a86e..296001e7f498 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> @@ -11,7 +11,7 @@ maintainers:
>     - Maxime Ripard <mripard@kernel.org>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> index 5ec8f2bdb3a5..e0860b6b85f3 100644
> --- a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> @@ -15,7 +15,7 @@ maintainers:
>     - Sven Peter <sven@svenpeter.dev>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 25033de3ef6b..36def7128fca 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -20,7 +20,7 @@ maintainers:
>     - Rafał Miłecki <rafal@milecki.pl>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> index 3b4e6e94cb81..70fb2ad25103 100644
> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> @@ -14,7 +14,7 @@ description: |
>     unique identifier per part.
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> index 7aac1995cfaf..e9d9d8df4811 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> @@ -14,7 +14,7 @@ description: |
>     i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> index d0a239d7e199..9876243ff1e8 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> @@ -15,7 +15,7 @@ description: |
>     i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
> index fe2cd7f1afba..e89fd879c968 100644
> --- a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 75e0a516e59a..d16d42fb98b6 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -15,7 +15,7 @@ maintainers:
>     - Lala Lin <lala.lin@mediatek.com>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     $nodename:
> diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> index c3c96fd0baac..a296d348adb4 100644
> --- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> @@ -15,7 +15,7 @@ description: |
>     settings, chip identifiers) or user specific data could be stored.
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
> index ff317fd7c15b..8938eec22b52 100644
> --- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Anson Huang <Anson.Huang@nxp.com>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
> index f93bc50c40d7..6c26800f8b79 100644
> --- a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
> @@ -17,7 +17,7 @@ maintainers:
>     - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 2173fe82317d..e952907ad1d5 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> index e08504ef3b6e..34818683f80c 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> @@ -15,7 +15,7 @@ description: |
>     to/from the PBUS.
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> index a4a755dcfc43..38a39c9b8c1c 100644
> --- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
> index febee8129aa9..c5403e149080 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Heiko Stuebner <heiko@sntech.de>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
> index dc790d2cd9f0..b8bca0599c45 100644
> --- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
> @@ -11,7 +11,7 @@ maintainers:
>     - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     "#address-cells": true
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> index 172597cc5c63..a69de3e92282 100644
> --- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> @@ -16,7 +16,7 @@ maintainers:
>     - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> index a7644ebbc2ca..8877c2283e9e 100644
> --- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> @@ -11,7 +11,7 @@ maintainers:
>     - Vincent Shih <vincent.sunplus@gmail.com>
>   
>   allOf:
> -  - $ref: "nvmem.yaml#"
> +  - $ref: nvmem.yaml#
>   
>   properties:
>     compatible:
