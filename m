Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2072D637B98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKXOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKXOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:43:17 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10186FD1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:43:15 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u2so2220980ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Keu/zUBg0Z6OQkubfDh34dQ7E/R3mfv93eeBsB/9GeA=;
        b=weUrgXi6p7owFjZ3FjX9mNqQCMVGd0A4ZfJcQInSNYDZIVrDN8EADFCnb/Hga94iiD
         A8IxTiyB4MxJ/IFklTmrwDkw1BgO5QR2jOFSMOFUVv8bx68V7TcCH98j1BMZ+G4Uct7I
         go+7PHbNAZn0ANmJi9sCyZkExbTrblGb99mQjSIUMwiYeRKijuYolZaf+BOPftG6OLxS
         rMpr1dtv9ztklRxu1+UeeSrUfn10d0e6mxfurjPrZpiEQSdetxpqe7AwuZmKbY0P5HB4
         xWGcKL9KgSiXfCSKoFMJM0OEdFBpbStop29+sDAiGA9CL57xsL4IdqGuRUP38quZMoLK
         HOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Keu/zUBg0Z6OQkubfDh34dQ7E/R3mfv93eeBsB/9GeA=;
        b=lDYCWCQIBcWvE8XKNvDjg6IDMUicH6iq+v9DjlFpHNC3mCxfZdmQkCLQ6Pbgw5kX5A
         0C3Qo+UY5MYARBbb6u0KyXGWheL3whe2/If45KsjyvAlorG8eCCnlD1Hip1yfr13AtCd
         jWjJd5tfi9gkwsflXwazPMoXzDtk4um8dEVs0VrWI74KsMyqT+MKjMgAvEai4lc+rT/K
         e4gMKMJrB7t+lzt1VFSDWnZrU+TwpC/j3Op7K3GIu1hyB+8XbfuJi7s9uzZu/SKddHGz
         p82jr3gme+FoGsd9F2jvHheXqsf/6lGYIEpasp/ot2Eh+JuoWEarDUj0Ice4a4NLZx0H
         +yfg==
X-Gm-Message-State: ANoB5pmK7vnueRqyuv/m2vZSqglVmTr+m2E7rJDkrI+uHNXKF6krqunQ
        vARwLo7ZLS3hh/E6/BckKPTk9A==
X-Google-Smtp-Source: AA0mqf4CyNL9igDWU7RZ2gcxvigzHS7tIio6OcSbkzgnmozqXM3sVOTyCcHl6joRN04j4xsoZYxPgw==
X-Received: by 2002:a05:651c:171b:b0:26f:a90a:fd82 with SMTP id be27-20020a05651c171b00b0026fa90afd82mr11320495ljb.248.1669300993782;
        Thu, 24 Nov 2022 06:43:13 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id d23-20020a193857000000b00497a879e552sm136545lfj.291.2022.11.24.06.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:43:13 -0800 (PST)
Message-ID: <9f49fd73-2104-fd12-458c-e4d8152ce9d5@linaro.org>
Date:   Thu, 24 Nov 2022 15:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: Add base SM8550 MTP dts
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221124135646.1952727-1-abel.vesa@linaro.org>
 <20221124135646.1952727-11-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221124135646.1952727-11-abel.vesa@linaro.org>
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



