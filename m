Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A36F7AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjEECaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEECau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:30:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B68711544
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 19:30:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so8606155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683253845; x=1685845845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHd6awHMIT1ZuZgmRC4EFRtAIxyb2YMEXiL1eYpLWGk=;
        b=t9UJ1pVXFIvVM7dI7nTIdM06HGovKEtoRqskwSI9K2YrcdD2OQJcNbbVru9lTvwZJP
         ZiNHHbnhSEkEf70cS+Kntf61SYLn+wNOeCECyZp6kSvlJYfvFFw2VzX4/JlAxJ/oRAZJ
         zQg0IZ1upvUpg45Lw+GEe5nE3MsVb409CqrmZPmdv9w0qNnmR0kaUQB4ld7flT8/OFU4
         rlRYHAwXwqBKPIC7N8SB4gkTbv/8EqNWTv/vbs5vq6T53PJk4bPr4VxBT0n9YbzQIYlT
         34EXGKx6RCt4KjeCR2i4QBbPxWHEf6r7HwkCRFYGYL/SSs0c2XKvoSHK0oVndnmg8s0K
         ddEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683253845; x=1685845845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHd6awHMIT1ZuZgmRC4EFRtAIxyb2YMEXiL1eYpLWGk=;
        b=W7r/ncwnoKQuAuD35PY7GqastWhStiHF4PdFOz2auXfU30Py6sajNeNuV5K/StiyMm
         J6tXo/dJKo320va2FTzZWNM88pFwnQ5jkvPRL8iXYcVOhyNSOHC4YfhfQ42hwe+DV52q
         m3FyqfDolqCsdTGrg7M3piwIZBUg7BYHwKEcwr2nwxW3l+DdZ2VgBTMeoc9p/aUBIfhw
         JxnVtFEAFdEl0mVRlbCDMH5h9sbMxsYR3FheghDFOmKxdj1rmKzFPhCiCgxLY73q0aoj
         M3hzHBuu3Nfn+TnomFqOv2oHOid/OHI0kfoT/pR8z80YK0Ab7cpJ4nN7dYyK5uB/Gx/S
         rctw==
X-Gm-Message-State: AC+VfDzg/it/8BCdyP4Vzb0xmFNRH0/aPdl0mYWdJfjMqdXjUJrwVvPJ
        VFxr2bOO25lsm65zc+7fCtijyA==
X-Google-Smtp-Source: ACHHUZ6BDD1/Prkvjl0XcavBE6I5FXn/S+wkQqh4TH7ZELpZgTcesll6erynrQhhw344aaZ+gmDARQ==
X-Received: by 2002:a05:600c:ca:b0:3f3:1299:5625 with SMTP id u10-20020a05600c00ca00b003f312995625mr990611wmm.30.1683253844968;
        Thu, 04 May 2023 19:30:44 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bc8d0000000b003f17e79d74asm6477899wml.7.2023.05.04.19.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 19:30:44 -0700 (PDT)
Message-ID: <67e5f823-e9bf-cc52-3693-59880f495cbb@linaro.org>
Date:   Fri, 5 May 2023 03:30:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505-fxtec-pro1x-support-v1-1-1d9473b4d6e4@riseup.net>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230505-fxtec-pro1x-support-v1-1-1d9473b4d6e4@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2023 21:33, Dang Huynh wrote:
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

Hi Dang,

Thanks for the patch! I'm glad to see it :D

Just a few minor suggestions from me. Firstly, please can you re-order
the devicetree nodes to be alphabetical. I also left a few comments below.

With these nitpicks fixed:

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 252 ++++++++++++++++++++++++
>  2 files changed, 253 insertions(+)
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
> index 000000000000..f1d18710d2f0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
> +	model = "F(x)tec Pro1 (QX1050)";
> +	compatible = "fxtec,pro1x", "qcom,sm6115";
> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */

This comment isn't necessary, these two properties are documented in
Documentation/devicetree/bindings/arm/qcom.yaml and are easily searchable.
> +	qcom,msm-id = <417 0x10000>, <444 0x10000>;
> +	qcom,board-id = <34 0>;
> +
> +	aliases {
> +	};

I think this node can be dropped if it's empty.
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1080 * 2160 * 4)>;
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
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <14 4>;
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
> +&dispcc {
> +	/* HACK: disable until a panel driver is ready to retain simplefb */
> +	status = "disabled";
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
> +
> +&sleep_clk {
> +	clock-frequency = <32764>;
> +};
> +
> +&ufs_mem_hc {
> +	vcc-supply = <&vreg_l24a>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-supply = <&vreg_l11a>;
> +	vccq2-max-microamp = <600000>;
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
> ---
> base-commit: 145e5cddfe8b4bf607510b2dcf630d95f4db420f
> change-id: 20230505-fxtec-pro1x-support-7f782f0480e9
> 
> Best regards,

-- 
Kind Regards,
Caleb (they/them)
