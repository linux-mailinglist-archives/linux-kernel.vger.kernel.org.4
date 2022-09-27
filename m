Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B25EC318
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiI0Mm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiI0MmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:42:22 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67CADB96A;
        Tue, 27 Sep 2022 05:42:20 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0A4083F30C;
        Tue, 27 Sep 2022 14:34:15 +0200 (CEST)
Message-ID: <cfd28ebb-3ce1-7bec-3ae4-fe482d46ddab@somainline.org>
Date:   Tue, 27 Sep 2022 14:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 03/15] arm64: dts: qcom: sc8280xp: align TLMM pin
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
 <20220925110608.145728-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220925110608.145728-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.2022 13:05, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
>   qcom/sc8280xp-crd.dtb: pinctrl@f100000: kybd-default-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'disable', 'int-n', 'reset' do not match any of the regexes: 'pinctrl-[0-9]+'
>     'disable', 'int-n', 'reset' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts            | 12 ++++++------
>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index fea7d8273ccd..a2027f1d1d04 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -374,19 +374,19 @@ &tlmm {
>  	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
>  	kybd_default: kybd-default-state {
> -		disable {
> +		disable-pins {
>  			pins = "gpio102";
>  			function = "gpio";
>  			output-low;
>  		};
>  
> -		int-n {
> +		int-n-pins {
>  			pins = "gpio104";
>  			function = "gpio";
>  			bias-disable;
>  		};
>  
> -		reset {
> +		reset-pins {
>  			pins = "gpio105";
>  			function = "gpio";
>  			bias-disable;
> @@ -410,7 +410,7 @@ qup2_i2c5_default: qup2-i2c5-default-state {
>  	};
>  
>  	tpad_default: tpad-default-state {
> -		int-n {
> +		int-n-pins {
>  			pins = "gpio182";
>  			function = "gpio";
>  			bias-disable;
> @@ -418,13 +418,13 @@ int-n {
>  	};
>  
>  	ts0_default: ts0-default-state {
> -		int-n {
> +		int-n-pins {
>  			pins = "gpio175";
>  			function = "gpio";
>  			bias-disable;
>  		};
>  
> -		reset-n {
> +		reset-n-pins {
>  			pins = "gpio99";
>  			function = "gpio";
>  			output-high;
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index b2b744bb8a53..68b61e8d03c0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -350,19 +350,19 @@ &tlmm {
>  	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
>  	kybd_default: kybd-default-state {
> -		disable {
> +		disable-pins {
>  			pins = "gpio102";
>  			function = "gpio";
>  			output-low;
>  		};
>  
> -		int-n {
> +		int-n-pins {
>  			pins = "gpio104";
>  			function = "gpio";
>  			bias-disable;
>  		};
>  
> -		reset {
> +		reset-pins {
>  			pins = "gpio105";
>  			function = "gpio";
>  			bias-disable;
> @@ -384,7 +384,7 @@ qup2_i2c5_default: qup2-i2c5-default-state {
>  	};
>  
>  	tpad_default: tpad-default-state {
> -		int-n {
> +		int-n-pins {
>  			pins = "gpio182";
>  			function = "gpio";
>  			bias-disable;
> @@ -392,13 +392,13 @@ int-n {
>  	};
>  
>  	ts0_default: ts0-default-state {
> -		int-n {
> +		int-n-pins {
>  			pins = "gpio175";
>  			function = "gpio";
>  			bias-disable;
>  		};
>  
> -		reset-n {
> +		reset-n-pins {
>  			pins = "gpio99";
>  			function = "gpio";
>  			output-high;
