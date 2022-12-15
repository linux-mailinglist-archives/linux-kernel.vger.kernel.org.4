Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1D64DC26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLONUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLONUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:20:37 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C72DA9F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:20:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bf43so2326733lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilerhl9aB5wldZrGi6JAgqg6pC5+HsK4xqZHdd6qSDQ=;
        b=cwIRbjabiTAM/XKcFoAozZBIgY2TmT4pmJeGjO/WYqhQctpp4UjGeDHE1/u4Hl5q0I
         6IFMCv6ct0755kRKSvAwmJ7i5Sih27uziVxexSL4OetAC5oDPRA8OfCv7AzA7U9S/Bca
         d8NHqzvSXNr0jxlCYMxCZPwONJCEQ4gMEHnGKjqOPUxDfo+w12ofxUblc9+Qdg75ijgm
         jyjf7twPWXwfwak2kC2TIAQJbWqeb1DVw1Wqgv6ys7haZw9DVcv17r4k3qUh4HMJ8/PJ
         LehfHsTnXINxibMAtsRE9oY3sHcAPC0Fg/yh0Frhj27gQTwM5tXnrf0Qfi6/c0WI1bdt
         Ms6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilerhl9aB5wldZrGi6JAgqg6pC5+HsK4xqZHdd6qSDQ=;
        b=RC+fKsOI2YinsyjgCYiNrKYtbq/Lf44/10E5u4zemlTtSW4gJBZkOteMYjg0JEzZq8
         xVy41g9UV+uMsb02upomUXD14pm7LxFafXtSlN13oDmq1KZhcHSe+ds9XdNU5PbMQe0Z
         0Ob1hYWnP6axfDB8v/yjSleoIym7HdA4pNFACCEn1iSF7OOq+rEf7NZJXbXiexJOjbxj
         kaJZFeRJRHPOrytxaCJvYKC+ALTD3McIXXNn3lDgimG+Ickbx4MNwuzR5mC0OjSczr26
         w55p7niaeOeiKeJll9hu9W8V4ipJN+aKjZhffwxfkPfi8t382iD/Q9kaBgGrHqonZ+ao
         O1Kg==
X-Gm-Message-State: ANoB5pmNnzXnHa3QvL3/+6G79ksHc8R1WbEdNJ5tVBMq+pujc2Dq0wyU
        7HPkWhxsJ2T2Cb/TFH3+2sLWDg==
X-Google-Smtp-Source: AA0mqf7RT8oY59cf+Be3rLYgLtjU2DX4Etj8BCthJJuaJRchwXq8CyN2TyAqyBsJDjQnRL9mUF2CCw==
X-Received: by 2002:a05:6512:b91:b0:4b6:ed8b:4f16 with SMTP id b17-20020a0565120b9100b004b6ed8b4f16mr6433868lfv.52.1671110433312;
        Thu, 15 Dec 2022 05:20:33 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id p15-20020a056512328f00b004a46f92a15bsm1153210lfe.41.2022.12.15.05.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 05:20:32 -0800 (PST)
Message-ID: <33fe1249-34b4-443b-4258-586ed8c5f0e6@linaro.org>
Date:   Thu, 15 Dec 2022 14:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: msm8976: Declare and use SDC2 pins
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214232049.703484-1-marijn.suijten@somainline.org>
 <20221214232049.703484-6-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214232049.703484-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
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



On 15.12.2022 00:20, Marijn Suijten wrote:
> Add the pinctrl states for SDC2 and use them on sdhc_2 to support SD
> Cards on the currently mainlined Sony Loire platform.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../qcom/msm8956-sony-xperia-loire-kugo.dts   |  6 +++
>  .../dts/qcom/msm8956-sony-xperia-loire.dtsi   |  6 +++
>  arch/arm64/boot/dts/qcom/msm8976.dtsi         | 45 +++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
> index 3fb8e23e4330..9178943e2ee1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
> @@ -33,3 +33,9 @@ &pm8950_l1 {
>  	regulator-min-microvolt = <1100000>;
>  	regulator-max-microvolt = <1300000>;
>  };
> +
> +&sdc2_on_state {
> +	data-pins {
> +		drive-strength = <8>;
> +	};
> +};
You can add a label to the data-pins subnode.


> diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> index 700583a56a0e..2253fb05f1c9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> @@ -264,6 +264,12 @@ &sdhc_1 {
>  	status = "okay";
>  };
>  
> +&sdc2_on_state {
> +	clk-pins {
> +		drive-strength = <10>;
> +	};
> +};
> +
>  &sdhc_2 {
>  	bus-width = <4>;
>  	cd-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 7d4c7548882c..f3371eaa2940 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -558,6 +558,46 @@ rclk-pins {
>  				};
>  			};
>  
> +			sdc2_off_state: sdc2-off-state {
> +				clk-pins {
> +					pins = "sdc2_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc2_cmd";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc2_data";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			sdc2_on_state: sdc2-on-state {
> +				clk-pins {
> +					pins = "sdc2_clk";
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc2_cmd";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc2_data";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +			};
> +
>  			spi1_default: spi0-default-state {
>  				spi-pins {
>  					pins = "gpio0", "gpio1", "gpio3";
> @@ -751,6 +791,11 @@ sdhc_2: mmc@7864000 {
>  				 <&gcc GCC_SDCC2_APPS_CLK>,
>  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
> +
> +			pinctrl-0 = <&sdc2_on_state>;
> +			pinctrl-1 = <&sdc2_off_state>;
> +			pinctrl-names = "default", "sleep";
Ditto (prev patch)

Konrad
> +
>  			status = "disabled";
>  		};
>  
