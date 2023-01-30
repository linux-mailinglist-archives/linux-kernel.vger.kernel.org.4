Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D4680D93
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbjA3MZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjA3MZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:25:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B5206AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:25:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml19so7657786ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkR3BTFY1oVomQa8hlX0b7MVFpByHTMAOSPu+tHlr70=;
        b=HYqm4Lnvsdlbv3LS6+g7g7LaI/wMYzZNjyxH6SbiQb8jVCybdLwquBujoW+BuUUcku
         Cl1jpTdXxfSOCetzfSTfiwEoS6zj1yiXdsJcAs1hFMLMCIx4uRaGIimgHmwhbxa224jB
         KnINr7J1KWa3SGk/aEGQZiYimUlfvXeOJdmU9V0WPOs/qi1QHmFzjj/oX7YVpLElmPar
         lhOZhadpMMPF5ZuaGDUsCRSdDOTGSipaHsOz+/ZZ30oYbHktPlJAHSt4+rzxIbedgBSp
         h8Kt1XSS9ci2uTLxzWlWsgT2N1xDv5y7dTEmSWBd84Fb3bNWuJ2X0YNQ6/QJVPHJ/o7v
         +nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkR3BTFY1oVomQa8hlX0b7MVFpByHTMAOSPu+tHlr70=;
        b=0kgurMjI05Kwrct25VjY5Z4psQPMU8Nl0468e3jdH84sBqb0jS7xWwP5QsFBSfadfp
         7dIogCMmyWjZireaaOpx4ss9lNOULMCq70r9z28Lw8q14Hl3AQJHnSOknd0Z3x9mSmGT
         mpvA7aLLsxO+XH9APhv+aa/Y73sFcXpEERu9dq5iIKs+bErU6pU+0D0lGlQqxd8SclqI
         j1qcBwA6RFPk+eu9Ynb067lB+Krw9ismD+a8JWLqSOoKt2TU8AAN7n3LW20kBfVtjt2m
         Yskh7w/ik6EzbHdiKPueCB0zp0QIvsTc9jQP2d+NVTx5v7Vhp1O+cQ+seepUcxCHfu/0
         mErA==
X-Gm-Message-State: AFqh2kpgvw6Ie+7iWXpuKFDyKw9CkOa4i3qzQK5Pcem1mqoc+QfvIFJx
        dyj5VqDK7NAfyp+6kDETlUoxhg==
X-Google-Smtp-Source: AMrXdXvr7lbfBr/0aAPcw/lRc7A3Gxq6jzYwol6WZi9K5FbXJFqpTlQyqukpZJ8FgA920AjDdCNJvg==
X-Received: by 2002:a17:906:a058:b0:84d:4e9b:ace5 with SMTP id bg24-20020a170906a05800b0084d4e9bace5mr47899987ejb.67.1675081554102;
        Mon, 30 Jan 2023 04:25:54 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906394900b00872a726783dsm6766163eje.217.2023.01.30.04.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 04:25:53 -0800 (PST)
Message-ID: <1d8777f7-ec11-b68c-629e-b17d5772396b@linaro.org>
Date:   Mon, 30 Jan 2023 13:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 8/9] arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board
 support
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
 <20230130114702.20606-9-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130114702.20606-9-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.01.2023 12:47, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> Add initial device tree support for the Qualcomm IPQ5332 SoC and
> MI01.2 board.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
[...]

> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		tz_mem: tz@4a600000 {
> +			no-map;
> +			reg = <0x0 0x4a600000 0x0 0x200000>;
reg should come before no-map


> +		};
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,ipq5332-tlmm";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 53>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			serial_0_pins: serial0-state {
> +				pins = "gpio18", "gpio19";
> +				function = "blsp0_uart0";
> +				drive-strength = <8>;
> +				bias-pull-up;
> +			};
> +		};
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,ipq5332-gcc";
> +			reg = <0x01800000 0x80000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			clock-names = "xo",
> +				      "sleep_clk",
> +				      "pcie_2lane_phy_pipe_clk",
> +				      "pcie_2lane_phy_pipe_clk_x1",
> +				      "usb_pcie_wrapper_pipe_clk";
> +			clocks = <&xo_board>,
> +				 <&sleep_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +		};
> +
> +		sdhc: mmc@7804000 {
> +			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
> +
> +			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&xo_board>;
> +			clock-names = "iface", "core", "xo";
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			max-frequency = <192000000>;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart0: serial@78af000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078af000 0x200>;
> +			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			reg = <0x0b000000 0x1000>,	/* GICD */
> +			      <0x0b002000 0x1000>,	/* GICC */
> +			      <0x0b001000 0x1000>,	/* GICH */
> +			      <0x0b004000 0x1000>;	/* GICV */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x0b00c000 0x3000>;
> +
> +			v2m0: v2m@0 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00000000 0xffd>;
> +				msi-controller;
> +			};
> +
> +			v2m1: v2m@1 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00001000 0xffd>;
The unit address does not match the address part of the reg
property, dtbs_check will not succeed..

The rest lgtm

Konrad
> +				msi-controller;
> +			};
> +
> +			v2m2: v2m@2 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00002000 0xffd>;
> +				msi-controller;
> +			};
> +		};
> +
> +		timer@b120000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b120000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			frame@b120000 {
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
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
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +};
