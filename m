Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA76DF578
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjDLMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjDLMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:37:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE57DBD;
        Wed, 12 Apr 2023 05:36:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s2so7473911wra.7;
        Wed, 12 Apr 2023 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303008; x=1683895008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+yJqelcjnVJsBvuc5XbMPT6WJPDQKryMhB4y470pSo=;
        b=LLjqDK8tdTHUH7mzFIFmfQT8xQyuLtVYbmR7OQrKeNzsqHXLj5BBQMhtKqzkyUOumi
         Sn/FVrn77yRrZUvVN/HJuEHXk/hHx7wn1bvjgdWUlsHOf/xX2c58NYs7Pb4IjjyABuXJ
         w3agsCkggYVx3P+20Poa/ChhqMclxJlCHVv6UQRDUKXEyh2AO/A2pJg8bMu868T2DGa+
         hhoq5XcdPPbLdXlR/sjZKqdDnicTwRtks9MloCIznQD29X6PMwXA0qlZEltcag2yqo0k
         qPm6j05xWOMfFQ7zE8JislSdbLHAMo8LpDUZSfG5aZy/z2WIvaDc7lTllYO7QMVQsCju
         InTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303008; x=1683895008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+yJqelcjnVJsBvuc5XbMPT6WJPDQKryMhB4y470pSo=;
        b=iJH3v0x7qgabSW7UiMqxDmo1xKuqHqDq1+LN/FKCrrjE1+o9VrUVMZtW3ftx93yqF+
         Dg88yRViiqiPY5Z+0+Ukpyq/htQU49fcWAJgezlV+6M35H8pjIMU9yexvqOEq80V1AnK
         f9fpmrmg3xPMdG216+si1ldqnLx3oMeXikSbds4JoWSFC15q13zSJL+nYjrS3EjhDIuG
         ua5UBit9XUgqxVTOL8ufIY13snKpMOtfhXC2i+BrNIKPcMgWJxVuQSfo9Sk79Vde5oy9
         axWN4F6ERl3W/S4LiW3JxT668u9dI/gs9QWJkU7n+vXN+bueIDGR4MmFibh5iAVnIOwL
         y0TA==
X-Gm-Message-State: AAQBX9cdKFtiMU44FePsP8caxkjlI8jHu8fxx4y6wNYikIkyf+v1ncOC
        x9kJx6EGRFxzgXAa+Fn+lMw=
X-Google-Smtp-Source: AKy350YfaWPBQRxXe37/4nw4RvtdvOSXPdUuUJj6f7mSjFILGvCzsrsicMkzLrBGLQ3m32F6fCsuGw==
X-Received: by 2002:adf:ec82:0:b0:2d7:67bc:344a with SMTP id z2-20020adfec82000000b002d767bc344amr13517948wrn.37.1681303007626;
        Wed, 12 Apr 2023 05:36:47 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m8-20020adffe48000000b002c55521903bsm17181465wrs.51.2023.04.12.05.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:36:46 -0700 (PDT)
Message-ID: <3e8c6b55-5b5e-5141-8f63-d7f0fc7d1699@gmail.com>
Date:   Wed, 12 Apr 2023 14:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 08/27] dt-bindings: display: mediatek: wdma: Add
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
 <20230412112739.160376-9-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-9-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795's WDMA block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,wdma.yaml    | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> index 7d7cc1ab526b..1a19b3ef036f 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> @@ -23,6 +23,9 @@ properties:
>       oneOf:
>         - items:
>             - const: mediatek,mt8173-disp-wdma
> +      - items:
> +          - const: mediatek,mt6795-disp-wdma
> +          - const: mediatek,mt8173-disp-wdma

:D

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   
>     reg:
>       maxItems: 1
