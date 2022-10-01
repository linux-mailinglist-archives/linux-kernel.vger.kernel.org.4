Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D35F1F34
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJAUPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJAUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:15:07 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069CF1902A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 13:15:01 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 934AA20139;
        Sat,  1 Oct 2022 22:14:59 +0200 (CEST)
Message-ID: <a3e44fe8-5abb-b0a7-efc5-2317ccb22f80@somainline.org>
Date:   Sat, 1 Oct 2022 22:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm6125: Add i2c and SPI pin
 configuration
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221001185628.494884-1-martin.botka@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221001185628.494884-1-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.10.2022 20:56, Martin Botka wrote:
> This commit adds configuration for I2C and SPI
> pins used in SM6125 SoC
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 547 +++++++++++++++++++++++++++
>  1 file changed, 547 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 85c52b64522e..350713742ccd 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -445,6 +445,553 @@ data {
>  					bias-pull-up;
>  				};
>  			};
> +
> +			/* qup_0 SE mappings */
> +			/* SE 0 pin mappings */
Drop the downstream-copypasted comments, drop mux{}/config{} and align the
names with bindings.

Konrad
> +			qup_i2c0_default: qup-i2c0-default {
> +				mux {
> +					pins = "gpio0", "gpio1";
> +					function = "qup00";
> +				};
> +
> +				config {
> +					pins = "gpio0", "gpio1";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +			qup_i2c0_sleep: qup-i2c0-sleep {
> +				mux {
> +					pins = "gpio0", "gpio1";
> +					function = "gpio";
> +				};
> +
> +				config {
> +					pins = "gpio0", "gpio1";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 1 pin mappings */
> +			qup_i2c1_default: qup-i2c1-default {
> +				mux {
> +					pins = "gpio4", "gpio5";
> +					function = "qup01";
> +				};
> +
> +				config {
> +					pins = "gpio4", "gpio5";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +			qup_i2c1_sleep: qup-i2c1-sleep {
> +				mux {
> +					pins = "gpio4", "gpio5";
> +					function = "gpio";
> +				};
> +
> +				config {
> +					pins = "gpio4", "gpio5";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 2 pin mappings */
> +			qup_i2c2_default: qup-i2c2-default {
> +				mux {
> +					pins = "gpio6", "gpio7";
> +					function = "qup02";
> +				};
> +
> +				config {
> +					pins = "gpio6", "gpio7";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +			qup_i2c2_sleep: qup-i2c2-sleep {
> +				mux {
> +					pins = "gpio6", "gpio7";
> +					function = "gpio";
> +				};
> +
> +				config {
> +					pins = "gpio6", "gpio7";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 3 pin mappings */
> +			qup_i2c3_default: qup-i2c3-default {
> +				mux {
> +						pins = "gpio14", "gpio15";
> +						function = "qup03";
> +				};
> +
> +				config {
> +						pins = "gpio14", "gpio15";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c3_sleep: qup-i2c3-sleep {
> +				mux {
> +						pins = "gpio14", "gpio15";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio14", "gpio15";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 4 pin mappings */
> +			qup_i2c4_default: qup-i2c4-default {
> +				mux {
> +						pins = "gpio16", "gpio17";
> +						function = "qup04";
> +				};
> +
> +				config {
> +						pins = "gpio16", "gpio17";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c4_sleep: qup-i2c4-sleep {
> +				mux {
> +						pins = "gpio16", "gpio17";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio16", "gpio17";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/*qup_1 SE mappings */
> +			/* SE 5 pin mappings */
> +			qup_i2c5_default: qup-i2c5-default {
> +				mux {
> +						pins = "gpio22", "gpio23";
> +						function = "qup10";
> +				};
> +
> +				config {
> +						pins = "gpio22", "gpio23";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c5_sleep: qup-i2c5-sleep {
> +				mux {
> +						pins = "gpio22", "gpio23";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio22", "gpio23";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 6 pin mappings */
> +			qup_i2c6_default: qup-i2c6-default {
> +				mux {
> +						pins = "gpio30", "gpio31";
> +						function = "qup11";
> +				};
> +
> +				config {
> +						pins = "gpio30", "gpio31";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c6_sleep: qup-i2c6-sleep {
> +				mux {
> +						pins = "gpio30", "gpio31";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio30", "gpio31";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 7 pin mappings */
> +			qup_i2c7_default: qup-i2c7-default {
> +				mux {
> +						pins = "gpio28", "gpio29";
> +						function = "qup12";
> +				};
> +
> +				config {
> +						pins = "gpio28", "gpio29";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c7_sleep: qup-i2c7-sleep {
> +				mux {
> +						pins = "gpio28", "gpio29";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio28", "gpio29";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 8 pin mappings */
> +			qup_i2c8_default: qup-i2c8-default {
> +				mux {
> +						pins = "gpio18", "gpio19";
> +						function = "qup13";
> +				};
> +
> +				config {
> +						pins = "gpio18", "gpio19";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c8_sleep: qup-i2c8-sleep {
> +				mux {
> +						pins = "gpio18", "gpio19";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio18", "gpio19";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			/* SE 9 pin mappings */
> +			qup_i2c9_default: qup-i2c9-default {
> +				mux {
> +						pins = "gpio10", "gpio11";
> +						function = "qup14";
> +				};
> +
> +				config {
> +						pins = "gpio10", "gpio11";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_i2c9_sleep: qup-i2c9-sleep {
> +				mux {
> +						pins = "gpio10", "gpio11";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio10", "gpio11";
> +						drive-strength = <2>;
> +						bias-pull-up;
> +				};
> +			};
> +
> +			qup_se3_rx: qup-se3-rx {
> +				mux {
> +					pins = "gpio15";
> +					function = "qup03";
> +				};
> +
> +				config {
> +					pins = "gpio15";
> +					drive-strength = <2>;
> +					bias-no-pull;
> +				};
> +			};
> +
> +			qup_se3_tx: qup-se6-tx {
> +				mux {
> +					pins = "gpio14";
> +					function = "qup03";
> +				};
> +
> +				config {
> +					pins = "gpio14";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			qup_se4_2uart_default: qup-se4-2uart-default {
> +				mux {
> +					pins = "gpio16", "gpio17";
> +					function = "qup04";
> +				};
> +
> +				config {
> +						pins = "gpio16", "gpio17";
> +						drive-strength = <2>;
> +						bias-disable;
> +				};
> +			};
> +
> +			qup_se4_2uart_sleep: qup-se4-2uart-sleep {
> +				mux {
> +						pins = "gpio16", "gpio17";
> +						function = "gpio";
> +				};
> +
> +				config {
> +						pins = "gpio16", "gpio17";
> +						drive-strength = <2>;
> +						bias-pull-down;
> +				};
> +			};
> +
> +			qup_se9_ctsrx: qup-se9-ctsrx {
> +				mux {
> +					pins = "gpio10", "gpio13";
> +					function = "qup14";
> +				};
> +
> +				config {
> +					pins = "gpio10", "gpio13";
> +					drive-strength = <2>;
> +					bias-no-pull;
> +				};
> +			};
> +
> +			qup_se9_rts: qup-se9-rts {
> +				mux {
> +					pins = "gpio11";
> +					function = "qup14";
> +				};
> +
> +				config {
> +					pins = "gpio11";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
> +			qup_se9_tx: qup-se9-tx {
> +				mux {
> +					pins = "gpio12";
> +					function = "qup14";
> +				};
> +
> +				config {
> +					pins = "gpio12";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			/* SPI Instances */
> +			/* SE 0 pin mappings */
> +			qup_spi0_default: qup-spi0-default {
> +				mux {
> +					pins = "gpio0", "gpio1", "gpio2",
> +								"gpio3";
> +					function = "qup00";
> +				};
> +
> +				config {
> +					pins = "gpio0", "gpio1", "gpio2",
> +								"gpio3";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			qup_spi0_sleep: qup-spi0-sleep {
> +				mux {
> +					pins = "gpio0", "gpio1", "gpio2",
> +								"gpio3";
> +					function = "gpio";
> +				};
> +
> +				configs {
> +					pins = "gpio0", "gpio1", "gpio2",
> +								"gpio3";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			/* SE 2 pin mappings */
> +			qup_spi2_default: qup-spi2-default {
> +				mux {
> +					pins = "gpio6", "gpio7", "gpio8",
> +								"gpio9";
> +					function = "qup02";
> +				};
> +
> +				config {
> +					pins = "gpio6", "gpio7", "gpio8",
> +								"gpio9";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			qup_spi2_sleep: qup-spi2-sleep {
> +				mux {
> +					pins = "gpio6", "gpio7", "gpio8",
> +								"gpio9";
> +					function = "gpio";
> +				};
> +
> +				configs {
> +					pins = "gpio6", "gpio7", "gpio8",
> +								"gpio9";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			/* SE 5 pin mappings */
> +			qup_spi5_default: qup-spi5-default {
> +				mux {
> +					pins = "gpio22", "gpio23", "gpio24",
> +								"gpio25";
> +					function = "qup10";
> +				};
> +
> +				config {
> +					pins = "gpio22", "gpio23", "gpio24",
> +								"gpio25";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			qup_spi5_sleep: qup-spi5-sleep {
> +				mux {
> +					pins = "gpio22", "gpio23", "gpio24",
> +								"gpio25";
> +					function = "gpio";
> +				};
> +
> +				configs {
> +					pins = "gpio22", "gpio23", "gpio24",
> +								"gpio25";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			/* SE 6 pin mappings */
> +			qup_spi6_default: qup-spi6-default {
> +				mux {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					function = "qup11";
> +				};
> +
> +				config {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			qup_spi6_sleep: qup-spi6-sleep {
> +				mux {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					function = "gpio";
> +				};
> +
> +				configs {
> +					pins = "gpio30", "gpio31", "gpio32",
> +								"gpio33";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			/* SE 8 pin mappings */
> +			qup_spi8_default: qup-spi8-default {
> +				mux {
> +					pins = "gpio18", "gpio19", "gpio20",
> +								"gpio21";
> +					function = "qup13";
> +				};
> +
> +				config {
> +					pins = "gpio18", "gpio19", "gpio20",
> +								"gpio21";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			qup_spi8_sleep: qup-spi8-sleep {
> +				mux {
> +					pins = "gpio18", "gpio19", "gpio20",
> +								"gpio21";
> +					function = "gpio";
> +				};
> +
> +				configs {
> +					pins = "gpio18", "gpio19", "gpio20",
> +								"gpio21";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			/* SE 9 pin mappings */
> +			qup_spi9_default: qup-spi9-default {
> +				mux {
> +					pins = "gpio10", "gpio11", "gpio12",
> +								"gpio13";
> +					function = "qup_14";
> +				};
> +
> +				config {
> +					pins = "gpio10", "gpio11", "gpio12",
> +								"gpio13";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
> +
> +			qup_spi9_sleep: qup-spi9-sleep {
> +				mux {
> +					pins = "gpio10", "gpio11", "gpio12",
> +								"gpio13";
> +					function = "gpio";
> +				};
> +
> +				configs {
> +					pins = "gpio10", "gpio11", "gpio12",
> +								"gpio13";
> +					drive-strength = <6>;
> +					bias-disable;
> +				};
> +			};
>  		};
>  
>  		gcc: clock-controller@1400000 {
