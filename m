Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E724464053F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiLBKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiLBKvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:51:35 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5FD1596
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:51:29 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id r8so4971101ljn.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXC6cS5eGCHlEenV07SWq3mzDPAluIVl75tanNPQOpc=;
        b=MpyWZcQdqt6tTfz5gQA4V8BmkCOTx5xB6cJ4AKTOTn5i4pdtKMb78vr6stuSMptga9
         eJTCsouTRd3/a5yUv9oSAoCye9ODIF8pqn30+KheCXi3KuxpsUgRFOBQxdPyld9N+UOe
         jf+XhAqrXfxvS2u1+wumYsms3s//6OZFKdTt3DNr/+8GuLffU1Dd+nFmfwin2VYu+f0Q
         qv3KwWFdENsskX/BKRa7tMD80/vAsQ2IhlKgnLzqDiwMtqPxacHg9A8nschAvrpHY6WF
         JCpICRmw9jH1fJB9EYxiPESzf3+4s2WSiqA7RMXADDZODcfW9x/UjP3GPrNlph48pVMr
         fb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXC6cS5eGCHlEenV07SWq3mzDPAluIVl75tanNPQOpc=;
        b=uQSbVJlz3n3s3V9N12pNaKTcqsWLUUKzDFUJqpSlxkS55DU4cTCweNfoZji2eURe3r
         Tq9nmC4TQPdPclrJWs7dLEwJAE0R6x9MTA1t5O3oX90UiPSCb+WPCmuiI/7FboH5I/l1
         zhdSWalMRfEmFFVm6Vf6jQ4gtuVr3C3wr2DYeMCv2xnOH6pH1ms5UWbs8y7G+WtNZOj2
         b5zOeasZmuybXjJbXBsuM6U8m4VPAgh4F09RyA9Aa/KTsBg+RRwycFBDJesEjq7ZB5tp
         JhESN0rO6RFaDEHiBER8W87x+botpRwT9pLL2QAkkXz1SBVEBaTma8sH8CoYhqVarnlI
         iJGQ==
X-Gm-Message-State: ANoB5pmR2SgHKGgnoOvcanNjHdfatS8wPouXNtwkD6pNQuvBeMAmVMI3
        nKL7aSXSWw3vuyASXua3Os+bsA==
X-Google-Smtp-Source: AA0mqf6r8dPUNIkST30ne6G3/+l1gl+MJYWN3vbRn2dPNEpYV0U2iLt6t0RNaiAKykeBuTt2oBJvUQ==
X-Received: by 2002:a2e:be87:0:b0:277:f0f:927e with SMTP id a7-20020a2ebe87000000b002770f0f927emr23763568ljr.138.1669978288257;
        Fri, 02 Dec 2022 02:51:28 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.2.neoplus.adsl.tpnet.pl. [95.49.125.2])
        by smtp.gmail.com with ESMTPSA id u4-20020a056512040400b00492f1b2ac0bsm986347lfk.101.2022.12.02.02.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:51:27 -0800 (PST)
Message-ID: <5b6a160a-f2fd-28fc-b980-3d2a52a9b394@linaro.org>
Date:   Fri, 2 Dec 2022 11:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: sm6115: Add i2c/spi nodes
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221130200950.144618-1-a39.skl@gmail.com>
 <20221130200950.144618-11-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221130200950.144618-11-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.2022 21:09, Adam Skladowski wrote:
> Add I2C/SPI nodes for SM6115.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 290 +++++++++++++++++++++++++++
>  1 file changed, 290 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index b30a5485671d..e676b9d117e3 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sm6115.h>
>  #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -365,6 +366,90 @@ tlmm: pinctrl@500000 {
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  
> +			qup_i2c0_default: qup-i2c0-default-state {
> +				pins = "gpio0", "gpio1";
> +				function = "qup0";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_i2c1_default: qup-i2c1-default-state {
> +				pins = "gpio4", "gpio5";
> +				function = "qup1";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_i2c2_default: qup-i2c2-default-state {
> +				pins = "gpio6", "gpio7";
> +				function = "qup2";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_i2c3_default: qup-i2c3-default-state {
> +				pins = "gpio8", "gpio9";
> +				function = "qup3";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_i2c4_default: qup-i2c4-default-state {
> +				pins = "gpio12", "gpio13";
> +				function = "qup4";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_i2c5_default: qup-i2c5-default-state {
> +				pins = "gpio14", "gpio15";
> +				function = "qup5";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_spi0_default: qup-spi0-default-state {
> +				pins = "gpio0", "gpio1","gpio2", "gpio3";
> +				function = "qup0";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_spi1_default: qup-spi1-default-state {
> +				pins = "gpio4", "gpio5", "gpio69", "gpio70";
> +				function = "qup1";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_spi2_default: qup-spi2-default-state {
> +				pins = "gpio6", "gpio7", "gpio71", "gpio80";
> +				function = "qup2";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_spi3_default: qup-spi3-default-state {
> +				pins = "gpio8", "gpio9", "gpio10", "gpio11";
> +				function = "qup3";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_spi4_default: qup-spi4-default-state {
> +				pins = "gpio12", "gpio13", "gpio96", "gpio97";
> +				function = "qup4";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			qup_spi5_default: qup-spi5-default-state {
> +				pins = "gpio14", "gpio15", "gpio16", "gpio17";
> +				function = "qup5";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
>  			sdc1_state_on: sdc1-on-state {
>  				clk-pins {
>  					pins = "sdc1_clk";
> @@ -701,6 +786,211 @@ gpi_dma0: dma-controller@4a00000 {
>  			status = "disabled";
>  		};
>  
> +		qupv3_id_0: geniqup@4ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x04ac0000 0x2000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			iommus = <&apps_smmu 0xe3 0x0>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c0: i2c@4a80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a80000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c0_default>;
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi0: spi@4a80000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a80000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi0_default>;
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@4a84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a84000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c1_default>;
> +				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi1: spi@4a84000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a84000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi1_default>;
> +				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@4a88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a88000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c2_default>;
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi2: spi@4a88000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a88000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi2_default>;
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@4a8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a8c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c3_default>;
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi3: spi@4a8c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a8c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi3_default>;
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@4a90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a90000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c4_default>;
> +				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi4: spi@4a90000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a90000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi4_default>;
> +				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c5: i2c@4a94000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a94000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_i2c5_default>;
> +				interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi5: spi@4a94000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a94000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_spi5_default>;
> +				interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		usb_1: usb@4ef8800 {
>  			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
