Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB01F625A68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiKKMWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKKMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:22:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926AF6316D;
        Fri, 11 Nov 2022 04:22:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h9so6323104wrt.0;
        Fri, 11 Nov 2022 04:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJF/8BTnSqG+0qzLAs/+pNq+7xJdZS+ZH3azcuPryMo=;
        b=ReJtGUVtPIOZD10UwPMf/wuiKfYhAqeiyHBCvfLLM6JirZ+HESrvGnGq4lc9SZgpxT
         HCYbKDcafWQLxeXB2azC5v8/HBZ8kFHVzNylEizSHc6K9LSZS3Km/pYwy6iNVdjsXtlW
         QAIe01T57aYTpRw/QLp7MReKqt9RQePVfLkhnsQhaU9MfUa4ieGV5xwm8oz/XgvLz/dc
         6+PztoAvvKIR+BiZO9jy1tmtSluVaohUaF6HYNjwClF/Y1o98bzQ/Q0epxOn4dPIXqCY
         yBs1lpCaVlrRMrwbIxziU2N8nc4d72A1Mpcj+sQq0c+iBKh7/6fU/KaGMK/3hj56y7e7
         dl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJF/8BTnSqG+0qzLAs/+pNq+7xJdZS+ZH3azcuPryMo=;
        b=z2QF3j9AbBQCjtESbHpzo/gRSYxElJx0KS+nR03wNpughOHewxMYojY7rXFCK/F9hA
         MGzs03Frq9g7HPjXb9pcPrt96Z31FCqBp+XB012qCd02wtufLyRncin5AGYENw4tdfYn
         7+0k5CtL378w6UvbnjyOOF4HbHydk+o3nTwq0qBYTJioU7al/kFjhUTi90AgjwpItIJt
         Db23N3CKtoBqix1JYlCovvmUY0pqCA6CQYH1TUWA8PqAga17c+rR4AjBUj3qhKyu0DX9
         SS/1tAMT/HlEDd0O30GqzoER+L1Qp5r7+Z2Pfl5zkttBH20rXWLl4qj/P6CpiqmZIelz
         8L3Q==
X-Gm-Message-State: ANoB5pmUwS3Oz65EHVIn3HWRJXI1VMbK+nvwQMv0c7AKt+4B5NTkVdp/
        2Z0JQzumwhjq7MY1gMAlDQ4=
X-Google-Smtp-Source: AA0mqf5yCmIRuMQealOe2SgKrahw6GpYmGze85fj/1zyx+KuAnlrqbktXvgYBo9gP7I7GVvBEc7nWA==
X-Received: by 2002:adf:f207:0:b0:236:8322:4be9 with SMTP id p7-20020adff207000000b0023683224be9mr1090927wro.171.1668169324130;
        Fri, 11 Nov 2022 04:22:04 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d540b000000b0022cdeba3f83sm1751168wrv.84.2022.11.11.04.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 04:22:02 -0800 (PST)
Message-ID: <73e5491a-9720-ea52-48ff-cc506c6dc582@gmail.com>
Date:   Fri, 11 Nov 2022 13:22:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 2/4] arm64: dts: mt8195: Add edptx and dptx nodes
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
 <20221110063716.25677-3-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221110063716.25677-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 07:37, Bo-Chen Chen wrote:
> In MT8195, we use edptx as the internal display interface and use
> dptx as the external display interface. Therefore, we need to add
> these nodes to support the internal display and the external display.
> 
> - Add dp calibration data in the efuse node.
> - Add edptx and dptx nodes for MT8195.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 25 ++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index c380738d10cb..7acbef5a4517 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1244,6 +1244,9 @@
>   				reg = <0x189 0x2>;
>   				bits = <7 5>;
>   			};
> +			dp_calibration: dp-data@1ac {
> +				reg = <0x1ac 0x10>;
> +			};
>   		};
>   
>   		u3phy2: t-phy@11c40000 {
> @@ -2205,5 +2208,27 @@
>   			clock-names = "engine", "pixel", "pll";
>   			status = "disabled";
>   		};
> +
> +		edp_tx: edp-tx@1c500000 {
> +			compatible = "mediatek,mt8195-edp-tx";
> +			reg = <0 0x1c500000 0 0x8000>;
> +			nvmem-cells = <&dp_calibration>;
> +			nvmem-cell-names = "dp_calibration_data";
> +			power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
> +			interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
> +			max-linkrate-mhz = <8100>;
> +			status = "disabled";
> +		};
> +
> +		dp_tx: dp-tx@1c600000 {
> +			compatible = "mediatek,mt8195-dp-tx";
> +			reg = <0 0x1c600000 0 0x8000>;
> +			nvmem-cells = <&dp_calibration>;
> +			nvmem-cell-names = "dp_calibration_data";
> +			power-domains = <&spm MT8195_POWER_DOMAIN_DP_TX>;
> +			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
> +			max-linkrate-mhz = <8100>;
> +			status = "disabled";
> +		};

For some not really obvious reasons we get the following errors with
make CHECK_DTBS=1 mediatek/mt8195-cherry-tomato-r2.dtb

arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb:0:0: 
/soc/edp-tx@1c500000: failed to match any schema with compatible: 
['mediatek,mt8195-edp-tx']
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb:0:0: 
/soc/dp-tx@1c600000: failed to match any schema with compatible: 
['mediatek,mt8195-dp-tx']

Can you please see how to fix this. Tested with next-20221111.

Regards,
Matthias

>   	};
>   };
