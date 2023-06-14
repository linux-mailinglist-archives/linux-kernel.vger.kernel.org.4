Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3A72FB52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbjFNKk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243732AbjFNKkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:40:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6BA19AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:40:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f642a24568so8338876e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686739205; x=1689331205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/MPXbgWZ6Bb4Q6iWIVkMd2Ydwy7nYmcqjTIO5cJ/NM=;
        b=TY69fy21qzfz7CIt3c0M/M7LnHzclI6PlH4lBT0OIuY89S6NkqhqGACm7d2r7OGi6F
         b7HCz72qxtkhtxZc+67MGd+F1XkrOOGJEo24kUADzvDEMoKy2gr7ECdSyhuptc67lVui
         Ef4vsGujZH76+GjBMBPB50Z/ogkZmD/A5tJTbG1zsnMaaqwtcXPH0xpmWUg7WSShlQg6
         wGNqX/xRgc2ConN6Tt6iWw1TTuR7C+AsQxrtO8YCYlRzHHxWweTb0RxEAmX+80iTjaup
         lkSkYQqjd9G5w1V4nX6jS+prFJZ/2DyIQmeFBXHykVbNztIogftNIWMR/Uk1u1nxmbY0
         lfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739205; x=1689331205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/MPXbgWZ6Bb4Q6iWIVkMd2Ydwy7nYmcqjTIO5cJ/NM=;
        b=DKgjToCBFKseaRAOTeOLwnv5qn+6YJjCLgQoXspkOMsshwTB2GjLVO96dpWxe/3RAK
         68G4n6mnH0Tv4cltAHUfiNSSNuiY8Vpm7k4kEjqm1InzZoCMCIBUAsAZgP2rvO83Kn/Y
         jsf1sjM0TY2SSVkWPhsnMCyW/oQ5eyjJIr54Psq0FWwx73LTrQoX9ZyiX9BEFInQcQQd
         F4e4fJqQM99UUo4fyNxsTaGbF8gVaCRQ/+pz2/Qh9OTO5u7619+OQ1qkwhDuqFJ25CxD
         SGP418Em4XOZ1hNRoYfoN9aujovePr56HvXPgzUzeYN60xYid7297eLhnfkCbYt04DSV
         kBoQ==
X-Gm-Message-State: AC+VfDwV1aqtNm19p/EkS2ox69gZIFyG1NTyXGob0Pe9OgN9zhInlHzY
        wJwG0x3GSLOvi0+CfYMH+xwscW3f8JfRaV59cIw=
X-Google-Smtp-Source: ACHHUZ6Q3QRxn5XizBE5VFLMJuDmJ35SfFEP2WX0fpXpa5qNj+GP5kc6VDajF0jfU+TYInx+Wd3KJA==
X-Received: by 2002:a19:5f58:0:b0:4f6:5198:652c with SMTP id a24-20020a195f58000000b004f65198652cmr6910813lfj.62.1686739204641;
        Wed, 14 Jun 2023 03:40:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id w20-20020a19c514000000b004f740564140sm1270269lfe.214.2023.06.14.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 03:40:04 -0700 (PDT)
Message-ID: <f850b295-212f-ac06-3ad2-c86213875019@linaro.org>
Date:   Wed, 14 Jun 2023 12:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: ipq9574: Add common RDP dtsi file
Content-Language: en-US
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_poovendh@quicinc.com
References: <20230614085040.22071-1-quic_anusha@quicinc.com>
 <20230614085040.22071-2-quic_anusha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230614085040.22071-2-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.06.2023 10:50, Anusha Rao wrote:
> Add a dtsi file to include interfaces that are common
> across RDPs.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
This enables SDHCI on RDP453. Whether or not it was intended, please
mention it in the commit message.

