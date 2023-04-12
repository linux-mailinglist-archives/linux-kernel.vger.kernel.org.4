Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1607C6DF568
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjDLMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjDLMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:35:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E347ABD;
        Wed, 12 Apr 2023 05:35:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j1so14736006wrb.0;
        Wed, 12 Apr 2023 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302920; x=1683894920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYHSgufQGPfsF5vAg0opMnss76My6NDOcEfiI+dOR3E=;
        b=Gdoo7jQaku69ktNF9SD+vwJOUXaz8W5CG7Iec1zVbexwiq0FwZblgy3P9YHsS+/YMR
         kfmWq9T6J5UD6nBDAbUk5kEsPiGt77owQYxonu+e4/WKERVILLYVpXKE2QCckV8J6Nt5
         eTmKA/Nvl6SM70odZp51QoDMPAmqMLBTffQhdENQWztVd5qXYxkI1XXu1vqLzLOC+f9d
         zwzyifpaIzunPEAIFP34jMT1M02huYUbZzo5rmO8yooQXCGQ7OFZUwtf509ajbqbtmIU
         6OHNDcqpu3ZMn9elbph56P1JeVoZL8NJaNaUJ6TMHfyRt7GIavnWBZIhrhz4JYiptJ/e
         GcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302920; x=1683894920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYHSgufQGPfsF5vAg0opMnss76My6NDOcEfiI+dOR3E=;
        b=MBhwCLZCivD7naHr+CrBj/7IIDd2F1+rK0BVXLemCBen4W6T16t7S3KWJYjQRPzGdL
         hEj+2wqn0lB8hdIwAttyEPJ+vKltVElMRCzlhth6N0jEvwGiJo045IfHchVbpFJjoTT8
         DztVhZFm2cFucwTzsMFggoCoHoGaEqpBSscKpa6EjpG9VssU0liYknvMfPWBXhSEYg3w
         dDcV/T/7+ly8plnthMhzy4oHbqRCvgVcZO5BCuT1cevBt3w9xZPEwVDgskmYKd3Fx0Ut
         eCKrwREiTTYbhdyv4RU8FVkbez/NuDMdspLGw/hbi7UOuGU0kUNs089wwuWSepQaXwDA
         cjOA==
X-Gm-Message-State: AAQBX9cMmTCISIQhlgTIyF4pgwEtMAx8xoifiexnKUCboYFKmhHBmg/8
        wRW3BdsrS/gMdzBDp9FI3KQ=
X-Google-Smtp-Source: AKy350YJDBIXDYs4pLFPPdXIwXv2xr+tmhcoVzQ/7lfEPyTz8FT7yOyyA6AmK41Lu0ewaS+izRE8PA==
X-Received: by 2002:adf:e0c1:0:b0:2ef:b4a9:202f with SMTP id m1-20020adfe0c1000000b002efb4a9202fmr11506835wri.69.1681302919583;
        Wed, 12 Apr 2023 05:35:19 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i3-20020adfdec3000000b002f24db41f50sm7013909wrn.69.2023.04.12.05.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:35:18 -0700 (PDT)
Message-ID: <0416a00e-b567-1ae4-c49c-ec21e024ab0f@gmail.com>
Date:   Wed, 12 Apr 2023 14:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/27] dt-bindings: display: mediatek: dpi: Add compatible
 for MediaTek MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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

Shouldn't we declare both const: ?
