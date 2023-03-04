Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57B66AA9A6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCDM5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCDM5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:57:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194B1F911
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:57:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j11so6900553lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677934638;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPOGNGSxpOef32KPTSDLqHKntHHLrommHkmw5uSDC/E=;
        b=k7tvPZ687F128O/rQJ4psXWcIFMe8NHLj3KdsFr+bI/mghUihG2LLUqcfp6JCnTQQT
         vxP3DSggtaucYyIsL1S9AQzVoxMpLAWWRpVSmpFQdC7AuLALdYeMyTG+V75VQkJ3J5Gq
         pT0+xNji5kfZHt1hQW54tlh/JlOjUFC1pFrNycBSukoVrtkGbkr+nDEaVwBHkovtw2Bz
         QSMEQxcqwqk5sMpceFQVEThjhC8ZhXv/dJLEsTezguZWEQMkSvqeFb2Yy+PpnQToNzsQ
         f4ffMxgz11qF8aoOFAx6zMgkV8YjRT8JM5tQwXkReZBlMw6nGiyteuKmS63VEYtu+e4E
         J4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677934638;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPOGNGSxpOef32KPTSDLqHKntHHLrommHkmw5uSDC/E=;
        b=vZ1jg2qKMH5qY8XHHFWkG7XQGpUAYy7gWg2BuqxpttAq3cYyeu/Au0P6U5eXdBQBqH
         AvysJxbYb4u6rcGZzUh7iWsgYtpFwhmSyAeKcYPDyk0Htkh4/hN9wM6U/0TX5zkqGtOl
         /p5SnNuhhTNVz/fI4WlPjqqpWYsFD6y6pIvcq9Uv+6RNI5YuKA+htovdoi0PPfIaKRNA
         UA6QtXKNiUZrxBETAf8By4ir1tK+FqDebE4IqKcf2gNt+YTT/f0eQK9kfRvIt8Kk5AZC
         rS5DSDN/BjEAVnBl4Leb65+sFNzdJaC1wH2DzBIkjcUBAxCMC4jQ89vLPdsxQIcpRSSb
         4qrg==
X-Gm-Message-State: AO0yUKVYD9bmkbERU2XRQRXF3IyLf8j60zucY0yVQ7FoVY1oioxPXFfP
        td4A0cftf1uHskz2RK0m9xahHA==
X-Google-Smtp-Source: AK7set+4g0DYlqNzzn80AXk3mqjncOuKBfkRtvxXYv9ZFP4AzTBbeGE/Kn255t0kcxoIO+h+JTaQ2Q==
X-Received: by 2002:ac2:5210:0:b0:4dd:aefe:c647 with SMTP id a16-20020ac25210000000b004ddaefec647mr1558460lfl.22.1677934638322;
        Sat, 04 Mar 2023 04:57:18 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id q10-20020a19a40a000000b004d58e782886sm822031lfc.303.2023.03.04.04.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 04:57:18 -0800 (PST)
Message-ID: <8184ca39-6cdf-8ac2-aafb-0ab4741da8dc@linaro.org>
Date:   Sat, 4 Mar 2023 13:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/8] arm64: dts: qcom: sc7280-idp: correct GPIO keys
 wakeup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
 <20230304123358.34274-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230304123358.34274-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.03.2023 13:33, Krzysztof Kozlowski wrote:
> gpio-keys,wakeup is a deprecated property:
> 
>   sc7280-idp.dtb: gpio-keys: key-volume-up: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index cff0e0d31c15..b4b9d5e5cbd6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -70,7 +70,7 @@ key-volume-up {
>  			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <1>;
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			debounce-interval = <15>;
>  			linux,can-disable;
>  		};
