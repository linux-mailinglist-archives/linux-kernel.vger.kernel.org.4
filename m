Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB19619D5E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKDQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiKDQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:34:25 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F12B628;
        Fri,  4 Nov 2022 09:34:23 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 937DC3F67C;
        Fri,  4 Nov 2022 17:34:21 +0100 (CET)
Message-ID: <b9f217bf-f0cc-675e-bf76-399a63b10309@somainline.org>
Date:   Fri, 4 Nov 2022 17:34:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcs404: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2022 17:11, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>   arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 20 +++---
>   arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 52 +++++++--------
>   arch/arm64/boot/dts/qcom/qcs404.dtsi         | 66 ++++++++++++--------
>   3 files changed, 71 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
> index 08d5d51221cf..9c7d4e780357 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
> @@ -37,54 +37,54 @@ phy1: phy@4 {
>   };
>   
>   &tlmm {
> -	ethernet_defaults: ethernet-defaults {
> -		int {
> +	ethernet_defaults: ethernet-defaults-state {
> +		int-pins {
>   			pins = "gpio61";
>   			function = "rgmii_int";
>   			bias-disable;
>   			drive-strength = <2>;
>   		};
> -		mdc {
> +		mdc-pins {
>   			pins = "gpio76";
>   			function = "rgmii_mdc";
>   			bias-pull-up;
>   		};
> -		mdio {
> +		mdio-pins {
>   			pins = "gpio75";
>   			function = "rgmii_mdio";
>   			bias-pull-up;
>   		};
> -		tx {
> +		tx-pins {
>   			pins = "gpio67", "gpio66", "gpio65", "gpio64";
>   			function = "rgmii_tx";
>   			bias-pull-up;
>   			drive-strength = <16>;
>   		};
> -		rx {
> +		rx-pins {
>   			pins = "gpio73", "gpio72", "gpio71", "gpio70";
>   			function = "rgmii_rx";
>   			bias-disable;
>   			drive-strength = <2>;
>   		};
> -		tx-ctl {
> +		tx-ctl-pins {
>   			pins = "gpio68";
>   			function = "rgmii_ctl";
>   			bias-pull-up;
>   			drive-strength = <16>;
>   		};
> -		rx-ctl {
> +		rx-ctl-pins {
>   			pins = "gpio74";
>   			function = "rgmii_ctl";
>   			bias-disable;
>   			drive-strength = <2>;
>   		};
> -		tx-ck {
> +		tx-ck-pins {
>   			pins = "gpio63";
>   			function = "rgmii_ck";
>   			bias-pull-up;
>   			drive-strength = <16>;
>   		};
> -		rx-ck {
> +		rx-ck-pins {
>   			pins = "gpio69";
>   			function = "rgmii_ck";
>   			bias-disable;
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index dbbe1653718b..4d53cd544e41 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -229,7 +229,7 @@ &sdcc1 {
>   };
>   
>   &tlmm {
> -	perst_state: perst {
> +	perst_state: perst-state {
>   		pins = "gpio43";
>   		function = "gpio";
>   
> @@ -238,68 +238,63 @@ perst_state: perst {
>   		output-low;
>   	};
>   
> -	sdc1_on: sdc1-on {
> -		clk {
> +	sdc1_on: sdc1-on-state {
> +		clk-pins {
>   			pins = "sdc1_clk";
>   			bias-disable;
>   			drive-strength = <16>;
>   		};
>   
> -		cmd {
> +		cmd-pins {
>   			pins = "sdc1_cmd";
>   			bias-pull-up;
>   			drive-strength = <10>;
>   		};
>   
> -		data {
> +		data-pins {
>   			pins = "sdc1_data";
>   			bias-pull-up;
>   			drive-strength = <10>;
>   		};
>   
> -		rclk {
> +		rclk-pins {
>   			pins = "sdc1_rclk";
>   			bias-pull-down;
>   		};
>   	};
>   
> -	sdc1_off: sdc1-off {
> -		clk {
> +	sdc1_off: sdc1-off-state {
> +		clk-pins {
>   			pins = "sdc1_clk";
>   			bias-disable;
>   			drive-strength = <2>;
>   		};
>   
> -		cmd {
> +		cmd-pins {
>   			pins = "sdc1_cmd";
>   			bias-pull-up;
>   			drive-strength = <2>;
>   		};
>   
> -		data {
> +		data-pins {
>   			pins = "sdc1_data";
>   			bias-pull-up;
>   			drive-strength = <2>;
>   		};
>   
> -		rclk {
> +		rclk-pins {
>   			pins = "sdc1_rclk";
>   			bias-pull-down;
>   		};
>   	};
>   
> -	usb3_id_pin: usb3-id-pin {
> -		pinmux {
> -			pins = "gpio116";
> -			function = "gpio";
> -		};
> +	usb3_id_pin: usb3-id-state {
> +		pins = "gpio116";
> +		function = "gpio";
>   
> -		pinconf {
> -			pins = "gpio116";
> -			drive-strength = <2>;
> -			bias-pull-up;
> -			input-enable;
> -		};
> +		drive-strength = <2>;
> +		bias-pull-up;
> +		input-enable;
>   	};
>   };
>   
> @@ -366,31 +361,28 @@ &wifi {
>   /* PINCTRL - additions to nodes defined in qcs404.dtsi */
>   
>   &blsp1_uart2_default {
> -	rx {
> +	rx-pins {
>   		drive-strength = <2>;
>   		bias-disable;
>   	};
>   
> -	tx {
> +	tx-pins {
>   		drive-strength = <2>;
>   		bias-disable;
>   	};
>   };
>   
>   &blsp1_uart3_default {
> -	cts {
> -		pins = "gpio84";
> +	cts-pins {
>   		bias-disable;
>   	};
>   
> -	rts-tx {
> -		pins = "gpio85", "gpio82";
> +	rts-tx-pins {
>   		drive-strength = <2>;
>   		bias-disable;
>   	};
>   
> -	rx {
> -		pins = "gpio83";
> +	rx-pins {
>   		bias-pull-up;
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 80f2d05595fa..577d76662468 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -593,118 +593,130 @@ tlmm: pinctrl@1000000 {
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
>   
> -			blsp1_i2c0_default: blsp1-i2c0-default {
> +			blsp1_i2c0_default: blsp1-i2c0-default-state {
>   				pins = "gpio32", "gpio33";
>   				function = "blsp_i2c0";
>   			};
>   
> -			blsp1_i2c1_default: blsp1-i2c1-default {
> +			blsp1_i2c1_default: blsp1-i2c1-default-state {
>   				pins = "gpio24", "gpio25";
>   				function = "blsp_i2c1";
>   			};
>   
> -			blsp1_i2c2_default: blsp1-i2c2-default {
> -				sda {
> +			blsp1_i2c2_default: blsp1-i2c2-default-state {
> +				sda-pins {
>   					pins = "gpio19";
>   					function = "blsp_i2c_sda_a2";
>   				};
>   
> -				scl {
> +				scl-pins {
>   					pins = "gpio20";
>   					function = "blsp_i2c_scl_a2";
>   				};
>   			};
>   
> -			blsp1_i2c3_default: blsp1-i2c3-default {
> +			blsp1_i2c3_default: blsp1-i2c3-default-state {
>   				pins = "gpio84", "gpio85";
>   				function = "blsp_i2c3";
>   			};
>   
> -			blsp1_i2c4_default: blsp1-i2c4-default {
> +			blsp1_i2c4_default: blsp1-i2c4-default-state {
>   				pins = "gpio117", "gpio118";
>   				function = "blsp_i2c4";
>   			};
>   
> -			blsp1_uart0_default: blsp1-uart0-default {
> +			blsp1_uart0_default: blsp1-uart0-default-state {
>   				pins = "gpio30", "gpio31", "gpio32", "gpio33";
>   				function = "blsp_uart0";
>   			};
>   
> -			blsp1_uart1_default: blsp1-uart1-default {
> +			blsp1_uart1_default: blsp1-uart1-default-state {
>   				pins = "gpio22", "gpio23";
>   				function = "blsp_uart1";
>   			};
>   
> -			blsp1_uart2_default: blsp1-uart2-default {
> -				rx {
> +			blsp1_uart2_default: blsp1-uart2-default-state {
> +				rx-pins {
>   					pins = "gpio18";
>   					function = "blsp_uart_rx_a2";
>   				};
>   
> -				tx {
> +				tx-pins {
>   					pins = "gpio17";
>   					function = "blsp_uart_tx_a2";
>   				};
>   			};
>   
> -			blsp1_uart3_default: blsp1-uart3-default {
> -				pins = "gpio82", "gpio83", "gpio84", "gpio85";
> -				function = "blsp_uart3";
> +			blsp1_uart3_default: blsp1-uart3-default-state {
> +				cts-pins {
> +					pins = "gpio84";
> +					function = "blsp_uart3";
> +				};
> +
> +				rts-tx-pins {
> +					pins = "gpio85", "gpio82";
> +					function = "blsp_uart3";
> +				};
> +
> +				rx-pins {
> +					pins = "gpio83";
> +					function = "blsp_uart3";
> +				};
>   			};
>   
> -			blsp2_i2c0_default: blsp2-i2c0-default {
> +			blsp2_i2c0_default: blsp2-i2c0-default-state {
>   				pins = "gpio28", "gpio29";
>   				function = "blsp_i2c5";
>   			};
>   
> -			blsp1_spi0_default: blsp1-spi0-default {
> +			blsp1_spi0_default: blsp1-spi0-default-state {
>   				pins = "gpio30", "gpio31", "gpio32", "gpio33";
>   				function = "blsp_spi0";
>   			};
>   
> -			blsp1_spi1_default: blsp1-spi1-default {
> -				mosi {
> +			blsp1_spi1_default: blsp1-spi1-default-state {
> +				mosi-pins {
>   					pins = "gpio22";
>   					function = "blsp_spi_mosi_a1";
>   				};
>   
> -				miso {
> +				miso-pins {
>   					pins = "gpio23";
>   					function = "blsp_spi_miso_a1";
>   				};
>   
> -				cs_n {
> +				cs-n-pins {
>   					pins = "gpio24";
>   					function = "blsp_spi_cs_n_a1";
>   				};
>   
> -				clk {
> +				clk-pins {
>   					pins = "gpio25";
>   					function = "blsp_spi_clk_a1";
>   				};
>   			};
>   
> -			blsp1_spi2_default: blsp1-spi2-default {
> +			blsp1_spi2_default: blsp1-spi2-default-state {
>   				pins = "gpio17", "gpio18", "gpio19", "gpio20";
>   				function = "blsp_spi2";
>   			};
>   
> -			blsp1_spi3_default: blsp1-spi3-default {
> +			blsp1_spi3_default: blsp1-spi3-default-state {
>   				pins = "gpio82", "gpio83", "gpio84", "gpio85";
>   				function = "blsp_spi3";
>   			};
>   
> -			blsp1_spi4_default: blsp1-spi4-default {
> +			blsp1_spi4_default: blsp1-spi4-default-state {
>   				pins = "gpio37", "gpio38", "gpio117", "gpio118";
>   				function = "blsp_spi4";
>   			};
>   
> -			blsp2_spi0_default: blsp2-spi0-default {
> +			blsp2_spi0_default: blsp2-spi0-default-state {
>   				pins = "gpio26", "gpio27", "gpio28", "gpio29";
>   				function = "blsp_spi5";
>   			};
>   
> -			blsp2_uart0_default: blsp2-uart0-default {
> +			blsp2_uart0_default: blsp2-uart0-default-state {
>   				pins = "gpio26", "gpio27", "gpio28", "gpio29";
>   				function = "blsp_uart5";
>   			};
