Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927425BD525
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiISTUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiISTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:20:04 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5232B86
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:20:01 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B0DA61F5FA;
        Mon, 19 Sep 2022 21:19:59 +0200 (CEST)
Message-ID: <df6b1f7a-3dd4-496b-bb6d-572aa8e08257@somainline.org>
Date:   Mon, 19 Sep 2022 21:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: dts: qcom: correct white-space before {
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919163333.129989-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220919163333.129989-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.09.2022 18:33, Krzysztof Kozlowski wrote:
> Add missing space or remove redundant one before opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Very nice!

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad

>  arch/arm64/boot/dts/qcom/msm8996.dtsi                 | 2 +-
>  arch/arm64/boot/dts/qcom/msm8998.dtsi                 | 8 ++++----
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts              | 4 ++--
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 8 ++++----
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi            | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts            | 8 ++++----
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts  | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts      | 6 +++---
>  10 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 1e6b70582866..6a0420c079f5 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1498,7 +1498,7 @@ blsp2_i2c3_sleep: blsp2-i2c3-sleep {
>  				bias-disable;
>  			};
>  
> -			wcd_intr_default: wcd-intr-default{
> +			wcd_intr_default: wcd-intr-default {
>  				pins = "gpio54";
>  				function = "gpio";
>  				drive-strength = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index d463a66715ea..7e2a8b168d91 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -1903,7 +1903,7 @@ etm5: etm@7c40000 {
>  
>  			cpu = <&CPU4>;
>  
> -			port{
> +			port {
>  				etm4_out: endpoint {
>  					remote-endpoint = <&apss_funnel_in4>;
>  				};
> @@ -1920,7 +1920,7 @@ etm6: etm@7d40000 {
>  
>  			cpu = <&CPU5>;
>  
> -			port{
> +			port {
>  				etm5_out: endpoint {
>  					remote-endpoint = <&apss_funnel_in5>;
>  				};
> @@ -1937,7 +1937,7 @@ etm7: etm@7e40000 {
>  
>  			cpu = <&CPU6>;
>  
> -			port{
> +			port {
>  				etm6_out: endpoint {
>  					remote-endpoint = <&apss_funnel_in6>;
>  				};
> @@ -1954,7 +1954,7 @@ etm8: etm@7f40000 {
>  
>  			cpu = <&CPU7>;
>  
> -			port{
> +			port {
>  				etm7_out: endpoint {
>  					remote-endpoint = <&apss_funnel_in7>;
>  				};
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index bf8077a1cf9a..3d1bd8e3fc73 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -1007,7 +1007,7 @@ can@0 {
>  };
>  
>  &swr0 {
> -	left_spkr: wsa8810-left{
> +	left_spkr: wsa8810-left {
>  		compatible = "sdw10217211000";
>  		reg = <0 3>;
>  		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
> @@ -1016,7 +1016,7 @@ left_spkr: wsa8810-left{
>  		#sound-dai-cells = <0>;
>  	};
>  
> -	right_spkr: wsa8810-right{
> +	right_spkr: wsa8810-right {
>  		compatible = "sdw10217211000";
>  		reg = <0 4>;
>  		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> index 7ee407f7b6bb..1ce73187a562 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -181,7 +181,7 @@ &sound_multimedia0_codec {
>  /* PINCTRL - modifications to sc7180-trogdor.dtsi */
>  
>  &en_pp3300_dx_edp {
> -	pinmux  {
> +	pinmux {
>  		pins = "gpio67";
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index 1bd6c7dcd9e9..7fcff4eddd3a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -189,7 +189,7 @@ pinconf {
>  	};
>  };
>  
> -&sec_mi2s_active{
> +&sec_mi2s_active {
>  	pinmux {
>  		pins = "gpio49", "gpio50", "gpio51", "gpio52";
>  		function = "mi2s_1";
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index b5f534db135a..6ea62ce138ce 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -1220,7 +1220,7 @@ pinconf {
>  	};
>  
>  	ap_suspend_l_neuter: ap-suspend-l-neuter {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio27";
>  			function = "gpio";
>  		};
> @@ -1365,7 +1365,7 @@ pinconf {
>  	};
>  
>  	pen_rst_odl: pen-rst-odl {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio18";
>  			function = "gpio";
>  		};
> @@ -1489,7 +1489,7 @@ pinconf {
>  	};
>  
>  	ts_int_l: ts-int-l {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio9";
>  			function = "gpio";
>  		};
> @@ -1501,7 +1501,7 @@ pinconf {
>  	};
>  
>  	ts_reset_l: ts-reset-l {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio8";
>  			function = "gpio";
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index b5eb8f7eca1d..d46a6d2a7912 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -1341,7 +1341,7 @@ pinconf {
>  	};
>  
>  	pen_rst_l: pen-rst-l {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio23";
>  			function = "gpio";
>  		};
> @@ -1408,7 +1408,7 @@ pinconf {
>  	};
>  
>  	ts_int_l: ts-int-l {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio125";
>  			function = "gpio";
>  		};
> @@ -1420,7 +1420,7 @@ pinconf {
>  	};
>  
>  	ts_reset_l: ts-reset-l {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio118";
>  			function = "gpio";
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 132417e2d11e..feb1396fadb6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1076,7 +1076,7 @@ &venus {
>  	status = "okay";
>  };
>  
> -&wcd9340{
> +&wcd9340 {
>  	pinctrl-0 = <&wcd_intr_default>;
>  	pinctrl-names = "default";
>  	clock-names = "extclk";
> @@ -1089,7 +1089,7 @@ &wcd9340{
>  	vdd-io-supply = <&vreg_s4a_1p8>;
>  
>  	swm: swm@c85 {
> -		left_spkr: wsa8810-left{
> +		left_spkr: wsa8810-left {
>  			compatible = "sdw10217201000";
>  			reg = <0 1>;
>  			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
> @@ -1098,7 +1098,7 @@ left_spkr: wsa8810-left{
>  			#sound-dai-cells = <0>;
>  		};
>  
> -		right_spkr: wsa8810-right{
> +		right_spkr: wsa8810-right {
>  			compatible = "sdw10217201000";
>  			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
>  			reg = <0 2>;
> @@ -1126,7 +1126,7 @@ &qup_spi2_default {
>  	drive-strength = <16>;
>  };
>  
> -&qup_uart3_default{
> +&qup_uart3_default {
>  	pinmux {
>  		pins = "gpio41", "gpio42", "gpio43", "gpio44";
>  		function = "qup3";
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index be59a8ba9c1f..761927535778 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -783,7 +783,7 @@ &wcd9340{
>  	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>  
>  	swm: swm@c85 {
> -		left_spkr: wsa8810-left{
> +		left_spkr: wsa8810-left {
>  			compatible = "sdw10217211000";
>  			reg = <0 3>;
>  			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
> @@ -792,7 +792,7 @@ left_spkr: wsa8810-left{
>  			#sound-dai-cells = <0>;
>  		};
>  
> -		right_spkr: wsa8810-right{
> +		right_spkr: wsa8810-right {
>  			compatible = "sdw10217211000";
>  			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
>  			reg = <0 4>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index f954fe5cb61a..7e92438034e8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -574,7 +574,7 @@ pinconf {
>  	};
>  
>  	pen_rst_l: pen-rst-l {
> -		pinmux  {
> +		pinmux {
>  			pins = "gpio21";
>  			function = "gpio";
>  		};
> @@ -715,7 +715,7 @@ &wcd9340{
>  	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>  
>  	swm: swm@c85 {
> -		left_spkr: wsa8810-left{
> +		left_spkr: wsa8810-left {
>  			compatible = "sdw10217211000";
>  			reg = <0 3>;
>  			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
> @@ -724,7 +724,7 @@ left_spkr: wsa8810-left{
>  			#sound-dai-cells = <0>;
>  		};
>  
> -		right_spkr: wsa8810-right{
> +		right_spkr: wsa8810-right {
>  			compatible = "sdw10217211000";
>  			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
>  			reg = <0 4>;
