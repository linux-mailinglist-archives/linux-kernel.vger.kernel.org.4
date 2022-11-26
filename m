Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A05E63969C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiKZOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKZOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:44:49 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33670E017
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:44:48 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l8so8165634ljh.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3VFbb/urxLt4AAbODMiwaHIsutCiRetAeBhPsiZMY8=;
        b=lkK9tjAxY+rK64IySFXie0Pn7s+N3HzN3LSVyZNp1qk5LiWLHoS+D6aSmC4fzfLJMv
         e6aMj6VJLzj5YnZdIJNjGawiR1kQGYkGwtQqyaf29SnGNcLVZhEfi7GhnSI8Fxzt6FOw
         16QOCfwebHFOuOw9jkTkSQ1Lf5MkHB7Il+o8fGqyj9Mqtbn33TA3JsegGzs9Bsx5MQIi
         oyMKDPGqE1XbQkc5enMjVKMqDX5Kg1gZ8F52pETQQigqSIfB4fTQu2naTFqtV2eOTzJr
         yphXI7lfaf6Un7+dvfFj7P4cbWKKi9IQNscYMpo6dRLdtYp6XCeoc+NvLfiOfzfbA/1s
         FemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3VFbb/urxLt4AAbODMiwaHIsutCiRetAeBhPsiZMY8=;
        b=4/xrFQIgAHxCGzzFwzTFQQ4SOS0jUopJJLEQqX9DK77DK2cuWPARGUsxoLGy6SvQKH
         cr1stb7Xm/iTap+WDwUzpPiRlgcHBqJ+RUyhSxU0Ho4Wb8pXl2FS7mRztEUSUGfzJjUt
         4otqlrDblTEEAdQgK4koVg+glo7gvpprN8N6hY2Ls+8U7ZCB5Z0g2OgRyRCcrpUocvkX
         rcCa+3cIFK/ah+uVr+7Ag3UBymp7Ouyj6j67DAR5u98dRTKx2M2rT2DiHP8HQWmzL2Fd
         wI9s+SnpmYUA0erebe5kZ49w/DR/aozauLgC9NodxCUAizYNxc716X5j/K4gt10dIitt
         ooRA==
X-Gm-Message-State: ANoB5pnrDDbeSF+ubHSf/SIcBqjJJG81PPR9CUAbjKTcc3JhD0EEjP8v
        KHz4etxoMhKZgBrIO0IS7IRlog==
X-Google-Smtp-Source: AA0mqf51Yx6WqiwVxyoyJfkAFW7n7xuxrcH0IkvAg4nEpDeV4o2XHda6z9Todbe0a8B+WQn7pA7oRA==
X-Received: by 2002:a05:651c:12cb:b0:279:774e:dfe4 with SMTP id 11-20020a05651c12cb00b00279774edfe4mr5969907lje.303.1669473886576;
        Sat, 26 Nov 2022 06:44:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b23-20020ac247f7000000b004aa95889063sm953784lfp.43.2022.11.26.06.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 06:44:46 -0800 (PST)
Message-ID: <fb3f9ad7-7b6f-fe22-8787-5bfa1d7caf05@linaro.org>
Date:   Sat, 26 Nov 2022 15:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 05/18] dt-bindings: msm: dsi-controller-main: Document
 clocks on a per compatible basis
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
 <20221124004801.361232-6-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124004801.361232-6-bryan.odonoghue@linaro.org>
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

On 24/11/2022 01:47, Bryan O'Donoghue wrote:
> Each compatible has a different set of clocks which are associated with it.
> Add in the list of clocks for each compatible.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 154 ++++++++++++++++--
>  1 file changed, 143 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index c4da7179999d2..88aac7d33555c 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm Display DSI controller
>  maintainers:
>    - Krishna Manikandan <quic_mkrishn@quicinc.com>
>  
> -allOf:
> -  - $ref: "../dsi-controller.yaml#"
> -
>  properties:
>    compatible:
>      items:
> @@ -48,13 +45,8 @@ properties:
>        - description: Display AXI clock
>  
>    clock-names:
> -    items:
> -      - const: byte
> -      - const: byte_intf
> -      - const: pixel
> -      - const: core
> -      - const: iface
> -      - const: bus
> +    minItems: 6
> +    maxItems: 9
>  
>    phys:
>      maxItems: 1
> @@ -147,6 +139,146 @@ required:
>    - assigned-clock-parents
>    - ports
>  
> +allOf:
> +  - $ref: "../dsi-controller.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,apq8064-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 7
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: core_mmss
> +            - const: src
> +            - const: byte
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8916-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: mdp_core
> +            - const: iface
> +            - const: bus
> +            - const: byte
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8974-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: vsync

minItems are 6, so does it actually work?

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8996-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 7
> +        clock-names:
> +          items:
> +            - const: mdp_core
> +            - const: byte
> +            - const: iface
> +            - const: bus
> +            - const: core_mmss
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7180-dsi-ctrl
> +              - qcom,sc7280-dsi-ctrl
> +              - qcom,sm8250-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: byte
> +            - const: byte_intf
> +            - const: pixel
> +            - const: core
> +            - const: iface
> +            - const: bus
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm630-dsi-ctrl
> +              - qcom,sdm660-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 9
> +        clock-names:
> +          items:
> +            - const: mdp_core
> +            - const: byte
> +            - const: byte_intf
> +            - const: mnoc
> +            - const: iface
> +            - const: bus
> +            - const: core_mmss
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm845-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: byte
> +            - const: byte_intf
> +            - const: pixel
> +            - const: core
> +            - const: iface
> +            - const: bus
> +
>  additionalProperties: false
>  
>  examples:
> @@ -157,7 +289,7 @@ examples:
>       #include <dt-bindings/power/qcom-rpmpd.h>
>  
>       dsi@ae94000 {
> -           compatible = "qcom,mdss-dsi-ctrl";
> +           compatible = "qcom,sc7180-dsi-ctrl", "qcom,mdss-dsi-ctrl";

Not related to this patch.


Best regards,
Krzysztof

