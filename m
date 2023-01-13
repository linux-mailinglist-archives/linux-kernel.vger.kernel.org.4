Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728DC66915A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjAMIlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbjAMIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:41:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07826E430
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:40:52 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk9so50667469ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1kAdR9rbZYNZXDKJv3ISJYLqHwPDHk2VkOZ3geBEyA=;
        b=IyzI+KqVwuPIvysUj+B5SbnwTT63oHItMo4rUftc2DjjCbZPivdNWYWuha40eoTll9
         yGBBcEeuY/h5i1k7YAMDNlurpHbp5Ne/kDfmmjCoTUJzVX0d8/FgREivFrGiPjiAhy+a
         ksVf7qU5Q2+5A/JZEjT/srZuCtGCJAewJCzSkOCmHcWhK3ajvi/L2+E/tPH129oRZd3d
         ufuZ4f8gyYVJolCN/i754L1KyR9x7bB+2+I8VsE5ZovuFyM73MscPZ85nu330rj/xGSH
         /KtR+ZRyqkTfZGH0vMcSqkIX8wL+FIL8B0jDMdiDGzc9C9mEdn4c3VcAqOZhOK2H/sIK
         7/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1kAdR9rbZYNZXDKJv3ISJYLqHwPDHk2VkOZ3geBEyA=;
        b=iC2ZWxiDjcMfLLOrzFVVWZSSPG26FU5NGIKvRk5hLt705qoBofp0jKqkAyG1vgj5Hz
         9aEOOTDlNM60+P63ut8TCgkmX6kDqyGiw1PCZOjvVVuGXbLLcZ1thQbBx9iBvIhcbzeW
         0t+p71qLbIzPFYIWGZtzjQoB6sMhDm306X3MV64XPKC3wX0PCM7bGKVEIJxmMgLqD/jb
         ZFLS/DxKxYloiiAvvU3IFtxhrIOhjXb/3rIY0wheQ1Qja32hVEY+ukvG5woC737llytE
         BX+KQI10MFfVPhbJJL+bVjkMWo1w81CgISoaIna1fq8JYs/u/Rrq06/R7vN2carZeql5
         T4CA==
X-Gm-Message-State: AFqh2kpJfT92OBDsWAGFWgVepcZ4V4O7ynqVrGXKULvrhDQTYVXe8gFP
        d/ORKpC15euifH4cR5TlnryQmQ==
X-Google-Smtp-Source: AMrXdXsxFF1ElWv2D/C3zAI3Fn+eRM5/QDh+mR3xzsWJdREWOX7Zq5GkJ/I9W5FIyGJdmZruw9SP+g==
X-Received: by 2002:a17:907:d302:b0:84d:34b0:e955 with SMTP id vg2-20020a170907d30200b0084d34b0e955mr19252302ejc.69.1673599251440;
        Fri, 13 Jan 2023 00:40:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b007e0e2e35205sm8363900eje.143.2023.01.13.00.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:40:51 -0800 (PST)
Message-ID: <fc2deca7-36c6-bdf6-27ec-21ec6020b170@linaro.org>
Date:   Fri, 13 Jan 2023 09:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add
 MSM8226
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
 <20230112202612.791455-2-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112202612.791455-2-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 21:26, Matti Lehtimäki wrote:
> Adds support for platforms with only single power domain.

Add
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> Adds support for external power block headswitch (BHS) registers

Add.
Full stop.

> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  .../remoteproc/qcom,msm8916-mss-pil.yaml      | 41 +++++++++++++++++--
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
> index 6e6e69ad9cd7..6a921f2711b2 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,msm8226-mss-pil
>            - qcom,msm8909-mss-pil
>            - qcom,msm8916-mss-pil
>            - qcom,msm8953-mss-pil
> @@ -70,16 +71,17 @@ properties:
>      items:
>        - description: CX proxy power domain (control handed over after startup)
>        - description: MX proxy power domain (control handed over after startup)
> +                     (not valid for qcom,msm8226-mss-pil)
>        - description: MSS proxy power domain (control handed over after startup)
>                       (only valid for qcom,msm8953-mss-pil)
> -    minItems: 2
> +    minItems: 1
>  
>    power-domain-names:
>      items:
>        - const: cx
> -      - const: mx
> +      - const: mx # not valid for qcom,msm8226-mss-pil
>        - const: mss # only valid for qcom,msm8953-mss-pil
> -    minItems: 2
> +    minItems: 1
>  
>    pll-supply:
>      description: PLL proxy supply (control handed over after startup)
> @@ -106,6 +108,15 @@ properties:
>      items:
>        - const: stop
>  
> +  qcom,ext-bhs-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: External power block headswitch (BHS) register
> +                 (only valid for qcom,msm8226-mss-pil)
> +    items:
> +      - items:
> +          - description: phandle to external BHS syscon region
> +          - description: offset to the external BHS register
> +
>    qcom,halt-regs:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description:
> @@ -205,13 +216,35 @@ allOf:

in this block:
qcom,ext-bhs-reg: false

>        required:
>          - power-domains
>          - power-domain-names
> -    else:
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8909-mss-pil
> +              - qcom,msm8916-mss-pil
> +              - qcom,msm8974-mss-pil
> +    then:
>        properties:
>          power-domains:
>            maxItems: 2
>          power-domain-names:
>            maxItems: 2

         qcom,ext-bhs-reg: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8226-mss-pil
> +    then:
> +      properties:
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names:
> +          maxItems: 1
> +      required:
> +        - qcom,ext-bhs-reg
> +
>    - if:
>        properties:
>          compatible:

Best regards,
Krzysztof

