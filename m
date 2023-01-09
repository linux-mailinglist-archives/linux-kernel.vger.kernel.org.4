Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95695662563
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjAIMVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjAIMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:21:08 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDED1B9EA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:21:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d30so7740247lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w17QSa1ARYLt0H4+l17Tri9UL9700QafW8CiMlQZ0uM=;
        b=TdYMmxQXzKHh1BjRxuzDNgzgDfl51r4VwvA6AksxTgEUHLBraxCNyZhoLfclQcSFT2
         nTj5Te2Iv2r7IzjwuHj7kRPeSipmrANcuJfep6eiOAe4pI9zn+PAkBvio/HSk3GOUqpu
         aC89R/Cq3UdvZyYVyKWH650Oe/jXAdxJhPZl+EoAoEWUPJjdA+AVGvZ2E6n+wjA/SBj6
         PCZ0kXAGGiCbkCgGJDQ9KGWKqx6zEIwbW8e2kPB2JF0FJVsVybhzPjdzw7dmwaComqYx
         SzhEF1MApuLvCC8a6Jm3bqPXiKGibozrttBu7UBohaOQ17sZHg7Aa+EfpX1SVWrcUfI2
         ftnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w17QSa1ARYLt0H4+l17Tri9UL9700QafW8CiMlQZ0uM=;
        b=rcsZedvYV0942Qmn9kzux50T4YnBJSiHLqdAC7TRiNdAJ7ZiC3XAku+Q1PetJm2BLW
         7AJpUfazFOmcCIzH9RIthTzMElneZCWM/WRR08+deiphgEDyJmPDNAtxNTigpTe27Vpv
         q3nizClJEtemev0ytYTZ0WOUpWVBtf90HU0RJA/Zu+i9YkMGL6f1rmsSztHFjuLFMjwm
         CF9dNEw1OHxDCHB/jArK4GaBcvHlP2Fm2hDST3C4lrOFWhBylppgNzAVHoJ3Cbw8lFe2
         TVG1uuYyTm0Ds24jm7w7BIG7N+zAiYepE8+dQj5n7XWMMLCqJFsxOVIL/NFUQBriCK4j
         3VlA==
X-Gm-Message-State: AFqh2krjJX1FJl5z+Q0hXK488FeQkIy8DEDhqTed4oqWCbcwBQ+AxisB
        eOAWeO0ktls05PrlIfXbRMe9ww==
X-Google-Smtp-Source: AMrXdXtPQON1Ss/DWTegUWU0BoVgOaMkJeldz0jQ6A8VM3F2Mgy+/T77nl9C71ZH1M+OlDNBPw75Tg==
X-Received: by 2002:a05:6512:31d1:b0:4b5:7925:8707 with SMTP id j17-20020a05651231d100b004b579258707mr22533225lfe.26.1673266863572;
        Mon, 09 Jan 2023 04:21:03 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fe6000000b004b6efcb7bb5sm1599179lfg.169.2023.01.09.04.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:21:03 -0800 (PST)
Message-ID: <ee8c5ad1-77c0-43fe-a233-ee1fa31f1a3a@linaro.org>
Date:   Mon, 9 Jan 2023 13:21:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230108195336.388349-1-they@mint.lgbt>
 <20230108195336.388349-7-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230108195336.388349-7-they@mint.lgbt>
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



