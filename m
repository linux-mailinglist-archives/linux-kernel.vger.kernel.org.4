Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C375F7E19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJGTgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJGTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:36:43 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18530100BEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:36:40 -0700 (PDT)
Received: from [192.168.1.101] (95.49.30.201.neoplus.adsl.tpnet.pl [95.49.30.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 60C812009D;
        Fri,  7 Oct 2022 21:36:37 +0200 (CEST)
Message-ID: <ad9f1515-a7ff-e8a5-bbc0-4f0278c08952@somainline.org>
Date:   Fri, 7 Oct 2022 21:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/6] arm: dts: qcom: mdm9615: fix pinctrl subnodes
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-2-0cbc006e2a30@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-2-0cbc006e2a30@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.10.2022 11:57, Neil Armstrong wrote:
> Fix the MDM9615 DT to the expected subnodes namings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  8 ++++----
>  arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         | 22 +++++++++++-----------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> index 4e53b3d70195..30a110984597 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> +++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> @@ -45,8 +45,8 @@ &msmgpio {
>  	 * - 42: IOT0_GPIO1 and SD Card Detect
>  	 */
>  
> -	gpioext1_pins: gpioext1_pins {
> -		pins {
> +	gpioext1_pins: gpioext1-state {
> +		gpioext1-pins {
>  			pins = "gpio2";
>  			function = "gpio";
>  			input-enable;
> @@ -54,8 +54,8 @@ pins {
>  		};
>  	};
>  
> -	sdc_cd_pins: sdc_cd_pins {
> -		pins {
> +	sdc_cd_pins: sdc-cd-state {
> +		sdc-cd-pins {
>  			pins = "gpio42";
>  			function = "gpio";
>  			drive-strength = <2>;
> diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
> index 2fe8693dc3cd..92c8003dac25 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
> +++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
> @@ -22,8 +22,8 @@ &msmgpio {
>  	pinctrl-0 = <&reset_out_pins>;
>  	pinctrl-names = "default";
>  
> -	gsbi3_pins: gsbi3_pins {
> -		mux {
> +	gsbi3_pins: gsbi3-state {
> +		gsbi3-pins {
>  			pins = "gpio8", "gpio9", "gpio10", "gpio11";
>  			function = "gsbi3";
>  			drive-strength = <8>;
> @@ -31,8 +31,8 @@ mux {
>  		};
>  	};
>  
> -	gsbi4_pins: gsbi4_pins {
> -		mux {
> +	gsbi4_pins: gsbi4-state {
> +		gsbi4-pins {
>  			pins = "gpio12", "gpio13", "gpio14", "gpio15";
>  			function = "gsbi4";
>  			drive-strength = <8>;
> @@ -40,15 +40,15 @@ mux {
>  		};
>  	};
>  
> -	gsbi5_i2c_pins: gsbi5_i2c_pins {
> -		pin16 {
> +	gsbi5_i2c_pins: gsbi5-i2c-state {
> +		sda-pins {
>  			pins = "gpio16";
>  			function = "gsbi5_i2c";
>  			drive-strength = <8>;
>  			bias-disable;
>  		};
>  
> -		pin17 {
> +		scl-pins {
>  			pins = "gpio17";
>  			function = "gsbi5_i2c";
>  			drive-strength = <2>;
> @@ -56,8 +56,8 @@ pin17 {
>  		};
>  	};
>  
> -	gsbi5_uart_pins: gsbi5_uart_pins {
> -		mux {
> +	gsbi5_uart_pins: gsbi5-uart-state {
> +		gsbi5-uart-pins {
>  			pins = "gpio18", "gpio19";
>  			function = "gsbi5_uart";
>  			drive-strength = <8>;
> @@ -65,8 +65,8 @@ mux {
>  		};
>  	};
>  
> -	reset_out_pins: reset_out_pins {
> -		pins {
> +	reset_out_pins: reset-out-state {
> +		reset-out-pins {
>  			pins = "gpio66";
>  			function = "gpio";
>  			drive-strength = <2>;
> 
