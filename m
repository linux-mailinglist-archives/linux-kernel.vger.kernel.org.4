Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC476DF559
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjDLMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDLMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:34:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4BD59D3;
        Wed, 12 Apr 2023 05:34:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso11143169wmr.0;
        Wed, 12 Apr 2023 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302873; x=1683894873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eY38QovBO9X6brYLqxxxjQBNRV1VBzhniRNPrjrGVZU=;
        b=fmZsiHj4rx9xq5FQgOmOXXcMbHU/E0WtOfVdbUc8+/vCn2M26CpV8Ek1O40/kkrWEi
         6zMJDO5HcE660BAUn/G/QDSuh2gBMfU2cw6cyqL8o2NhawqkxGwQ7pPopcs2lBY5HuYx
         V7B8DOHQWR+5JsQYup6pv5v7W29eqmYY+B3IrwanVAdzSY1wx6NTATHVfYFNfMDJC9X/
         0+GEUiksr0AZa+EI+SRN79aBlMgcgPNMLkTf+YnmKZ+q+T78X+fZKV1M6tPm2FSWQSrQ
         YloSPAcWSSJQkVX0MlpguqUpaYZxw51vAKtrGBbjWA7gFpMz/D2gsbFSSl5VU95KjoWE
         dO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302873; x=1683894873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eY38QovBO9X6brYLqxxxjQBNRV1VBzhniRNPrjrGVZU=;
        b=pmMSDOtU/wzCsk8oT4aNkfiIuHY3EzJ28L9sLGo6yJ9MdX+qnB5EY/ILoGQFU7t0ub
         7cnVNsKmZNZDL6ohBZuT6uZ56ssfRc5dfFxL5Ndh47mL/PPAo28JMeCrCR+E5oqUVL98
         7IgpQh4wS1EM28Y128dmdFMCAcNWrpld83jhLxyUJajrkD01FwdtRmrMkdCygnARaX7o
         2biajjY3/53uUu8IgbpP4hVoPVlNWkJpWTRRXHXNyFhURJdKPiUG7zZze3zZxn2FNOQJ
         lrkmQozk6EAgZU5bbilnrkDJln/eltFaG5SxAiLCcU3auMjGNniOof6uoaIHkDUH4/hl
         469A==
X-Gm-Message-State: AAQBX9eiZtP3isoqs2Y86hDcrk5Dz+pwShnGBQcYxPWo9JFy0yUIBocs
        TjjOWw3Gye9ysK0LyOL0csU=
X-Google-Smtp-Source: AKy350bGRvf/Hjw+RYU3A7cGvEuMBp8eO5w3pbAUHmtpQjt3TNMecIwKpO6IParEHspcLI6mD84xZA==
X-Received: by 2002:a7b:c84c:0:b0:3ed:bc83:3745 with SMTP id c12-20020a7bc84c000000b003edbc833745mr1856609wml.25.1681302872837;
        Wed, 12 Apr 2023 05:34:32 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e2-20020a05600c218200b003ede06f3178sm2223361wme.31.2023.04.12.05.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:34:31 -0700 (PDT)
Message-ID: <7adda7a4-99e6-f3a9-22c2-6f4e1e2273de@gmail.com>
Date:   Wed, 12 Apr 2023 14:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
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
 <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
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

I suppose you expect more SoCs to share the same fallback in the future, apart 
from keeping in sync with other comaptibles described here, so:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>



>         - items:
>             - enum:
>                 - mediatek,mt8365-mipi-tx
