Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5355FFA43
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJON34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJON3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 09:29:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7127178
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:29:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m6so4176449qkm.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkW2CXLArWU6UYz1PeNN9+TpW/vu7L7d5airtAAW634=;
        b=WKSQiT0T8o9i+EGL2uC2lPocGSjZwOkzFvVSsTLRNMfnRFQ7c5y9ngmtxIxD3M+jyM
         /RpxerKVSjbMTOwyJBKtKF2VEXF6EJZlaByzaw2AyMoGKlXL1CYrdKPRCFWzUV9x48LK
         JlAB5vLxrMlh4Qgdgrb7zOXVbfrFKKqY05Ykkm5kiKsMAAuqqG/0Z+0ve6BxubCbXI6G
         gcK5KEXrncwr3QbeVDxvS9eYYjeh1Q6AStLdpLFa6NZl46o8++DFqHTqhGFTVjetCrp3
         wwerLIfyOlh+2JCC8nsH03pN6ujk7i/2XYMnoTKYFgXhgCGEVAKapz7lPFlScJ2+1+/h
         tt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkW2CXLArWU6UYz1PeNN9+TpW/vu7L7d5airtAAW634=;
        b=6BmI5ADDn2hzUZ0TQgHc5RCXQios/8wwMjEXcgDi7MiOzx/622CKireWglFgcRM1EI
         2aICd3uS9HxT630Q4dvMFAdgE9Mb9Qh9TkKzCZsf6wpZwMOAv3OwbIuKy1m6tTlgVtC4
         J7IfFJxx+qyB/79XgWa0kpR3zdU+0IEMwRnyjtZ6ZByqBOzU3YiSC55g/CXSr6BG7p7O
         nWqS5jGlenSQbvFuUyLsCGUkaFu+/MxIZ3aSpnNQPfNaFLFSsGLz95wQdMNCvgPU13ge
         65l1GvpIN1GOVQb2pZvUneZD3Ylo6NbHzhzmaBJl5PFEm6w3znT+BBq8rgSq853GbhsZ
         EBAQ==
X-Gm-Message-State: ACrzQf09GiMagEcZzohMsHB5WninJZoV8wMd9onAE0vswQ05cUg+A17C
        kA2NuYm4q62oYRhne3yooGE0HA==
X-Google-Smtp-Source: AMsMyM6nyVyEkwe09IbCrfSIE97qDXKrDnpKLAxbEyF3FVbBpJZZIMaM86MfHDBgVBzu44zNvqg2wQ==
X-Received: by 2002:ae9:e848:0:b0:6ee:92d5:94e4 with SMTP id a69-20020ae9e848000000b006ee92d594e4mr1708017qkg.404.1665840587903;
        Sat, 15 Oct 2022 06:29:47 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:161:5720:79e9:9739? ([2601:42:0:3450:161:5720:79e9:9739])
        by smtp.gmail.com with ESMTPSA id fc26-20020a05622a489a00b003434d3b5938sm4119358qtb.2.2022.10.15.06.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 06:29:46 -0700 (PDT)
Message-ID: <e94d9029-e0aa-574f-62d2-632e2c5d70d2@linaro.org>
Date:   Sat, 15 Oct 2022 09:29:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-4-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221138.7552-4-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:11, Melody Olvera wrote:
> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
> SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   2 +
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 230 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 230 +++++++++++++++++++++++
>  3 files changed, 462 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d7669a7cee9f..8417295adfeb 100644
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
> index 000000000000..47a8eaf4fda2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -0,0 +1,230 @@
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
> +	pm8150-regulators {

regulators

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
> index 000000000000..54770c697db8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -0,0 +1,230 @@
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
> +	pm8150-regulators {

regulators


Best regards,
Krzysztof