On 24.11.2022 14:56, Abel Vesa wrote:
> Add dts file for Qualcomm MTP platform which uses SM8550 SoC.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
>  * renamed all pm8550*-rpmh-regulators regulators-*
>  * moved the status property in the proper place
>  * removed the card-det-pins envelope node
>  * moved sdc2-default-state to the dtsi file
> 
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 404 ++++++++++++++++++++++++
>  2 files changed, 405 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index afe496a93f94..b447b3082c84 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -169,3 +169,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> new file mode 100644
> index 000000000000..b0bcabecd60e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -0,0 +1,404 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8550.dtsi"
> +#include "pm8010.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550b.dtsi"
> +#include "pm8550ve.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +#include "pmr735d.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. SM8550 MTP";
> +	compatible = "qcom,sm8550-mtp", "qcom,sm8550";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
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
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm8550-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-bob1-supply = <&vph_pwr>;
> +		vdd-bob2-supply = <&vph_pwr>;
> +		vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +		vdd-l3-supply = <&vreg_s4g_1p3>;
> +		vdd-l6-l16-supply = <&vreg_bob1>;
> +		vdd-l6-l7-supply = <&vreg_bob1>;
> +		vdd-l8-l9-supply = <&vreg_bob1>;
> +		vdd-l11-supply = <&vreg_s4g_1p3>;
> +		vdd-l12-supply = <&vreg_s6g_1p8>;
> +		vdd-l15-supply = <&vreg_s6g_1p8>;
> +		vdd-l17-supply = <&vreg_bob2>;
> +
> +		vreg_bob1: bob1 {
> +			regulator-name = "vreg_bob1";
> +			regulator-min-microvolt = <3296000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob2: bob2 {
> +			regulator-name = "vreg_bob2";
> +			regulator-min-microvolt = <2720000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1b_1p8: ldo1 {
> +			regulator-name = "vreg_l1b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2b_3p0: ldo2 {
> +			regulator-name = "vreg_l2b_3p0";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5b_3p1: ldo5 {
> +			regulator-name = "vreg_l5b_3p1";
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p8: ldo6 {
> +			regulator-name = "vreg_l6b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_1p8: ldo7 {
> +			regulator-name = "vreg_l7b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8b_1p8: ldo8 {
> +			regulator-name = "vreg_l8b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_2p9: ldo9 {
> +			regulator-name = "vreg_l9b_2p9";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11b_1p2: ldo11 {
> +			regulator-name = "vreg_l11b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12b_1p8: ldo12 {
> +			regulator-name = "vreg_l12b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13b_3p0: ldo13 {
> +			regulator-name = "vreg_l13b_3p0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14b_3p2: ldo14 {
> +			regulator-name = "vreg_l14b_3p2";
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15b_1p8: ldo15 {
> +			regulator-name = "vreg_l15b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16b_2p8: ldo16 {
> +			regulator-name = "vreg_l16b_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17b_2p5: ldo17 {
> +			regulator-name = "vreg_l17b_2p5";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd-l3-supply = <&vreg_s4e_0p9>;
> +
> +		vreg_l3c_0p91: ldo3 {
> +			regulator-name = "vreg_l3c_0p9";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vdd-l1-supply = <&vreg_s4e_0p9>;
> +
> +		vreg_l1d_0p88: ldo1 {
> +			regulator-name = "vreg_l1d_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-3 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-l1-supply = <&vreg_s4e_0p9>;
> +		vdd-l2-supply = <&vreg_s4e_0p9>;
> +		vdd-l3-supply = <&vreg_s4g_1p3>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +
> +		vreg_s4e_0p9: smps4 {
> +			regulator-name = "vreg_s4e_0p9";
> +			regulator-min-microvolt = <904000>;
> +			regulator-max-microvolt = <984000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5e_1p1: smps5 {
> +			regulator-name = "vreg_s5e_1p1";
> +			regulator-min-microvolt = <1080000>;
> +			regulator-max-microvolt = <1120000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1e_0p88: ldo1 {
> +			regulator-name = "vreg_l1e_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2e_0p9: ldo2 {
> +			regulator-name = "vreg_l2e_0p9";
> +			regulator-min-microvolt = <904000>;
> +			regulator-max-microvolt = <970000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3e_1p2: ldo3 {
> +			regulator-name = "vreg_l3e_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-4 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "f";
> +
> +		vdd-l1-supply = <&vreg_s4e_0p9>;
> +		vdd-l2-supply = <&vreg_s4e_0p9>;
> +		vdd-l3-supply = <&vreg_s4e_0p9>;
> +		vdd-s4-supply = <&vph_pwr>;
> +
> +		vreg_s4f_0p5: smps4 {
> +			regulator-name = "vreg_s4f_0p5";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <700000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1f_0p9: ldo1 {
> +			regulator-name = "vreg_l1f_0p9";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_0p88: ldo2 {
> +			regulator-name = "vreg_l2f_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3f_0p91: ldo3 {
> +			regulator-name = "vreg_l3f_0p91";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-5 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "g";
> +
> +		vdd-l1-supply = <&vreg_s4g_1p3>;
> +		vdd-l2-supply = <&vreg_s4g_1p3>;
> +		vdd-l3-supply = <&vreg_s4g_1p3>;
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +
> +		vreg_s1g_1p2: smps1 {
> +			regulator-name = "vreg_s1g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2g_0p8: smps2 {
> +			regulator-name = "vreg_s2g_0p8";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s3g_0p7: smps3 {
> +			regulator-name = "vreg_s3g_0p7";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1004000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s4g_1p3: smps4 {
> +			regulator-name = "vreg_s4g_1p3";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1352000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5g_0p8: smps5 {
> +			regulator-name = "vreg_s5g_0p8";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1004000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s6g_1p8: smps6 {
> +			regulator-name = "vreg_s6g_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1g_1p2: ldo1 {
> +			regulator-name = "vreg_l1g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2g_1p2: ldo2 {
> +			regulator-name = "vreg_l2g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3g_1p2: ldo3 {
> +			regulator-name = "vreg_l3g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&pm8550_gpios {
> +	sdc2_card_det_n: sdc2-card-det-state {
> +		pins = "gpio12";
> +		function = "normal";
> +		input-enable;
> +		output-disable;
> +		bias-pull-up;
> +		power-source = <1>; /* 1.8 V */
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
> +	vmmc-supply = <&vreg_l9b_2p9>;
> +	vqmmc-supply = <&vreg_l8b_1p8>;
> +	bus-width = <4>;
> +	no-sdio;
> +	no-emmc;
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <32 8>;
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> +
> +&xo_board {
> +	clock-frequency = <76800000>;
> +};
