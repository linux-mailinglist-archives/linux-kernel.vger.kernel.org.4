Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDAF723CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjFFJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjFFJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:16:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA8E78
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:16:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9768fd99c0cso741512966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686042975; x=1688634975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBYlIdpTft+IILWfU8QKB41NOLs5b4pNVwgWdOe7tqc=;
        b=vncFQqDlNQD4M5UowqZ7dH5lQ9V03vmSMwGeG54OCxGVIfCL8ROEWg+2m0+709wKLt
         5WzqpiXlaMYIFX/QL93ikhZg08bbq3bKsm0NaUBQr61w4+MqTKBj1BADt+v3PC+X+V9Q
         xidNvJRdtIIHT4eEOg9pPWnD2/hX23fZfSiWghBEClSAa5KX31VnDo6U0IkFnMg8/mMQ
         gDfyxMq/BUJuV6WrO3voT7uDVUpFYdqFlyDJvPgrcpxnTJU495rJsoi789X0U822pN21
         eba/ZjepKoQ2alj2V0QLqWdFEaDnZXHcX0fAPoDcmaaZOY/WK71/A6B1QgqmA/OJsD7w
         EDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042975; x=1688634975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBYlIdpTft+IILWfU8QKB41NOLs5b4pNVwgWdOe7tqc=;
        b=AE7dXFxsjf3I679IsOKqQGJdVEloOlQJ9HOZotrgiqnS/iGYsyLm3vz/6dJp7JExTe
         vO6VhIu/8B8RXmzNC1KGC5t5zy2d545sAegOU/kth62HkXO6APRWM41c6I7+Ieh+UdG9
         h3Ldw6x5+JCV53pjOD2MZro2bRgZhaJzC4Mjsrn2g3B/fR4Nb/wVXTXVEkHp++J3cIZR
         xnuzH97d+m80ZoRIJjbM+VrcSsUlA3gDH+Juk58FXpjDimEoxLI9EqlblaNasaEroz1X
         6VxazM6gAPNcgnNKyOL5Py+rqAcrqn8tsDW4wuPpL+juzTmq0hWJxZPMNx6842S9MgkX
         6wgQ==
X-Gm-Message-State: AC+VfDzixzyBwA7y4cQkv9wASQuIzGbGf48pixZxbikQ7duGlycp579w
        KfVqzIkD3TZQol7es3c1k8kzpg==
X-Google-Smtp-Source: ACHHUZ4PZb7TYXvL7RYHNqfdcJ+lt6xZPJBxKI73CgRYcLmtnpjkmNEq8NjmkFFBYXv2bKypsJ0oAw==
X-Received: by 2002:a17:907:9405:b0:973:93c3:16a1 with SMTP id dk5-20020a170907940500b0097393c316a1mr7380863ejc.19.1686042975479;
        Tue, 06 Jun 2023 02:16:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906700700b00965d4b2bd4csm5415416ejj.141.2023.06.06.02.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:16:15 -0700 (PDT)
Message-ID: <6d476d6d-7100-7674-2e08-661516b75f43@linaro.org>
Date:   Tue, 6 Jun 2023 11:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/6] media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS
 for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230605162030.274395-1-nfraprado@collabora.com>
 <20230605162030.274395-4-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605162030.274395-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 18:20, Nícolas F. R. A. Prado wrote:
> The binding expects the first register space to be VDEC_SYS. But on
> mt8183, which uses the stateless decoders, this space is used only for
> controlling clocks and resets, which are better described as separate
> clock-controller and reset-controller nodes.
> 
> In fact, in mt8173's devicetree there are already such separate
> clock-controller nodes, which cause duplicate addresses between the
> vdecsys node and the vcodec node. But for this SoC, since the stateful
> decoder code makes other uses of the VDEC_SYS register space, it's not
> straightforward to remove it.
> 
> In order to avoid the same address conflict to happen on mt8183,
> since the only current use of the VDEC_SYS register space in
> the driver is to read the status of a clock that indicates the hardware
> is active, remove the VDEC_SYS register space from the binding and
> describe an extra clock that will be used to directly check the hardware
> status.
> 
> Also add reg-names to be able to tell that this new register schema is
> used, so the driver can keep backward compatibility.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  .../media/mediatek,vcodec-decoder.yaml        | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index 6447e6c86f29..36a53b2484d6 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -21,17 +21,21 @@ properties:
>        - mediatek,mt8183-vcodec-dec
>  
>    reg:
> +    minItems: 11
>      maxItems: 12
>  
> +  reg-names:
> +    minItems: 11

maxItems

> +
>    interrupts:
>      maxItems: 1
>  
>    clocks:
> -    minItems: 1
> +    minItems: 2

It does not make any sense. Just two patches ago you made it 1! Don't
add incorrect values which are immediately changed in the same patchset.

>      maxItems: 8
>  
>    clock-names:
> -    minItems: 1
> +    minItems: 2
>      maxItems: 8
>  
>    assigned-clocks: true
> @@ -84,6 +88,24 @@ allOf:
>          clock-names:
>            items:
>              - const: vdec
> +            - const: active
> +
> +        reg:
> +          maxItems: 11
> +
> +        reg-names:
> +          items:
> +            - const: misc
> +            - const: ld
> +            - const: top
> +            - const: cm
> +            - const: ad
> +            - const: av
> +            - const: pp
> +            - const: hwd
> +            - const: hwq
> +            - const: hwb
> +            - const: hwg
>  
>    - if:
>        properties:
> @@ -108,6 +130,9 @@ allOf:
>              - const: venc_lt_sel
>              - const: vdec_bus_clk_src
>  
> +        reg:
> +          minItems: 12

so max can be 1000?



Best regards,
Krzysztof

