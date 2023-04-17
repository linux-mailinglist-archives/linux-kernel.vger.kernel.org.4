Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE06E40FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjDQHaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjDQH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:29:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F354239
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c3so2121229ljf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716591; x=1684308591;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6295nZRF4St2CJlI19rzVCO+MZ09C/LgaZ34xDbyNs=;
        b=oicSPWby1EtGTCoq+gV57CbGzztfQb7PML9OtMGsQAhddOO33HYOgFxOTls5BkRUAr
         jM0Izrn80NjnBJwkfx1A3HnO9UTWJv2JCBFaBUaCUxcX5iC1qVgQ4/LPYcD+R7sEbGtO
         hPdsHWf3wfPUScAEKB77nqoDfcc+an6GWxtz8wmeNbK7RPTaT+7SmtPDxst7rSI6WwrT
         q9ec4g2cnN8Eoy6FD/COCkZi1bVYASt4wQFWv7TQoNOlq5iIgVux5WPkwHEFhvCn3Asu
         O3o+J0iRMK9o54OxvD6aK51lucFf6ZBorxMMY6y29Ye6wV8x455D3eMKMoNuMbGZ0cUW
         EIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716591; x=1684308591;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6295nZRF4St2CJlI19rzVCO+MZ09C/LgaZ34xDbyNs=;
        b=K1ZjR0k6QQKYbC8NJfwXOdBVmUZtty/8xp+3yqNI4wqqvmBSjvUD51wg2Q6FmUi0T2
         +ic7RMZ2agxlRzIaT3+xEL95xWXYQJNmaZNJINqaxAY4EiY+J9vUqYbe5DSvkh8tXibK
         R56o5Vl/66Xf9LPAYMlQXnG6l+afrXk4Kl2m25tqITOoWhfIlBl1rIUM4CtNazVwm7GD
         BvRemjyIgy/3ZETxMegdsg0YpcFm2yvQbHYJI1X5HwNakZk0IonSd0Ovlxgt/vA5l3Nd
         wkZxAV7/ZGI9Ap5s2RCSurh3d8BAf1dnTZZkEmuMv+wBQFV/bAqmdnC2iwDtnCWIrIxD
         G/kQ==
X-Gm-Message-State: AAQBX9dE+mZKnLnwL060sarpOO7+if9bJp7O+2LoiZlOw2R7GNWX7/M+
        nP7jgHweNNpTJPxSe7iKL+RLdA==
X-Google-Smtp-Source: AKy350Zq+UCKuycVVA9oEFCZ/P1ByiL2Ly0lxS3Y7qafjn/VGlHRHIB/BD3Eyi/PbszK/WjVOI6ObQ==
X-Received: by 2002:a2e:9685:0:b0:2a7:7162:ae14 with SMTP id q5-20020a2e9685000000b002a77162ae14mr3618325lji.21.1681716590994;
        Mon, 17 Apr 2023 00:29:50 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id j13-20020a2eb70d000000b00295bbe17b46sm2114409ljo.132.2023.04.17.00.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:29:50 -0700 (PDT)
Message-ID: <3c7ae8f5-da22-c8be-7a18-6554f64d3bce@linaro.org>
Date:   Mon, 17 Apr 2023 09:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/6] arm64: dts: qcom: ipq8074: drop incorrect SPI bus
 spi-max-frequency
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
 <20230416123730.300863-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416123730.300863-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 14:37, Krzysztof Kozlowski wrote:
> The spi-max-frequency property belongs to SPI devices, not SPI
> controller:
> 
>   ipq8074-hk01.dtb: spi@78b5000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 5b2c1986c8f4..3b801c4d7eb3 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -476,7 +476,6 @@ blsp1_spi1: spi@78b5000 {
>  			#size-cells = <0>;
>  			reg = <0x078b5000 0x600>;
>  			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> -			spi-max-frequency = <50000000>;
>  			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
>  				<&gcc GCC_BLSP1_AHB_CLK>;
>  			clock-names = "core", "iface";
