Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2E5EC3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiI0NLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiI0NLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:11:25 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8B1876A9;
        Tue, 27 Sep 2022 06:11:22 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 945AB3F341;
        Tue, 27 Sep 2022 15:11:20 +0200 (CEST)
Message-ID: <c4bcb0b6-e798-d3fb-3722-d27f76401d21@somainline.org>
Date:   Tue, 27 Sep 2022 15:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 05/33] ARM: dts: qcom: msm8226: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
 <20220926074415.53100-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220926074415.53100-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.09.2022 09:43, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts |  6 +++---
>  arch/arm/boot/dts/qcom-msm8226.dtsi         | 24 ++++++++++-----------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> index 193569f0ca5f..02bef5870526 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> @@ -299,8 +299,8 @@ bluetooth_default_state: bluetooth-default-state {
>  		input-enable;
>  	};
>  
> -	touch_pins: touch {
> -		irq {
> +	touch_pins: touch-state {
> +		irq-pins {
>  			pins = "gpio17";
>  			function = "gpio";
>  
> @@ -309,7 +309,7 @@ irq {
>  			input-enable;
>  		};
>  
> -		reset {
> +		reset-pins {
>  			pins = "gpio16";
>  			function = "gpio";
>  
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index cf2d56929428..3b6e746a4af9 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -354,35 +354,35 @@ tlmm: pinctrl@fd510000 {
>  			#interrupt-cells = <2>;
>  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>  
> -			blsp1_i2c1_pins: blsp1-i2c1 {
> +			blsp1_i2c1_pins: blsp1-i2c1-state {
>  				pins = "gpio2", "gpio3";
>  				function = "blsp_i2c1";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			blsp1_i2c2_pins: blsp1-i2c2 {
> +			blsp1_i2c2_pins: blsp1-i2c2-state {
>  				pins = "gpio6", "gpio7";
>  				function = "blsp_i2c2";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			blsp1_i2c3_pins: blsp1-i2c3 {
> +			blsp1_i2c3_pins: blsp1-i2c3-state {
>  				pins = "gpio10", "gpio11";
>  				function = "blsp_i2c3";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			blsp1_i2c4_pins: blsp1-i2c4 {
> +			blsp1_i2c4_pins: blsp1-i2c4-state {
>  				pins = "gpio14", "gpio15";
>  				function = "blsp_i2c4";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			blsp1_i2c5_pins: blsp1-i2c5 {
> +			blsp1_i2c5_pins: blsp1-i2c5-state {
>  				pins = "gpio18", "gpio19";
>  				function = "blsp_i2c5";
>  				drive-strength = <2>;
> @@ -390,13 +390,13 @@ blsp1_i2c5_pins: blsp1-i2c5 {
>  			};
>  
>  			sdhc1_default_state: sdhc1-default-state {
> -				clk {
> +				clk-pins {
>  					pins = "sdc1_clk";
>  					drive-strength = <10>;
>  					bias-disable;
>  				};
>  
> -				cmd-data {
> +				cmd-data-pins {
>  					pins = "sdc1_cmd", "sdc1_data";
>  					drive-strength = <10>;
>  					bias-pull-up;
> @@ -404,13 +404,13 @@ cmd-data {
>  			};
>  
>  			sdhc2_default_state: sdhc2-default-state {
> -				clk {
> +				clk-pins {
>  					pins = "sdc2_clk";
>  					drive-strength = <10>;
>  					bias-disable;
>  				};
>  
> -				cmd-data {
> +				cmd-data-pins {
>  					pins = "sdc2_cmd", "sdc2_data";
>  					drive-strength = <10>;
>  					bias-pull-up;
> @@ -418,21 +418,21 @@ cmd-data {
>  			};
>  
>  			sdhc3_default_state: sdhc3-default-state {
> -				clk {
> +				clk-pins {
>  					pins = "gpio44";
>  					function = "sdc3";
>  					drive-strength = <8>;
>  					bias-disable;
>  				};
>  
> -				cmd {
> +				cmd-pins {
>  					pins = "gpio43";
>  					function = "sdc3";
>  					drive-strength = <8>;
>  					bias-pull-up;
>  				};
>  
> -				data {
> +				data-pins {
>  					pins = "gpio39", "gpio40", "gpio41", "gpio42";
>  					function = "sdc3";
>  					drive-strength = <8>;
