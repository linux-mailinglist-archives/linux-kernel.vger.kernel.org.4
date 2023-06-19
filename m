Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E71073583E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjFSNPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjFSNPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:15:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761F18C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:14:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b4619ef079so35270631fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180498; x=1689772498;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAKfLnG4L/FkIRCtZlL0hEXhowH/BrSCiSNuhsp0iFI=;
        b=JWXj27WC/ITLWeswOJjal+rtKh+b15ZWDA08A1kpuJHPONEPBZXgXaKsdfvIYeA9tK
         QIY9EuQBl/m5P/QAJUVrNHm7vSQi3W0TVSj9Q79QTRe45R5xQqGY6Nbjozvv9OMWQRqS
         lV2sb0LAbfOoTZMdX4OiubOv8eQR+1CUvh/rzIzuCmUoYemPz2+HcOgkfQvAWmGaAPS1
         jeVOTy0s1JTWszhtreuP8bCTvaHFrS6sFc0rKXq4uCHwPG2z03DKRvi0iGGnD3JZHdDi
         8mtXmn0ziV8CLLTZX4jf8Q0a/oS8AilMC6jRCtOKxwPiS+js3BMR7pqAUE8iFQrs30uy
         P7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180498; x=1689772498;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAKfLnG4L/FkIRCtZlL0hEXhowH/BrSCiSNuhsp0iFI=;
        b=l3cYjETDNcPLooqAWCM6HSrrnn8/mE3RdZ774acChh8cYllD1H4hHfpVQfATsd+kot
         hrdVpCPhWHFp85m1FEx7YyVfvxIUBytRzMrIjtb9X/H0yUMZ3QAiZxcUhel5MMFpElZH
         PPMQCFsHKIPwhoRkDJi1uEnnKDh3+Ozi9O7Ojh+0upXfYggWsjDXTDjmbNuLRij6z4tw
         sTXKxRqHx6Y7q4fEMmFBSR3fXaP2/jKebLLXeDd8VuarBwLCaPfWgJS+SBK3jf8TC7/g
         LeTFIBLhZX+9WOS3d1FgnawW+Xdy1lId68JBtEZRt22GKVKCq9y3NZL5fV5LVqmFRMjQ
         TlzA==
X-Gm-Message-State: AC+VfDyb8+xm8vSWM+lJuOBkkBz00nVjuqmwUhlU8Wppd4Oizq8k9T/m
        KFzP5fJg/I16k4Knv9SdeA9dAQ==
X-Google-Smtp-Source: ACHHUZ4Jswcy8MJAfNQljxKoT1H2yExNyhctHP8PdVXFLjfqiyAQYoYgqa2hNfDvWTOd5jaeSC2hoA==
X-Received: by 2002:a2e:7e0e:0:b0:2b4:5e6d:a9e9 with SMTP id z14-20020a2e7e0e000000b002b45e6da9e9mr3868313ljc.37.1687180497906;
        Mon, 19 Jun 2023 06:14:57 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id j6-20020a2eb706000000b002b34f9cfc7asm2681289ljo.90.2023.06.19.06.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:14:57 -0700 (PDT)
Message-ID: <4beedb80-f07c-d868-711a-a0e791d50fa7@linaro.org>
Date:   Mon, 19 Jun 2023 15:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/15] arm64: dts: qcom: sc8180x: align thermal node name
 with bindings
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
 <20230617171541.286957-11-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-11-krzysztof.kozlowski@linaro.org>
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

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> Bindings expect thermal node names to end with 'thermal':
> 
>   sc8180x-lenovo-flex-5g.dtb: thermal-zones: 'gpu-thermal-bottom', 'gpu-thermal-top' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index d3ae18535636..576180451491 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -3856,7 +3856,7 @@ cluster-crit {
>  			};
>  		};
>  
> -		gpu-thermal-top {
> +		gpu-top-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> @@ -4006,7 +4006,7 @@ trip-point0 {
>  			};
>  		};
>  
> -		gpu-thermal-bottom {
> +		gpu-bottom-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
