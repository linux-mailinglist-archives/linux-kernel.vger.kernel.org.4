Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF970635BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiKWL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiKWL3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:29:16 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7CEC09E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:28:15 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so27716916lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1ADM7UYe44oPMUdR6G7H2LOvTiTNGV7P8fJqETMECo=;
        b=y4f4ErZCeTYMmipHc+uKfUdwmYenDNglYBypVQlDRhsh0UqP/veREFs+35Nl8dDqsY
         jCByBajx/AabQjcFZgikBUXpRIEtO4lySKcc66TbWw74Of2X0+2GSDPSN59oi+ETkA64
         JR9q8V/Mu3wFuewMpGST8gSnGpUWCfsQUrdobTLd7Ibfzhy9nI5NPUXbH0tg4HlSm+l3
         qA/ftoRddicm+ZYqrLwt/T/3SDpdkVxA4fQf3Aep/RGYxFZQflHX4VbIPOCe1JBt9M0g
         Cg/HGo1NH7C1j7Y4Nl26aQZOoMEDkLHQs/c1gYZ1+YdroS8HRoE+Q0Kk8+8yfx04xXSk
         CUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1ADM7UYe44oPMUdR6G7H2LOvTiTNGV7P8fJqETMECo=;
        b=dCtP2iFODXk44IFYXqNsf2JLgI/CsY/7kKImMdH5G+48fiG8Zy92Kb1yZ+lKY+y7ik
         oMmXt/GmoB6pu7DfXYI7YPb8bkLvqjS4hYaWzHTy0EVhhVIbif6uaSYY72GO7RfXSPM4
         7z5hBFbOqXRjr6uYc7jNuPKIiJvcdm2GeZ+iNi0y1DgJo1RRY2yMQDDyYZBw8HyrW8yP
         KbxGb+ARlpsWja/dAjHsscUR2tTRJqFC1YOZiLDQ2AyO5nIexbpoepAtoddh5XHhzl1/
         K4NPW0FKPVaZ9IZw3AM7m8qQxDO3yGqnK3nUW3FQtJS9kv9dGn4zaOKWjv1Vomutld/y
         ZfnQ==
X-Gm-Message-State: ANoB5plrPT9wUBryXPND1Jcq9VZOfx6CzDVUttcVFzLo+6+0z54ihm4N
        qdizVev6BxXyQpoKaJBUgB14qg==
X-Google-Smtp-Source: AA0mqf5hFh16jq8zxNHpSxi7CuwYbhXKAFsg22owMtSy38KbIA6849AQxkEFyLxZVwneGKqpacQM6Q==
X-Received: by 2002:ac2:46f0:0:b0:4b4:c0c:89a3 with SMTP id q16-20020ac246f0000000b004b40c0c89a3mr8844104lfo.129.1669202893857;
        Wed, 23 Nov 2022 03:28:13 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id j4-20020a05651231c400b004a44ffb1023sm2889071lfe.57.2022.11.23.03.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 03:28:13 -0800 (PST)
Message-ID: <f48780d3-cce6-ea0b-1799-67ffc1eee6e4@linaro.org>
Date:   Wed, 23 Nov 2022 12:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 4/4] arm64: dts: qcom: msm8916-acer-a1-724: Add
 touchscreen
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221123033524.148682-1-linmengbo0689@protonmail.com>
 <20221123033844.149115-1-linmengbo0689@protonmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221123033844.149115-1-linmengbo0689@protonmail.com>
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



On 23.11.2022 04:39, Lin, Meng-Bo wrote:
> A1-724 uses a Focaltech FT5446 touchscreen that is connected to blsp_i2c5.
> Add it to the device tree.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> index bea0d022dd9a..ed3fa7b3575b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> @@ -81,6 +81,30 @@ magnetometer@12 {
>  	};
>  };
>  
> +&blsp_i2c5 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		/* Actually ft5446 */
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&msmgpio 12 GPIO_ACTIVE_LOW>;
> +
> +		vcc-supply = <&pm8916_l16>;
> +		iovcc-supply = <&pm8916_l6>;
> +
> +		touchscreen-size-x = <720>;
> +		touchscreen-size-y = <1280>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_default>;
> +	};
> +};
> +
>  &blsp1_uart2 {
>  	status = "okay";
>  };
> @@ -245,6 +269,22 @@ gpio_keys_default: gpio-keys-default-state {
>  		bias-pull-up;
>  	};
>  
> +	touchscreen_default: touchscreen-default-state {
> +		reset-pins {
> +			pins = "gpio12";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		touchscreen-pins {
> +			pins = "gpio13";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio110";
>  		function = "gpio";
