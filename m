Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D0B5EC2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiI0MjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiI0Mi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:38:58 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C3151DC8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:38:51 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9791D3F3E7;
        Tue, 27 Sep 2022 14:38:49 +0200 (CEST)
Message-ID: <bee7b82a-da95-f5db-c382-5f1f55b9a1fc@somainline.org>
Date:   Tue, 27 Sep 2022 14:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 07/15] arm64: dts: qcom: msm8953: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
 <20220925110608.145728-8-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220925110608.145728-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.2022 13:06, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
>   qcom/sdm632-fairphone-fp3.dtb: pinctrl@1000000: 'cd-off-pins', 'cd-on-pins', 'gpio-key-default-pins', ....
>     do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 70 +++++++++++++--------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 6b992a6d56c1..db94e6fd18f5 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -460,229 +460,229 @@ tlmm: pinctrl@1000000 {
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  
> -			uart_console_active: uart-console-active-pins {
> +			uart_console_active: uart-console-active-state {
>  				pins = "gpio4", "gpio5";
>  				function = "blsp_uart2";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			uart_console_sleep: uart-console-sleep-pins {
> +			uart_console_sleep: uart-console-sleep-state {
>  				pins = "gpio4", "gpio5";
>  				function = "blsp_uart2";
>  				drive-strength = <2>;
>  				bias-pull-down;
>  			};
>  
> -			sdc1_clk_on: sdc1-clk-on-pins {
> +			sdc1_clk_on: sdc1-clk-on-state {
>  				pins = "sdc1_clk";
>  				bias-disable;
>  				drive-strength = <16>;
>  			};
>  
> -			sdc1_clk_off: sdc1-clk-off-pins {
> +			sdc1_clk_off: sdc1-clk-off-state {
>  				pins = "sdc1_clk";
>  				bias-disable;
>  				drive-strength = <2>;
>  			};
>  
> -			sdc1_cmd_on: sdc1-cmd-on-pins {
> +			sdc1_cmd_on: sdc1-cmd-on-state {
>  				pins = "sdc1_cmd";
>  				bias-disable;
>  				drive-strength = <10>;
>  			};
>  
> -			sdc1_cmd_off: sdc1-cmd-off-pins {
> +			sdc1_cmd_off: sdc1-cmd-off-state {
>  				pins = "sdc1_cmd";
>  				bias-disable;
>  				drive-strength = <2>;
>  			};
>  
> -			sdc1_data_on: sdc1-data-on-pins {
> +			sdc1_data_on: sdc1-data-on-state {
>  				pins = "sdc1_data";
>  				bias-pull-up;
>  				drive-strength = <10>;
>  			};
>  
> -			sdc1_data_off: sdc1-data-off-pins {
> +			sdc1_data_off: sdc1-data-off-state {
>  				pins = "sdc1_data";
>  				bias-pull-up;
>  				drive-strength = <2>;
>  			};
>  
> -			sdc1_rclk_on: sdc1-rclk-on-pins {
> +			sdc1_rclk_on: sdc1-rclk-on-state {
>  				pins = "sdc1_rclk";
>  				bias-pull-down;
>  			};
>  
> -			sdc1_rclk_off: sdc1-rclk-off-pins {
> +			sdc1_rclk_off: sdc1-rclk-off-state {
>  				pins = "sdc1_rclk";
>  				bias-pull-down;
>  			};
>  
> -			sdc2_clk_on: sdc2-clk-on-pins {
> +			sdc2_clk_on: sdc2-clk-on-state {
>  				pins = "sdc2_clk";
>  				drive-strength = <16>;
>  				bias-disable;
>  			};
>  
> -			sdc2_clk_off: sdc2-clk-off-pins {
> +			sdc2_clk_off: sdc2-clk-off-state {
>  				pins = "sdc2_clk";
>  				bias-disable;
>  				drive-strength = <2>;
>  			};
>  
> -			sdc2_cmd_on: sdc2-cmd-on-pins {
> +			sdc2_cmd_on: sdc2-cmd-on-state {
>  				pins = "sdc2_cmd";
>  				bias-pull-up;
>  				drive-strength = <10>;
>  			};
>  
> -			sdc2_cmd_off: sdc2-cmd-off-pins {
> +			sdc2_cmd_off: sdc2-cmd-off-state {
>  				pins = "sdc2_cmd";
>  				bias-pull-up;
>  				drive-strength = <2>;
>  			};
>  
> -			sdc2_data_on: sdc2-data-on-pins {
> +			sdc2_data_on: sdc2-data-on-state {
>  				pins = "sdc2_data";
>  				bias-pull-up;
>  				drive-strength = <10>;
>  			};
>  
> -			sdc2_data_off: sdc2-data-off-pins {
> +			sdc2_data_off: sdc2-data-off-state {
>  				pins = "sdc2_data";
>  				bias-pull-up;
>  				drive-strength = <2>;
>  			};
>  
> -			sdc2_cd_on: cd-on-pins {
> +			sdc2_cd_on: cd-on-state {
>  				pins = "gpio133";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-pull-up;
>  			};
>  
> -			sdc2_cd_off: cd-off-pins {
> +			sdc2_cd_off: cd-off-state {
>  				pins = "gpio133";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			gpio_key_default: gpio-key-default-pins {
> +			gpio_key_default: gpio-key-default-state {
>  				pins = "gpio85";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-pull-up;
>  			};
>  
> -			i2c_1_default: i2c-1-default-pins {
> +			i2c_1_default: i2c-1-default-state {
>  				pins = "gpio2", "gpio3";
>  				function = "blsp_i2c1";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_1_sleep: i2c-1-sleep-pins {
> +			i2c_1_sleep: i2c-1-sleep-state {
>  				pins = "gpio2", "gpio3";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_2_default: i2c-2-default-pins {
> +			i2c_2_default: i2c-2-default-state {
>  				pins = "gpio6", "gpio7";
>  				function = "blsp_i2c2";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_2_sleep: i2c-2-sleep-pins {
> +			i2c_2_sleep: i2c-2-sleep-state {
>  				pins = "gpio6", "gpio7";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_3_default: i2c-3-default-pins {
> +			i2c_3_default: i2c-3-default-state {
>  				pins = "gpio10", "gpio11";
>  				function = "blsp_i2c3";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_3_sleep: i2c-3-sleep-pins {
> +			i2c_3_sleep: i2c-3-sleep-state {
>  				pins = "gpio10", "gpio11";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_4_default: i2c-4-default-pins {
> +			i2c_4_default: i2c-4-default-state {
>  				pins = "gpio14", "gpio15";
>  				function = "blsp_i2c4";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_4_sleep: i2c-4-sleep-pins {
> +			i2c_4_sleep: i2c-4-sleep-state {
>  				pins = "gpio14", "gpio15";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_5_default: i2c-5-default-pins {
> +			i2c_5_default: i2c-5-default-state {
>  				pins = "gpio18", "gpio19";
>  				function = "blsp_i2c5";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_5_sleep: i2c-5-sleep-pins {
> +			i2c_5_sleep: i2c-5-sleep-state {
>  				pins = "gpio18", "gpio19";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_6_default: i2c-6-default-pins {
> +			i2c_6_default: i2c-6-default-state {
>  				pins = "gpio22", "gpio23";
>  				function = "blsp_i2c6";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_6_sleep: i2c-6-sleep-pins {
> +			i2c_6_sleep: i2c-6-sleep-state {
>  				pins = "gpio22", "gpio23";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_7_default: i2c-7-default-pins {
> +			i2c_7_default: i2c-7-default-state {
>  				pins = "gpio135", "gpio136";
>  				function = "blsp_i2c7";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_7_sleep: i2c-7-sleep-pins {
> +			i2c_7_sleep: i2c-7-sleep-state {
>  				pins = "gpio135", "gpio136";
>  				function = "gpio";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_8_default: i2c-8-default-pins {
> +			i2c_8_default: i2c-8-default-state {
>  				pins = "gpio98", "gpio99";
>  				function = "blsp_i2c8";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
> -			i2c_8_sleep: i2c-8-sleep-pins {
> +			i2c_8_sleep: i2c-8-sleep-state {
>  				pins = "gpio98", "gpio99";
>  				function = "gpio";
>  				drive-strength = <2>;
