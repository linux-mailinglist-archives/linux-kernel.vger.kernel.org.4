Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF95621127
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiKHMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiKHMnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:43:39 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400A818B08
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:43:37 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h12so20891517ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7CgUpuOhO0bb1QuM22uaBQfdN8D1V8Stm51wZ3T8Gg=;
        b=LIsNsGwiOurmNx0OiaNbMbgKLGxxPZrE5Ef9wutqCgn7FlkzxjxESBTv3v5MOPksqR
         +bn6BF7a8oe/Z+zDgdYcAe4OYq7KpJBO3vw2hQS1Jg6YpZK1J2wu4sAoGAyJw6QiArTT
         87uHy2JAD/DMD0745o4HuGf024W0kcucak9yYExf7+v8aMEXIW5G1KZhI24FlN4lISC+
         f3dNPUor52xNTcG4+8WGROATKhFASFjr6G6F9q7MheigHNQ6HnovXw4Q1+3KB1OZEWjz
         cZsaxh/f/tZPNUavangu+lnQoyisMrN/paYt1HmbeyX5gM7EGH5GR0WuzCqGSQ75spx9
         0IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7CgUpuOhO0bb1QuM22uaBQfdN8D1V8Stm51wZ3T8Gg=;
        b=DUnEb3q671Bnd+8mb38RW1b/P7F2GsONI8/gBIJiaA70yPMGDXoqL7viBd2/H8CSXF
         3vaynilRmXoIpKj6B2CDsbhGwWrNG6ofnad9wAI3RJ1OAbDGv8yzQLjxzl4mVXfxk/dO
         fe2DReLFK+z64zUQetfaV/LVqbsb+XfpgYtimyjaGMVeIicmIyJGpGo5ogtwHTvbqTGK
         W4U09+ld5dITH4z9oi/kHUTAPFcBIu9fQoMUrUL48veQZC5u9U8N1XePMkYliHPDRNpX
         AglNFxUj3xxKNpgaKCZBMVpfIrgbkCvLE9dE8rhbLd42m8ISB5EQdW0DMd0t88fhC4tQ
         Dpqw==
X-Gm-Message-State: ACrzQf006IkXPiXhqoJceffO5axhCUT0AGKNkD5IQoPfpHt20on20XZR
        X9L9fOTCyPwL5duoyq5vB7dTtw==
X-Google-Smtp-Source: AMsMyM4plXmGbRfyztNmF+l3FkFcv6jZ3fAguBNi/YGBes4B3ZKtrI2nDy+X8O0NPJiI8DvlCweMoQ==
X-Received: by 2002:a2e:bcc5:0:b0:277:978:dae0 with SMTP id z5-20020a2ebcc5000000b002770978dae0mr7218782ljp.475.1667911415455;
        Tue, 08 Nov 2022 04:43:35 -0800 (PST)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512114400b004b0a1e77cb6sm1765227lfg.139.2022.11.08.04.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:43:35 -0800 (PST)
Message-ID: <d10bf67c-c21c-5096-d774-ff924bf1dd41@linaro.org>
Date:   Tue, 8 Nov 2022 15:43:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 08/18] dt-bindings: msm: dsi-controller-main: Document
 clocks on a per compatible basis
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-9-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221107235654.1769462-9-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08/11/2022 02:56, Bryan O'Donoghue wrote:
> Each compatible has a different set of clocks which are associated with it.
> Add in the list of clocks for each compatible.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../display/msm/dsi-controller-main.yaml      | 177 +++++++++++++++---
>   1 file changed, 150 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 9db3e63acda3d..c975df0ca22fc 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -9,24 +9,22 @@ title: Qualcomm Display DSI controller
>   maintainers:
>     - Krishna Manikandan <quic_mkrishn@quicinc.com>
>   
> -allOf:
> -  - $ref: "../dsi-controller.yaml#"
> -
>   properties:
>     compatible:
> -    enum:
> -      - qcom,dsi-ctrl-6g-qcm2290
> -      - qcom,mdss-dsi-ctrl
> -      - qcom,mdss-dsi-ctrl-apq8064
> -      - qcom,mdss-dsi-ctrl-msm8916
> -      - qcom,mdss-dsi-ctrl-msm8974
> -      - qcom,mdss-dsi-ctrl-msm8996
> -      - qcom,mdss-dsi-ctrl-sc7180
> -      - qcom,mdss-dsi-ctrl-sc7280
> -      - qcom,mdss-dsi-ctrl-sdm630
> -      - qcom,mdss-dsi-ctrl-sdm660
> -      - qcom,mdss-dsi-ctrl-sdm845
> -      - qcom,mdss-dsi-ctrl-sm8250
> +    items:
> +      - enum:
> +          - qcom,dsi-ctrl-6g-qcm2290
> +          - qcom,mdss-dsi-ctrl-apq8064
> +          - qcom,mdss-dsi-ctrl-msm8916
> +          - qcom,mdss-dsi-ctrl-msm8974
> +          - qcom,mdss-dsi-ctrl-msm8996
> +          - qcom,mdss-dsi-ctrl-sc7180
> +          - qcom,mdss-dsi-ctrl-sc7280
> +          - qcom,mdss-dsi-ctrl-sdm630
> +          - qcom,mdss-dsi-ctrl-sdm660
> +          - qcom,mdss-dsi-ctrl-sdm845
> +          - qcom,mdss-dsi-ctrl-sm8250
> +      - const: qcom,mdss-dsi-ctrl

I'd prefer to have this part squashed into the previous patch.

>   
>     reg:
>       maxItems: 1
> @@ -51,17 +49,8 @@ properties:
>       minItems: 6
>   
>     clock-names:
> -    items:
> -      - const: byte
> -      - const: byte_intf
> -      - const: pixel
> -      - const: core
> -      - const: iface
> -      - const: bus
> -      - const: core_mmss
> -      - const: mdp_core
> -      - const: mnoc
>       minItems: 6
> +    maxItems: 9
>   
>     phys:
>       maxItems: 1
> @@ -169,6 +158,140 @@ required:
>     - vddio-supply
>     - vdda-supply
>   
> +allOf:
> +  - $ref: "../dsi-controller.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mdss-dsi-ctrl-apq8064
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

Empty lines between clauses please.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mdss-dsi-ctrl-msm8916
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
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mdss-dsi-ctrl-msm8974
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: vsync
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mdss-dsi-ctrl-msm8996
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
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mdss-dsi-ctrl-sc7180
> +              - qcom,mdss-dsi-ctrl-sc7280
> +              - qcom,mdss-dsi-ctrl-sm8250
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
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mdss-dsi-ctrl-sdm630
> +              - qcom,mdss-dsi-ctrl-sdm660
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
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mdss-dsi-ctrl-sdm845
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
>   additionalProperties: false
>   
>   examples:
> @@ -179,7 +302,7 @@ examples:
>        #include <dt-bindings/power/qcom-rpmpd.h>
>   
>        dsi@ae94000 {
> -           compatible = "qcom,mdss-dsi-ctrl";
> +           compatible = "qcom,mdss-dsi-ctrl-sc7180", "qcom,mdss-dsi-ctrl";
>              reg = <0x0ae94000 0x400>;
>              reg-names = "dsi_ctrl";
>   

-- 
With best wishes
Dmitry

