Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332A3682020
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjA3XzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjA3XzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:55:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E335B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:55:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q19so2831555edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFjOWHgkvZebxYzxoiCAE7e2/Np/cCk8o0D0l7t8ZKc=;
        b=WaDg1frrPGPqEKtZzwZsb+v7eYHophW7esHgpb1wMId8WusF5WXqprpgnxhlp9jKig
         1xtNxO//E3lIbkdwkepGa/oIyQBFA2EiA12qQW67sR8qPltZkjOnl6yuzFeCriKTJGcw
         +YqBCQoEzSQByTBPmzqRW6GSkFdTkmTmeYehRJ4UQTJHrwQJoM1GmAqtXV35hl9vkQD9
         3GaK7ibIE12k0AYMu8a2AMY3wRPpuSoz3g4on/ngjbeoMUT4ryeFKhRijwWM/GuEExdC
         dgJKIGCinjG3h4a1C8W3dfgKpi/yItJHyYAaBYjFop+CHiyTeViMve8gGSddxl27xXwo
         q8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFjOWHgkvZebxYzxoiCAE7e2/Np/cCk8o0D0l7t8ZKc=;
        b=bhxfGK47J9InQgHjqZmD8qQhdIPSEubZBEMDe6ypyRcmUgsQ22SE2R1l+Yapd320MF
         3nd5v7GmDfk9T1rT7OvqsHdK1IrcGI5DWNlN7eEoCGVF8sPxi3xvy26tK8FtlQCU2pbP
         6aj07Elhtann0C48XL0YId1uDcjDf2X3FGAAwALB1eaxlp6trYvWZAuHW/4EbRrD0PH2
         PeXSWAiZRrBqvfdhB1AQj961Wzv0MnQW/tugOJLcNXaCoT8pUTuudJKFwR08Fs2wokzG
         mD61D6HbFXC7qx/fQ2g41QsdL9K/02uy1N9ZHKh6rFqw+kS8Kdxq5alB3Nh7LFHY4Xpg
         UmNw==
X-Gm-Message-State: AO0yUKX4eHEbeqXcqTOVyWw2oVHDgIJAwLc4eW4GXQIjNaa6h3rFIRNH
        C2S2RdtnEiKMuMM0IgxC6c4TyA==
X-Google-Smtp-Source: AK7set/xwdMiW0hR2LsXAcGXBFzyg+8SBGaAVKoJNEBRgwPqjHJKeiMs6U2qCHenWgSRz+hdLh3dAw==
X-Received: by 2002:a05:6402:528a:b0:49f:88ef:8d76 with SMTP id en10-20020a056402528a00b0049f88ef8d76mr30839260edb.29.1675122905202;
        Mon, 30 Jan 2023 15:55:05 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id w12-20020a05640234cc00b0049fc459ef1fsm7454163edc.90.2023.01.30.15.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:55:04 -0800 (PST)
Message-ID: <a1171edc-f1f2-da95-b0b4-81e3f5f7935d@linaro.org>
Date:   Tue, 31 Jan 2023 00:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V3 6/7] arm64: dts: qcom: Add ipq9574 SoC and AL02 board
 support
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230130125528.11509-1-quic_devipriy@quicinc.com>
 <20230130125528.11509-7-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130125528.11509-7-quic_devipriy@quicinc.com>
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



On 30.01.2023 13:55, devi priya wrote:
> Add initial device tree support for Qualcomm IPQ9574 SoC
> and AL02 board
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
>         - Updated the order of signed-offs
> 
>  Changes in V2:
>         - Updated the node name - emmc_pins to sdc_default_state
>         - Moved the xo and sleep clock frequency to board DT
>         - Removed the pipe clock definitions
>         - Dropped clock frequency property for timer nodes
>         - Added qcom,ipq9574-sdhci compatible string 
>         - Updated the copyright year to 2023
>         - Corrected the indentations
> 
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  78 +++++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 285 +++++++++++++++++++
>  3 files changed, 364 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0423ca3e79f..ff40e86181d4 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += ipq9574-al02-c7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> new file mode 100644
> index 000000000000..4aa06e4f63c7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 AL02-C7 board device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
> +	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
> +
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&blsp1_uart2 {
> +	pinctrl-0 = <&uart2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sdhc_1 {
> +	pinctrl-0 = <&sdc_default_state>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	sdc_default_state: sdc-default-state {
> +		clk-pins {
> +			pins = "gpio5";
> +			function = "sdc_clk";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "gpio4";
> +			function = "sdc_cmd";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "gpio0", "gpio1", "gpio2",
> +				"gpio3", "gpio6", "gpio7",
> +				"gpio8", "gpio9";
The second and third rows are still incorrectly indented.

> +			function = "sdc_data";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		rclk-pins {
> +			pins = "gpio10";
> +			function = "sdc_rclk";
> +			drive-strength = <8>;
> +			bias-pull-down;
> +		};
> +	};

[...]

> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		tz_region: memory@4a600000 {
tz@

> +			reg = <0x0 0x4a600000 0x0 0x400000>;
> +			no-map;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +		compatible = "simple-bus";
compatible first, please

> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,ipq9574-tlmm";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 65>;
> +			gpio-reserved-ranges = <59 1>;
It's reserved in the pinctrl driver, no need to do it again here.


> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			uart2_pins: uart2-state {
> +				pins = "gpio34", "gpio35";

[...]

> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			reg = <0x0b000000 0x1000>,  /* GICD */
> +			      <0x0b002000 0x1000>,  /* GICC */
> +			      <0x0b001000 0x1000>,  /* GICH */
> +			      <0x0b004000 0x1000>;  /* GICV */
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			ranges = <0 0x0b00c000 0x3000>;
> +
> +			v2m0: v2m@0 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x0 0xffd>;
> +				msi-controller;
> +			};
> +
> +			v2m1: v2m@1 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00001000 0xffd>;
Unit address must match the address part of the reg property.

> +				msi-controller;
> +			};
> +
> +			v2m2: v2m@2 {
And here.

Konrad
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
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			frame@b123000 {
> +				reg = <0x0b123000 0x1000>;
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				reg = <0x0b124000 0x1000>;
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				reg = <0x0b125000 0x1000>;
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				reg = <0x0b126000 0x1000>;
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				reg = <0x0b127000 0x1000>;
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				reg = <0x0b128000 0x1000>;
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
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
