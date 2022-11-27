Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A36639C77
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK0TDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK0TDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:03:18 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97F32AD6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:03:16 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a7so10844252ljq.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ks0N6znr1vGi6JDJPBhcyjjAyKjqoYsA8yyutY2k1vI=;
        b=sGt78KVRvrqFoCLppsWM6darHOf6eQ+7UF/dWbXLDEehUVs6Hv/EZW/977Pzp9xpfO
         fFEjxYM/XFgj1Bn8qwGt3xyg+8jw5rq02NFprjgSlf2XLGYDVrmtrfVS7BdzH7Qo0Ub+
         sinIAtOdqIVfiRSoBr/wDnS5BRLN/7mbaxjwRl4+1kKgtEW6I0JUm1FdXA1uVBxytRXU
         KzxPje+J7+hJLun2MvPv5Fhbz6V/tmSCaQkZqHEX3IWXaD9JBZ7oC+FpLKFgaq3R2gEd
         ZUhuLut2Kt6+wNOuxBx5fGfoiiI573RzPU4N/oiAlzLK24R+Tiffw5dEUGzmdtWjgAOm
         fn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks0N6znr1vGi6JDJPBhcyjjAyKjqoYsA8yyutY2k1vI=;
        b=AJFVyHrla/FWUGvDbk5MHjGCH3a0T8GC+0c70+ZTZUeZBXlHgJN7y6XzwLwOIulb7H
         8w+QIJ+r10un2CfHUhuzcHboX7Wy+dgveuar1APwNCb5PC/kssGjEucgwUXMxtji/BOa
         iMeuqxFA0umw0yk5fbLwas5h6bQQ6w5sBSdNqd30Syniq3VqbhfqJ+DA+7GZaoyZ/J/r
         ZKygWQN0Ppy20eWojxAfEmtACqsZK88Z1yX6hE6sMsjhE5/hWeryujZ+Z37JZyYmSfd+
         ZKYUPI/scmeN1KQfqkxQQhgT/RQgjERnHSvL9tNssEgHQKSCerpZVu/miDYexc91OJv/
         A6uA==
X-Gm-Message-State: ANoB5pklzBIeaUzclE0UIFENA+dP3Aw1SR4+ZaE/sJ2zC+i1UHnN3onI
        lkjYq2/4fqwwOTde7X1ktY23Kg==
X-Google-Smtp-Source: AA0mqf6A85VH2mpitY8wloEBCYmOsmxuxKNyN89W5J9dM+m+SXbQbJIRYhxSPP8i5+RDnDmNeCzLXw==
X-Received: by 2002:a05:651c:110a:b0:26d:e85b:92af with SMTP id e10-20020a05651c110a00b0026de85b92afmr14297139ljo.464.1669575795108;
        Sun, 27 Nov 2022 11:03:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d18-20020a2eb052000000b002797ea7c983sm986949ljl.105.2022.11.27.11.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 11:03:14 -0800 (PST)
Message-ID: <1ec0bd07-320b-c7a2-98e1-2a3d95316812@linaro.org>
Date:   Sun, 27 Nov 2022 20:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8250-lenovo-j716f: Add initial
 device tree
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221127170858.440040-1-davidwronek@gmail.com>
 <20221127170858.440040-3-davidwronek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127170858.440040-3-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 18:08, David Wronek wrote:
> Add the initial device tree for Lenovo Xiaoxin Pad Pro 2021 based on
> Qualcomm SM8250 with the following features:
> 
> - SimpleFB
> - GPIO keys
> - Regulators
> - I2C
> - UFS
> - USB
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm8250-lenovo-j716f.dts     | 561 ++++++++++++++++++
>  2 files changed, 562 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index afe496a93f94..c002f78144b6 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -158,6 +158,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-lenovo-j716f.dtb

Thank you for your patch. There is something to discuss/improve.

