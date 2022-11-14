Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10B46282CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiKNOif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiKNOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:38:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F9307
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:38:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a5so17579320edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqqUx7jeg7y/E/nMBqurpKnaZhcr17k+jJ5fcyWu3v8=;
        b=MYcwephvYa7GUyaY/QiqWOye2J3Ho6Kj5JLdQDYdGyLGfi+PHjARZinsjkO1TAlf7y
         jHZJblFrgtaOCc0us6rUhw+znVI/kunPlp1jVju59gkHP6V+YcEi651j9dfi85LXRlc9
         uBiT+UZAbwg6c30O0vJjSx0849O0h+VIoHWA8K7bM6RUugRWh/NITNC1pdYztdiaw6Me
         YJfKnr6ACBRUC2QV/5vOEwy/UsSWB3/2dKALu+CEYBJMk9vwvUW8Pco/TYVL85mDt1cz
         fwR8QHbm8xUaglZ/QmfIH+8iBF1G4WbJQ0SJU3O8M/azmFPOZTRKf5YmJRv6rKzkiHE0
         Xkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LqqUx7jeg7y/E/nMBqurpKnaZhcr17k+jJ5fcyWu3v8=;
        b=BP2/ngveSrbbau3NCrTDSQakIDO5qn8f0dya+gduAjE3Qz+1yE2a6CcA55YVaCtsbx
         0x5KBZ5gpPndKZ0bmLAjusrVGV8z0kgSsMf+M9Z0wnKqaSTHFldc6UTSMEoDflgwpB4M
         NF4p4HhnfU8NL7yq6ZImc4zXTess7RGTR32CG8ltKuwXB0kJgEBZ+XoQUsTkTEw6btYf
         H+O1sWlfqrertybCEkXElm93ostFtdwJDn218hwpgiNLXRdzSo14AV/de+kZVvk9f2ph
         uQbEvF1gDON+ZqwtFe+swyo7vIVdAB6FmcDW98SuRwmLYel2uFrTd55oOAoa55qz1BNC
         cQ0Q==
X-Gm-Message-State: ANoB5plMgRALxjOgFjetshDLwuLVwuKM97ceZO1F/gTvaDGYpAVwt+0O
        EF5uMncKcG/Ycer8v6ezfcmwHA==
X-Google-Smtp-Source: AA0mqf6luQo4JVFA04VeRS35aPiZWQMhzTwbkk7AMirt++NdBLv+JTPJpxktifaK/f5XKJr+gEeKww==
X-Received: by 2002:aa7:c95a:0:b0:458:b6dc:2b56 with SMTP id h26-20020aa7c95a000000b00458b6dc2b56mr11628589edt.412.1668436702715;
        Mon, 14 Nov 2022 06:38:22 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b007addcbd402esm4255069ejb.215.2022.11.14.06.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:38:22 -0800 (PST)
