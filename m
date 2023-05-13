Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D5701611
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbjEMKNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjEMKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:13:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD35273D
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:13:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso79845645e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683972811; x=1686564811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TntwDyRQBQkREIDCdn4BpjeykfiqHeYROq6mlKfx9fQ=;
        b=iB/sL0NLZKH3Mydm+DkOmMhXHr+1VBsyoKMAZ/LNrEbDOxWoWVZfhxTmJhCWdyp5Fg
         7g26sXOIDhwlxgUwmZpX3l5niyXIH+POn9MGlrF9lQGeyFAtCBLxs+uqun9nHaespV85
         MfKQZxWB4qiabpRWHjk7Og9D8bDZqGlbshh/V+hqAp7UqLjo+JuktQdl4vQrKcc7H8SH
         BOQQyr7PeSWt9r/B3wWLskm78jy2Dgca8ZhSvg+04lDeGF4L7jqm7ipB//1+tjVIOfDv
         32uSi0vj/XVDJBEVkIEYkTViaFSP2yiQtaEWkWu4/RlIZ4XGHoU6UcPAOPXYGMDuM/WH
         MaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683972811; x=1686564811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TntwDyRQBQkREIDCdn4BpjeykfiqHeYROq6mlKfx9fQ=;
        b=aOn1kGvMzCjVsz+gji1uBVQKVndDPQHFbQldqcSaCnPx8fiAgqtgRdr5bCOKHc0GAs
         J7ZxfnGSnFtF5ZJScOU++R51TlYjg3XnLDU8DIhyxFGEpoelakMkHMWUlHqDwBemt0r9
         jincjIn2ElmhLcomeRbIYoBF/Jv7CK+ULdcl4E/CmXtSlMEgcnarM1BuOnj/zX36hVMu
         eF+1bbO86D/3S12E2WWYfv/c+nXJXILe4+wQaGcWrO0ETYnERb2RPCMMCPdKVlUthnwg
         GtcU08eZeS4x9toyDFvk/wxGdENYOBhVLySE2SmYXb/OfxrkKSDyVlMG90Fuyg6eo92/
         bnWw==
X-Gm-Message-State: AC+VfDylPooCPK2ESbzZR7zCv5SmgVyNYSaXRSCQW2DJHME7kC1LrKmj
        CSUN7UyLfSe5fvoYTF9YVQk3WA==
X-Google-Smtp-Source: ACHHUZ4Vo5NqUXY0PkQGL1cwYSYcHh+SDIqUmKazCu03inG1yMQkTNnE3lr5p54Lkqe1V4vDOirR5w==
X-Received: by 2002:a7b:ca51:0:b0:3f4:2174:b27d with SMTP id m17-20020a7bca51000000b003f42174b27dmr15232001wml.39.1683972811096;
        Sat, 13 May 2023 03:13:31 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c020700b003f42e008c8dsm11677671wmi.44.2023.05.13.03.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 03:13:30 -0700 (PDT)
Message-ID: <d1f1fd32-8191-bb78-decd-c10e9c538ad7@linaro.org>
Date:   Sat, 13 May 2023 10:13:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
 <20230505-fxtec-pro1x-support-v3-2-0c9c7f58b205@riseup.net>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230505-fxtec-pro1x-support-v3-2-0c9c7f58b205@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/05/2023 01:05, Dang Huynh wrote:
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

Thanks Dang, hopefully we get support for that sweet sweet physical
keyboard soon!

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 250 ++++++++++++++++++++++++
>  2 files changed, 251 insertions(+)
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
> index 000000000000..3ce9875e932c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm6115.dtsi"
> +#include "pm6125.dtsi"
> +#include <dt-bindings/arm/qcom,ids.h>
> +
> +/ {
> +	model = "F(x)tec Pro1X (QX1050)";
> +	compatible = "fxtec,pro1x", "qcom,sm6115";
> +	chassis-type = "handset";
> +
> +	qcom,msm-id = <QCOM_ID_SM6115 0x10000>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0x5c000000 0x0 (1080 * 2160 * 4)>;
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
> +		pinctrl-0 = <&vol_up_n>;
> +		pinctrl-names = "default";
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
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		pm6125_s6a: s6 {
> +			regulator-min-microvolt = <304000>;
> +			regulator-max-microvolt = <1456000>;
> +		};
> +
> +		pm6125_s7a: s7 {
> +			regulator-min-microvolt = <1280000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		pm6125_s8a: s8 {
> +			regulator-min-microvolt = <1064000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		pm6125_l1a: l1 {
> +			regulator-min-microvolt = <952000>;
> +			regulator-max-microvolt = <1152000>;
> +		};
> +
> +		pm6125_l4a: l4 {
> +			regulator-min-microvolt = <488000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		pm6125_l5a: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3056000>;
> +		};
> +
> +		pm6125_l6a: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		pm6125_l7a: l7 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		pm6125_l8a: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		pm6125_l9a: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		pm6125_l10a: l10 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l11a: l11 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1952000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		pm6125_l12a: l12 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <1984000>;
> +		};
> +
> +		pm6125_l13a: l13 {
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		pm6125_l14a: l14 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l15a: l15 {
> +			regulator-min-microvolt = <2920000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		pm6125_l16a: l16 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		pm6125_l17a: l17 {
> +			regulator-min-microvolt = <1152000>;
> +			regulator-max-microvolt = <1384000>;
> +		};
> +
> +		pm6125_l18a: l18 {
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1312000>;
> +		};
> +
> +		pm6125_l19a: l19 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		pm6125_l20a: l20 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		pm6125_l21a: l21 {
> +			regulator-min-microvolt = <2400000>;
> +			regulator-max-microvolt = <3600000>;
> +		};
> +
> +		pm6125_l22a: l22 {
> +			regulator-min-microvolt = <2952000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		pm6125_l23a: l23 {
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3400000>;
> +		};
> +
> +		pm6125_l24a: l24 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <3600000>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +};
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
> +	vcc-supply = <&pm6125_l24a>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-supply = <&pm6125_l11a>;
> +	vccq2-max-microamp = <600000>;
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&pm6125_l4a>;
> +	vdda-pll-supply = <&pm6125_l12a>;
> +	vddp-ref-clk-supply = <&pm6125_l18a>;
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
> +	vdd-supply = <&pm6125_l4a>;
> +	vdda-pll-supply = <&pm6125_l12a>;
> +	vdda-phy-dpdm-supply = <&pm6125_l15a>;
> +	status = "okay";
> +};
> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
> 

-- 
Kind Regards,
Caleb (they/them)
