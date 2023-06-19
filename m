Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F049735CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjFSRQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjFSRQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:16:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE725187
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:16:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f122ff663eso4803505e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194983; x=1689786983;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptDpY4WLfYIYqgrjiXJtUFRwJP5nap77mhX716vEea0=;
        b=YcVTLtmrKkB45p8pnUFr66EwdZPghMG0r//pAU7NAFcFvluzfGsAau/onFSqWNq7lA
         fYPTFGlw8T+AOzwdwJMJahtykaB6A4yqPU5U4p4vQtN0Z0Ojqb5APZP5Tnd/Ppc8CzNL
         biDQ1M7Cq0POmBkSHiU3XQEl7Yrw7HjSEqHrlCGhkRytcrtr9F4ZTOLT2gQwx2N7bOwE
         pVpbx3rSd3Ty2jlFUZ6KTBzWNHcvSuOmptKgkU9qHYj9MvRHsv18QjovdIh9XtOmxihV
         kjbYjtOsIUJQUeT+OMnDNwzDvPMWvn5xNINkHD/BBPtQ5v0kz2aAYcpwJ7rM2K4SsvIV
         4IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194983; x=1689786983;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptDpY4WLfYIYqgrjiXJtUFRwJP5nap77mhX716vEea0=;
        b=kQ9eTrJkGZsMQhLsh0dOAq8egYh/Tco98IbmoeRe50iWcprc07/T+EvGRJfCzzE8s8
         D7uSYiYcpqUA4RxpFcEAR0oUnvNQSvX14q95nzICaWNsTYQi9MbwlE/KVOC/MlD+c1RV
         3xfbhqAbnIoY3fQqwvFyZqerwFKYdGM3/zF/txLW+AnnSIFR/3OyfgZpQFV/Kykp5jJc
         nrGpscNKCeje/SyOosMU3z1naR60Z/pe1dUSjFHr9btTkAN6Rstet+YSEBTFgpljC+2F
         EeNq+hT+NS4S7gDJ+JJabrPToAQwOaasUayI5JbJ9DFXKpg9Ag5xLBRZccEoNc2lUwam
         1scQ==
X-Gm-Message-State: AC+VfDwcZJGn1iet6FZcPoomO6jqZfP48O4hXy39ZIearHhccx1fOAW2
        v4/2GoAppGR6FbF6TbdFm+SxVQ==
X-Google-Smtp-Source: ACHHUZ44QLzrmqVmb1gN42UnkXuQ42QaAnur2KC7nIC0Ti+Ju5rwTrOa2WoL3Fgz4H2vpftxjkX7gw==
X-Received: by 2002:a19:911b:0:b0:4f7:69a1:f60e with SMTP id t27-20020a19911b000000b004f769a1f60emr4962068lfd.13.1687194983094;
        Mon, 19 Jun 2023 10:16:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id j8-20020ac24548000000b004f764090bb9sm15627lfm.42.2023.06.19.10.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 10:16:22 -0700 (PDT)
Message-ID: <4658b5c2-3140-2071-391f-1f8af722aa53@linaro.org>
Date:   Mon, 19 Jun 2023 19:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8960: drop spi-max-frequency from
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
 <20230619170151.65505-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230619170151.65505-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2023 19:01, Krzysztof Kozlowski wrote:
> spi-max-frequency is a property of SPI device, not SPI controller.  Drop
> it from the controller nodes.  No functional impact expected, although
> qcom-msm8960-samsung-expressatt board does not have any child SPI
> devices thus the property disappears.  This fixes dtbs_check warnings
> like:
> 
>   qcom-msm8960-cdp.dtb: spi@16080000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index fa2013388d99..d13080fcbeea 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -364,7 +364,6 @@ gsbi1_spi: spi@16080000 {
>  				#size-cells = <0>;
>  				reg = <0x16080000 0x1000>;
>  				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> -				spi-max-frequency = <24000000>;
>  				cs-gpios = <&msmgpio 8 0>;
>  
>  				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