Message-ID: <364844bf-73ca-96b6-cc17-893709ed5b9b@linaro.org>
Date:   Mon, 14 Nov 2022 15:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8350-sagami: Add most RPMh
 regulators
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114143642.44839-1-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221114143642.44839-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 14/11/2022 15:36, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Configure most RPMh-controlled regulators on SoMC Sagami. The missing
> ones (on pm8350b and pm8008[ij]) will be configured when driver support
> is added. Thankfully, it looks like PDX215 and PDX214 don't have any
> differences when it comes to PM8350/PM8350C/PMR735a.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
Missing second S-o-b, sorry:

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 350 ++++++++++++++++++
>   1 file changed, 350 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index 93e88c40b3b9..f118caab3d42 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
>    */
>   
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "sm8350.dtsi"
>   #include "pm8350.dtsi"
>   #include "pm8350b.dtsi"
> @@ -73,6 +74,16 @@ ramoops@ffc00000 {
>   			no-map;
>   		};
>   	};
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
>   };
>   
>   &adsp {
> @@ -80,6 +91,345 @@ &adsp {
>   	firmware-name = "qcom/sm8350/Sony/sagami/adsp.mbn";
>   };
>   
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "b";
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
> +		vdd-s11-supply = <&vph_pwr>;
> +		vdd-s12-supply = <&vph_pwr>;
> +
> +		vdd-l1-l4-supply = <&pm8350_s11>;
> +		vdd-l2-l7-supply = <&vreg_bob>;
> +		vdd-l3-l5-supply = <&vreg_bob>;
> +		vdd-l6-l9-l10-supply = <&pm8350_s11>;
> +
> +		/*
> +		 * ARC regulators:
> +		 * S5 - mx.lvl
> +		 * S6 - gfx.lvl
> +		 * S9 - mxc.lvl
> +		 */
> +
> +		pm8350_s10: smps10 {
> +			regulator-name = "pm8350_s10";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350_s11: smps11 {
> +			regulator-name = "pm8350_s11";
> +			regulator-min-microvolt = <752000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350_s12: smps12 {
> +			regulator-name = "pm8350_s12";
> +			regulator-min-microvolt = <1224000>;
> +			regulator-max-microvolt = <1360000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350_l1: ldo1 {
> +			regulator-name = "pm8350_l1";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350_l2: ldo2 {
> +			regulator-name = "pm8350_l2";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350_l3: ldo3 {
> +			regulator-name = "pm8350_l3";
> +			regulator-min-microvolt = <904000>;
> +			regulator-max-microvolt = <904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L4 - lmx.lvl (ARC) */
> +
> +		pm8350_l5: ldo5 {
> +			regulator-name = "pm8350_l5";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <888000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		pm8350_l6: ldo6 {
> +			regulator-name = "pm8350_l6";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1208000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		pm8350_l7: ldo7 {
> +			regulator-name = "pm8350_l7";
> +			regulator-min-microvolt = <2400000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		/* L8 - lcx.lvl (ARC) */
> +
> +		pm8350_l9: ldo9 {
> +			regulator-name = "pm8350_l9";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm8350c-rpmh-regulators";
> +		qcom,pmic-id = "c";
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
> +		vdd-l1-l12-supply = <&pm8350c_s1>;
> +		vdd-l2-l8-supply = <&pm8350c_s1>;
> +		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
> +		vdd-l6-l9-l11-supply = <&vreg_bob>;
> +		vdd-l10-supply = <&pm8350_s12>;
> +
> +		vdd-bob-supply = <&vph_pwr>;
> +
> +		pm8350c_s1: smps1 {
> +			regulator-name = "pm8350c_s1";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1952000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* S2 - ebi.lvl (ARC) */
> +
> +		pm8350c_s3: smps3 {
> +			regulator-name = "pm8350c_s3";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <704000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/*
> +		 * ARC regulators:
> +		 * S4 - mss.lvl
> +		 * S6 - cx.lvl
> +		 * S8 - mmcx.lvl
> +		 */
> +
> +		pm8350c_s10: smps10 {
> +			regulator-name = "pm8350c_s10";
> +			regulator-min-microvolt = <1048000>;
> +			regulator-max-microvolt = <1128000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l1: ldo1 {
> +			regulator-name = "pm8350c_l1";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l2: ldo2 {
> +			regulator-name = "pm8350c_l2";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l3: ldo3 {
> +			regulator-name = "pm8350c_l3";
> +			regulator-min-microvolt = <3304000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l4: ldo4 {
> +			regulator-name = "pm8350c_l4";
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l5: ldo5 {
> +			regulator-name = "pm8350c_l5";
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l6: ldo6 {
> +			regulator-name = "pm8350c_l6";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l7: ldo7 {
> +			regulator-name = "pm8350c_l7";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l8: ldo8 {
> +			regulator-name = "pm8350c_l8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l9: ldo9 {
> +			regulator-name = "pm8350c_l9";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l10: ldo10 {
> +			regulator-name = "pm8350c_l10";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l11: ldo11 {
> +			regulator-name = "pm8350c_l11";
> +			regulator-min-microvolt = <2400000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l12: ldo12 {
> +			regulator-name = "pm8350c_l12";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8350c_l13: ldo13 {
> +			regulator-name = "pm8350c_l13";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob: bob {
> +			regulator-name = "vreg_bob";
> +			regulator-min-microvolt = <3400000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +
> +	/* TODO: Add pm8350b (just one ldo) once the driver part is in */
> +
> +	regulators-2 {
> +		compatible = "qcom,pmr735a-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +
> +		vdd-l1-l2-supply = <&pmr735a_s2>;
> +		vdd-l3-supply = <&pmr735a_s1>;
> +		vdd-l4-supply = <&pm8350c_s1>;
> +		vdd-l5-l6-supply = <&pm8350c_s1>;
> +		vdd-l7-bob-supply = <&vreg_bob>;
> +
> +		pmr735a_s1: smps1 {
> +			regulator-name = "pmr735a_s1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1280000>;
> +		};
> +
> +		pmr735a_s2: smps2 {
> +			regulator-name = "pmr735a_s2";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		pmr735a_s3: smps3 {
> +			regulator-name = "pmr735a_s3";
> +			regulator-min-microvolt = <2208000>;
> +			regulator-max-microvolt = <2352000>;
> +		};
> +
> +		pmr735a_l1: ldo1 {
> +			regulator-name = "pmr735a_l1";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +		};
> +
> +		pmr735a_l2: ldo2 {
> +			regulator-name = "pmr735a_l2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pmr735a_l3: ldo3 {
> +			regulator-name = "pmr735a_l3";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pmr735a_l4: ldo4 {
> +			regulator-name = "pmr735a_l4";
> +			regulator-min-microvolt = <1776000>;
> +			regulator-max-microvolt = <1872000>;
> +		};
> +
> +		pmr735a_l5: ldo5 {
> +			regulator-name = "pmr735a_l5";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <800000>;
> +		};
> +
> +		pmr735a_l6: ldo6 {
> +			regulator-name = "pmr735a_l6";
> +			regulator-min-microvolt = <480000>;
> +			regulator-max-microvolt = <904000>;
> +		};
> +
> +		pmr735a_l7: ldo7 {
> +			regulator-name = "pmr735a_l7";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +	};
> +};
> +
>   &cdsp {
>   	status = "okay";
>   	firmware-name = "qcom/sm8350/Sony/sagami/cdsp.mbn";
