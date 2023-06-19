Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C5735832
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFSNNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjFSNNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:13:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB39E7D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:13:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b45e347266so38115051fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180405; x=1689772405;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUCyn43Ba05/wUTOfOtOC0PNLhyt9DVE36oTpy8FhmQ=;
        b=GSgSqHAeUeq4yP1hrxDx/jdZ19hRgodHecxJnEL1tomeV8PoZWM97/WPmxMn+bAtih
         m3AAO2zg/F3NnYk9gJsmCYcj2CgD7StPi6jD4yCs7Dhdbx6OXOdLEHwIdMul1tLYEuDu
         +7bzTOEHmMyNJI+xKjgpxMkphW6SYj5fn0humBCqFARjsT91t1mb2DVl4MeImsy6eqUK
         qp0kRvsh6tEGiiGcASFCmRh6njWsWWXEIvTtLzVh4q6VPsi0Yfq8oT8UeaSz6BgRkJHD
         RRwFaS4R8FFfbkgur0rkYTx2YTwvO2Oscdj1yCE153vdUvG/UyaIBKODCFPMRrrgTWRN
         FDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180405; x=1689772405;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUCyn43Ba05/wUTOfOtOC0PNLhyt9DVE36oTpy8FhmQ=;
        b=A7Rtu5TZ5/IM4PBTPMUmLeVzglTxsoezyj+YSI8CyLl/ZVG70/+ad5LlrEmnogr8ow
         ac4mwpb6ODAb9yu5l9J5bE7fh3hgnCubym+/es3NQm89qvjtb+oJOM8ygteEtOA2EftT
         j8YaJjARLmFoFx8wF9Q/7AKAp4FoaIjN1b1p7neUuFN4m59psyyo87DTP0FyQn9FbZD7
         fiR3Fssdn3n8lnWFeVKPSjeo3wSCpW0dz0jAolnumaJwIIqhfpaHdQpyNRGt/9/HsN9S
         sqkkuaimGC+izan4WOwSIxmZ7rR6W2olcMyx+Oia9VRTJo4Ovsbbe78hlbsCEXiDorMs
         o6mg==
X-Gm-Message-State: AC+VfDwUs19lB6cXK/Wv8R10lDq990MQ3fD+7e5YeAqS/jaL9C55NBdL
        g7Uj3dVnAbv/Z7BMTcxI6WDPuQ==
X-Google-Smtp-Source: ACHHUZ4QmAXqKKYI0X6pS123LITWyxHMwUQiADRiJtPSdqleIp0mfmhlbA2qwnxHC6FBbbgptq8bcQ==
X-Received: by 2002:a2e:9808:0:b0:2b4:4a0b:8fb8 with SMTP id a8-20020a2e9808000000b002b44a0b8fb8mr5529604ljj.53.1687180404749;
        Mon, 19 Jun 2023 06:13:24 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id d8-20020a2e9288000000b002b247680950sm4758983ljh.131.2023.06.19.06.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:13:24 -0700 (PDT)
Message-ID: <43f57911-15bc-072e-fc41-bbb55c99c5fc@linaro.org>
Date:   Mon, 19 Jun 2023 15:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/15] arm64: dts: qcom: sc7180-aspire1: use generic ADC
 channel node names
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-8-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> ADC channel node names were changed to require generic 'channel'.  The
> user-visible part is defined via label.
> 
>   sc7180-acer-aspire1.dtb: adc@3100: 'charger-thermistor@4f', 'thermistor@4e' do not match any of the regexes: '^channel@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
> index b637b4270f88..dbb48934d499 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
> @@ -314,16 +314,18 @@ &mdss_dsi0_phy {
>  };
>  
>  &pm6150_adc {
> -	thermistor@4e {
> +	channel@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "thermistor";
>  	};
>  
> -	charger-thermistor@4f {
> +	channel@4f {
>  		reg = <ADC5_AMUX_THM3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> +		label = "charger_thermistor";
>  	};
>  };
>  
