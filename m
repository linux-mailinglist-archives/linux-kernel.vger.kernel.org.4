Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4F632096
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKUL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiKUL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:29:11 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9D1A4166
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:23:55 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id d3so14179579ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1hGOwFF0QOaziSceA+/kHlNJfHPDOB+lxzerxjy37o=;
        b=YJggKpNFJMfD36AY7M96yLXiFYjsPS9oSWYw5ibweyqMc6ggvkWBDLZjKQ83ZQMMVP
         +eskohJ9QvWrIxPl1/JTg7qU78bDg7VUHkWZXh8UE3odnBpAOS02WupeYx1uWwIOCpHD
         Pa71ENGsyNFTJ+4Z5vm92AMNQo2pqk7Ob5oVcL18SoSCI/LoUfuzUgYWvp454xiWLTkH
         V9LN9tDVb1tDGTvpOPD8loXSx3hZ5OadJM3qf9dOcQ8U8wSAN9r3B6F6HfOm8AugbOOI
         7tjJV3S2SWa6T8owV7VDSedJt1H1gIkEAHvcD0psTRcawWZT1PmD9SqZPFXZq/CwGL6K
         9FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1hGOwFF0QOaziSceA+/kHlNJfHPDOB+lxzerxjy37o=;
        b=htED2veXZ5Pa4BVdtsorp057qc9v91W6kEFO0IryjPRAoQAz6oLF03TqjYuaAaPN+r
         BLFmhV1pJmKWLhTs1PCzCZHO7EOXiTTEFPkd093fiCWvWKrq0mSoW3jMXY8n3L2axD8n
         ZDSzcT4T3st1rpsJapo9TPHbQKYFK5WI+amBvvw9fT3TJYx8iVTpr5zckG0K72nIzSkU
         L+gDaI69WHhhe+vayU9tMAr9b/RIUkwa6D+lNgdx2GSQBhGm3RJi+oEnVM3NuGh0iH23
         0m3i8AtB/PQz4u7mREn7AYQB715LwdIkGExq5jACg9OxPrBrnfMWG8NmJ6DeBGo2FCte
         r4Ww==
X-Gm-Message-State: ANoB5pmnytQ5gtnzLEajAlbRIcjmaJXmbb4ZqBnbqhRiPvhJGASXT8MG
        Wqqlz7EveP0tUg4SaIPtL2BsIA==
X-Google-Smtp-Source: AA0mqf5Gy6Om8GCoWWSM+y5Gu90BLj8vZ4RsuzPdzhzC3Pz48PdN39Vc+SL0UNZKWidA5ntFxgVyNw==
X-Received: by 2002:a2e:3807:0:b0:277:b3a:43dc with SMTP id f7-20020a2e3807000000b002770b3a43dcmr5051173lja.411.1669029834066;
        Mon, 21 Nov 2022 03:23:54 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651210c800b0048a982ad0a8sm1980583lfg.23.2022.11.21.03.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:23:53 -0800 (PST)
Message-ID: <729600fb-e2e6-5ae8-514b-2847501b1c14@linaro.org>
Date:   Mon, 21 Nov 2022 12:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add
 touchscreen
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221119202316.93142-1-linmengbo0689@protonmail.com>
 <20221119202649.93613-1-linmengbo0689@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221119202649.93613-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.11.2022 21:27, Lin, Meng-Bo wrote:
> FL8005A uses a Focaltech FT5402 touchscreen that is connected to
> blsp_i2c5. Add it to the device tree.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
> index bed1fe984287..cc81880f7c42 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
> @@ -65,6 +65,32 @@ usb_id: usb-id {
>  	};
>  };
>  
> +&blsp_i2c5 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		/* Actually ft5402 */
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +
> +		reset-gpios = <&msmgpio 12 GPIO_ACTIVE_LOW>;
> +
> +		vcc-supply = <&pm8916_l17>;
> +		iovcc-supply = <&pm8916_l6>;
> +
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <500>;
> +		touchscreen-inverted-x;
> +		touchscreen-swapped-x-y;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_default>;
> +	};
> +};
> +
>  &blsp1_uart2 {
>  	status = "okay";
>  };
> @@ -229,6 +255,24 @@ gpio_leds_default: gpio-led-default-state {
>  		bias-disable;
>  	};
>  
> +	touchscreen_default: touchscreen-default-state {
> +		touchscreen-pins {
> +			pins = "gpio13";
> +			function = "gpio";
> +
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		reset-pins {
> +			pins = "gpio12";
> +			function = "gpio";
> +
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
These subnodes are not sorted in any way, neither alphabetically nor
GPIO-no wise. Please swap them.

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +	};
> +
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio110";
>  		function = "gpio";
