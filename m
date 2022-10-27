Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72460FBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiJ0PX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiJ0PXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:23:23 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64887DF7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:23:21 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g16so1367385qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=li3Jh5qYXAa7bCGf9rDsJ94tZJUZjYPQ2H/IZws9h/Y=;
        b=QOT3M7TkkrB8Tk6pzL/SO/jHWwY2VIN/6/8SBlIz3RiXLShWaHoFDTsrOYZzDZnsEO
         GIJQaXmYDBWgMeLPLuDwD1MhxsUi7DLmv93Zyu0mVXyTZRdycaNQ3kztlmKAbB37Qfrj
         IFsgR+srKzZi9erQ8wFOsADuJBoueidp0q/dVJTnEoIaSuBHQYea9CzmIlH/l/fOLhp3
         96Sm19GbeKgCLLvXA59XxJ9THTykAVzSp3owNAEm6iipSmMHa8Veauy/U7EIqrqg3zch
         MQH/79sorL0fUVDJrWjGkCqkFSENJNhwziAztWMjozn5NaUDnWs0cIKjd87wOMoXXaq5
         EUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li3Jh5qYXAa7bCGf9rDsJ94tZJUZjYPQ2H/IZws9h/Y=;
        b=w06e6o0TWnBLT2T+tno0X+Egg86riJLF38ak+tHYwx7czjY+IERoEdXfBRaVR2wBO1
         uX4N5/Ip81O2EjVfj/E/brpUzJcr7WdpVdWL10pPboXaS3/+4g3mDt6fy3u2SUqVchw6
         WlkFvpG+yslqluPx+lT8mw1HHEzbRSXCKTdmOoPfQ1XXllsuMWI5e0Z9KPSf4OvAlwx7
         vLQGf9cYgzOG/Zrar9p5YVJ+I4P+S7L9WghHWtb5ICcveMDMvXNy10pHu05gjiLpu5Sm
         jwwgcggfgO5RPJOM26wf1saNXPHNkyLxuwCLfYYtrWr03zSPsAv4k7tnjvF7kyJzJ6uJ
         I+ng==
X-Gm-Message-State: ACrzQf00CFnVXeH4ATX1ThunKTslVvTGJ4ookPijs+5Yb3aB+IAts7Kc
        9jsvtFirm8xim9Guw6mwrgP/1g==
X-Google-Smtp-Source: AMsMyM5ifqA15mlV8+0/tz2R+8K5kOHeFxBvZ3Dbn4PXE4/GVYyM8Wdd4cYs11ITahQDWi5ZJazgYA==
X-Received: by 2002:a05:622a:1747:b0:39c:d4f5:a65 with SMTP id l7-20020a05622a174700b0039cd4f50a65mr41828713qtk.583.1666884200429;
        Thu, 27 Oct 2022 08:23:20 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a409200b006cdd0939ffbsm1138446qko.86.2022.10.27.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:23:19 -0700 (PDT)
