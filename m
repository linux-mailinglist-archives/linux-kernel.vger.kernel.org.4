Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525FC713069
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjEZXg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEZXgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:36:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B31F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:36:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so2319960e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685144181; x=1687736181;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8aHH4bwAIGi4TXqYQZBpRXn2xRLYPqkRwFmzcf8RQ0=;
        b=moFYde6zXumMKz5aEaI0uk1nbXQpQh0uuVU0N7nOcW9bIN+E14KL40GGacKKdKlzSS
         C7azggyeQcADIXum3OOM2sFl5USu6mX72UQq3Cx4cK7Xzn2dq2O9UsTcygC39DhVioz4
         HSHZ6gcXHtkZluYkbUSaXvoOivO/1AECJzDkXNX5Hv9FmlkH4lEueiRBbwCPifsndRD2
         EKsK52Y1S6Z0loWj7eSF1We/2stHFCbU+hZRV5XOBdZj/KX/Frdhx6M7O7eqtEy8AldY
         jVncaYlOSWI4ZtFqY/t+BFKKIogi4v4YgV3vh4RkBVUdo7uXJCM1sbCY6oed/p0PoHkg
         F6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685144181; x=1687736181;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8aHH4bwAIGi4TXqYQZBpRXn2xRLYPqkRwFmzcf8RQ0=;
        b=LGu5glChBlGxUr6rAcInaZMwjxD6gth2geEdVd0AQdkteESwpLXGLgUijCr7rBDaRL
         cbNapu/a8jMMg77o9taKCqxxHDm3vGc+nqHjt0Hmqjjkl/cIaPIDl5hkkrlXExY0K4V/
         TYqVJDEVaGBJqp9V+kstbS8yU6DzfefDHF167jhk8XYeU2PbOrXsb+k1hRnLicgi2DEt
         IOol3j5j7DOTVPThQAuMJFxNtJGe1RQSXS7/I3OgRExStMAe/hu38N2MJRg/ITUew0LG
         T8mn6Gn69olRNYIC7MTEIjbJ+JIlSlyppGUu3ap4jJkAm1rar7KxO4NmRxJfdGV+ix6L
         GAgg==
X-Gm-Message-State: AC+VfDxNPIaVOcAHtazHHfF/9+Zr/9FPeeIPYozDNKburITLbNuOrZ8W
        kF0YN4/KDXSh5CEeLmtJ0Bd4Uw==
X-Google-Smtp-Source: ACHHUZ7IKzShJJud6IE5qi1orR9D9JjPUqaQtzqM51it7GaT9GyszcYoRVGVxRPY7Z8yv4xqM4X4RA==
X-Received: by 2002:a05:6512:398b:b0:4f4:cb90:d2a0 with SMTP id j11-20020a056512398b00b004f4cb90d2a0mr137829lfu.22.1685144180796;
        Fri, 26 May 2023 16:36:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q26-20020ac24a7a000000b004ec83bc3e2dsm827243lfp.42.2023.05.26.16.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 16:36:20 -0700 (PDT)
Message-ID: <947e3212-f6ef-f00d-19c2-4f629af0e791@linaro.org>
Date:   Sat, 27 May 2023 01:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     david@ixit.cz, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230524230459.120681-1-guptarud@gmail.com>
 <20230524230459.120681-5-guptarud@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 5/5] ARM: Add Samsung Galaxy Express support
In-Reply-To: <20230524230459.120681-5-guptarud@gmail.com>
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



