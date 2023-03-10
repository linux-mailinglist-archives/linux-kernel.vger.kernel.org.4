Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6389F6B38F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCJIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCJIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:40:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052DBC4899
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:38:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ay14so17303732edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDVe/ilGCM1upNn+sXA7kF6veY8qJPcVwvcThxhDa6I=;
        b=Pppuz/JUxawEDgmha2lSlsuKf9XEo5uJceQZxG8fZOdPlDwIRI++f8KUoyTdi1SIHS
         X4sXlMNXDbkeuKb3jIUN4o7S7NEkEG05vm7lD5PCJnPhjmgOzY89IEQtKS8dxyxk8J1p
         CfyhenjkMXgLzXcACM5LDZPpRa8/h28POLoty99ux4Xb0Q86qvvbHHOXRmxkf5MV+Kc6
         QdP7NdvX7H5WiLeysJM+Aj6g9JV9sy6/1kkXK3r7A6IdtKIkQar1kh768C/tV89f1G8l
         yzL1HXgEv/znoQ72yptz3rHrY2mOypVUIlhUmH9q0mw/tr9JSHfiV630dBNEKEq1uHas
         L5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDVe/ilGCM1upNn+sXA7kF6veY8qJPcVwvcThxhDa6I=;
        b=QWzwZ21JT6KTz/jnvP0Yi/BSSR7uDDL9UcRtXT+n4MBfUaBCL/JSZEYJmjddKVQDl1
         3Xssp5gboedS6Xa/cgeux78YukS0t14Gb5dZHyoOzeR/7FlecgmzGwMxjpEHesPSolOt
         JHgTQiUUUp2HsHTTW/RbawUIna3I81M3K1kfg0LAo6MC26wk3R0KdKi10EAoow2uYCKz
         Otz9uDE0SjJtF1T3T4rMeA8JnuaDk51fsszLAZeLNsHFw58T3rfqasuQ+8KqyO3hNyn0
         kjqP+A0Mv+xJVeyUJsflMmSDnHFSqnxr7uLP7MfIY3BFbHimq0KMI2PYknIME06F5Ixl
         d2gw==
X-Gm-Message-State: AO0yUKU6Eyr4R2Afoetl3QrXI4tNferYt+ImVUD4LeVyRlPmNc+rIpUh
        JpHEKzbeNhUwWgTDgMuA6eQ6wA==
X-Google-Smtp-Source: AK7set/A9FqHxSnqzhC3hpME6V/vzWuY7o2BpQIjGMxyMR4uXXCeSmQQGuphYw5/Z1RGHpprlaNx2Q==
X-Received: by 2002:a17:907:1b1e:b0:7c4:fa17:7203 with SMTP id mp30-20020a1709071b1e00b007c4fa177203mr31355684ejc.63.1678437491488;
        Fri, 10 Mar 2023 00:38:11 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906319600b008ee5356801dsm661622ejy.187.2023.03.10.00.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:38:11 -0800 (PST)
Message-ID: <f908e9f1-2cee-8f9f-5da1-f231febf107b@linaro.org>
Date:   Fri, 10 Mar 2023 09:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/21] dt-bindings: display: mediatek: dpi: add binding
 for MT8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-7-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-7-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 15:22, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> DPI for MT8365 is compatible with MT8192 but requires an additional
> clock. Modify the documentation to requires this clock only on MT8365 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml    | 48 ++++++++++++++++++----
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index 56511c4d4b9b..3f6cca81340c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -17,15 +17,20 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - mediatek,mt2701-dpi
> -      - mediatek,mt7623-dpi
> -      - mediatek,mt8173-dpi
> -      - mediatek,mt8183-dpi
> -      - mediatek,mt8186-dpi
> -      - mediatek,mt8188-dp-intf
> -      - mediatek,mt8192-dpi
> -      - mediatek,mt8195-dp-intf
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-dpi
> +          - mediatek,mt7623-dpi
> +          - mediatek,mt8173-dpi
> +          - mediatek,mt8183-dpi
> +          - mediatek,mt8186-dpi
> +          - mediatek,mt8188-dp-intf
> +          - mediatek,mt8192-dpi
> +          - mediatek,mt8195-dp-intf
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-dpi
> +          - const: mediatek,mt8192-dpi
>  
>    reg:
>      maxItems: 1
> @@ -34,16 +39,20 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 3
>      items:
>        - description: Pixel Clock
>        - description: Engine Clock
>        - description: DPI PLL
> +      - description: DPI Clock
>  
>    clock-names:
> +    minItems: 3
>      items:
>        - const: pixel
>        - const: engine
>        - const: pll
> +      - const: dpi
>  
>    pinctrl-0: true
>    pinctrl-1: true
> @@ -72,6 +81,27 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8365-dpi
> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4

We usually set minItems, so it is clear readable that you raise the
lower bracket. Code should be equivalent, but I would say this is less
readable (maxItems: 4 was actually implied by top-level list).



Best regards,
Krzysztof

