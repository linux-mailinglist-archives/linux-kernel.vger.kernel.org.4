Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A86C8DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCYMDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjCYMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:03:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A2B45B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:03:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e11so4263266lji.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679745811;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+HvbnHAFO6mX+JqArCA+vYEYcRN5IjHek0RMpHLSYE=;
        b=pmlxprMkzSvX3zwFUp25X3fcETxfhi7YTQEyol6Hac9WwBrOuVVgMbQPKY7oO8O8Xx
         P957xQYV2akDnvN6w0yjR57x1D7EN140MWXRSC6p7QTbcwRiDMYJXz3ieqhZlq5+yPQj
         yUsTLd8A1ZcxtXuwT0Kj/L5WBy/wtdq/stJS5LlcYvngVY1MHjPkVlTB8i2aPxMovigi
         L7U9k3/VAPTi8jpMISrCTrADhcFYyWcGyXlKKBKD544/lBEU4ce5hZGWKAqoywHa+bnX
         cs+L6t0rnIMHiOKZEs+IjMNtOnQTmwHAmRGo/vvOF76rfjhr1ifwGUo0zSGVL0txunMl
         jq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679745811;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+HvbnHAFO6mX+JqArCA+vYEYcRN5IjHek0RMpHLSYE=;
        b=rawtOIw3Cmjjek/cOBAaD7mXHGX2s7VhONZV089cyhnvohJqnth3R4s8K+n2JLDts4
         qpCwmUuAGpKoS1OIWx83b4lZZraojv3SVqTiyj+Nf7VXNqcvRE3tLsDXNiwJ1kfA5ytu
         e9gUX0LMlQ7iyQOCxWsEeEnqCtI2YPbiw0yfdIeOOSkDbxE4dHURzcicPNUUbcnt9EKB
         RfCSfp8sdoRGtjbmJfZ2HSwY0DfoH+HC8gsWBzD3td5qow+WzaAZUfNvK7kdA3hFNO4D
         G+ugiTDz1io60mF//h/QNQK8QvVnYXwO5hDgwBfaisFUc/dhCNJYHdfRJhai7kcqZ/Ni
         DwZg==
X-Gm-Message-State: AAQBX9dyMX01U+WVdPup0LAbx4Bg75bLSoDh2IO9r6JwyUnYkoftKaoP
        kGf/hdRvqsBxAByLT4i3D+LaJg==
X-Google-Smtp-Source: AKy350ZGsgRIDOvaMDS3h3addre0DOEsaX5Ta6RVe2+xSwrnaX50tJynYFBELwXJsjD0h7OfZv9lUw==
X-Received: by 2002:a2e:9c04:0:b0:29e:e7b1:1202 with SMTP id s4-20020a2e9c04000000b0029ee7b11202mr1671306lji.43.1679745810922;
        Sat, 25 Mar 2023 05:03:30 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e904c000000b00299f0194108sm3786959ljg.31.2023.03.25.05.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:03:30 -0700 (PDT)
Message-ID: <adea74ab-5fdf-f073-a2c7-d39f5d3cd2bd@linaro.org>
Date:   Sat, 25 Mar 2023 13:03:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: msm8994-msft-lumia: drop simple-bus
 from clocks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
 <20230324202244.744271-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230324202244.744271-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.03.2023 21:22, Krzysztof Kozlowski wrote:
> 'clocks' node is not a bus, but just a placeholder for clocks:
> 
>   msm8992-msft-lumia-octagon-talkman.dtb: clocks: $nodename:0: 'clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
>     From schema: dtschema/schemas/simple-bus.yaml
>   msm8992-msft-lumia-octagon-talkman.dtb: clocks: xo-board: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], ...
>     From schema: dtschema/schemas/simple-bus.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
> index 0c112b7b57ea..2861bcdf87b7 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
> @@ -46,8 +46,6 @@ chosen {
>  	};
>  
>  	clocks {
> -		compatible = "simple-bus";
> -
>  		divclk4: divclk4 {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
