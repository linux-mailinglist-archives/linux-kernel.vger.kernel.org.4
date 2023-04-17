Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB64C6E4114
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDQHch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDQHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:32:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E459DC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:31:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c3so2124961ljf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716677; x=1684308677;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQL9KZY7FW2Qg45tBkM7dKXdpeg8tHxW2q8lij1q41c=;
        b=Bm78Kgh8C173ihnNSQOi9dpKN2xDuPU6PsRBd2usuMQof9ncak3h0wJIjppIQTKO+Y
         eZWs8n8teNUh672FmlawPg+5d/FopqpxzZv8QuifHZkozmJ3Z8qd7Z3UGf/pqxYPQZLZ
         6DB5ZI2rsIbBvXOZCKEsD+JrQaA7XpIGPLQ3sDEFAL0L8sxUcXeJgW0HN3wpNN+FMvGi
         Oqpbx4AcUbaMVdUnOQw/FCXYwm9Z3Ll3HRYYD9E23+NdIWEZOMx6En+bbkv8QSp1pB6h
         PluXaAEce8npv03m7elDzswmr6VDNOMEkx5D1g0XrKtrWXt5kSi80qRkenbuVtkyUa06
         mWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716677; x=1684308677;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQL9KZY7FW2Qg45tBkM7dKXdpeg8tHxW2q8lij1q41c=;
        b=BH9xMnsZtra1ck682DLmmCQNClykbXvohRyBZRAacTtubEzq/S9KtuJJYuzvcBLPeV
         IHcfzHwboN2C2VvtWSQ6B6PRYtBqCbtUexnvrPdIroHrQ4YUWCHACsyKxbMo8Nfg+LM4
         CXy/LIZMJrwImqiB4Jg4fg7R2pTVa7sCr7yTfbum99qBXXWXrOCVOXWIz7Y8dhtuCagG
         R2el0HkkYC/shsK3W6QBXDFdZv6JrOhjxPHSPltaW3huYauwgoFRB3eHSf1k9Jnks267
         zuRo7kBSK47lxiQdNvKcL4vZPD3ZQdW3b+JwoyO8b4cD/MhN26rUtqCfSbmu1XMr1uQA
         fjBg==
X-Gm-Message-State: AAQBX9fxv6O8ApBViiK0OGIBHuBWrJSVCbqbeh3imtm8Xlk0xJiSFUhC
        K+HoWlkOjVKINIS9t1i/lqjGGg==
X-Google-Smtp-Source: AKy350bbwl++ToVpbCwpNTBuz2rvYRz8CM9GTNp/a92rGhFBMuSYhJNAAy2BqvRmZcPR5vR/fzU27Q==
X-Received: by 2002:a2e:8892:0:b0:2a8:bf74:61cc with SMTP id k18-20020a2e8892000000b002a8bf7461ccmr945460lji.26.1681716677270;
        Mon, 17 Apr 2023 00:31:17 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id 15-20020a05651c008f00b002a8a8f2dc89sm1762700ljq.72.2023.04.17.00.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:31:16 -0700 (PDT)
Message-ID: <a0e2156f-4a0b-82ed-f3a2-f928c21f1619@linaro.org>
Date:   Mon, 17 Apr 2023 09:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm6125-sprout: align ADC channel
 node names with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
 <20230416123730.300863-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416123730.300863-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 14:37, Krzysztof Kozlowski wrote:
> Bindings expect ADC channel node names to follow specific pattern:
> 
>   sm6125-xiaomi-laurel-sprout.dtb: adc@3100: 'adc-chan@4d', 'adc-chan@4e', 'adc-chan@52', 'adc-chan@54' do not match any of the regexes: ...
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> index b1038eb8cebc..a7f4aeae9c1a 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> @@ -138,7 +138,7 @@ &pm6125_adc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm>;
>  
> -	adc-chan@4d {
> +	channel@4d {
>  		reg = <ADC5_AMUX_THM1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> @@ -146,7 +146,7 @@ adc-chan@4d {
>  		label = "rf_pa0_therm";
>  	};
>  
> -	adc-chan@4e {
> +	channel@4e {
>  		reg = <ADC5_AMUX_THM2_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> @@ -154,7 +154,7 @@ adc-chan@4e {
>  		label = "quiet_therm";
>  	};
>  
> -	adc-chan@52 {
> +	channel@52 {
>  		reg = <ADC5_GPIO1_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
> @@ -162,7 +162,7 @@ adc-chan@52 {
>  		label = "camera_flash_therm";
>  	};
>  
> -	adc-chan@54 {
> +	channel@54 {
>  		reg = <ADC5_GPIO3_100K_PU>;
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
