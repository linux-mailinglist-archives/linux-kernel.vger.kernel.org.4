Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27EA61A076
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKDTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDTBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:01:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C22E2E9D3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:01:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x18so3647275qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjWIc+Y2VWYx4jNbBOgLh874LMSqyb32z5QF9mj3i98=;
        b=AlLUcC8QKTEj3lZ/hMrjZsNAl53EoSJwstuGy647whsx6xmXqpT4fBFDy/1+E0Z6b3
         Jz7jCpwKbRajJwFjezaIA7DoSjLzFUcNYcSf10IBOmsONWjyVKyqG+uEGvvOiEXSP7mU
         BIsSarPtW7141YK4Kg8/Iu3vE7PrZZzQ/3l8rnqLF+D1UMP16sCPTJS4aOxM86dscAr0
         nl3khHjXqIpI1TFVm1+Rb+kCw2Np7KrEuHhCwa3ydC9yh/0Ad67sdwE4LhUk6qIdjmn7
         ct6dKjGnBHdpep9cbpZVSXc5uFbUXSE1utghBAi/8xN/fH8X2vJRFw1W6w1TTHnpRqmd
         kPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjWIc+Y2VWYx4jNbBOgLh874LMSqyb32z5QF9mj3i98=;
        b=oEote7U/FJtshBSzPtYQKqr1fLi8dw1T16cN/JIggnUxT4qPsK5TKD4E2t/puTxgGS
         c9ttiuifM5Jbkc67rtKVAzx+70ZrhTT29ZD+D82CkEtXkZYNI7+2ae6KAID5biFHLNrw
         vbWHwQ9PNCU4kwTLFklLwQrdBERch5yZio1X84lybAXU7bWaoBAp4yMK0283WhUBkeVV
         GBa+3P+YzdIN6+2PwdXH/RVFF96+hu42PMZYzmAF2P/H5NAEBQG0qJXTAdYfgMDlwm8S
         vLHQ+MVl11Js+KiYlQ9GVeiUYtEDXow30Ua15IVeZSghJtha65MkNAvANIY6H4KiULp6
         5mgw==
X-Gm-Message-State: ACrzQf2Cxj+/qnS/pjJpVdEEFFRm/qC9YyYnZ9QtDqepL+ulPI9Dfj1A
        zNMZkbNj3iJ7xXeeNyOq33fJ/A==
X-Google-Smtp-Source: AMsMyM60TSb8xotwNMjbAKMwxDCG0ZEzIOX+ZgUYerdP9/xUaeF7mI33HM8CiO3mwGhiXuRCl31I1w==
X-Received: by 2002:a05:620a:2b93:b0:6fa:307f:e074 with SMTP id dz19-20020a05620a2b9300b006fa307fe074mr20650829qkb.523.1667588502338;
        Fri, 04 Nov 2022 12:01:42 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id f3-20020ac84643000000b003a51e6b6c95sm74654qto.14.2022.11.04.12.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 12:01:41 -0700 (PDT)
Message-ID: <f42baf44-3143-8895-5270-e1af6e0d66ba@linaro.org>
Date:   Fri, 4 Nov 2022 15:01:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 8/9] arm64: dts: qcom: Add DTS for MSM8976 and MSM8956
 SoCs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-9-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> This commit adds device trees for MSM8956 and MSM8976 SoCs.
