Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C376DF64F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDLM7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:59:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7797
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:59:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so7743424wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681304366; x=1683896366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erBuPeVrzFlZV2m3GTCAkkOKGldewGoCCeiRWUfnelM=;
        b=F3QYxAcPMEMt/kGu/5NByv+dQTgXrV0wu04xUscbtGXnLbiLeFOS1KcmYiIJBCWHYW
         7oGqnSz3qQQfm6CBdfszFSm6BbyNqp4yyoHQrIYbFACnz6HblmyOWwRe0nwB4lKOZQwy
         ZNcW4VyrkPYzIE/V5G0yoBj+CM/K7MeTre4/QK9FfLVkLXnUxrldAv2p93KDUBDQGTow
         wADA+CIo+H3OZrgzIEdbuB70UnXPDpErMTq2+KNu9gDKflwBNcOw+bDrQCvyHO2P3y9D
         8mgBG+FsHdrPy2AdWof8uN9KSgtRKoG+7Hr0aTXvEiWax2WW1iLo9S2QVEKHCYz5XyuI
         0Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681304366; x=1683896366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erBuPeVrzFlZV2m3GTCAkkOKGldewGoCCeiRWUfnelM=;
        b=2Qg5yBH3RUJXA5zyVUZJM8ZlVDQXIPZrdOBw2xJb8h+mKvyF8itxjmKHZ7T8x6c6dd
         L3hTXv8q1K+GbtBj4GGUmobYlaN1XZaM0nXiFK+EpC7W7aM6393d5dABRMgwWlKGwDGu
         khdhnBB7t5/kJ5UsKEcKC4AJ6qeDbb/sMr54T1XHqQlCHUZdndqPnw+aFEfR365eiY0k
         5aNSk1G85lPVyYQbZ5yi0y7hmQgYPsUlp5yfmICveM/QIiztmVL1WHK9i1pM9PJ9HHIx
         1Qb+DjlY778yvNsoHpVKbYcnP8wn6m6vhnWmK+obE6kHf3jku1srrqAMlA2UNzPFk/Wo
         0qNg==
X-Gm-Message-State: AAQBX9cHs+d+2rpN26utGag3+awvyR/8qnMNIWiVREpN77jcgVeTLnvs
        QIqXUQR9anxcILRZfwV3/9stYw==
X-Google-Smtp-Source: AKy350bzixhPofoYl7nQAhHg2btqGdbmFdg6kAkDkZeSl6i/hQ1NZTJGFcOxcJQxrOqLzKHQWAZ7Vg==
X-Received: by 2002:a05:600c:3ba8:b0:3f0:5ed7:f859 with SMTP id n40-20020a05600c3ba800b003f05ed7f859mr2135365wms.7.1681304366135;
        Wed, 12 Apr 2023 05:59:26 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c0b5700b003eeb1d6a470sm2305203wmr.13.2023.04.12.05.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:59:25 -0700 (PDT)
Message-ID: <20684378-cf3e-0299-d390-287b7bafbda5@baylibre.com>
Date:   Wed, 12 Apr 2023 14:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
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
 <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
> the same DSI PHY as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index 26f2b887cfc1..a9f78344efdb 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -24,6 +24,10 @@ properties:
>             - enum:
>                 - mediatek,mt7623-mipi-tx
>             - const: mediatek,mt2701-mipi-tx
> +      - items:
> +          - enum:
> +              - mediatek,mt6795-mipi-tx
> +          - const: mediatek,mt8173-mipi-tx

AFAIK, it should be:
       - items:
           - const: mediatek,mt6795-mipi-tx
           - const: mediatek,mt8173-mipi-tx

Since it isn't respected above for mt7623, it may be tolerated.
Please, take this comment as a suggestion, isn't a NAK from me.

>         - items:
>             - enum:
>                 - mediatek,mt8365-mipi-tx

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

