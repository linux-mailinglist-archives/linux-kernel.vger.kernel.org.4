Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45B6D9F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbjDFSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbjDFSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:12:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ADF35B1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:11:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9188b85a615so158194366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680804717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dlTAcrGsySRcdvFlIEAdlxMvmki5beeXo1X6M8HUAI=;
        b=ybTaZYswIsB9kSiA+qHwOr2M6THedSXWNg2r1upNnTvDoVNgMlDyMeGCLzsO7NNSm6
         5Cbh4D6zo1IKDuSlTU6JS1uORX1e/PB/3o9+C1v+264VOB9eSh0muVWSbw3FFTFW12g2
         GZ6m29idMJqugoOdxtHeMseWxZcqPEDx/gCsq3Hy6qDZws8+fKQiDtnVlaAWkR78AJ5K
         Fh40ASSh5pyV3a/j+tbiH4ETWy2LV5j1/aCT2KIsh0LNizCC91bSpHSzkC9vHqXxMK4G
         oAXf0HXPO+mLSw7AfzTrVxjSTaSbS/mmQwCEvVTeUYdWSbehQHq5eveV+QS9HaeIDDRd
         jsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dlTAcrGsySRcdvFlIEAdlxMvmki5beeXo1X6M8HUAI=;
        b=vBx8TTE6OIrp8LKe5noVa2Y5jnYwnoeg0TfW0XpMo0GW1Sxg8MHapJGoSp3Tsz0cCN
         CHhu/gtJ/jWVvwZFFAS6LAFctgKhpJD9ZlvI8hGR1uq1UfoSDqQX+QiYBwa5Jze2BYFw
         8XFMlVlOrQFgqv9CMFGu0jCBXCWQ/uvNw0xZ2xNCaLkDSNYLHF9Tz4y4xce5D8U6lDro
         ZbpZ10eYlPhEban7qOHQOuU/rmzOPwmD2Gbhpzbqvu1CHX7SYdKZhn1eezBc8/YXTEHf
         dxDRQkroq8Bq/VLMwQmLsQuQbrn/6wrmXXE9k3PTe9HAxhUx4Wrb+NYuQhkOtqqWL62G
         rmig==
X-Gm-Message-State: AAQBX9eg60W016mpghVxj6rABdBNCn7tmA4nsz15WDek8mRFxNZeuUav
        oq1jW4AlygpqA6kKArBE8uSHYA==
X-Google-Smtp-Source: AKy350YLeBw/Rt+uWm89BvbtIXmourGOXrTNPTJjVC12cxrxUYgvhnCNlbiIHz0DWz4hq8Sh7Nrwfw==
X-Received: by 2002:a05:6402:59:b0:502:61d8:233b with SMTP id f25-20020a056402005900b0050261d8233bmr484101edu.19.1680804717562;
        Thu, 06 Apr 2023 11:11:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id x102-20020a50baef000000b004af73333d6esm1024556ede.53.2023.04.06.11.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:11:57 -0700 (PDT)
Message-ID: <284f1538-dfe3-8d54-d20f-b47365283e74@linaro.org>
Date:   Thu, 6 Apr 2023 20:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] dt-bindings: arm: amlogic: add C3 bindings
Content-Language: en-US
To:     Kelvin Zhang <kelvin.zhang@amlogic.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230406081627.4083103-1-kelvin.zhang@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406081627.4083103-1-kelvin.zhang@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 10:16, Kelvin Zhang wrote:
> Document the new C3 SoC/board device tree bindings.
> 
> C3 is an advanced edge AI processor designed for smart IP camera
> applications, which does not belong to Meson series.
> 
> Therefore, modify the title field accordingly.
> 
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 274ee0890312..ade730f35519 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/arm/amlogic.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Amlogic MesonX
> +title: Amlogic SoC based Platforms
>  
>  maintainers:
>    - Kevin Hilman <khilman@baylibre.com>
> @@ -211,6 +211,13 @@ properties:
>                - amlogic,aq222
>            - const: amlogic,s4
>  
> +      - description: Boards with the Amlogic C3 C302X/C308L SoC
> +        items:
> +          - enum:
> +              - amlogic,aw409
> +              - amlogic,aw419
> +          - const: amlogic,c3

Try to keep some order, e.g. between a and s.

Best regards,
Krzysztof