> They are *almost* identical, with minor differences, such as
> MSM8956 having two A72 cores less.
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +		sdhc_1: mmc@7824000 {
> +			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
> +			reg = <0x07824900 0x500>, <0x07824000 0x800>;
> +			reg-names = "hc", "core";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "iface", "core", "xo";
> +
> +			bus-width = <8>;
> +			non-removable;

Aren't these two depend where is eMMC and where SD? Similarly to the
node below. I wouold expect board DTS define them.

> +			status = "disabled";
> +		};
> +
> +		sdhc_2: mmc@7864000 {
> +			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
> +			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
> +			reg-names = "hc", "core";
> +
> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "iface", "core", "xo";
> +
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		blsp1_dma: dma-controller@7884000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07884000 0x1f000>;
> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +		};
> +
> +		blsp1_uart1: serial@78af000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078af000 0x200>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp1_dma 0>, <&blsp1_dma 1>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart2: serial@78b0000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b0000 0x200>;
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_spi1: spi@78b5000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x078b5000 0x500>;
> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp1_dma 4>, <&blsp1_dma 5>;
> +			dma-names = "tx", "rx";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&spi1_default>;
> +			pinctrl-1 = <&spi1_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		blsp1_i2c2: i2c@78b6000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b6000 0x500>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			clock-frequency = <400000>;
> +			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
> +			dma-names = "tx", "rx";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp1_i2c2_default>;
> +			pinctrl-1 = <&blsp1_i2c2_default>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		blsp1_i2c4: i2c@78b8000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b8000 0x500>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			clock-frequency = <400000>;
> +			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
> +			dma-names = "tx", "rx";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp1_i2c4_default>;
> +			pinctrl-1 = <&blsp1_i2c4_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		otg: usb@78db000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x078db000 0x200>,
> +			      <0x078db200 0x200>;
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>, <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			clock-names = "iface", "core";
> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			assigned-clock-rates = <80000000>;
> +			resets = <&gcc RST_USB_HS_BCR>;
> +			reset-names = "core";
> +			ahb-burst-config = <0>;
> +			dr_mode = "peripheral";
> +			phy_type = "ulpi";
> +			phy-names = "usb-phy";
> +			phys = <&usb_hs_phy>;
> +			status = "disabled";
> +			#reset-cells = <1>;
> +		};
> +
> +		sdhc_3: mmc@7a24000 {
> +			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
> +			reg = <0x07a24900 0x11c>, <0x07a24000 0x800>;
> +			reg-names = "hc", "core";
> +
> +			interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
> +				 <&gcc GCC_SDCC3_APPS_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "iface", "core", "xo";
> +			bus-width = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;

These two are needed also for the board if SDIO is attached here.

> +
> +			status = "disabled";
> +		};
> +
> +		blsp2_dma: dma-controller@7ac4000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07ac4000 0x1f000>;
> +			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +		};
> +
> +		blsp2_uart2: serial@7af0000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x07af0000 0x200>;
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp2_dma 0>, <&blsp2_dma 1>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp2_i2c2: i2c@7af6000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x07af6000 0x600>;
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			clock-frequency = <400000>;
> +			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
> +			dma-names = "tx", "rx";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp2_i2c2_default>;
> +			pinctrl-1 = <&blsp2_i2c2_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		blsp2_i2c4: i2c@7af8000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x07af8000 0x600>;
> +			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			clock-frequency = <400000>;
> +			dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
> +			dma-names = "tx", "rx";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp2_i2c4_default>;
> +			pinctrl-1 = <&blsp2_i2c4_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +
> +		apcs: syscon@b011000 {
> +			compatible = "syscon";

This cannot be alone, you need specific compatible.

> +			reg = <0x0b011000 0x1000>;
> +		};
> +
> +		timer@b120000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b120000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clock-frequency = <19200000>;
> +
> +			frame@b121000 {
> +				reg = <0x0b121000 0x1000>, <0x0b122000 0x1000>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <0>;
> +			};
> +
> +			frame@b123000 {
> +				reg = <0x0b123000 0x1000>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <1>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				reg = <0x0b124000 0x1000>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <2>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				reg = <0x0b125000 0x1000>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <3>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				reg = <0x0b126000 0x1000>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <4>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				reg = <0x0b127000 0x1000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <5>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				reg = <0x0b128000 0x1000>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <6>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		imem: imem@8600000 {
> +			compatible = "simple-mfd";

You need specific compatible. This is imem. I was already fixing other
boards but I think new ones appeared... so I will re-fix these.


> +			reg = <0x08600000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0x08600000 0x1000>;
> +
> +			pil-reloc@94c {
> +				compatible = "qcom,pil-reloc-info";
> +				reg = <0x94c 0xc8>;
> +			};
> +		};
> +	};
> +

Best regards,
Krzysztof