> +/ {
> +	model = "Lenovo Xiaoxin Pad Pro 2021";
> +	compatible = "lenovo,j716f", "qcom,sm8250";
> +	classis-type = "tablet";
> +
> +	qcom,msm-id = <0x164 0x20001>;
> +	qcom,board-id = <0x2010008 0>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		bootargs = "fw_devlink=permissive clk_ignore_unused pd_ignore_unused";

These do not belong to mainlined DTS.

> +		stdout-path = "framebuffer0";
> +
> +		framebuffer0: framebuffer@9c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x9c000000 0 0x2300000>;
> +			width = <2560>;
> +			height = <1600>;
> +			stride = <(2560 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		cont_splash_mem: memory@9c000000 {
> +			reg = <0x0 0x9c000000 0x0 0x2300000>;
> +			no-map;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +	};
> +
> +	/* S6c is really ebi.lvl but it's there for supply map completeness sake. */
> +	vreg_s6c_0p88: smpc6-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_s6c_0p88";
> +
> +		regulator-min-microvolt = <880000>;
> +		regulator-max-microvolt = <880000>;
> +		regulator-always-on;
> +		vin-supply = <&vph_pwr>;
> +	};
> +};
> +
> +&apps_rsc {
> +	pm8150-rpmh-regulators {

Node name: regulators-0
(this should already complain with dtbs_check)

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
> +		vdd-l1-l8-l11-supply = <&vreg_s6c_0p88>;
> +		vdd-l2-l10-supply = <&vreg_bob>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p95>;
> +		vdd-l6-l9-supply = <&vreg_s8c_1p35>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_1p9>;
> +		vdd-l13-l16-l17-supply = <&vreg_bob>;
> +
> +		/* (S1+S2+S3) - cx.lvl (ARC) */
> +
> +		vreg_s4a_1p8: smps4 {
> +			regulator-name = "vreg_s4a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5a_1p9: smps5 {
> +			regulator-name = "vreg_s5a_1p9";
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <2040000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s6a_0p95: smps6 {
> +			regulator-name = "vreg_s6a_0p95";
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <1128000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2a_3p1: ldo2 {
> +			regulator-name = "vreg_l2a_3p1";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3a_0p93: ldo3 {
> +			regulator-name = "vreg_l3a_0p93";
> +			regulator-min-microvolt = <928000>;
> +			regulator-max-microvolt = <932000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L4 - lmx.lvl (ARC) */
> +
> +		vreg_l5a_0p88: ldo5 {
> +			regulator-name = "vreg_l5a_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6a_1p2: ldo6 {
> +			regulator-name = "vreg_l6a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7a_1p7: ldo7 {
> +			regulator-name = "vreg_l7a_1p7";
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9a_1p2: ldo9 {
> +			regulator-name = "vreg_l9a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10a_1p8: ldo10 {
> +			regulator-name = "vreg_l10a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L11 - lcx.lvl (ARC) */
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-name = "vreg_l12a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13a_3p0: ldo13 {
> +			regulator-name = "vreg_l13a_3p0";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-name = "vreg_l14a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-name = "vreg_l15a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16a_3p0: ldo16 {
> +			regulator-name = "vreg_l16a_3p0";
> +			regulator-min-microvolt = <3024000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17a_2p5: ldo17 {
> +			regulator-name = "vreg_l17a_2p5";
> +			regulator-min-microvolt = <2496000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l18a_0p8: ldo18 {
> +			regulator-name = "vreg_l18a_0p8";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/*
> +	 * Remaining regulators that are not yet supported:
> +	 * OLEDB: 4925000-8100000
> +	 * ab: 4600000-6100000
> +	 * ibb: 800000-5400000
> +	 */
> +
> +	pm8150l-rpmh-regulators {

Node name: regulators-1

> +		compatible = "qcom,pm8150l-rpmh-regulators";
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
> +		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
> +		vdd-l2-l3-supply = <&vreg_s8c_1p35>;
> +		vdd-l4-l5-l6-supply = <&vreg_bob>;
> +		vdd-l7-l11-supply = <&vreg_bob>;
> +		vdd-l9-l10-supply = <&vreg_bob>;
> +		vdd-bob-supply = <&vph_pwr>;
> +
> +		vreg_bob: bob {
> +			regulator-name = "vreg_bob";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		/*
> +		 * S1-S6 are ARCs:
> +		 * (S1+S2) - gfx.lvl,
> +		 * S3 - mx.lvl,
> +		 * (S4+S5) - mmcx.lvl,
> +		 * S6 - ebi.lvl
> +		 */
> +
> +		vreg_s7c_0p35: smps7 {
> +			regulator-name = "vreg_s7c_0p35";
> +			regulator-min-microvolt = <348000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s8c_1p35: smps8 {
> +			regulator-name = "vreg_s8c_1p4";
> +			regulator-min-microvolt = <1350000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1c_1p8: ldo1 {
> +			regulator-name = "vreg_l1c_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_1p2: ldo2 {
> +			regulator-name = "vreg_l2c_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_0p8: ldo3 {
> +			regulator-name = "vreg_l3c_0p8";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4c_1p8: ldo4 {
> +			regulator-name = "vreg_l4c_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5c_1p8: ldo5 {
> +			regulator-name = "vreg_l5c_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6c_2p9: ldo6 {
> +			regulator-name = "vreg_l6c_2p9";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7c_2p9: ldo7 {
> +			regulator-name = "vreg_l7c_2p9";
> +			regulator-min-microvolt = <2856000>;
> +			regulator-max-microvolt = <3104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8c_1p8: ldo8 {
> +			regulator-name = "vreg_l8c_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c_2p7: ldo9 {
> +			regulator-name = "vreg_l9c_2p7";
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l10c_3p0: ldo10 {
> +			regulator-name = "vreg_l10c_3p0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_3p1: ldo11 {
> +			regulator-name = "vreg_l11c_3p1";
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	pm8009-rpmh-regulators {

Node name: regulators-2

> +		compatible = "qcom,pm8009-rpmh-regulators";
> +		qcom,pmic-id = "f";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vreg_bob>;
> +		vdd-l2-supply = <&vreg_s8c_1p35>;
> +		vdd-l5-l6-supply = <&vreg_bob>;
> +		vdd-l7-supply = <&vreg_s4a_1p8>;
> +
> +		vreg_s1f_1p2: smps1 {
> +			regulator-name = "vreg_s1f_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2f_0p5: smps2 {
> +			regulator-name = "vreg_s2f_0p5";
> +			regulator-min-microvolt = <512000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1f_1p1: ldo1 {
> +			regulator-name = "vreg_l1f_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_1p2: ldo2 {
> +			regulator-name = "vreg_l2f_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3f_1p1: ldo3 {
> +			regulator-name = "vreg_l3f_1p1";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4f_1p1: ldo4 {
> +			regulator-name = "vreg_l4f_1p1";
> +			regulator-min-microvolt = <1096000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5f_2p8: ldo5 {
> +			regulator-name = "vreg_l5f_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6f_2p8: ldo6 {
> +			regulator-name = "vreg_l6f_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7f_1p8: ldo7 {
> +			regulator-name = "vreg_l7f_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <1000000>;
> +
> +	/* hid-over-i2c ptp @ 60 */
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	bq27541@55 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,bq27541";
> +		reg = <0x55>;
> +	};
> +};

Best regards,
Krzysztof

