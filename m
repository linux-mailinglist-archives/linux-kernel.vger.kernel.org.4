Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8556D1EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCaLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCaLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:03:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3CD21A9C;
        Fri, 31 Mar 2023 04:01:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so9749931wmq.3;
        Fri, 31 Mar 2023 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jTmAQHN2+OXRqY503UggSJwokP+lo1DAE3YraqVPgU=;
        b=AS6rtvhoVboqTtIZPL2lpA1igZcWE5laXowWtQURab9TW369XdjV2ROkp+9hWF0KyB
         ffUSpQg7/9CrK3+QutvI1nikpZJ6j9ttznvpoYwyVseZe0kBoQGsl4DEwGBY0SMG5Wgg
         h/9tlnYecR3bG79UvqT1crr6DqXmd7DTA1LgSbXhMjXivyBEeFikcyH0DsdQazf6I63s
         u0xIkCKDysVqhRgKa3hbhDY9Ou5Yt9ZiFaOBSDsbFqIRcp2MrTqaabDCYM4dijUQ2tqI
         Q9Uc2G+DUBGf/SYYhl7nHWukck0B046j2mjZymjHHOBdLmqwAylrEJ+9eU8s5bWdcaKJ
         ZRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jTmAQHN2+OXRqY503UggSJwokP+lo1DAE3YraqVPgU=;
        b=GqfmbOEZahN49xOBrPMufPjYiryE/O853ywugRYJteyCQmXcu9GkOd6Zg2c35AD4aL
         P55/M4NRxXHxJ/YZRIA/ixrfTFgZaIZUeWo2E2C+vzCI6KuYD96Z7IBYsTljg4ALtoj4
         H1P1Z+/OWacosm1FCkRTVsrdCiSfM02ESHn8fvKWO8dfXcDfJHXmZnBwVT0kF85uxEvW
         67T818wFRZBwMuZ5mT0h0wKvG4pq/vzj9I/hac6Dw3S7GXhFbsmaipPsbYrMikzKRM5p
         m4PN6bLZRN7DFbY55CE1KuaK5CHbth0YeodQhg0UfLHe/JNSf0x+wn8Ss3YuDgQy1fKX
         /k6g==
X-Gm-Message-State: AO0yUKXIZQ8+jbf34b+U2mLsczyZdNYU2K0BdwBRZuWFCvPuD5OVogJp
        pXb8J9zwX44fCcvBSwSPOs4=
X-Google-Smtp-Source: AK7set8WUdMxXiPG2/ws5noGWksr8D1CcLYSgekqr3nf9OtFvnMz/XzWv/14/4gIPB2erSFUKJRoPg==
X-Received: by 2002:a05:600c:22d6:b0:3ed:e5db:52e1 with SMTP id 22-20020a05600c22d600b003ede5db52e1mr21011292wmg.15.1680260399628;
        Fri, 31 Mar 2023 03:59:59 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003dd1bd0b915sm9483254wmq.22.2023.03.31.03.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 03:59:58 -0700 (PDT)
Message-ID: <848971ea-b142-d088-df6f-74ee2d807950@gmail.com>
Date:   Fri, 31 Mar 2023 12:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 11/11] arm64: dts: mediatek: mt8195: Add SCP 2nd core
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230328022733.29910-1-tinghan.shen@mediatek.com>
 <20230328022733.29910-12-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230328022733.29910-12-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2023 04:27, Tinghan Shen wrote:
> Rewrite the MT8195 SCP device node as a cluster and
> add the SCP 2nd core in it.
> 
> Since the SCP device node is changed to multi-core structure,
> enable SCP cluster to enable probing SCP core 0.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

As this is a bigger change I'd prefer to take it through my tree once the driver 
and dt-bindings changes are merged. Given the fact, maybe it would make sense to 
take 2/11 through my tree as well.

Regards,
Matthias

> ---
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |  6 +++-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 32 ++++++++++++++-----
>   2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 56749cfe7c33..31415d71b6a4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -933,7 +933,11 @@
>   	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>   };
>   
> -&scp {
> +&scp_cluster {
> +	status = "okay";
> +};
> +
> +&scp_c0 {
>   	status = "okay";
>   
>   	firmware-name = "mediatek/mt8195/scp.img";
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 8fc527570791..5fe5fb32261e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -826,14 +826,30 @@
>   			clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
>   		};
>   
> -		scp: scp@10500000 {
> -			compatible = "mediatek,mt8195-scp";
> -			reg = <0 0x10500000 0 0x100000>,
> -			      <0 0x10720000 0 0xe0000>,
> -			      <0 0x10700000 0 0x8000>;
> -			reg-names = "sram", "cfg", "l1tcm";
> -			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
> +		scp_cluster: scp@10500000 {
> +			compatible = "mediatek,mt8195-scp-dual";
> +			reg = <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
> +			reg-names = "cfg", "l1tcm";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x10500000 0x100000>;
>   			status = "disabled";
> +
> +			scp_c0: scp@0 {
> +				compatible = "mediatek,scp-core";
> +				reg = <0x0 0xa0000>;
> +				reg-names = "sram";
> +				interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
> +				status = "disabled";
> +			};
> +
> +			scp_c1: scp@a0000 {
> +				compatible = "mediatek,scp-core";
> +				reg = <0xa0000 0x20000>;
> +				reg-names = "sram";
> +				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
> +				status = "disabled";
> +			};
>   		};
>   
>   		scp_adsp: clock-controller@10720000 {
> @@ -2309,7 +2325,7 @@
>   				 <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
>   				 <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
>   			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
> -			mediatek,scp = <&scp>;
> +			mediatek,scp = <&scp_c0>;
>   			clocks = <&vencsys CLK_VENC_VENC>;
>   			clock-names = "venc_sel";
>   			assigned-clocks = <&topckgen CLK_TOP_VENC>;
