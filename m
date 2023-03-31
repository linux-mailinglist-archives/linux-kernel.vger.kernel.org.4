Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C804C6D22CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjCaOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjCaOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:42:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A71D875;
        Fri, 31 Mar 2023 07:42:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v1so22671524wrv.1;
        Fri, 31 Mar 2023 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680273772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQSQpbyEP141etG6ZHWQCiEBFDe9rB+aPA05dS71AiE=;
        b=cbBpJS1pp2VUe5eBBEWBtRWugdEsiSuZ1H1qoGepOP42kpx6N3zGIJHgbeL6Rec+eI
         s9pTLH9Ici9vksjbXT60EgfezzKaGrWspX+Dwq7+kCxYhp3cr+0WAKQZOR6aXbp7Bhz2
         08ENky6Z4m6kPYkUsD61RTA6JvPhuEtDkt1yL3ZCFfUisFGgUR594C8S5kD5AFRw7hfT
         7x1Z9wEqfBsYqHaanJwr0EHsSriJn+pKviGmh5lnyop2MFqokHOfWEj3l4IQywKa9j5t
         9JfJmH82bFFTyv+KK62K/QYrbTnfi2lLh8aW6VWZyeB7GwMprJ/xQfzyJF6KHzBDYoR6
         db2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680273772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQSQpbyEP141etG6ZHWQCiEBFDe9rB+aPA05dS71AiE=;
        b=SwH4/tZQk/HQjapqyOXGKgo9R/cuVqzf9ny9WEsGEr9e1tx21h+Mt/ut9d6cM0Y7Fo
         pBveiGjIWkF1JcdWdepk0mfAU4VYPCviEn2Al//GSrriAeE0/lfjuAsSV3xV5cMwHNQM
         m+B/s8fcGVmxqujfwBlFxXwMUA0AZMAWeyktqtQmsASE4igAvHJ05nm36PlQTlSHnXmQ
         a077PD3ne9oac9/EY0zTHvqqkdL+MnR9PWydRtGRhdeag55ctA5aM/URsjIh8OYIMlTL
         kZzLIY2Ev0tWjWqiQu46G4zOdfPRhAuM5WiCVxHXwDnqHkKXiZ32Zms1x10yygrucWiC
         kZVQ==
X-Gm-Message-State: AAQBX9dRgKbUkhnULDUnnlaE32Yw4DwFuEN0Hjq12CTEkIsmhpDK3Brs
        Dy8RKyM5d8HnnTLo2Ps5MKI=
X-Google-Smtp-Source: AKy350ajzHQlwsDqL16oAUF2LtmLOv7wD/G4o4yloSXgjLI/FwWSy/wydMjxZrGLOzpCruc324uE2w==
X-Received: by 2002:a5d:6585:0:b0:2c8:c667:1bb4 with SMTP id q5-20020a5d6585000000b002c8c6671bb4mr19680706wru.48.1680273772501;
        Fri, 31 Mar 2023 07:42:52 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g4-20020adffc84000000b002d8566128e5sm2374858wrr.25.2023.03.31.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:42:51 -0700 (PDT)
Message-ID: <d3d6392f-98ae-f6da-914c-943962d94a74@gmail.com>
Date:   Fri, 31 Mar 2023 16:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/21] dt-bindings: soc: mediatek: specify which
 compatible requires clocks property
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
 <20230220-display-v1-14-45cbc68e188b@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230220-display-v1-14-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 15:23, Alexandre Mergnat wrote:
> According to the mtk-mutex.c driver and the SoC DTS, the clock isn't
> required to work properly for some of MTK SoC. Improve the clock
> requirement by adding a condition which is function to the compatible.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Applied, thanks.

Now I think we can get rid of the no_clk variable in struct mtk_mutex_data, as 
this should be mandated by the device-tree.

Regards,
Matthias

> ---
>   .../bindings/soc/mediatek/mediatek,mutex.yaml        | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> index 9241e5fc7cff..ca0ca549257d 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> @@ -69,12 +69,30 @@ properties:
>         4 arguments defined in this property. Each GCE subsys id is mapping to
>         a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
>   
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2701-disp-mutex
> +              - mediatek,mt2712-disp-mutex
> +              - mediatek,mt6795-disp-mutex
> +              - mediatek,mt8173-disp-mutex
> +              - mediatek,mt8186-disp-mutex
> +              - mediatek,mt8186-mdp3-mutex
> +              - mediatek,mt8192-disp-mutex
> +              - mediatek,mt8195-disp-mutex
> +    then:
> +      required:
> +        - clocks
> +
> +
>   required:
>     - compatible
>     - reg
>     - interrupts
>     - power-domains
> -  - clocks
>   
>   additionalProperties: false
>   
> 
