Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B927237CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjFFGgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjFFGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:36:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCC12D;
        Mon,  5 Jun 2023 23:36:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so49418395e9.3;
        Mon, 05 Jun 2023 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686033366; x=1688625366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWZHLpwlZiyh0mbSg9UHrRROxQYp3ljP7tis5obXTpc=;
        b=I6uQYKAr4ZSDnsQ5/Tc2KorIc4lx/ptp3UP5pzJkKRNegwdUO9fao4Z8EvOQ4cukRp
         9ZIB5yjLuC43PvnRvt6PCiB+vnASb2VCAgTb5Bkpk34XJDn8xghPYDPLH6SYQjctRwvF
         7wc01KpZyH9UT8bzqjje08GtgR7I0EEo/+1kdcNuAAG/z2LNZHNuIdaXXuSDoGqgmYRc
         q5D/G8mwjBoHw+uKwakTnr0dr+XHzuEpTZlB2S0WVhipfxmtd8Ij7kAwPYyUTRmZnTkV
         2+9OXXdQzPFpWtcKCDXsWqv0HrHcCTXaPISw65V0+pnENpL53EPmHruQanvzpN0KYhYu
         QTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033366; x=1688625366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWZHLpwlZiyh0mbSg9UHrRROxQYp3ljP7tis5obXTpc=;
        b=iwIDqm+eaHnhpfBN/DaUYfiJa0+CKSVAEha2XyUvlSQDr/F4vhsFTx3VTADaS9r0Ei
         UPaJwKSgm6kC9PUqOUH8RWG/mb03Je0L63168LhghUkCXD0XBjnHvRmoF2T8TP/CJ/p4
         7Dfm5taQoKRxHL8buFxILHrZTvu9rQGatGzTejSuAaYxrIuxKtmT3DwfTui8vcTu+zHc
         xiBesZsOQXTVLhiBVauKWucACIzZCv1Ke5INCqWzRrh668AjQlT5TsDzis+ZL7vtiz1z
         5FpgMSI7a0SmpNQGrka39txP28RO3Cu3VYeXXYeJAXPBAcsWlWcnRciokVv6jsla4RhN
         Oi2w==
X-Gm-Message-State: AC+VfDzUmhR6JSk7wxROfsfJLDNFTh1/rHDF5yEwMlL+JedyyiYJaOMi
        YGy5walu+a2dlj5K5swamkg=
X-Google-Smtp-Source: ACHHUZ55SslIZxqqaCA3NchHhTQzQVFyP1VjU3PUlqivDduX4REkNysmvGxeH/m7wpDX3O04U76m3Q==
X-Received: by 2002:a7b:c858:0:b0:3f6:e59:c04c with SMTP id c24-20020a7bc858000000b003f60e59c04cmr1029053wml.24.1686033365945;
        Mon, 05 Jun 2023 23:36:05 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f60482024fsm12966148wmc.30.2023.06.05.23.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:36:04 -0700 (PDT)
Message-ID: <23b38a9b-8e7d-446a-ca97-f4f60c971bce@gmail.com>
Date:   Tue, 6 Jun 2023 08:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/6] media: dt-bindings: mediatek,vcodec: Allow single
 clock for mt8183
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
 <20230605162030.274395-2-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230605162030.274395-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2023 18:20, Nícolas F. R. A. Prado wrote:
> MT8173 and MT8183 have different clocks, and consequently clock-names.
> Relax the number of clocks and set clock-names based on compatible.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> ---
> 
>   .../media/mediatek,vcodec-decoder.yaml        | 29 +++++++++++++------
>   1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index fad59b486d5d..57d5ca776df0 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -27,18 +27,12 @@ properties:
>       maxItems: 1
>   
>     clocks:
> +    minItems: 1
>       maxItems: 8
>   
>     clock-names:
> -    items:
> -      - const: vcodecpll
> -      - const: univpll_d2
> -      - const: clk_cci400_sel
> -      - const: vdec_sel
> -      - const: vdecpll
> -      - const: vencpll
> -      - const: venc_lt_sel
> -      - const: vdec_bus_clk_src
> +    minItems: 1
> +    maxItems: 8
>   
>     assigned-clocks: true
>   
> @@ -88,6 +82,11 @@ allOf:
>         required:
>           - mediatek,scp
>   
> +      properties:
> +        clock-names:
> +          items:
> +            - const: vdec
> +
>     - if:
>         properties:
>           compatible:
> @@ -99,6 +98,18 @@ allOf:
>         required:
>           - mediatek,vpu
>   
> +      properties:
> +        clock-names:
> +          items:
> +            - const: vcodecpll
> +            - const: univpll_d2
> +            - const: clk_cci400_sel
> +            - const: vdec_sel
> +            - const: vdecpll
> +            - const: vencpll
> +            - const: venc_lt_sel
> +            - const: vdec_bus_clk_src
> +
>   additionalProperties: false
>   
>   examples:
