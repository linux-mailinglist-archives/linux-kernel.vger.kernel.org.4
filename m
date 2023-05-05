Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09666F88C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjEESl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjEESl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:41:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0D1A4AE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:41:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so2441743e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683312082; x=1685904082;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzPy+iq8a63Uih5V5BHvhkK4VYVy2xJjUkPpIT7jjdE=;
        b=XfGN3SuTBQF73/rg4jMXOCkVwj/o73CYxcVrt1bHNPbpE3R75EkWCfpr7qdoDTrVTj
         FkfqTKGQPjz6IMrsPMwpnn73X17vpTwlpPLvnEh9x3Xkej18lML4K8QenunJUjL4h/1S
         CvSWK92t9aPGRd5NHvKcBPOxZm5rGlVqHIq4r3EvoIUq3dXGu08tbJRHnavOWuNxrLEB
         I0WgLjCwEfVFUlmo/lo15BH9GO/wpq/gH997LAnNNhoejg/jDYiRWunSdEjF5s0Btvru
         fHgyHJByVZKxlIF/KlLvobI0TyRLadz8rV3sS28oVtup2n1Ku7/vv2rr32njQevmBw38
         ogyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312082; x=1685904082;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzPy+iq8a63Uih5V5BHvhkK4VYVy2xJjUkPpIT7jjdE=;
        b=RgUeLdgWqHDpRjOi5qGT+bNsYK0FPQ+A9vP9RnCwUW9yEbp9aoeIdKj0XzxFMtod/U
         KV02cH/DUrUKpcmqSN9tnGxzRvt12Sa3TqtfmoX2i1kzYUgUd+AvkvCjZDcdc7N9zvuK
         Nft58gn0NGBYYb52744Caced5F6SmLrr6bJ26F5UAQYNM8l177XbMP6yzBrHIcWVYXf5
         mtxe78v/CM0JwsMqwhZVuIcYr4Pb0TAqkYvopivMTscuGWxj17nUIEYpAHDjQK90TvSX
         Zv0bmvd0rj8x0NaDI82mzNDH9R2AzYUc0YFHK2ZLbUnVdYOCiKpy5V45jHHWJgZCFOp7
         uwmw==
X-Gm-Message-State: AC+VfDyae74lMji7cE7HzXpDG6Y7amiiL+GcWMtRTUsRHAt70SNcwvvq
        ivJAvBW6HvS/M81keMIH9ADWiw==
X-Google-Smtp-Source: ACHHUZ5Kq8DCcFerFvnER6d5bxfAsAulsOWNSVgtTTfvVVk4qhoQlbHeCl701Vi9kVR4uiApSJvUdQ==
X-Received: by 2002:a19:7412:0:b0:4eb:c12:df1c with SMTP id v18-20020a197412000000b004eb0c12df1cmr695998lfe.65.1683312081866;
        Fri, 05 May 2023 11:41:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y3-20020a2e95c3000000b002a7a03e1c67sm76154ljh.13.2023.05.05.11.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:41:21 -0700 (PDT)
Message-ID: <abae55ef-172b-036f-40a9-b27c38e850ec@linaro.org>
Date:   Fri, 5 May 2023 20:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net>
 <20230505-fxtec-pro1x-support-v2-1-0ea2378ba9ae@riseup.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
In-Reply-To: <20230505-fxtec-pro1x-support-v2-1-0ea2378ba9ae@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.05.2023 19:12, Dang Huynh wrote:
> The F(x)tec Pro1X is a mobile phone released by FX Technologies Ltd
> in 2022.
> 
> The phone is exactly the same as the Pro1 released in 2019 with some
> changes:
> - MSM8998 -> SM6115
> - Camera button is no longer multistate
> - Only one 48MP back camera
> - A new keyboard layout picked by the community.
> 
> This commit has the following features working:
> - Display (using simplefb)
> - UFS
> - Power and volume buttons
> - Pinctrl
> - RPM Regulators
> - USB (Device Mode)
> 
> To get a successful boot run:
> 
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/\
> sm6115-fxtec-pro1x.dtb  > .Image.gz-dtb
> 
> mkbootimg --kernel .Image.gz-dtb \
> --ramdisk initrd.img \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --second_offset 0xf00000 \
> --tags_offset 0x100 \
> --pagesize 4096 \
> --cmdline "CMDLINE HERE" \
> -o qx1050-boot.img
> 
> fastboot flash boot qx1050-boot.img
> fastboot erase dtbo
> fastboot reboot
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 248 ++++++++++++++++++++++++
>  2 files changed, 249 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d42c59572ace..e311ba675f35 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -174,6 +174,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> new file mode 100644
> index 000000000000..a9ff1d9534ae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only
I'm not a licensing expert, but fyi sm6115.dtsi uses (GPL2+ & BSD3)

> +/*
> + * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm6115.dtsi"
> +#include "pm6125.dtsi"
> +
> +/ {
> +	model = "F(x)tec Pro1X (QX1050)";
> +	compatible = "fxtec,pro1x", "qcom,sm6115";
> +	chassis-type = "handset";
> +
> +	qcom,msm-id = <417 0x10000>, <444 0x10000>;
Please include include/dt-bindings/arm/qcom,ids.h and use the
defines.

417 corresponds to the weaker version of this SoC, SM4250. It may
not necessarily make sense to add it to the list if we know it
shouldn't be used.

> +	qcom,board-id = <34 0>;
Does the bootloader refuse to boot without these? Some newer
ones don't need it.

In case they are compulsory, you'll have to add the pro1x to the
relevant allOf:if:then: block in bindings.

> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1080 * 2160 * 4)>;
Use 0x0 in reg, please.

> +			width = <1080>;
> +			height = <2160>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;
property-n
property-names

> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> +
> +&dispcc {
> +	/* HACK: disable until a panel driver is ready to retain simplefb */
> +	status = "disabled";
> +};
> +
> +&pm6125_gpios {
> +	vol_up_n: vol-up-n-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	pm6125-regulators {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		vreg_s6a: s6 {
You can keep the PMIC name apparent by renaming vreg_s6a to
pm6125_s6 etc.

Konrad
> +			regulator-min-microvolt = <304000>;
> +			regulator-max-microvolt = <1456000>;
> +		};
> +
> +		vreg_s7a: s7 {
> +			regulator-min-microvolt = <1280000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		vreg_s8a: s8 {
> +			regulator-min-microvolt = <1064000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		vreg_l1a: l1 {
> +			regulator-min-microvolt = <952000>;
> +			regulator-max-microvolt = <1152000>;
> +		};
> +
> +		vreg_l4a: l4 {
> +			regulator-min-microvolt = <488000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		vreg_l5a: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3056000>;
> +		};
> +
> +		vreg_l6a: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		vreg_l7a: l7 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		vreg_l8a: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		vreg_l9a: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		vreg_l10a: l10 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l11a: l11 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		vreg_l12a: l12 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <1984000>;
> +		};
> +
> +		vreg_l13a: l13 {
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		vreg_l14a: l14 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l15a: l15 {
> +			regulator-min-microvolt = <2920000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		vreg_l16a: l16 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l17a: l17 {
> +			regulator-min-microvolt = <1152000>;
> +			regulator-max-microvolt = <1384000>;
> +		};
> +
> +		vreg_l18a: l18 {
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1312000>;
> +		};
> +
> +		vreg_l19a: l19 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		vreg_l20a: l20 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		vreg_l21a: l21 {
> +			regulator-min-microvolt = <2400000>;
> +			regulator-max-microvolt = <3600000>;
> +		};
> +
> +		vreg_l22a: l22 {
> +			regulator-min-microvolt = <2952000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		vreg_l23a: l23 {
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3400000>;
> +		};
> +
> +		vreg_l24a: l24 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <3600000>;
> +		};
> +	};
> +};
> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
Out of alphabetical order

> +
> +&sleep_clk {
> +	clock-frequency = <32764>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <14 4>;
> +};
> +
> +&ufs_mem_hc {
> +	vcc-supply = <&vreg_l24a>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-supply = <&vreg_l11a>;
> +	vccq2-max-microamp = <600000>;
You need `regulator-allow-set-load` on regulators which
set current (i.e. sdhci and ufs/phy regulators)

> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +	vddp-ref-clk-supply = <&vreg_l18a>;
> +	status = "okay";
> +};
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb_dwc3 {
> +	maximum-speed = "high-speed";
Do you know whether the phone supports usb3? Usually if that's
the case, you will get usb3 in fastboot.

You'll need an actual usb3 cable to check that though, many claim
that but then don't have the necessary wires connected.

Konrad
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_hsphy {
> +	vdd-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +	vdda-phy-dpdm-supply = <&vreg_l15a>;
> +	status = "okay";
> +};
> 
