Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48F6DF56B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjDLMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjDLMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:35:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3D4202;
        Wed, 12 Apr 2023 05:35:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so7695941wmq.2;
        Wed, 12 Apr 2023 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302929; x=1683894929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOc2AucAU7aYdgbiSm2th1euSZVFGfwkabbTq6fep20=;
        b=m+v514HGaFK5Ryst2GvVu0WpbKzjiMUgoyTC3y7ib70zmND8f67yDqDhLEyszteIcu
         nDEgm33pZMF14/NNYFE24RJ4wbeF6salTTbtdl1udWn14nlYygKujZcEmXvXeCrBKu20
         +uHCSmVjN7gN/VCu2q6bPg9rk3QWIOcAVF8XQ8OFc/EyKn6V4ER2/rkYwBUSltPIteMT
         snSivVlPFZSUA7xOhLeIVhtWzFFbsxi/TyAwby9iugYa7cAG2iQNu0+ThiWWmiAZ2KsA
         I8wgaKW3OSXULH/DAaKqPGc/lFQDpCVKycLjbmpJbYKXoe1pSxtsvoQj+sPanEZNJ6af
         xwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302929; x=1683894929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOc2AucAU7aYdgbiSm2th1euSZVFGfwkabbTq6fep20=;
        b=L1CuNLcrdbN3P08R6MIIWtFc/DSwJDfFr3h8Li+qths/7Kaj/pGT1AxqhKks8vGjxU
         DutyxHiFRaPPzDHBkUXNuAZMPCFZYsSUAxFP328s8TnIuMnEim429KawzII5Y2cw3lKA
         6DYzXIFgneA/wPx6HafsUFFRywrlu3XTK3cXQ2RZ2UmG7DPMQgCfbwOtIzJoZQgJC1IG
         XhG4HEVFVcZhPiEoMm6E155dTUUkk6i7xT1xHGqDFbKxW69ygJUjBYPMa7nNIkasTL5Z
         t5p02Uz/UV4VQTsr64472wb09EPNf5YXiA639SL91DaOV8KJoUTJn2r4Uukjurh32bNb
         8y0w==
X-Gm-Message-State: AAQBX9em8d5Ox31Ee26qQi/53UrXzDcQ9HAicH6O6sWZ2gL0f+vWm0sD
        WOLm6160gwVMFwbVScQhf9Y=
X-Google-Smtp-Source: AKy350bP8nKYohS7TIl2I5thMGIpEvLFOztUtKV5055tbR5s2H7wE+Qv5yJdtdxWYRvuV7mf/92Nfg==
X-Received: by 2002:a7b:c3d4:0:b0:3f0:7f4b:f3ab with SMTP id t20-20020a7bc3d4000000b003f07f4bf3abmr4704930wmj.5.1681302929390;
        Wed, 12 Apr 2023 05:35:29 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003ee5fa61f45sm2359319wmq.3.2023.04.12.05.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:35:28 -0700 (PDT)
Message-ID: <6920f628-8e8e-b800-eaeb-2703a9b7f9f0@gmail.com>
Date:   Wed, 12 Apr 2023 14:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/27] dt-bindings: display: mediatek: aal: Add compatible
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
 <20230412112739.160376-5-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-5-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795: similarly to
> MT8173, this SoC has the gamma LUT registers in DISP_AAL.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/display/mediatek/mediatek,aal.yaml       | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index 92741486c24d..7fd42c8fdc32 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -27,6 +27,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt2712-disp-aal
> +              - mediatek,mt6795-disp-aal
>             - const: mediatek,mt8173-disp-aal
>         - items:
>             - enum:
