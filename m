Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01D9611B56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJ1UCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiJ1UCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:02:07 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30D1DE3E7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:02:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 8so4173521qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdMQ1e2RSiY0iFjHTnOY+ZoLlVTTLqoC3Ptqc5DqK0I=;
        b=PcqZ7PtW5MlDoiLP2IwcD+4RGCbeVZgP8Ksej6kiYupCJ8j+Ee9znOOhCKCd+Xs5m9
         vHlrKzRJTBMnvo+aNvaGBudhEltguTzoc8Cjo2zBRrlX4Fa0sAuPbHHoHwbF1XXrhIpC
         uMDPzyHpUpDGsJ7C67l22jfaKS6nIdticRTNFiIZpA1AMRM9Ug3ZQ4oGLGV259rLUVBG
         6yZwkCzCDTG8IFGZc7HVfOgdCUNE6lGJnd62PKYU08DJA++91R1ZZ3F8cWlWjMRNGtPS
         5aexMW7upmnpRE6YqJRp5EAYSHk5+YM6N1LumIhWeFSIY8j4fasxqCM5RwRkqgSQMX/F
         lngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdMQ1e2RSiY0iFjHTnOY+ZoLlVTTLqoC3Ptqc5DqK0I=;
        b=RS5uD6/1gUAqTvCD9rEvGGeVJadIKg93S7UZST0T2G+y5mFeLcskiHBK82OJfDsAbY
         IOemDCmCfhONphQIVY8rv140R1gusLHEruNNvNQY+o61dGKX5l+mD7CwxHsKCLu+Btnc
         tiN3W9Cjtvi/jjms7y2+0AAiT2wYoLN6z31HNMiRJrRX4Ji84EDwS8/m1Kgbo50BHMP7
         jWjfu/QweuSs525foJ7AmQn+eScrFNSvzXsrY5yph8wsff9D/3bpZn6VvHhMr0rEM5sH
         6CJUotP5/ohBKPDKt2PeYzNgkzsA0IS/2nEkWkArKiU5bUn142CkttiU0T+ddQAyvWJo
         ohTw==
X-Gm-Message-State: ACrzQf1AQGtzktPE5z7LbMNBDpzDwpuF2rxEzs2or6HKN3mp733929Js
        tyfsYoM/5xR4VFbzbNBz3dg6GQ==
X-Google-Smtp-Source: AMsMyM5YpeL94Iw48e5O3aOG/3SA+rFA4qewOF0lq3w+vTmwLbFf7lZKx0HynAPmLDSOr4u3Ran9sA==
X-Received: by 2002:a37:2d02:0:b0:6f1:15cd:1493 with SMTP id t2-20020a372d02000000b006f115cd1493mr769971qkh.131.1666987320813;
        Fri, 28 Oct 2022 13:02:00 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id v6-20020a05622a014600b003999d25e772sm2839124qtw.71.2022.10.28.13.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 13:02:00 -0700 (PDT)
Message-ID: <e34b35f4-4197-3973-0947-14ee577494e9@linaro.org>
Date:   Fri, 28 Oct 2022 16:01:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 09/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6795
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
 <20221028153505.23741-10-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028153505.23741-10-y.oudjana@protonmail.com>
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

On 28/10/2022 11:35, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Combine MT6795 pin controller document into MT6779 one. In the
> process, amend the example with comments and additional pinctrl
> nodes from the MT6795 example, replace the current interrupts
> property description with the one from the MT6795 document since
> it makes more sense and define its items using conditionals
> as they now vary between variants. Also use conditionals to define
> valid values for the drive-strength property for each variant.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 189 ++++++++++-----
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 227 ------------------
>  2 files changed, 127 insertions(+), 289 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> index 70e4ffa2d897..6f2cffe50b11 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> @@ -8,6 +8,7 @@ title: Mediatek MT6779 Pin Controller
>  
>  maintainers:
>    - Andy Teng <andy.teng@mediatek.com>
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>    - Sean Wang <sean.wang@kernel.org>
>  
>  description:
> @@ -18,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt6779-pinctrl
> +      - mediatek,mt6795-pinctrl
>        - mediatek,mt6797-pinctrl
>  
>    reg:
> @@ -43,9 +45,7 @@ properties:
>    interrupt-controller: true
>  
>    interrupts:
> -    maxItems: 1

Leave the constraints.

Why? Because now you dropped it for mt6797... You bring here some random
changes and it is difficult to review it.

> -    description: |
> -      Specifies the summary IRQ.
> +    description: Interrupt outputs to the system interrupt controller (sysirq).
>  
>    "#interrupt-cells":
>      const: 2
> @@ -57,59 +57,6 @@ required:
>    - gpio-controller
>    - "#gpio-cells"
>  
> -allOf:
> -  - $ref: "pinctrl.yaml#"
> -  - if:
> -      properties:

Make the move of this hunk in your description cleanup patch. Don't mix
functional changes and some cleanups.

> -        compatible:
> -          contains:
> -            const: mediatek,mt6779-pinctrl
> -    then:
> -      properties:
> -        reg:
> -          minItems: 9
> -          maxItems: 9
> -
> -        reg-names:
> -          items:
> -            - const: gpio
> -            - const: iocfg_rm
> -            - const: iocfg_br
> -            - const: iocfg_lm
> -            - const: iocfg_lb
> -            - const: iocfg_rt
> -            - const: iocfg_lt
> -            - const: iocfg_tl
> -            - const: eint
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            const: mediatek,mt6797-pinctrl
> -    then:
> -      properties:
> -        reg:
> -          minItems: 5
> -          maxItems: 5
> -
> -        reg-names:
> -          items:
> -            - const: gpio
> -            - const: iocfgl
> -            - const: iocfgb
> -            - const: iocfgr
> -            - const: iocfgt
> -  - if:
> -      properties:
> -        reg-names:
> -          contains:
> -            const: eint
> -    then:
> -      required:
> -        - interrupts
> -        - interrupt-controller
> -        - "#interrupt-cells"
> -
>  patternProperties:
>    '-pins$':
>      type: object
> @@ -169,8 +116,7 @@ patternProperties:
>  
>            input-schmitt-disable: true
>  
> -          drive-strength:
> -            enum: [2, 4, 8, 12, 16]
> +          drive-strength: true
>  
>            slew-rate:
>              enum: [0, 1]
> @@ -202,6 +148,110 @@ patternProperties:
>  
>          additionalProperties: false
>  
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt6779-pinctrl
> +    then:
> +      properties:
> +        reg:
> +          minItems: 9
> +          maxItems: 9
> +
> +        reg-names:
> +          items:
> +            - const: gpio
> +            - const: iocfg_rm
> +            - const: iocfg_br
> +            - const: iocfg_lm
> +            - const: iocfg_lb
> +            - const: iocfg_rt
> +            - const: iocfg_lt
> +            - const: iocfg_tl
> +            - const: eint
> +
> +        interrupts:
> +          items:
> +            - description: EINT interrupt
> +
> +      patternProperties:
> +        '-pins$':
> +          patternProperties:
> +            '^pins':
> +              properties:
> +                drive-strength:
> +                  enum: [2, 4, 8, 12, 16]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt6795-pinctrl
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +
> +        reg-names:
> +          items:
> +            - const: base
> +            - const: eint
> +
> +        interrupts:
> +          items:
> +            - description: EINT interrupt
> +            - description: EINT event_b interrupt
> +
> +      patternProperties:
> +        '-pins$':
> +          patternProperties:
> +            '^pins':
> +              properties:
> +                drive-strength:
> +                  enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt6797-pinctrl
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +          maxItems: 5
> +
> +        reg-names:
> +          items:
> +            - const: gpio
> +            - const: iocfgl
> +            - const: iocfgb
> +            - const: iocfgr
> +            - const: iocfgt
> +
> +      patternProperties:
> +        '-pins$':
> +          patternProperties:
> +            '^pins':
> +              properties:
> +                drive-strength:
> +                  enum: [2, 4, 8, 12, 16]
> +
> +  - if:
> +      properties:
> +        reg-names:
> +          contains:
> +            const: eint
> +    then:
> +      required:
> +        - interrupts
> +        - interrupt-controller
> +        - "#interrupt-cells"
> +
>  additionalProperties: false
>  
>  examples:
> @@ -237,8 +287,9 @@ examples:
>              #interrupt-cells = <2>;
>              interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
>  
> -            mmc0_pins_default: mmc0-0 {
> -                cmd-dat-pins {

How this is related to the patch?

Organize the patches so they are easy for review.

Best regards,
Krzysztof

