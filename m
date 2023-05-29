Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D220E714B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjE2OH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjE2OHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:07:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A330A8;
        Mon, 29 May 2023 07:07:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f61530506aso34876985e9.1;
        Mon, 29 May 2023 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685369241; x=1687961241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuPny2OtXAzM2wWK6VJ+p5t+ABcpKnPrmiRDWrl/TM4=;
        b=S2L7ubx5W2cOkZ8pVxf0WL9LIoKztesZZ7B2oDF4cIv688EwisgTFdGiM051ckbdog
         IXapWwJUh2Sh6C7luDJmahU3Z1RFiNnb2Xcc5ff1MQi/cBNguGxh3qq9r2Bl7TGwBbE1
         bSK0Ywk6NRfXydQ4E8JfKxCbrJbbQTkPJbgXxCEC6adjw90zodzr7FC+1MguNY0Y2fQ+
         zR31DzhDv+0TkE1tTVvgqkRujPKG05bWuEgyAx+upRvmciOpX7BQvMA1kJnAfcSwE2q/
         7Bnlpgt016RARi6s5pTc1VXtFlvPg1WJ1f3QbiwkXDjMkEARdqGYdrv5Dqbly81nqaFT
         oyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685369241; x=1687961241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuPny2OtXAzM2wWK6VJ+p5t+ABcpKnPrmiRDWrl/TM4=;
        b=QiucotOh6qZe45DCaoE2f9cQKfg0clcRCmFmVzUxmEZ1/r3cwg8Tnhx2Lmw7x8t4eB
         2Z+D7hwuwOuSbJNIFY1U2UBTeqjtc2WnIinCl44FXx3wr0P+gquehq3lXsNb7I3ZvV1k
         z6/NYUe+8t8Z+hUjhRzHLM2QJweRvixuPgnFxF9dZy+WDOBWhi0BrpioiOV++bKnK0Ru
         DZ1i1fTlNkImC+tCh7JXVANygrqn4Z01yK/QuGQSkXcEO5wiTvY1yEtFeljA+AaL41YE
         3ZrmrHTYAzkcwOsnN+sJtWd7huWeqOYt/+wQo/DpQtGF80E843Cov1BFZ8DT7meodTh5
         t4fQ==
X-Gm-Message-State: AC+VfDwlK1iCIoCNnJaWUdmkS0xSMy2KPFCFLYUfc7cft/5Y/+X1dGwk
        fDBqZBO1IUoxHVQon19Oyac=
X-Google-Smtp-Source: ACHHUZ6zxu2kt7VKYzBTez/NpRcKvfFT/05iC4XI/22RhPD4iBaJlYpy/McywyI+4iaDMmBq5kffpQ==
X-Received: by 2002:a7b:cb9a:0:b0:3f1:72e2:5d13 with SMTP id m26-20020a7bcb9a000000b003f172e25d13mr9545158wmi.16.1685369241290;
        Mon, 29 May 2023 07:07:21 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003f4ecf1fcbcsm18247034wmf.22.2023.05.29.07.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:07:20 -0700 (PDT)
Message-ID: <02a588ca-680f-ab45-1005-768d5b5db252@gmail.com>
Date:   Mon, 29 May 2023 16:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 03/27] dt-bindings: display: mediatek: dpi: Add compatible
 for MediaTek MT6795
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-4-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang Hu,

Can you help to merge the missing DT-binding patches in this series?

Thanks a lot,
Matthias

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the MediaTek Helio X10 MT6795 SoC, using
> the same parameters as MT8183.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../display/mediatek/mediatek,dpi.yaml        | 23 +++++++++++--------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index d976380801e3..803c00f26206 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -17,15 +17,20 @@ description: |
>   
>   properties:
>     compatible:
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
> +              - mediatek,mt6795-dpi
> +          - const: mediatek,mt8183-dpi
>   
>     reg:
>       maxItems: 1
