Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE74A608E82
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJVQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJVQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:28:38 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A81B5773
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:28:36 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n130so6589572oia.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3ny+yXpYDqLgCl1b12wzlahRflhVPiMY2auk8rtU9A=;
        b=JdjPExc59m1e2oyhgLWsKrEbhHJUNp3rx52BD3ksxMWuy2Y1q7cAjERfKDTFb7ojf+
         uaCYqxoqvwfrVXiIBjI84aWy6Sb40M8dHHH/+mUOK8VZE7S82aY5TuBFED5NMOFMDTCh
         bO046RFT+6uIrWK3ZwYENkB1OFrPnT3ybrPqGL0CoPW6cNZO4JjLRqCZXaDGQVv6ywQA
         tuhKYVpWFXvMEreOiG7/EueX1PZ5hgMNMuYNJXKn4KSSIMqZB9nFHLoR/WWDyAujYcFQ
         vKjHyg73LewI90SjFaL3MMwYb3wx4oCLsjiCZ/mbF5pSl6tE60R/SWOLJHpnjw1Mj10w
         hiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3ny+yXpYDqLgCl1b12wzlahRflhVPiMY2auk8rtU9A=;
        b=s5nAU0cwYcDOn0Bt0XQ+GMc6xV744dRIBtgHsaiebyrbFkNKjoSsS10axeKAN70y5f
         TBBxvBjcGK7NK3yZTdzaQSkv/0erI/rfQSU7Yro0ZZPkgSL3eKdHlNCV8Mgljzu4vvTl
         6eEMxYpH3SOHPYEhqsWCEG2+OQEZVZQeoRWqu20UkyVs7F6a3gKDK/0uMc1RudX61JWw
         fD2IPNmHpDxn5qwRr68U5KJdeJXrhCHGwi1oGm66ItvkJJ0W+TMVO1zNrasd3Z4flhXG
         21iohGB0SuIVBQoSRgqju6oDTJwgXWu1tIE1JA1X8gQ3wQIM++D1VPiJkX2UzFNM1+5j
         kvHg==
X-Gm-Message-State: ACrzQf3LxDJMea5eMJ1Js5u4WHy2Ibr+lhm92zZORdFyTji8VQny+vwE
        mKqFJlAImllKF7x8yOkkTKE0sA==
X-Google-Smtp-Source: AMsMyM634zWdX9U8U9UebN4uP0I0NHWWXs08sHj/vn8eEv9h2ANg8MGdNdngwgd9cwKtD9sU/cL1zg==
X-Received: by 2002:aca:c143:0:b0:355:4f9a:78a0 with SMTP id r64-20020acac143000000b003554f9a78a0mr11757740oif.245.1666456115751;
        Sat, 22 Oct 2022 09:28:35 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id d8-20020a056870960800b00127fbb7afffsm11282161oaq.5.2022.10.22.09.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:28:35 -0700 (PDT)
Message-ID: <1a1ab959-8c0b-90f8-347f-9809fe4b23d7@linaro.org>
Date:   Sat, 22 Oct 2022 12:28:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/5] dt-bindings: mmc: mtk-sd: Set clocks based on
 compatible
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20221022090530.16265-1-linux@fw-web.de>
 <20221022090530.16265-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022090530.16265-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2022 05:05, Frank Wunderlich wrote:
> From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> The binding was describing a single clock list for all platforms, but
> that's not really suitable: mt2712 requires an extra 'bus_clk' on some
> of its controllers, while mt8192 requires four different extra clocks.
> The rest of the platforms can share the same 3 clocks, with the third
> being optional as it's not present on all platforms.

It was also wrong...

> 
> Move the clock definitions inside if blocks that match on the
> compatibles. In practice this gets rid of dtbs_check warnings on mt8192,
> since the 'bus_clk' clock from mt2712 is no longer expected on this
> platform.
> 
> Fixes: 59a23395d8aa ("dt-bindings: mmc: Add support for MT8192 SoC")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 111 +++++++++++++-----
>  1 file changed, 81 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 3cbf0208f1b4..c7bcf0c3dd5d 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -10,9 +10,6 @@ maintainers:
>    - Chaotian Jing <chaotian.jing@mediatek.com>
>    - Wenbin Mei <wenbin.mei@mediatek.com>
>  
> -allOf:
> -  - $ref: mmc-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -49,27 +46,11 @@ properties:
>      description:
>        Should contain phandle for the clock feeding the MMC controller.
>      minItems: 2
> -    items:
> -      - description: source clock (required).
> -      - description: HCLK which used for host (required).
> -      - description: independent source clock gate (required for MT2712).
> -      - description: bus clock used for internal register access (required for MT2712 MSDC0/3).
> -      - description: msdc subsys clock gate (required for MT8192).
> -      - description: peripheral bus clock gate (required for MT8192).
> -      - description: AXI bus clock gate (required for MT8192).
> -      - description: AHB bus clock gate (required for MT8192).
> +    maxItems: 7

Confusing to see 8 clocks replaced by 7, but I guess this is problem of
old bindings.
>  
>    clock-names:
>      minItems: 2
> -    items:
> -      - const: source
> -      - const: hclk
> -      - const: source_cg
> -      - const: bus_clk
> -      - const: sys_cg
> -      - const: pclk_cg
> -      - const: axi_cg
> -      - const: ahb_cg
> +    maxItems: 7
>  
>    interrupts:
>      description:
> @@ -191,15 +172,85 @@ required:
>    - vmmc-supply
>    - vqmmc-supply
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: mediatek,mt8183-mmc
> -then:
> -  properties:
> -    reg:
> -      minItems: 2
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8183-mmc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2

Blank line

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8192-mmc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +            - description: msdc subsys clock gate
> +            - description: peripheral bus clock gate
> +            - description: AXI bus clock gate
> +            - description: AHB bus clock gate
> +        clock-names:
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: source_cg
> +            - const: sys_cg
> +            - const: pclk_cg
> +            - const: axi_cg
> +            - const: ahb_cg

Blank line

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt2712-mmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +            - description: bus clock used for internal register access (required for MSDC0/3).
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: source_cg
> +            - const: bus_clk

Blank line

> +  - if:
> +      not:

Can you not use negation, but list applicable compatibles? It would be
easier to read, I think

> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - mediatek,mt2712-mmc
> +                - mediatek,mt8192-mmc
Best regards,
Krzysztof

