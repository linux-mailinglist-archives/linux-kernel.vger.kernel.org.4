Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8500A731225
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbjFOI2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbjFOI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:28:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00062135
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:28:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9788554a8c9so249439966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686817698; x=1689409698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btRiVH3HebqEvJU/ceqOGLLApwkh3MSRyqi6Oy1tTjg=;
        b=stKocO0YX+Zgeaq+WdnYnCHS7qmHwHuW6GtGZ8PwDWi6+4QUY7Md8ZSHHKlin3RFPC
         0RCyb3NucHMQc7Wb+add/fubhkSeuqEV+9No8l4P5Rxl8Ugj56I8cjhEnEHv29B1yM4p
         82PRMIZVUKaKeWDdvtZuYYuFfq/czdnj3I06B0+V2i394zaF1ZEcs4CSJFgeu16WQveF
         Vf3i+D/XCCCRE+/b/fBt+X7GdH2brhO80Ny3uK773pLUtmCCLWp/mO1GAaFX9x5Sgd2O
         oaduNSrcAV/bAO/CXwjYCqlwqLDoYwTC9NK7eVrFEwyynY9qupZIScJYI5ecTVstEW27
         52Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686817698; x=1689409698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btRiVH3HebqEvJU/ceqOGLLApwkh3MSRyqi6Oy1tTjg=;
        b=hOvbhia7L4gvccu+Fbkuuk/dhdQowaycjyElwr2UFqOombQMdLvcR8/ezYOLxJqc4G
         JUsyaFHw+QVb2v6HzKAcMjO2UNnOjUtLuOzDBPK2Cv9qK8b/hvTpclitTM0TafYj/lqI
         fLmx4djQxSFeK5mSZEqn3sc2GZrKIOI/hkNJgPkYU9VUjzF3m6DrNgNpTej3FvKytzAl
         hPaVnz4Mxv70MuNfxbpaqtcpl+gfBwEqlrMvvqqIx0wrj0jFzkpKmtoTgM2K5R1c6v0a
         TjOEBmLuUtr96xlyApWcn0doo5gI1FpTsZT4RbPoKP7npD1Xk8JiPedN+kpu41PMBxRU
         CiTQ==
X-Gm-Message-State: AC+VfDwcuaIOzglMOGUsljvAeLnzvafl0DxA/oc7mBjCjbkZTnPGdHCp
        XMx56RHAwB3DdiLQB3kk80xNCQ==
X-Google-Smtp-Source: ACHHUZ4EEL5QsRnHbC0CalmjqF6e/AkURCXs6uIPydVvSbl/YzUPPaYHlmpuxXeiS3STXVtQu7VQBA==
X-Received: by 2002:a17:907:748:b0:978:acec:36b1 with SMTP id xc8-20020a170907074800b00978acec36b1mr19685758ejb.17.1686817698328;
        Thu, 15 Jun 2023 01:28:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906169400b0096650f46004sm8982763ejd.56.2023.06.15.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:28:17 -0700 (PDT)
Message-ID: <25816ad5-339c-e52f-adbb-686aa7977e9e@linaro.org>
Date:   Thu, 15 Jun 2023 10:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-4-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614073125.17958-4-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 09:31, Hsiao Chien Sung wrote:
> Add compatible name for MediaTek MT8188 MERGE.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,merge.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> index eead5cb8636e..5c678695162e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> @@ -27,6 +27,9 @@ properties:
>        - items:
>            - const: mediatek,mt6795-disp-merge
>            - const: mediatek,mt8173-disp-merge
> +      - items:
> +          - const: mediatek,mt8188-disp-merge
> +          - const: mediatek,mt8195-disp-merge

Linux next has something entirely different. I don't know the base here,
but it's really, really different and it suggests you should add mt8188
to an enum with mt8173.

Best regards,
Krzysztof

