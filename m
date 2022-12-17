Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E964FB72
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLQR4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 12:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLQR4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 12:56:42 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05A12A98;
        Sat, 17 Dec 2022 09:56:40 -0800 (PST)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4NZDDl6jLQzDqgj;
        Sat, 17 Dec 2022 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1671299800; bh=rgVvW+QSVBgX3nDCbaWA1aBTc5DpyYA+GfFdLOSQ09g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mpzm1QBZs+HUu9ApIbPJ/eyypTLRs2EsSt2rCwIkW5xpMlg3xtEQ/EajewdI6J15C
         5fa+OMMcqSiFAzPEKLA725D75dP1LakbXrEc99ysupOxPXUg+AiwOpgfesnOddvhNX
         TxBi/Xb0mfes+JGkq7+HdNjSgyfL7yw79F+H0dws=
X-Riseup-User-ID: 31A5AF4E0E9AD3A9049DA48DA65AF0F5EEE9BABFC61F39D0B165D21C3D4BBF8D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4NZDDh6KZhz5vbr;
        Sat, 17 Dec 2022 17:56:36 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add Lenovo Tab P11 (J606F/XiaoXin Pad) dts
Date:   Sun, 18 Dec 2022 00:56:25 +0700
Message-ID: <6898596.lOV4Wx5bFT@melttower>
In-Reply-To: <20221208201401.530555-5-konrad.dybcio@linaro.org>
References: <20221208201401.530555-1-konrad.dybcio@linaro.org>
 <20221208201401.530555-5-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add an initial device tree for the Lenovo Tab P11. Currently it
> enables:
> 
> - simplefb
> - SD Card slot via SDHCI2
> - gpio-keys & PON keys
> - UFS
> - RPM regulators
> - USB2
> 
> This has been validated with a rev (62) device. You can check yours
> next to the serial no. on the sticker in the lower portion of the
> back side of your tablet.
> 
> To get a successful boot run:
> 
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/\
> sm6115p-lenovo-j606f.dtb > .Image.gz-dtb
> 
> ~/mkbootimg/mkbootimg.py \
> --kernel .Image.gz-dtb \
> --ramdisk some/initrd.img \
> --pagesize 4096 \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --tags_offset 0x100 \
> --cmdline 'SOME_CMDLINE' \
> --dtb_offset 0x1f00000 \
> --header_version 1 \
> --os_version 11 \
> --os_patch_level 2022-11 \
> -o j606f.img
> 
> fastboot flash boot j606f.img
> fastboot flash dtbo empty.img
> fastboot flash recovery empty.img
> fastboot reboot
> 
> Where empty.img is 2 zero-bytes.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    | 290 ++++++++++++++++++
>  2 files changed, 291 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile
> b/arch/arm64/boot/dts/qcom/Makefile index 3e79496292e7..5d281436172d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -156,6 +156,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts new file mode 100644
> index 000000000000..102730dd49a7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2022 Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include "sm6115.dtsi"
> +#include "pm6125.dtsi"
> +
> +/ {
> +	model = "Lenovo Tab P11";
> +	compatible = "lenovo,j606f", "qcom,sm6115p", "qcom,sm6115";
> +	chassis-type = "tablet";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <445 0x10000>, <420 0x10000>;
> +	qcom,board-id = <34 3>;
> +
> +	aliases {
> +		mmc0 = &sdhc_2;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (2000 * 1200 * 4)>;
> +			width = <1200>;
> +			height = <2000>;
> +			stride = <(1200 * 4)>;
> +			format = "a8r8g8b8";
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		label = "gpio-keys";
Why is this needed? I had to make a patch to remove this label from many 
device trees a few months ago and I haven't had any issue with it.
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm6125_gpio 5 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> +
> +&dispcc {
> +	/* HACK: disable until a panel driver is ready to retain simplefb 
*/
> +	status = "disabled";
> +};
> +
> +&pm6125_gpio {
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
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		pm6125_s6: s6 {
> +			regulator-min-microvolt = <304000>;
> +			regulator-max-microvolt = <1456000>;
> +		};
> +
> +		pm6125_s7: s7 {
> +			regulator-min-microvolt = <1280000>;
> +			regulator-max-microvolt = <2080000>;
> +		};
> +
> +		pm6125_s8: s8 {
> +			regulator-min-microvolt = <1064000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		pm6125_l1: l1 {
> +			regulator-min-microvolt = <952000>;
> +			regulator-max-microvolt = <1152000>;
> +		};
> +
> +		pm6125_l4: l4 {
> +			regulator-min-microvolt = <488000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		pm6125_l5: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			/* 3.056V capped to 2.96V for SDHCI */
> +			regulator-max-microvolt = <2960000>;
> +			regulator-allow-set-load;
> +			/* Broken hw, this one can't be turned off or 
SDHCI will break! */
> +			regulator-always-on;
> +		};
> +
> +		pm6125_l6: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		pm6125_l7: l7 {
> +			/* 1.2V-1.304V fixed at 1.256V for SDHCI bias 
*/
> +			regulator-min-microvolt = <1256000>;
> +			regulator-max-microvolt = <1256000>;
> +			/*
> +			 * TODO: SDHCI seems to also work with this 
one turned off, however
> +			 * there exists a possibility that it may 
not work with some very
> +			 * specific SDCard types, perhaps validating 
this against a wide
> +			 * range of models could rule that out, 
saving some power would
> +			 * certainly be nice..
> +			 */
> +			regulator-always-on;
> +		};
> +
> +		pm6125_l8: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		pm6125_l9: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		pm6125_l10: l10 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l11: l11 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		pm6125_l12: l12 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <1984000>;
> +		};
> +
> +		pm6125_l13: l13 {
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		pm6125_l14: l14 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l15: l15 {
> +			regulator-min-microvolt = <2920000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		pm6125_l16: l16 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l17: l17 {
> +			regulator-min-microvolt = <1152000>;
> +			regulator-max-microvolt = <1384000>;
> +		};
> +
> +		pm6125_l18: l18 {
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1312000>;
> +		};
> +
> +		pm6125_l19: l19 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		pm6125_l20: l20 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		pm6125_l21: l21 {
> +			regulator-min-microvolt = <2400000>;
> +			regulator-max-microvolt = <3600000>;
> +		};
> +
> +		pm6125_l22: l22 {
> +			regulator-min-microvolt = <2952000>;
> +			/* 3.304V capped to 2.96V for SDHCI */
> +			regulator-max-microvolt = <2960000>;
> +			regulator-allow-set-load;
> +			/* Broken hw, this one can't be turned off or 
SDHCI will break! */
> +			regulator-always-on;
> +		};
> +
> +		pm6125_l23: l23 {
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3400000>;
> +		};
> +
> +		pm6125_l24: l24 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <3600000>;
> +		};
> +	};
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_state_on &sdc2_gate_pin>;
> +	pinctrl-1 = <&sdc2_state_off>;
> +	vmmc-supply = <&pm6125_l22>;
> +	vqmmc-supply = <&pm6125_l5>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32764>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <14 4>;
> +
> +	/*
> +	 * This is a wholly undocumented pin (other than a single vague
> "pwr-gpios" reference) +	 * that needs to be toggled for the SD Card slot
> to work properly.. +	 */
> +	sdc2_gate_pin: sdc2-gate-state {
> +		pins = "gpio45";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +		output-high;
> +	};
> +};
> +
> +&ufs_mem_hc {
> +	vcc-supply = <&pm6125_l24>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-supply = <&pm6125_l11>;
> +	vccq2-max-microamp = <600000>;
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&pm6125_l4>;
> +	vdda-pll-supply = <&pm6125_l12>;
> +	vddp-ref-clk-supply = <&pm6125_l18>;
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_hsphy {
> +	vdd-supply = <&pm6125_l4>;
> +	vdda-pll-supply = <&pm6125_l12>;
> +	vdda-phy-dpdm-supply = <&pm6125_l15>;
> +	status = "okay";
> +};
> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};