On 8.01.2023 20:53, Lux Aliaga wrote:
> Add support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
> summary on what's defined.
> 
> - dmesg output to bootloader preconfigured display
> - USB
> - UFS
> - SD card
> - SMD RPM regulators
> - Volume Up, Down and Power buttons
> - Thermistors
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 424 ++++++++++++++++++
>  2 files changed, 425 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7..2b2a0170db14 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -157,6 +157,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> new file mode 100644
> index 000000000000..7ff18f481060
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> @@ -0,0 +1,424 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include "sm6125.dtsi"
> +#include "pm6125.dtsi"
> +
> +/ {
> +	model = "Xiaomi Mi A3";
> +	compatible = "xiaomi,laurel-sprout", "qcom,sm6125";
> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <394 0>; /* sm6125 v1 */
> +	qcom,board-id = <11 0>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1560 * 720 * 4)>;
> +			width = <720>;
> +			height = <1560>;
> +			stride = <(720 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
These two properties are already set in the SoC dtsi, you can
drop them.

> +
> +		debug_mem: debug@ffb00000 {
> +			reg = <0x0 0xffb00000 0x0 0xc0000>;
> +			no-map;
> +		};
> +
> +		last_log_mem: lastlog@ffbc0000 {
> +			reg = <0x0 0xffbc0000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		pstore_mem: ramoops@ffc00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xffc40000 0x0 0xc0000>;
> +			record-size = <0x1000>;
> +			console-size = <0x40000>;
> +			msg-size = <0x20000 0x20000>;
> +		};
> +
> +		cmdline_mem: memory@ffd00000 {
> +			reg = <0x0 0xffd40000 0x0 0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	extcon_usb: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&vol_up_n>;
> +		pinctrl-names = "default";
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&pm6125_gpio 5 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	thermal-zones {
> +		rf-pa0-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pm6125_adc_tm 0>;
> +
> +			trips {
> +				active-config0 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		quiet-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&pm6125_adc_tm 1>;
> +
> +			trips {
> +				active-config0 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		xo-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pm6125_adc_tm 2>;
> +
> +			trips {
> +				active-config0 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&hsusb_phy1 {
> +	vdd-supply = <&vreg_l7a>;
> +	vdda-pll-supply = <&vreg_l10a>;
> +	vdda-phy-dpdm-supply = <&vreg_l15a>;
> +	status = "okay";
> +};
> +
> +&pm6125_adc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm>;
> +
> +	adc-chan@4d {
> +		reg = <ADC5_AMUX_THM1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +		label = "rf_pa0_therm";
> +	};
> +
> +	adc-chan@4e {
> +		reg = <ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +		label = "quiet_therm";
> +	};
> +
> +	adc-chan@52 {
> +		reg = <ADC5_GPIO1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +		label = "camera_flash_therm";
> +	};
> +
> +	adc-chan@54 {
> +		reg = <ADC5_GPIO3_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +		qcom,pre-scaling = <1 1>;
> +		label = "emmc_ufs_therm";
> +	};
> +};
> +
> +&pm6125_adc_tm {
> +	status = "okay";
> +
> +	rf-pa0-therm@0 {
> +		reg = <0>;
> +		io-channels = <&pm6125_adc ADC5_AMUX_THM1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	quiet-therm@1 {
> +		reg = <1>;
> +		io-channels = <&pm6125_adc ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	xo-therm@2 {
> +		reg = <2>;
> +		io-channels = <&pm6125_adc ADC5_XO_THERM_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +};
> +
> +&pm6125_gpio {
> +	camera_flash_therm: camera-flash-therm-state {
> +		pins = "gpio3";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		bias-high-impedance;
> +	};
> +
> +	emmc_ufs_therm: emmc-ufs-therm-state {
> +		pins = "gpio6";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		bias-high-impedance;
> +	};
> +
> +	vol_up_n: vol-up-n-state {
> +		pins = "gpio5";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		input-enable;
> +		bias-pull-up;
> +	};
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	status = "okay";
> +	linux,code = <KEY_VOLUMEDOWN>;
Status should go last.

With these two addressed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +};
> +
> +&rpm_requests {
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		vreg_s6a: s6 {
> +			regulator-min-microvolt = <936000>;
> +			regulator-max-microvolt = <1422000>;
> +		};
> +
> +		vreg_l1a: l1 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1256000>;
> +		};
> +
> +		vreg_l2a: l2 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1056000>;
> +		};
> +
> +		vreg_l3a: l3 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1064000>;
> +		};
> +
> +		vreg_l4a: l4 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l5a: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6a: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		vreg_l7a: l7 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		vreg_l8a: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		vreg_l9a: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +		};
> +
> +		vreg_l10a: l10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l11a: l11 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1952000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l12a: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1996000>;
> +		};
> +
> +		vreg_l13a: l13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1832000>;
> +		};
> +
> +		vreg_l14a: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l15a: l15 {
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		vreg_l16a: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l17a: l17 {
> +			regulator-min-microvolt = <1248000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		vreg_l18a: l18 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1264000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l19a: l19 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		vreg_l20a: l20 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		vreg_l21a: l21 {
> +			regulator-min-microvolt = <2600000>;
> +			regulator-max-microvolt = <2856000>;
> +		};
> +
> +		vreg_l22a: l22 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l23a: l23 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +		};
> +
> +		vreg_l24a: l24 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +};
> +
> +&sdc2_off_state {
> +	sd-cd-pins {
> +		pins = "gpio98";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
> +&sdc2_on_state {
> +	sd-cd-pins {
> +		pins = "gpio98";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
> +	vmmc-supply = <&vreg_l22a>;
> +	vqmmc-supply = <&vreg_l5a>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <22 2>, <28 6>;
> +};
> +
> +&ufs_mem_hc {
> +	vcc-supply = <&vreg_l24a>;
> +	vccq2-supply = <&vreg_l11a>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-max-microamp = <600000>;
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l10a>;
> +	vdda-phy-max-microamp = <51400>;
> +	vdda-pll-max-microamp = <14200>;
> +	vddp-ref-clk-supply = <&vreg_l18a>;
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	extcon = <&extcon_usb>;
> +};