Message-ID: <8866af06-39b6-a2f6-0e2f-f1bebaaa004d@linaro.org>
Date:   Thu, 27 Oct 2022 11:23:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-5-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026200429.162212-5-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 16:04, Melody Olvera wrote:
> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
> SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   2 +
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 245 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 245 +++++++++++++++++++++++
>  3 files changed, 492 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0558d3389e5..8ee949a58ce7 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -51,7 +51,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> new file mode 100644
> index 000000000000..e4fd6e2b656b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "qdu1000.dtsi"
> +#include "pm8150.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
> +	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <19200000>;
> +			clock-output-names = "xo_board";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	ppvar_sys: ppvar-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ppvar_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +
> +		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
> +		vdd-l2-l10-supply = <&vph_pwr>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
> +		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
> +		vdd-l13-l16-l17-supply = <&vph_pwr>;
> +
> +		vreg_s2a_0p5: smps2 {
> +			regulator-name = "vreg_s2a_0p5";
> +			regulator-min-microvolt = <320000>;
> +			regulator-max-microvolt = <570000>;
> +		};
> +
> +		vreg_s3a_1p05: smps3 {
> +			regulator-name = "vreg_s3a_1p05";
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <1170000>;
> +		};
> +
> +		vreg_s4a_1p8: smps4 {
> +			regulator-name = "vreg_s4a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_s5a_2p0: smps5 {
> +			regulator-name = "vreg_s5a_2p0";
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		vreg_s6a_0p9: smps6 {
> +			regulator-name = "vreg_s6a_0p9";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1128000>;
> +		};
> +
> +		vreg_s7a_1p2: smps7 {
> +			regulator-name = "vreg_s7a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		vreg_s8a_1p3: smps8 {
> +			regulator-name = "vreg_s8a_1p3";
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +		};
> +
> +		vreg_l1a_0p91: ldo1 {
> +			regulator-name = "vreg_l1a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l2a_2p3: ldo2 {
> +			regulator-name = "vreg_l2a_2p3";
> +			regulator-min-microvolt = <2970000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l3a_1p2: ldo3 {
> +			regulator-name = "vreg_l3a_1p2";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1260000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l5a_0p8: ldo5 {
> +			regulator-name = "vreg_l5a_0p8";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l6a_0p91: ldo6 {
> +			regulator-name = "vreg_l6a_0p91";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-name = "vreg_l7a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +
> +		};
> +
> +		vreg_l8a_0p91: ldo8 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <888000>;
> +			regulator-max-microvolt = <925000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l9a_0p91: ldo9 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l10a_2p95: ldo10 {
> +			regulator-name = "vreg_l10a_2p95";
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l11a_0p91: ldo11 {
> +			regulator-name = "vreg_l11a_0p91";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-name = "vreg_l12a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-name = "vreg_l14a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <1950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-name = "vreg_l15a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l16a_1p8: ldo16 {
> +			regulator-name = "vreg_l16a_1p8";
> +			regulator-min-microvolt = <1710000>;
> +			regulator-max-microvolt = <1890000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l17a_3p3: ldo17 {
> +			regulator-name = "vreg_l17a_3p3";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l18a_1p2: ldo18 {
> +			regulator-name = "vreg_l18a_1p2";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> new file mode 100644
> index 000000000000..445124e84485
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "qru1000.dtsi"
> +#include "pm8150.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QRU1000 IDP";
> +	compatible = "qcom,qru1000-idp", "qcom,qru1000";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <19200000>;
> +			clock-output-names = "xo_board";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	ppvar_sys: ppvar-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ppvar_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +
> +		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
> +		vdd-l2-l10-supply = <&vph_pwr>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
> +		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
> +		vdd-l13-l16-l17-supply = <&vph_pwr>;
> +
> +		vreg_s2a_0p5: smps2 {
> +			regulator-name = "vreg_s2a_0p5";
> +			regulator-min-microvolt = <320000>;
> +			regulator-max-microvolt = <570000>;
> +		};
> +
> +		vreg_s3a_1p05: smps3 {
> +			regulator-name = "vreg_s3a_1p05";
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <1170000>;
> +		};
> +
> +		vreg_s4a_1p8: smps4 {
> +			regulator-name = "vreg_s4a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_s5a_2p0: smps5 {
> +			regulator-name = "vreg_s5a_2p0";
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		vreg_s6a_0p9: smps6 {
> +			regulator-name = "vreg_s6a_0p9";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1128000>;
> +		};
> +
> +		vreg_s7a_1p2: smps7 {
> +			regulator-name = "vreg_s7a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		vreg_s8a_1p3: smps8 {
> +			regulator-name = "vreg_s8a_1p3";
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +		};
> +
> +		vreg_l1a_0p91: ldo1 {
> +			regulator-name = "vreg_l1a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l2a_2p3: ldo2 {
> +			regulator-name = "vreg_l2a_2p3";
> +			regulator-min-microvolt = <2970000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l3a_1p2: ldo3 {
> +			regulator-name = "vreg_l3a_1p2";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1260000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l5a_0p8: ldo5 {
> +			regulator-name = "vreg_l5a_0p8";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l6a_0p91: ldo6 {
> +			regulator-name = "vreg_l6a_0p91";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-name = "vreg_l7a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +
> +		};
> +
> +		vreg_l8a_0p91: ldo8 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <888000>;
> +			regulator-max-microvolt = <925000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l9a_0p91: ldo9 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l10a_2p95: ldo10 {
> +			regulator-name = "vreg_l10a_2p95";
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l11a_0p91: ldo11 {
> +			regulator-name = "vreg_l11a_0p91";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-name = "vreg_l12a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-name = "vreg_l14a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <1950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-name = "vreg_l15a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l16a_1p8: ldo16 {
> +			regulator-name = "vreg_l16a_1p8";
> +			regulator-min-microvolt = <1710000>;
> +			regulator-max-microvolt = <1890000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l17a_3p3: ldo17 {
> +			regulator-name = "vreg_l17a_3p3";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l18a_1p2: ldo18 {
> +			regulator-name = "vreg_l18a_1p2";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};

Best regards,
Krzysztof

