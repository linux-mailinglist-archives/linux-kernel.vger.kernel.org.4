Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0F6752DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjATK5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjATK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:57:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34C55926F;
        Fri, 20 Jan 2023 02:57:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so3368358wmc.1;
        Fri, 20 Jan 2023 02:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4Ii5e3QdaHgpxzco45qunbaAsydDjGix7Dw3cejJFE=;
        b=OYGLgKKAs+7hc4uUd1Uf2kfWjTFqH2Zb5Xbi1J1UsILPq94D8oG4U7cfSr/S52avoX
         oBylfZWRcfYClOXugMVosVjLw+t/o5g7T3xXx0LDP9NQnfiqH3fB4fX5c+OxNwZaOsSN
         MkuJULfjLA+z2ZYHeSfQFjsk3TBfuMW06NJPhyAtGFSQY57hfrlu3vRdchgTH050dsHz
         sh7Y2c21IEXtQdP0JhzcQR7WX6f5eSsIv4J939SutiLKmUCKFRPCPmPfjqk6Jm0L0IcG
         7GvsAn6TUCf5p4EgoXedkeylOvPko6kngHSXu6Agfo37TVUqQy9dJQBz4TZaK/ZOSJYU
         nqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4Ii5e3QdaHgpxzco45qunbaAsydDjGix7Dw3cejJFE=;
        b=GP0Je2MDpcB7Lq3XVUftcc9KE1uuQ6ANHQbvljmcuiFllTl7DTtRsNsvlcqAQSkeok
         ueZfgH3YPRb63qAHpMknD1e4Cx98l2okceAw72YSV4qUjWPKKrwzdOCKoQRHV+D65bfr
         e3NSA4FKfoFrZZoUxZy8jp9xHp6Nkq14JJo42qVxHzdIH6RjekYklJTsQs5x8edVFt1E
         G0+/58UkZVX7xLauwO3YB2E9AaEfviY/RkNLBhB4C7uM7+34dfkp8ErL6SkzzElIx3mW
         B2WoLff8U75mmEWJesoBGS/fLhSAwzhZqXvXGhRptpmcYtmpG2kdKa4UYG06x5S1dNuI
         V+iw==
X-Gm-Message-State: AFqh2ko8XX6XC8XzgxgIo293ce9m8FK4kcaOJJY2Mf/7bMxVvKa+bySf
        GBybDIifMAJTEkn+nYF5SbU=
X-Google-Smtp-Source: AMrXdXsZQTWcELo0E+WRaY2YZ2jzNC5vg23Fh18wO4KIPz84swiOfZhhsA8iMB2Y/TyA96Pbq+Uv8A==
X-Received: by 2002:a05:600c:2292:b0:3d3:50b9:b1a1 with SMTP id 18-20020a05600c229200b003d350b9b1a1mr22130930wmf.1.1674212251959;
        Fri, 20 Jan 2023 02:57:31 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003d9aa76dc6asm2703107wmq.0.2023.01.20.02.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 02:57:31 -0800 (PST)
Message-ID: <18e6d30d-15ee-3d88-e9d3-f8dad6034760@gmail.com>
Date:   Fri, 20 Jan 2023 11:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        linus.walleij@linaro.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
References: <20230101220149.3035048-1-bero@baylibre.com>
 <20230101220149.3035048-8-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 7/7] arm64: dts: mediatek: Initial mt8365-evk support
In-Reply-To: <20230101220149.3035048-8-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/01/2023 23:01, Bernhard Rosenkränzer wrote:
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
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 813e735c5b96d..d78523c5a7dd6 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -47,4 +47,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> new file mode 100644
> index 0000000000000..275ea3a0e7085
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
[...]
> +		apdma: dma-controller@11000280 {
> +			compatible = "mediatek,mt8365-uart-dma", "mediatek,mt6577-uart-dma";
> +			reg = <0 0x11000280 0 0x80>,
> +			      <0 0x11000300 0 0x80>,
> +			      <0 0x11000380 0 0x80>,
> +			      <0 0x11000400 0 0x80>,
> +			      <0 0x11000580 0 0x80>,
> +			      <0 0x11000600 0 0x80>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 47 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 48 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
> +			dma-requests = <6>;
> +			clocks = <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "apdma";
> +			#dma-cells = <1>;
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";

Unfortunately we are missing this compatible in the binding description.

> +			reg = <0 0x11002000 0 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART0>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 0>, <&apdma 1>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART1>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 2>, <&apdma 3>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11004000 {
> +			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
> +			reg = <0 0x11004000 0 0x1000>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART2>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 4>, <&apdma 5>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		pwm: pwm@11006000 {
> +			compatible = "mediatek,mt8365-pwm";
> +			reg = <0 0x11006000 0 0x1000>;
> +			#pwm-cells = <2>;
> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_IFR_PWM_HCLK>,
> +				 <&infracfg CLK_IFR_PWM>,
> +				 <&infracfg CLK_IFR_PWM1>,
> +				 <&infracfg CLK_IFR_PWM2>,
> +				 <&infracfg CLK_IFR_PWM3>;
> +			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
> +		};
> +
> +		spi: spi@1100a000 {
> +			compatible = "mediatek,mt8365-spi", "mediatek,mt7622-spi";
> +			reg = <0 0x1100a000 0 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_IFR_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		ssusb: usb@11201000 {
> +			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";

Same here.

> +			reg = <0 0x11201000 0 0x2e00>, <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u2port1 PHY_TYPE_USB2>;
> +			clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
> +				 <&infracfg CLK_IFR_SSUSB_REF>,
> +				 <&infracfg CLK_IFR_SSUSB_SYS>,
> +				 <&infracfg CLK_IFR_ICUSB>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			usb_host: usb@11200000 {
> +				compatible = "mediatek,mt8365-xhci", "mediatek,mtk-xhci";

Same here.

> +				reg = <0 0x11200000 0 0x1000>;
> +				reg-names = "mac";
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
> +					 <&infracfg CLK_IFR_SSUSB_REF>,
> +					 <&infracfg CLK_IFR_SSUSB_SYS>,
> +					 <&infracfg CLK_IFR_ICUSB>,
> +					 <&infracfg CLK_IFR_SSUSB_XHCI>;
> +				clock-names = "sys_ck", "ref_ck", "mcu_ck",
> +					      "dma_ck", "xhci_ck";
> +				status = "disabled";
> +			};
> +		};
> +
> +		u3phy: phy@11cc0000 {
> +			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#phy-cells = <1>;
> +			ranges;
> +
> +			u2port0: usb-phy@11cc0000 {
> +				reg = <0 0x11cc0000 0 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u2port1: usb-phy@11cc1000 {
> +				reg = <0 0x11cc1000 0 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	system_clk: dummy13m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <13000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	systimer: timer@10017000 {
> +		compatible = "mediatek,mt6795-systimer";

Why don't we use a compatible like
"mediatek,mt8365-systimer", "mediatek,mt6795-systimer";

We would need to add this to the binding description as well.

I leave it up to you, but I'd advise to start with a minimal working DT which 
includes only the bindings that are already merged. Then we can take the new 
devices like mtu3, xhci, spidev or i2c later once they are ready.

Regards,
Matthias