Konrad
>  .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 121 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts   | 107 +---------------
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  88 +------------
>  arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts   |  65 +---------
>  arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts   |  65 +---------
>  5 files changed, 125 insertions(+), 321 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> new file mode 100644
> index 000000000000..999902bc70bd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 RDP board common device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&blsp1_spi0 {
> +	pinctrl-0 = <&spi_0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&blsp1_uart2 {
> +	pinctrl-0 = <&uart2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-mp5496-regulators";
> +
> +		ipq9574_s1: s1 {
> +		/*
> +		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> +		 * During regulator registration, kernel not knowing the initial voltage,
> +		 * considers it as zero and brings up the regulators with minimum supported voltage.
> +		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> +		 * the regulators are brought up with 725mV which is sufficient for all the
> +		 * corner parts to operate at 800MHz
> +		 */
> +			regulator-min-microvolt = <725000>;
> +			regulator-max-microvolt = <1075000>;
> +		};
> +	};
> +};
> +
> +&sdhc_1 {
> +	pinctrl-0 = <&sdc_default_state>;
> +	pinctrl-names = "default";
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	max-frequency = <384000000>;
> +	bus-width = <8>;
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
> +			       "gpio3", "gpio6", "gpio7",
> +			       "gpio8", "gpio9";
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
> +
> +	spi_0_pins: spi-0-state {
> +		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> +		function = "blsp0_spi";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <24000000>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
> index 2b093e02637b..924e4c50101a 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
> @@ -8,117 +8,12 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C2";
>  	compatible = "qcom,ipq9574-ap-al02-c2", "qcom,ipq9574";
>  
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&blsp1_spi0 {
> -	pinctrl-0 = <&spi_0_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
> -		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		spi-max-frequency = <50000000>;
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
>  };
>  
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -	};
> -};
> -
> -&sdhc_1 {
> -	pinctrl-0 = <&sdc_default_state>;
> -	pinctrl-names = "default";
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	max-frequency = <384000000>;
> -	bus-width = <8>;
> -	status = "okay";
> -};
>  
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
> -&tlmm {
> -	sdc_default_state: sdc-default-state {
> -		clk-pins {
> -			pins = "gpio5";
> -			function = "sdc_clk";
> -			drive-strength = <8>;
> -			bias-disable;
> -		};
> -
> -		cmd-pins {
> -			pins = "gpio4";
> -			function = "sdc_cmd";
> -			drive-strength = <8>;
> -			bias-pull-up;
> -		};
> -
> -		data-pins {
> -			pins = "gpio0", "gpio1", "gpio2",
> -			       "gpio3", "gpio6", "gpio7",
> -			       "gpio8", "gpio9";
> -			function = "sdc_data";
> -			drive-strength = <8>;
> -			bias-pull-up;
> -		};
> -
> -		rclk-pins {
> -			pins = "gpio10";
> -			function = "sdc_rclk";
> -			drive-strength = <8>;
> -			bias-pull-down;
> -		};
> -	};
> -
> -	spi_0_pins: spi-0-state {
> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> -		function = "blsp0_spi";
> -		drive-strength = <8>;
> -		bias-disable;
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
> -};
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 2b3ed8d351f7..ae2578ba6980 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -8,96 +8,10 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>  	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>  
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -	};
> -};
> -
> -&sdhc_1 {
> -	pinctrl-0 = <&sdc_default_state>;
> -	pinctrl-names = "default";
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	max-frequency = <384000000>;
> -	bus-width = <8>;
> -	status = "okay";
> -};
> -
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
> -&tlmm {
> -	sdc_default_state: sdc-default-state {
> -		clk-pins {
> -			pins = "gpio5";
> -			function = "sdc_clk";
> -			drive-strength = <8>;
> -			bias-disable;
> -		};
> -
> -		cmd-pins {
> -			pins = "gpio4";
> -			function = "sdc_cmd";
> -			drive-strength = <8>;
> -			bias-pull-up;
> -		};
> -
> -		data-pins {
> -			pins = "gpio0", "gpio1", "gpio2",
> -			       "gpio3", "gpio6", "gpio7",
> -			       "gpio8", "gpio9";
> -			function = "sdc_data";
> -			drive-strength = <8>;
> -			bias-pull-up;
> -		};
> -
> -		rclk-pins {
> -			pins = "gpio10";
> -			function = "sdc_rclk";
> -			drive-strength = <8>;
> -			bias-pull-down;
> -		};
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
> index c8fa54e1a62c..d36d1078763e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
> @@ -8,73 +8,10 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C6";
>  	compatible = "qcom,ipq9574-ap-al02-c6", "qcom,ipq9574";
>  
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&blsp1_spi0 {
> -	pinctrl-0 = <&spi_0_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
> -		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		spi-max-frequency = <50000000>;
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -	};
> -};
> -
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
> -&tlmm {
> -	spi_0_pins: spi-0-state {
> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> -		function = "blsp0_spi";
> -		drive-strength = <8>;
> -		bias-disable;
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> index f01de6628c3b..c30c9fbedf26 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> @@ -8,73 +8,10 @@
>  
>  /dts-v1/;
>  
> -#include "ipq9574.dtsi"
> +#include "ipq9574-rdp-common.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
>  	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
>  
> -	aliases {
> -		serial0 = &blsp1_uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&blsp1_spi0 {
> -	pinctrl-0 = <&spi_0_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
> -		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		spi-max-frequency = <50000000>;
> -	};
> -};
> -
> -&blsp1_uart2 {
> -	pinctrl-0 = <&uart2_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&rpm_requests {
> -	regulators {
> -		compatible = "qcom,rpm-mp5496-regulators";
> -
> -		ipq9574_s1: s1 {
> -		/*
> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> -		 * During regulator registration, kernel not knowing the initial voltage,
> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> -		 * the regulators are brought up with 725mV which is sufficient for all the
> -		 * corner parts to operate at 800MHz
> -		 */
> -			regulator-min-microvolt = <725000>;
> -			regulator-max-microvolt = <1075000>;
> -		};
> -	};
> -};
> -
> -&sleep_clk {
> -	clock-frequency = <32000>;
> -};
> -
> -&tlmm {
> -	spi_0_pins: spi-0-state {
> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> -		function = "blsp0_spi";
> -		drive-strength = <8>;
> -		bias-disable;
> -	};
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <24000000>;
>  };
