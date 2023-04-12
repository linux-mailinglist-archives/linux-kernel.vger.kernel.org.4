Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC516DF572
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjDLMgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDLMg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:36:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB96E9A;
        Wed, 12 Apr 2023 05:36:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e7so654622wrc.12;
        Wed, 12 Apr 2023 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302963; x=1683894963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wE7N70141Au9hlevZXAZoj6fncNpv5mG2/2AtTaaiCY=;
        b=NEcoZuzS8P4iLio4nXH/fPKA+WVpnLFtlrKOnIPIT3Hx2KjonjAQrokGpRwlwnOBGO
         bGLkPeH7icTnEBAVVxA2h5hVZ/1gQr30E7WY8UkQUX7V3g/i1ZR3jOpLBmCjnONzLIqC
         p+1OB+B2Y9WPOSeoN4GbT1ZuCIZaYDEw8spi4Z8ZyVEtkGNDLFEuM0hEDHsgjQZFOKN+
         3zjg0YwBt3OUh20M6jYtvdwRP69s7PEMPcGL2c0bvNnWZCQFOgyvdvYS6OVvygJMRzR7
         5RAtXlaNgLtQpZeh2eBC2qzZ3blTgUd8gC3wOngl0DnYAfrFQ3N3kRQ9qTWHHc79qnlr
         J2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302963; x=1683894963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wE7N70141Au9hlevZXAZoj6fncNpv5mG2/2AtTaaiCY=;
        b=26FmiBGvnfYmvJ0S6rg7vfht1TncXiiglBjSC1du54rWtcKkXA+YyCHzLF9Nqv48dC
         Q3ykNbVUeYn09lFZHoVrggS5sXp03B1uLzYO5bXUAKQ26PuLodylyV/Nd1/kh8rqnuj6
         bu2boyibLsExhBudRXAJCx+8twS0oH3IzJhWQtRgs85nygpM/wd8lw8M6wGx2qgVQWWh
         zKsTjLErisUWJCIy4nQNQaPI6RUdAupT14qfu1xhOg9il4j6njU+CJ9w/IweifN6qKmL
         joJ3T4BrBms/ocRRSk285eeEC+s+MJxy1zm+mdw1mPxl3AmOREM2a9q7Tmdl2OygJiMA
         Tbig==
X-Gm-Message-State: AAQBX9d+RLJTIKxp51+GWzotu150J1O9s3Hr4lQykBDWEd6/TUBTmWox
        g7tdKAkAC5u2WSYwHdNe1pY=
X-Google-Smtp-Source: AKy350aeuLyAiDRCHx8WCMaCn9uP+PuosubsGjcr6o2UO9HCVUKys6W1CjIDSWkAVTjaxq4gQgUTDw==
X-Received: by 2002:adf:e441:0:b0:2f1:d17f:cf95 with SMTP id t1-20020adfe441000000b002f1d17fcf95mr7353387wrm.12.1681302963216;
        Wed, 12 Apr 2023 05:36:03 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f5-20020a0560001b0500b002cfe3f842c8sm17040059wrz.56.2023.04.12.05.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:36:02 -0700 (PDT)
Message-ID: <b9424113-f812-2f2d-5068-b04bb789e0de@gmail.com>
Date:   Wed, 12 Apr 2023 14:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 05/27] dt-bindings: display: mediatek: dsi: Add compatible
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
 <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795, using the same
> DSI block as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../display/mediatek/mediatek,dsi.yaml        | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> index 4707b60238b0..12441b937684 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> @@ -22,13 +22,18 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - mediatek,mt2701-dsi
> -      - mediatek,mt7623-dsi
> -      - mediatek,mt8167-dsi
> -      - mediatek,mt8173-dsi
> -      - mediatek,mt8183-dsi
> -      - mediatek,mt8186-dsi
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-dsi
> +          - mediatek,mt7623-dsi
> +          - mediatek,mt8167-dsi
> +          - mediatek,mt8173-dsi
> +          - mediatek,mt8183-dsi
> +          - mediatek,mt8186-dsi
> +      - items:
> +          - enum:
> +              - mediatek,mt6795-dsi
> +          - const: mediatek,mt8173-dsi

Same here, why not const?

>   
>     reg:
>       maxItems: 1
