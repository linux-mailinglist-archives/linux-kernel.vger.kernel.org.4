Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88526DF582
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjDLMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDLMhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:37:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BE83D8;
        Wed, 12 Apr 2023 05:37:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so14741813wrb.0;
        Wed, 12 Apr 2023 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303028; x=1683895028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QebsCGR48dQEN2uFXsUDxTq2kX2uFhujVCCTxx6X6sY=;
        b=MqljV6uGnNg0RpDoTvPQA1io/EHrpJzhs7XUBX2amgvCE5Mzgp0AJmVxhKaRDXenLJ
         WJ43jNPRyGo4GWUp6O7mhRMQfxFhfcDiYlJCPa0iyf8WNWWv2tEgky4QWGIwxGO4CBC8
         9GEalqJsu/HUaZew2t7MzNMvYL5oKgKBI2+a6QwvXGiWrKKedhxzil1CDMCSjdZxCXm+
         kWY6LayVxs7VmFTs5zTc6pNhAX3Q73bD0WEU55BNrpbvoAbhJC+Q37dC3HpfGO8zNmOf
         2hulNe2wp74teE0V74njHy1PitX9XXI0EQ1Dyq7+WnkPBXHWkoB3w3n0CGJlpkR5G+xS
         l+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303028; x=1683895028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QebsCGR48dQEN2uFXsUDxTq2kX2uFhujVCCTxx6X6sY=;
        b=udvZE/0Wx0HA7NX1PdsvEjblC29EF5vOVLNFlRfhvtVv5pryVfa7LLtGvqcmLsgIjB
         mp9FBcQjS8mQc2gCG6d/OHkm2kP1njldyW0olkudNtQhGjr5Nn0exVZTeJZijn1+ozaD
         z1PdwII4OMMr9qksGQCStyrVMfUVJmwYL75dfkdcH8gxxJDbaio46ZM/G5nDqFaY0O9K
         jXsyRhe/7DC80/a151JsMjQhBg8RvLkzDABchwN35pnggJO8e07muhrcab2jg0q6Osra
         QvX45Tt3IDqnO1rzFFwgQbrAEQx5F0c1SUzVPGf8lPqPvmXj6zeCuaIhMZ3X2bT8JEbn
         dw2Q==
X-Gm-Message-State: AAQBX9eSg4c+ZV0Sa/yGap7mIqZ5oegyY0V4OqEyp4QkrugVtEdcvOVQ
        Q1WFRdLOclcSKmelPhGVRP4=
X-Google-Smtp-Source: AKy350bWhA2Bil03ULejXNLxks5rc0fhv1cWCYAwy/T1bRJDjG13T7QQBhah4FiuPHT0Czkz7Wlp4A==
X-Received: by 2002:a5d:4a86:0:b0:2f4:adca:6f42 with SMTP id o6-20020a5d4a86000000b002f4adca6f42mr1182963wrq.21.1681303028356;
        Wed, 12 Apr 2023 05:37:08 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d4082000000b002f0e1181a20sm8625307wrp.34.2023.04.12.05.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:37:07 -0700 (PDT)
Message-ID: <801c8013-23f9-a031-5432-32dc2ee222cb@gmail.com>
Date:   Wed, 12 Apr 2023 14:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/27] dt-bindings: display: mediatek: color: Add
 compatible for MediaTek MT6795
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
 <20230412112739.160376-10-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-10-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795's COLOR block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/display/mediatek/mediatek,color.yaml     | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> index 62306c88f485..449b37c7560f 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> @@ -35,6 +35,7 @@ properties:
>             - const: mediatek,mt2701-disp-color
>         - items:
>             - enum:
> +              - mediatek,mt6795-disp-color
>                 - mediatek,mt8183-disp-color
>                 - mediatek,mt8186-disp-color
>                 - mediatek,mt8188-disp-color