On 25.05.2023 01:04, Rudraksha Gupta wrote:
> This adds a very basic device tree file for the Samsung Galaxy Express
> SGH-I437. Currently, the following things work: UART, eMMC, SD Card, and
> USB.
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/qcom-msm8960-samsung-expressatt.dts   | 334 ++++++++++++++++++
>  2 files changed, 335 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..12c90f263142 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1081,6 +1081,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-msm8916-samsung-grandmax.dtb \
>  	qcom-msm8916-samsung-serranove.dtb \
>  	qcom-msm8960-cdp.dtb \
> +	qcom-msm8960-samsung-expressatt.dtb \
>  	qcom-msm8974-lge-nexus5-hammerhead.dtb \
>  	qcom-msm8974-sony-xperia-rhine-amami.dtb \
>  	qcom-msm8974-sony-xperia-rhine-honami.dtb \
> diff --git a/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> new file mode 100644
> index 000000000000..2d6f0def0589
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/input/input.h>
> +
> +#include "qcom-msm8960.dtsi"
> +#include <dt-bindings/reset/qcom,gcc-msm8960.h>
> +
> +/ {
> +	model = "Samsung Galaxy S3 SGH-I437";
Googling the model name, it seems to be officially sold as
"Samsung Galaxy Express", without any mention of the S3 bit.
Is that on purpose?

> +	compatible = "samsung,expressatt", "qcom,msm8960";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		serial0 = &gsbi5_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&gsbi5 {
> +	status = "okay";
> +	qcom,mode = <GSBI_PROT_I2C_UART>;
Please ensure status is the last property within each node

> +};
> +
> +&gsbi5_serial {
> +	status = "okay";
> +};
> +
> +/* eMMC */
> +&sdcc1 {
You may want to add aliases for mmc hosts (check e.g.
arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts)

> +	status = "okay";
> +	vmmc-supply = <&pm8921_l5>;
> +};
> +
> +/* External micro SD card */
> +&sdcc3 {
> +	status = "okay";
> +	vmmc-supply = <&pm8921_l6>;
> +	vqmmc-supply = <&pm8921_l7>;
> +};
> +
> +&gsbi1 {
> +	status = "okay";
> +	qcom,mode = <GSBI_PROT_SPI>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_default>;
Please do

pinctrl-n
pinctrl-names

> +};
> +
> +&gsbi1_spi{
Add a space between 'i' and '{'

Konrad
> +	status = "okay";
> +};
> +
> +&msmgpio {
> +	spi1_default: spi1_default {
> +		mux {
> +			pins = "gpio6", "gpio7", "gpio9";
> +			function = "gsbi1";
> +		};
> +
> +		mosi {
> +			pins = "gpio6";
> +			drive-strength = <12>;
> +			bias-disable;
> +		};
> +
> +		miso {
> +			pins = "gpio7";
> +			drive-strength = <12>;
> +			bias-disable;
> +		};
> +
> +		cs {
> +			pins = "gpio8";
> +			drive-strength = <12>;
> +			bias-disable;
> +			output-low;
> +		};
> +
> +		clk {
> +			pins = "gpio9";
> +			drive-strength = <12>;
> +			bias-disable;
> +		};
> +	};
> +};
> +
> +
> +&rpm {
> +	regulators {
> +		compatible = "qcom,rpm-pm8921-regulators";
> +		vin_lvs1_3_6-supply = <&pm8921_s4>;
> +		vin_lvs2-supply = <&pm8921_s4>;
> +		vin_lvs4_5_7-supply = <&pm8921_s4>;
> +		vdd_ncp-supply = <&pm8921_l6>;
> +		vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
> +		vdd_l21_l23_l29-supply = <&pm8921_s8>;
> +		vdd_l24-supply = <&pm8921_s1>;
> +		vdd_l25-supply = <&pm8921_s1>;
> +		vdd_l27-supply = <&pm8921_s7>;
> +		vdd_l28-supply = <&pm8921_s7>;
> +
> +		/* Buck SMPS */
> +		pm8921_s1: s1 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1225000>;
> +			regulator-max-microvolt = <1225000>;
> +			qcom,switch-mode-frequency = <3200000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_s2: s2 {
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1300000>;
> +			qcom,switch-mode-frequency = <1600000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_s3: s3 {
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1150000>;
> +			qcom,switch-mode-frequency = <4800000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_s4: s4 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			qcom,switch-mode-frequency = <1600000>;
> +			bias-pull-down;
> +			qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
> +		};
> +
> +		pm8921_s7: s7 {
> +			regulator-min-microvolt = <1150000>;
> +			regulator-max-microvolt = <1150000>;
> +			qcom,switch-mode-frequency = <3200000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_s8: s8 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <2050000>;
> +			regulator-max-microvolt = <2050000>;
> +			qcom,switch-mode-frequency = <1600000>;
> +			bias-pull-down;
> +		};
> +
> +		/* PMOS LDO */
> +		pm8921_l1: l1 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1050000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l2: l2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l3: l3 {
> +			regulator-min-microvolt = <3075000>;
> +			regulator-max-microvolt = <3300000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l4: l4 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l5: l5 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l6: l6 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l7: l7 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1850000>;
> +			regulator-max-microvolt = <2950000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l8: l8 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3100000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l9: l9 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l10: l10 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l11: l11 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3300000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l12: l12 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l14: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l15: l15 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l16: l16 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3000000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l17: l17 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l18: l18 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1500000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l21: l21 {
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <1900000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l22: l22 {
> +			regulator-min-microvolt = <2750000>;
> +			regulator-max-microvolt = <2750000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l23: l23 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l24: l24 {
> +			regulator-min-microvolt = <750000>;
> +			regulator-max-microvolt = <1150000>;
> +			bias-pull-down;
> +		};
> +
> +		pm8921_l25: l25 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1225000>;
> +			regulator-max-microvolt = <1225000>;
> +			bias-pull-down;
> +		};
> +
> +		/* Low Voltage Switch */
> +		pm8921_lvs1: lvs1 {
> +			bias-pull-down;
> +		};
> +
> +		pm8921_lvs2: lvs2 {
> +			bias-pull-down;
> +		};
> +
> +		pm8921_lvs3: lvs3 {
> +			bias-pull-down;
> +		};
> +
> +		pm8921_lvs4: lvs4 {
> +			bias-pull-down;
> +		};
> +
> +		pm8921_lvs5: lvs5 {
> +			bias-pull-down;
> +		};
> +
> +		pm8921_lvs6: lvs6 {
> +			bias-pull-down;
> +		};
> +
> +		pm8921_lvs7: lvs7 {
> +			bias-pull-down;
> +		};
> +
> +		pm8921_ncp: ncp {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			qcom,switch-mode-frequency = <1600000>;
> +		};
> +	};
> +};
> +
> +&usb_hs1_phy {
> +	v3p3-supply = <&pm8921_l3>;
> +	v1p8-supply = <&pm8921_l4>;
> +};
> +
> +&usb1 {
> +	status = "okay";
> +	dr_mode = "otg";
> +};
> +
