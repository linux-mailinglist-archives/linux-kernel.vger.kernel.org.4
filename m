Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32716AC418
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCFO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCFO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:56:23 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60523018B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:56:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m6so13107976lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678114576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9LweKf4JzqL0IS+04n+yrHmshSKW/nm1KRbW1h+egk=;
        b=txLbWTIYbhEtXnglrzpLkGVIdUq3Kf9SZgONKaR6wrJ25g0ycyvEmUrY9pB/u3f6xX
         /BTKClMgKKrvAmGu9BKsiQp87kmFM50ZuxNE7fj2P31Zvcie7NprJxPpk4zH3nrVkULh
         3Z3QuIZDX5QyRLlnMBBco4JaTj3KmI4TyGJfbXMxshuO1Dz7UpQebfXYukmxe4jASSp8
         l1eIaYl95J/5JVY9W/Sg9xRY9Dt2AR2ZS6BjDHB8QuIzTVYL3CdADt9ef38lX9RJn1jy
         TAeR0bgPs6RGDiS+9sbXgcVDeGh8gXv2evCJH/Tf4vBZoS1FK9pgC6P6HG5ZAGSi8Dp0
         FNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9LweKf4JzqL0IS+04n+yrHmshSKW/nm1KRbW1h+egk=;
        b=pICrzD3Rjt/32CtDBJkMYhC/gYY8F0krndjCz8wa/rSFm2zOx478yvAB/Fk4gSHr/P
         8pw2X1zoIMzpF95/ztNwswIIrx7hXoZuIHDaVDODwQwLf6KI4/AooEkW3ANdOJFcj/zQ
         yh1aUF8FFsOTqrtUji9pj8erVlDGvwo0gcBu9grx/sbZIkOelu9yK5siehsXg2xyjxgI
         tkuNGgtYQ62EmNMkb8DOzYtWB/apsGvMg1a8AfvozkVjKiha9+JCtY+eE1mtedbELz+V
         Fb3PzhS6IuZVo7joI7fxGDC5kUlxCCNRLI04H9AkXjYTAoW19RZ3/dLSI80V6Il3pIe9
         kVcg==
X-Gm-Message-State: AO0yUKXWgbUb35Bxg+Hfjl0pxOJFxlbprM+Jf8zJDJHqqxcoNzvt+OIx
        1vr+hYcjpyAovxme+bXyqm1ryA==
X-Google-Smtp-Source: AK7set97r0sJJK2bJ6W3a0FtgTs/Fzkh401/msvyM73m8aF8nhQfFc9JddSVPhQFrlEeMzmNxmDY/g==
X-Received: by 2002:a19:f00e:0:b0:4db:1b30:e634 with SMTP id p14-20020a19f00e000000b004db1b30e634mr2657388lfc.65.1678114576311;
        Mon, 06 Mar 2023 06:56:16 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id z20-20020a05651c023400b00295d385481fsm1746147ljn.13.2023.03.06.06.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:56:16 -0800 (PST)
Message-ID: <0b02eefd-816c-1ee1-27bd-a04a681d9b37@linaro.org>
Date:   Mon, 6 Mar 2023 15:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/9] arm64: dts: qcom: sa8775p-ride: enable the SPI
 node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230216125257.112300-1-brgl@bgdev.pl>
 <20230216125257.112300-7-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230216125257.112300-7-brgl@bgdev.pl>
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



On 16.02.2023 13:52, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the SPI interface exposed on the sa8775p-ride development board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 5fdce8279537..d01ca3a9ee37 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -14,6 +14,7 @@ / {
>  	aliases {
>  		serial0 = &uart10;
>  		i2c18 = &i2c18;
> +		spi16 = &spi16;
>  	};
>  
>  	chosen {
> @@ -40,12 +41,25 @@ &sleep_clk {
>  	clock-frequency = <32764>;
>  };
>  
> +&spi16 {
> +	pinctrl-0 = <&qup_spi16_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &tlmm {
>  	qup_uart10_default: qup-uart10-state {
>  		pins = "gpio46", "gpio47";
>  		function = "qup1_se3";
>  	};
>  
> +	qup_spi16_default: qup-spi16-state {
> +		pins = "gpio86", "gpio87", "gpio88", "gpio89";
> +		function = "qup2_se2";
> +		drive-strength = <6>;
> +		bias-disable;
> +	};
> +
>  	qup_i2c18_default: qup-i2c18-state {
>  		pins = "gpio95", "gpio96";
>  		function = "qup2_se4";
