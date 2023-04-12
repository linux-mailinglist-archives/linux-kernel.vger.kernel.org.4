Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105E6DF595
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDLMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjDLMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:38:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8307ED2;
        Wed, 12 Apr 2023 05:38:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso11521480wmo.0;
        Wed, 12 Apr 2023 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303101; x=1683895101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrfSreIyYVzZ3y5IG1fr+KWAIr+UCJ0I73Dqb0W+8F0=;
        b=hKnB8rVVvWL/ZJVDH+5nnQup1V2zH+GXfSRvRjUwuxliSYmoOFCJYXpxVmdryKI5Z6
         em1bkjoymu8mUq+z0MMoyyqrcS+ggayxUSXiP9PeGUq3mZZolACfXxqRl9fshlGGPAFD
         Vkn8DAxLw+V9u8UTvs6/XjsZnQzXSTajc7QEVBBricagogLZ8T6SLB8w2LkIvy7fUNlo
         i5BFX0Abej8aMb/TM2bcwTGrZkLkNmZ6/s4uPq0g9ySPiufO2mj7uIebq3BMVV4pMOrE
         ZSfERzWfVLg4yCjn4pHkcURAMPmIsuND0L0K2xfg4HxUIjLL7AjNyC3IHq8/QR3EfDtj
         wkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303101; x=1683895101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrfSreIyYVzZ3y5IG1fr+KWAIr+UCJ0I73Dqb0W+8F0=;
        b=UzbYsXbZVW6KAJVFkf68/bwg7/KNtlsBl/f/TekfwkLOVRMP7pf0ZlRDUqJevxauqM
         YU+2VO2XRfSoIU4gihMYowKduEuSceIqzGFmz1QmZapeFh3c55DhF+PbIb5WnJP3r/g4
         9ZmndwHE27dkZgz87t5WqPI+0ycaH/HzJ9nv584z2m20AQUoYS7Kr173HJUcFBllKeUC
         aCNuRoxm2jiV9vwltiljXGYkYi6u+C5P0QrsTVfgl1r5VzNQZNCpTEMOxJzYNaPINUDa
         S+uJNZEm+VwnlroCh2embZFB5Bjab/EABqBRj+lywVr4rnVAoYwxVI3c3HEbng2+5eec
         gq6Q==
X-Gm-Message-State: AAQBX9et5sErY0VY2BAX280Sbp41iow+oWp2/yJjq6MRaeuJPVvR3Vhl
        Lc8rM/aHRNLorKxc8h5GJQc=
X-Google-Smtp-Source: AKy350b1vX5xNQp4/w0RoaPw15e4jwJGSLVJZU+94BcA1FM+NfcERa2O3p1GtJwdJ/T8GfM77hbaig==
X-Received: by 2002:a05:600c:1e25:b0:3ed:24f7:2b48 with SMTP id ay37-20020a05600c1e2500b003ed24f72b48mr1859483wmb.8.1681303100769;
        Wed, 12 Apr 2023 05:38:20 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b003ee6aa4e6a9sm2381574wmq.5.2023.04.12.05.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:38:19 -0700 (PDT)
Message-ID: <9b5a0ad7-bd94-98be-273a-7a2f9d53ed36@gmail.com>
Date:   Wed, 12 Apr 2023 14:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/27] dt-bindings: display: mediatek: od: Add compatible
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
 <20230412112739.160376-15-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-15-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795's OverDrive (OD)
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,od.yaml      | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
> index 853fcb9db2be..691a3644504f 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
> @@ -25,6 +25,9 @@ properties:
>             - const: mediatek,mt2712-disp-od
>         - items:
>             - const: mediatek,mt8173-disp-od
> +      - items:
> +          - const: mediatek,mt6795-disp-od
> +          - const: mediatek,mt8173-disp-od

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   
>     reg:
>       maxItems: 1
