Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A498A648E9D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLJM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLJM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:26:52 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC991AA3C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:26:50 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a19so7676154ljk.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0NUKyHj0pGtYwcMWK+k5oNIjBL0VY3COqPaURyA9DXE=;
        b=B+nF12mBvDvlHeCbpw1uY7+shYhfRxoXdG+VSAb7NEKjMOVFFm7032lQDPhtmYQhhD
         C/1BmvbW+k93v21WbOhkNblWJxd9P8QfLnZi044P8cEXxeEPsJlMJPfZW3oFPkGRHOCG
         5kwUNDmorycJs8Ipk3UjeBtgp9xvugrIY5dEoZgJkRO79Ucbajd1v7DTQLuRsjhYADEo
         oUkKlKj8sfVlo0PmiIQr0vbI84p9v1eAiriBM9Ut4dholeLBbjXqgCZ2hsZSyO/bjsTl
         dqWsEXHVOhVvn7tBBTfsjpzGeWntuZl8iCLMrTJZz3PHfb4q50DySvsmPaRt9jp6nV6W
         S1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NUKyHj0pGtYwcMWK+k5oNIjBL0VY3COqPaURyA9DXE=;
        b=QKVIC8GKZJzrmZ3N5jWsQLAYPN57g9c6CnDIRVmDs41ZdSlKuPTZoMn2D9F9qmc4tn
         i2z12uqmvYwiIMQgxX5hzf56t6zym0uuhe6bh0g50/Q32Luj1CiaA992w3KeBBWG0j1D
         TaiffjAMYp3Ecz1xtwojl9XK013ZY2B7i4AUWn1C8AgCDAbjfJ8L4fwujORYgxflxEC0
         /d3ZeIBTZ6+YShCVHImEnyLjBEWjUvOtO7A6yZyA7+5RLuvYWx2xOUrsTF0Z2hqGHVuJ
         bDaMKvZWQgveZlBQroMYhfbLsAOhJx6jv/Ll4DXhdlcf+P7skhsSB2g5751KzEB6jPcH
         pYlQ==
X-Gm-Message-State: ANoB5pm7dwFcevTowYVj5nkVr54kOERUtEG3oNH91RpjBAjxK1gnB9kL
        lOVzCJUd5ENeSqPwLHjMVffSfA==
X-Google-Smtp-Source: AA0mqf4FimTWnL2m/v0sPSiMWn1QzcsWJw+4fRNZfj3qstrvujdwJogfiOZMZUl1RVsjT5vBn72m8g==
X-Received: by 2002:a05:651c:1611:b0:26f:db35:1d65 with SMTP id f17-20020a05651c161100b0026fdb351d65mr2592225ljq.15.1670675208488;
        Sat, 10 Dec 2022 04:26:48 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id v17-20020a2ea451000000b0027708c94c9bsm589988ljn.79.2022.12.10.04.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:26:48 -0800 (PST)
Message-ID: <5d21408f-cc99-35f3-c4ce-b13f02c1c1f3@linaro.org>
Date:   Sat, 10 Dec 2022 13:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: drop 0x from unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210113340.63833-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221210113340.63833-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.2022 12:33, Krzysztof Kozlowski wrote:
> By coding style, unit address should not start with 0x.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
We somehow keep running into solving the same style issues :P

https://lore.kernel.org/lkml/20220930191049.123256-8-konrad.dybcio@somainline.org/

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1a257f672887..a63dbd12230f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1636,7 +1636,7 @@ uart7: serial@89c000 {
>  			};
>  		};
>  
> -		gpi_dma1: dma-controller@0xa00000 {
> +		gpi_dma1: dma-controller@a00000 {
>  			#dma-cells = <3>;
>  			compatible = "qcom,sdm845-gpi-dma";
>  			reg = <0 0x00a00000 0 0x60000>;
