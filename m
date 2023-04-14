Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9F6E1E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDNI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjDNI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:27:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2E6AD29
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:27:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jg21so43378827ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681460832; x=1684052832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfV+vHgOiOTb/T8PGJETWUjU9ShSgfKqGb/lRZ9bS+Q=;
        b=TXtg+5vSMswTh++PcVMw4FZVIJqiJXwtBF4esfUNcovAdf/NpcKSjcUBpatbisjxWJ
         1m3+T5xQIJMtC6itqvIY24p8+E3w3ulSHduTDMIz6GS7nU6oZ44ajbOjyIS8bdz7mJpy
         qxNUKmIeFOHGKpcVhauyQ/Ct94cEDQNwloMkJQzoPNWXy8VK7wgirOKomhYBd05xfbsm
         6nFmgoLKnZN10M2aIP00kyw3jXrKfO5vThqEULTFKVKu367PJgNidsKBUcg0i9HVQsUm
         VlrXmuInv8FGw66mhBXkZPMxcFgx1eqLzoDO+PsZE4esAJ1vYNVK6veTbl+F6t7oVHkl
         k20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460832; x=1684052832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfV+vHgOiOTb/T8PGJETWUjU9ShSgfKqGb/lRZ9bS+Q=;
        b=Ke/tUsRo3UZ0DhZlpWvpq4LjIj3fxWI9fb+jybz2CovBcWj82kuXNdjE43LTPMrHxJ
         5BF2wwutvogMFfWoaQll76+fhiWfTHeXEB/07HSKAYu5SHnXekE8BkW8779HVp5sEi5E
         Z5DiTcmkJM+BTWWmNHTGXxz8I4gq4YLoJese+OS8pYqCelTo2vsHzqVtJUWNRCin1UvC
         7W4R9+KFLudfKNsc4PgAYPdzaXOtZiosnGJQ59ck6Jyo8L6uXfPUh75l4q2qQqSwXnIp
         J8yOAoZHNPsg4xx8gPzT+TAjWV0JB9Su87vPzhtJOrgApuVRAw4sBTDxArDsbRyRkUAr
         f0UQ==
X-Gm-Message-State: AAQBX9cIysXeRPlC7VVp4fOpX01Iu6M/I/5Aq+se31Qu8vR8aVro9WqP
        RHtYXmC0ZmhWaTbTOvM/P7HOfQ==
X-Google-Smtp-Source: AKy350bROMqGwlhCVGwl5H8OJ+bgHbDFNGXpnOwYOw4FLgadYWAX0xpuhZWD9cFLA3D4vEUtaQZhkg==
X-Received: by 2002:a17:907:10ca:b0:94a:5a9e:9da0 with SMTP id rv10-20020a17090710ca00b0094a5a9e9da0mr5236919ejb.77.1681460832272;
        Fri, 14 Apr 2023 01:27:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id ss23-20020a170907c01700b0094a611b21a8sm2072758ejc.223.2023.04.14.01.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:27:11 -0700 (PDT)
Message-ID: <ca69a9a0-5abb-e3b8-dbd7-0389da955bd1@linaro.org>
Date:   Fri, 14 Apr 2023 10:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 10/27] dt-bindings: display: mediatek: gamma: Add
 compatible for MediaTek MT6795
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
 <20230412112739.160376-11-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's GAMMA block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

