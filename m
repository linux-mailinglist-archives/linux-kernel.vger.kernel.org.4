Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC98714A84
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjE2Nm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjE2Nm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:42:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE68E;
        Mon, 29 May 2023 06:42:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30abe551605so2346103f8f.0;
        Mon, 29 May 2023 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685367773; x=1687959773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMg7icjeG89PrUOfRTyZk0yCyfktq3KwivNjgB8ujGA=;
        b=jz3UGmF4zV/9ZmH3OmhLmGLamQqD/jZ4tmokA/ET2IpieZgSY68L0+c1ietFsX4TU7
         6BSGEZT3NGRiZ+MieAT8hphWP9r0eX+UwKn+A7HRxoS7fj/D08/TqRl2aTKUbN+z0Fuh
         BI2tXbCqIKrUNKJWjn2YP4s+qlMVhimEP+zMosSsk45/FBFs0lLVwPZsZeQRSqXlZaHy
         9WlKGeT43JbCWOF/Orv0EWP5LuSob5rFTnfR5yHX77ec1qv6eORm2OLXTL81V+9Nd3jL
         CAPia/n8/Pw9NAKK00E/V3MRG+iEFCcyLsH3fW/y+xf9g0v8IYrtsdQ8Ws0OLjSsP5Cc
         fqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367773; x=1687959773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMg7icjeG89PrUOfRTyZk0yCyfktq3KwivNjgB8ujGA=;
        b=JQxkbeC89fqtulaJgi/0urUp0YLms4OEBfv0KwVSk0ewxZ53BGBybWlwgHj9xAqW15
         3Gh81i5YZYM3wKV7uWmTJt0UTCGGKyVndmDo20zxmmc+dWbCnfxFzyZjKG0yeYzFfdXP
         jLw2E4GxBrERuOen+lLwF8cerOxZvMy1JMy8DKdNfUvyoEDJUe5HDlsJwM4Cun5joypy
         lBGTl/1nqpQYLBNcV5N+K8EGFpr3ihOkwIr484kATnGDBIBIlGjOzS1VxqUurpC3aQUy
         k8Gk5XqIeYMFTPjsV6nPzTtYgAE1rSUtLTACtPwRAWmOL2N2mpCeijgcsS8dyGV7weo6
         LCog==
X-Gm-Message-State: AC+VfDxfQAqVvFc22rxme56baSfSdAhxGHOGAOlsGPO/Zf9nn3PjW1K7
        tpxErouyalHK7GQEYQfBQyM=
X-Google-Smtp-Source: ACHHUZ5+STvADmKorwh7htg0ZWvj2+Br79ZOgigmjGtwFRYM3+R9pxPmtZn9DGFvsWZ/nDVJP5aIfg==
X-Received: by 2002:adf:da52:0:b0:309:7010:b869 with SMTP id r18-20020adfda52000000b003097010b869mr5917714wrl.8.1685367773521;
        Mon, 29 May 2023 06:42:53 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f8-20020a1c6a08000000b003f41bb52834sm18081032wmc.38.2023.05.29.06.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:42:52 -0700 (PDT)
Message-ID: <2ac28066-9798-79d7-5247-6af48ac95311@gmail.com>
Date:   Mon, 29 May 2023 15:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/6] arm64: dts: mediatek: mt8186: Add MTU3 nodes
Content-Language: en-US, ca-ES, es-ES
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230324021258.15863-1-allen-kh.cheng@mediatek.com>
 <20230324021258.15863-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230324021258.15863-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2023 03:12, Allen-KH Cheng wrote:
> Add MTU3 nodes for MT8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 68 ++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index a0d3e1f731bd..178421fd8380 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -981,6 +981,40 @@
>   			status = "disabled";
>   		};
>   
> +		ssusb0: usb@11201000 {
> +			compatible = "mediatek,mt8186-mtu3", "mediatek,mtu3";
> +			reg = <0 0x11201000 0 0x2dff>, <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			clocks = <&topckgen CLK_TOP_USB_TOP>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_HCLK>,
> +				 <&infracfg_ao CLK_INFRA_AO_ICUSB>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
> +			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port0 PHY_TYPE_USB2>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_SSUSB>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			usb_host0: usb@11200000 {
> +				compatible = "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
> +				reg = <0 0x11200000 0 0x1000>;
> +				reg-names = "mac";
> +				clocks = <&topckgen CLK_TOP_USB_TOP>,
> +					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
> +					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_HCLK>,
> +					 <&infracfg_ao CLK_INFRA_AO_ICUSB>,
> +					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
> +				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
> +				interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
> +				mediatek,syscon-wakeup = <&pericfg 0x420 2>;
> +				wakeup-source;
> +				status = "disabled";
> +			};
> +		};
> +
>   		mmc0: mmc@11230000 {
>   			compatible = "mediatek,mt8186-mmc",
>   				     "mediatek,mt8183-mmc";
> @@ -1012,6 +1046,40 @@
>   			status = "disabled";
>   		};
>   
> +		ssusb1: usb@11281000 {
> +			compatible = "mediatek,mt8186-mtu3", "mediatek,mtu3";
> +			reg = <0 0x11281000 0 0x2dff>, <0 0x11283e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_HCLK>,
> +				 <&clk26m>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
> +			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_SSUSB_P1>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			usb_host1: usb@11280000 {
> +				compatible = "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
> +				reg = <0 0x11280000 0 0x1000>;
> +				reg-names = "mac";
> +				clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
> +					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>,
> +					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_HCLK>,
> +					 <&clk26m>,
> +					 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_XHCI>;
> +				clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck","xhci_ck";
> +				interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH 0>;
> +				mediatek,syscon-wakeup = <&pericfg 0x424 2>;
> +				wakeup-source;
> +				status = "disabled";
> +			};
> +		};
> +
>   		u3phy0: t-phy@11c80000 {
>   			compatible = "mediatek,mt8186-tphy",
>   				     "mediatek,generic-tphy-v2";
