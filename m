Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B526E28AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDNQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDNQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:47:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5842D4A;
        Fri, 14 Apr 2023 09:47:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w24so8561428wra.10;
        Fri, 14 Apr 2023 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681490844; x=1684082844;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJKYiVcyPTMIO212Xaa81Dv2egDEM+1isH5+sbiFNtw=;
        b=WVEOqQQgBVSmwOoYClrlw78Y2D0CKqfwYC58Vx03s6zqrMtjJ8vOnoRAkyShPd42vV
         J/RcSXBJ/JesbpFdG/nGaoGSQxJhWwkk5LrPXfuQvL3cK7jivHUNDv6/FLuQNVqObfrQ
         rdEuxZfROGJbRZ1u1COPBsPdxm00rC3odL8n1wJ4XkuVP0PbY5i+Yz3OHGL1BIbcUbPA
         lvxIZLBA+/HLuxvqJjn0t8Tp2HE3fXnuzPbsdXJIxYBMR7vSLFWTeYwd5OuKO5TXS2mX
         KmX/sovsOckWxQYlz0ue4PbiWpBGJaDZ3IHJF7Fp7Fg3akfsSq2WbDekVWW558hEYN+t
         I2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490844; x=1684082844;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJKYiVcyPTMIO212Xaa81Dv2egDEM+1isH5+sbiFNtw=;
        b=E49Y5et2C9oOrIeG+0x5j4ZylOWCAcFefgGigRbaFkDLU5ztYsh60uULU9XsLmDm0d
         QPpARW4M94PO//lvHT02rHCGiQ7cP1I7AQs5ywgG25iI4i2dv8mfouZFNUPxjr5VxTd6
         WJ6IP7+6qLT6TahJ7aUHBf7xfQRjxR93iaOZEKta1EMr0LIIhTn0vNIaxjxr0IO+iCjK
         vhkmRlxtkXdRU0WNTrc6hxhkUhRRfIEie2MvmS4dsZ2t0yE2D7QbAqJk66EzGjL0QA/T
         2bkQIaYbcvmDbJlhlg+GfeNRqNOUsSfeBeb7fHCGSS3V3rTwVMrXdjwaPSzG4LqkbbK9
         B2/g==
X-Gm-Message-State: AAQBX9eKsaWlhkNTlZE0CY4NPT3MaMPb86L8yK2jr95lT/4znw7mswyk
        dX0Mq2nimBKVEBr5D/EP7PM=
X-Google-Smtp-Source: AKy350ayARE0wsSfVwRFheCOXyRFXtIHmD5clP7slQBUE/kO+LVmaQ3YmrA9ke7sVqJ0Pn9mmIAfew==
X-Received: by 2002:a5d:4592:0:b0:2ce:aa73:4960 with SMTP id p18-20020a5d4592000000b002ceaa734960mr4596931wrq.5.1681490843935;
        Fri, 14 Apr 2023 09:47:23 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e1-20020adfe381000000b002efbb93c461sm3902302wrm.25.2023.04.14.09.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:47:22 -0700 (PDT)
Message-ID: <f8ab9e20-2590-9095-4f18-c332a43a33f2@gmail.com>
Date:   Fri, 14 Apr 2023 18:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: display: mediatek: simplify compatibles
 syntax
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230414083311.12197-1-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230414083311.12197-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 10:33, Krzysztof Kozlowski wrote:
> Lists (items) with one item should be just enum because it is shorter,
> simpler and does not confuse, if one wants to add new entry with a
> fallback.  Convert all of them to enums.  OTOH, leave unused "oneOf"
> entries in anticipation of further growth of the entire binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> ---
> 
> Cc: angelogioacchino.delregno@collabora.com
> ---
>   .../bindings/display/mediatek/mediatek,ccorr.yaml   |  7 +++----
>   .../bindings/display/mediatek/mediatek,color.yaml   | 10 ++++------
>   .../bindings/display/mediatek/mediatek,dither.yaml  |  4 ++--
>   .../bindings/display/mediatek/mediatek,dsc.yaml     |  4 ++--
>   .../bindings/display/mediatek/mediatek,gamma.yaml   |  7 +++----
>   .../bindings/display/mediatek/mediatek,merge.yaml   |  7 +++----
>   .../bindings/display/mediatek/mediatek,od.yaml      |  7 +++----
>   .../bindings/display/mediatek/mediatek,ovl-2l.yaml  |  7 +++----
>   .../bindings/display/mediatek/mediatek,ovl.yaml     | 13 +++++--------
>   .../display/mediatek/mediatek,postmask.yaml         |  4 ++--
>   .../bindings/display/mediatek/mediatek,rdma.yaml    | 13 +++++--------
>   .../bindings/display/mediatek/mediatek,split.yaml   |  4 ++--
>   .../bindings/display/mediatek/mediatek,ufoe.yaml    |  4 ++--
>   .../bindings/display/mediatek/mediatek,wdma.yaml    |  4 ++--
>   14 files changed, 41 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index b04820c95b22..dc22bd522523 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -21,10 +21,9 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8183-disp-ccorr
> -      - items:
> -          - const: mediatek,mt8192-disp-ccorr
> +      - enum:
> +          - mediatek,mt8183-disp-ccorr
> +          - mediatek,mt8192-disp-ccorr
>         - items:
>             - enum:
>                 - mediatek,mt8188-disp-ccorr
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> index 62306c88f485..d0ea77fc4b06 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> @@ -22,12 +22,10 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt2701-disp-color
> -      - items:
> -          - const: mediatek,mt8167-disp-color
> -      - items:
> -          - const: mediatek,mt8173-disp-color
> +      - enum:
> +          - mediatek,mt2701-disp-color
> +          - mediatek,mt8167-disp-color
> +          - mediatek,mt8173-disp-color
>         - items:
>             - enum:
>                 - mediatek,mt7623-disp-color
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> index 5c7445c174e5..1588b3f7cec7 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> @@ -22,8 +22,8 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8183-disp-dither
> +      - enum:
> +          - mediatek,mt8183-disp-dither
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-dither
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
> index 49248864514b..2cbdd9ee449d 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
> @@ -20,8 +20,8 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8195-disp-dsc
> +      - enum:
> +          - mediatek,mt8195-disp-dsc
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> index a5c6a91fac71..6c2be9d6840b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> @@ -21,10 +21,9 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8173-disp-gamma
> -      - items:
> -          - const: mediatek,mt8183-disp-gamma
> +      - enum:
> +          - mediatek,mt8173-disp-gamma
> +          - mediatek,mt8183-disp-gamma
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-gamma
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> index 69ba75777dac..2f8e2f4dc3b8 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> @@ -21,10 +21,9 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8173-disp-merge
> -      - items:
> -          - const: mediatek,mt8195-disp-merge
> +      - enum:
> +          - mediatek,mt8173-disp-merge
> +          - mediatek,mt8195-disp-merge
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
> index 853fcb9db2be..29f9fa8f8219 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
> @@ -21,10 +21,9 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt2712-disp-od
> -      - items:
> -          - const: mediatek,mt8173-disp-od
> +      - enum:
> +          - mediatek,mt2712-disp-od
> +          - mediatek,mt8173-disp-od
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> index 4e94f4e947ad..c7dd0ef02dcf 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> @@ -21,10 +21,9 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8183-disp-ovl-2l
> -      - items:
> -          - const: mediatek,mt8192-disp-ovl-2l
> +      - enum:
> +          - mediatek,mt8183-disp-ovl-2l
> +          - mediatek,mt8192-disp-ovl-2l
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-ovl-2l
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> index 065e526f950e..92e320d54ba2 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> @@ -21,14 +21,11 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt2701-disp-ovl
> -      - items:
> -          - const: mediatek,mt8173-disp-ovl
> -      - items:
> -          - const: mediatek,mt8183-disp-ovl
> -      - items:
> -          - const: mediatek,mt8192-disp-ovl
> +      - enum:
> +          - mediatek,mt2701-disp-ovl
> +          - mediatek,mt8173-disp-ovl
> +          - mediatek,mt8183-disp-ovl
> +          - mediatek,mt8192-disp-ovl
>         - items:
>             - enum:
>                 - mediatek,mt7623-disp-ovl
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> index 27de64495401..11fe32e50a59 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> @@ -21,8 +21,8 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8192-disp-postmask
> +      - enum:
> +          - mediatek,mt8192-disp-postmask
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-postmask
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> index 3ade2ece3fed..42059efad45d 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> @@ -23,14 +23,11 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt2701-disp-rdma
> -      - items:
> -          - const: mediatek,mt8173-disp-rdma
> -      - items:
> -          - const: mediatek,mt8183-disp-rdma
> -      - items:
> -          - const: mediatek,mt8195-disp-rdma
> +      - enum:
> +          - mediatek,mt2701-disp-rdma
> +          - mediatek,mt8173-disp-rdma
> +          - mediatek,mt8183-disp-rdma
> +          - mediatek,mt8195-disp-rdma
>         - items:
>             - enum:
>                 - mediatek,mt8188-disp-rdma
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> index 35ace1f322e8..21a4e96ecd93 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> @@ -21,8 +21,8 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8173-disp-split
> +      - enum:
> +          - mediatek,mt8173-disp-split
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
> index b8bb135fe96b..62fad23a26f5 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
> @@ -22,8 +22,8 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8173-disp-ufoe
> +      - enum:
> +          - mediatek,mt8173-disp-ufoe
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> index 7d7cc1ab526b..991183165d29 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> @@ -21,8 +21,8 @@ description: |
>   properties:
>     compatible:
>       oneOf:
> -      - items:
> -          - const: mediatek,mt8173-disp-wdma
> +      - enum:
> +          - mediatek,mt8173-disp-wdma
>   
>     reg:
>       maxItems: 1
