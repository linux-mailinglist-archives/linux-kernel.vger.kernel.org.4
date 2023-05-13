Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92F77015C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbjEMJcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjEMJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:32:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEFF1BC5
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:32:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f25d79f6bfso6168362e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683970344; x=1686562344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2j6yML4VTm3RVRtiB9T22cc6YbB1Ma6I3GUz3afvnQ=;
        b=BgznDqJ+nt9aOGWWdP0VCBeM/dZAH1NWKeAu3LCBA3g/EtdSbMjUb++vfQZpPaMyxJ
         HGx5PeVxw8jo65XZgN/Un3YezyPKeffZY4DEMSTdq3niy51pOzHHJkoefalEevSLElHT
         AZIw0eigKMVedzRFWDt+0OYRR6k77PAyMjl2TNb6TqALzBep1BY57Le+29YvuL34/uAr
         zxUpg1s4lJ1MU1S/L1CwbGA6Qq84HjDDvp6v1zJUIiljli8IhpeCdeOdEwd7AZzfGNv3
         V+IqsMv1TtWGHMtVt0KYCZcnk4XGTGVYQMevd8weq4gSj2qVGw8agMEYnhhrFJtm874q
         hXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970344; x=1686562344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2j6yML4VTm3RVRtiB9T22cc6YbB1Ma6I3GUz3afvnQ=;
        b=NsAiJYxcDqx6mV0akMyoIryY5DOTLGJRO2Pq5MQSWeqtTK0/UNv5WqockqLbqRdXAC
         ke6CLZdwSOmrvUgWRdnyspYN5PzMD+4dy15YYogIPPRHuFpEjOoFJ7CFbZ4NZfMq+sWR
         oOIzlvl+0wb1F/sSMPFJYxcYvq2eoWuNs5O4X6LPukvZ6/Eb6QVzEFQmkF8+OpkxnoCP
         igPNWhhF7KmdvzFR3aEU6MtFOeMtyLFMBsdy3RCdj+4YFNM/cBqNJ2XIyPHMOSMiXiH0
         uIWtfU9bTo4r49151cbbPEkjroi3jGrifSoIBHFffTbm5V7ftdhDR2eCizs7Wqafeiew
         RQUw==
X-Gm-Message-State: AC+VfDwysNDUEtQ67mD9wVeJDm/yP0y3hXie1gxf1+AKj/HQYeeKsurn
        JIYvqrdkXOTXR/hl7KuNK5GM1A==
X-Google-Smtp-Source: ACHHUZ4NVuG1OTzPXNqnrX5GD1aVOu+Ye+VfUtyrYPkJvJxa++hTsnA78hXsEVY2zLHvAaJlDqAQqA==
X-Received: by 2002:ac2:4253:0:b0:4ea:f632:4738 with SMTP id m19-20020ac24253000000b004eaf6324738mr3926014lfl.6.1683970343710;
        Sat, 13 May 2023 02:32:23 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id z9-20020ac24f89000000b004e8451948desm1791263lfs.227.2023.05.13.02.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:32:23 -0700 (PDT)
Message-ID: <7a41e701-d184-53d1-04bc-b39868eb6bf5@linaro.org>
Date:   Sat, 13 May 2023 11:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
 <20230505-fxtec-pro1x-support-v3-2-0c9c7f58b205@riseup.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
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



On 13.05.2023 03:05, Dang Huynh wrote:
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
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
