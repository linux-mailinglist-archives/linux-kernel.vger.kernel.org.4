Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5645569331E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjBKSzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 13:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBKSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 13:55:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F00193F5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 10:55:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so8329364wrv.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 10:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij1y01yn3C78vrRH+kSZSIyMqD+0JyDpVdQ+2wk3B9c=;
        b=Zokr1RIWMk5TqBTt1WOuAh5RVLmb2SYoKN1OfGrBT2DpvKT0R1RRrOnziwT8Q3MhGK
         IdFguK0gtCvnpRi5eYmKjjNN6taFrQXqAg/1S7cZBo5EKtyCtN80BgprVx1fOMNwQVFo
         gV9VJrjhlsfzcZ3UD5h8Oxf6XMODQnxCva20cBKUDihVdPmn5DIIAh/j+rPPctdKl+A9
         /A1i7Q3Vp04MPb4gnVfuZvsF/KaZQpqHYlLUO6ewoSOCRpM4PgXJgxKrszRDlNIG6IkY
         9ZsyX6vlwuroabFgRjv32pPeqAaQmdTnLGOAaiCKl58FO+A6lY3eIfU1TNYyDuQlRk/3
         RMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij1y01yn3C78vrRH+kSZSIyMqD+0JyDpVdQ+2wk3B9c=;
        b=lCpEBT4V1zrI3hFYtP9NAEChftxPwywjCaMpi264Wa1d9EfM+B9wmzPk3jlE+ippJj
         DqTLUH1msZNYL5ctNau+taVFT/5yUcErNiHB72usQCtX4Yv4QnAdAAbvj5iYqlKjk9pk
         R/iuCLjQtNGMQa3+odkolL7Fo0qK+QVBwMYYY8SEXUr3wct/7Qfued3YZco4hQU9CJtV
         Vnv1jpABJvOxXQs2RLmwwSk0yoT5u0plmoVbBYl/KJdbCJj2jSs7nCQ+D48GCfNquhEX
         pMhXo2aQK76GzlwlvdIH7GTZK0whd7ZYgmRGM9njVcwOwUriMxwICYklJ25pIxwGucn1
         xTHg==
X-Gm-Message-State: AO0yUKW554pL3KMofzip9QhsI3jy7cqheYV5IaqM9aTxKGDZCWL0kQMc
        8FF9ySNizCZmem0TyVtYlyVSBQ==
X-Google-Smtp-Source: AK7set/H8VB5OT+If7vVAokqpNc4ciMCqSuPNxv+Fl5zFVgPpLeRWgsiqmatVGrAmjPVcYcIa0oPSw==
X-Received: by 2002:a5d:56cd:0:b0:2c5:4c5c:fd08 with SMTP id m13-20020a5d56cd000000b002c54c5cfd08mr4170911wrw.37.1676141700629;
        Sat, 11 Feb 2023 10:55:00 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y1-20020a5d6201000000b002c3ea5ebc73sm6532053wru.101.2023.02.11.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:55:00 -0800 (PST)
Date:   Sat, 11 Feb 2023 20:54:58 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550-qrd: add QRD8550
Message-ID: <Y+fkgvBIuYi+IXVV@linaro.org>
References: <20230210163844.765074-1-krzysztof.kozlowski@linaro.org>
 <20230210163844.765074-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210163844.765074-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-10 17:38:44, Krzysztof Kozlowski wrote:
> Add a minimal DTS for the new QRD8550 board - a mobile-like development
> board with SM8550.  Serial, UFS and USB should be working.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> ---
> 
> UFS should be working the same as on MTP8550, but both fail on next and
> patches from lists are needed (same as on MTP8550).

I believe it should be working fine on next-20230210, since both the
HC and the PHY drivers updates have been merged.

> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 439 ++++++++++++++++++++++++
>  2 files changed, 440 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 359e428e49b3..29d5bb0403de 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -197,3 +197,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> new file mode 100644
> index 000000000000..d5a645ee2a61
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -0,0 +1,439 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Linaro Limited
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
> +	model = "Qualcomm Technologies, Inc. SM8550 QRD";
> +	compatible = "qcom,sm8550-qrd", "qcom,sm8550";
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
> +		vdd-l1-l4-l10-supply = <&vreg_s6g_1p86>;
> +		vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +		vdd-l3-supply = <&vreg_s4g_1p25>;
> +		vdd-l5-l16-supply = <&vreg_bob1>;
> +		vdd-l6-l7-supply = <&vreg_bob1>;
> +		vdd-l8-l9-supply = <&vreg_bob1>;
> +		vdd-l11-supply = <&vreg_s4g_1p25>;
> +		vdd-l12-supply = <&vreg_s6g_1p86>;
> +		vdd-l15-supply = <&vreg_s6g_1p86>;
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
> +		vdd-l1-supply = <&vreg_s4g_1p25>;
> +		vdd-l2-supply = <&vreg_s4e_0p95>;
> +		vdd-l3-supply = <&vreg_s4e_0p95>;
> +
> +		vreg_l3c_0p9: ldo3 {
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
> +		vdd-l1-supply = <&vreg_s4e_0p95>;
> +		vdd-l2-supply = <&vreg_s4e_0p95>;
> +		vdd-l3-supply = <&vreg_s4e_0p95>;
> +
> +		vreg_l1d_0p88: ldo1 {
> +			regulator-name = "vreg_l1d_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* ldo2 supplies SM8550 VDD_LPI_MX */
> +	};
> +
> +	regulators-3 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-l1-supply = <&vreg_s4e_0p95>;
> +		vdd-l2-supply = <&vreg_s4e_0p95>;
> +		vdd-l3-supply = <&vreg_s4g_1p25>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +
> +		vreg_s4e_0p95: smps4 {
> +			regulator-name = "vreg_s4e_0p95";
> +			regulator-min-microvolt = <904000>;
> +			regulator-max-microvolt = <984000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5e_1p08: smps5 {
> +			regulator-name = "vreg_s5e_1p08";
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
> +		vdd-l1-supply = <&vreg_s4e_0p95>;
> +		vdd-l2-supply = <&vreg_s4e_0p95>;
> +		vdd-l3-supply = <&vreg_s4e_0p95>;
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
> +		vreg_l3f_0p88: ldo3 {
> +			regulator-name = "vreg_l3f_0p88";
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
> +		vdd-l1-supply = <&vreg_s4g_1p25>;
> +		vdd-l2-supply = <&vreg_s4g_1p25>;
> +		vdd-l3-supply = <&vreg_s4g_1p25>;
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +
> +		vreg_s1g_1p25: smps1 {
> +			regulator-name = "vreg_s1g_1p25";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2g_0p85: smps2 {
> +			regulator-name = "vreg_s2g_0p85";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s3g_0p8: smps3 {
> +			regulator-name = "vreg_s3g_0p8";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1004000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s4g_1p25: smps4 {
> +			regulator-name = "vreg_s4g_1p25";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1352000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5g_0p85: smps5 {
> +			regulator-name = "vreg_s5g_0p85";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1004000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s6g_1p86: smps6 {
> +			regulator-name = "vreg_s6g_1p86";
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
> +		vreg_l3g_1p2: ldo3 {
> +			regulator-name = "vreg_l3g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sm8550/adsp.mbn",
> +			"qcom/sm8550/adsp_dtb.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/sm8550/cdsp.mbn",
> +			"qcom/sm8550/cdsp_dtb.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/sm8550/modem.mbn",
> +			"qcom/sm8550/modem_dtb.mbn";
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
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l17b_2p5>;
> +	vcc-max-microamp = <1300000>;
> +	vccq-supply = <&vreg_l1g_1p2>;
> +	vccq-max-microamp = <1200000>;
> +	vccq2-supply = <&vreg_l3g_1p2>;
> +	vccq2-max-microamp = <100>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l1d_0p88>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +	vdd-supply = <&vreg_l1e_0p88>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_dp_qmpphy {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3f_0p88>;
> +
> +	status = "okay";
> +};
> +
> +&xo_board {
> +	clock-frequency = <76800000>;
> +};
> -- 
> 2.34.1
> 
