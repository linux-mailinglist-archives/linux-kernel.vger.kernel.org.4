Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB756E1DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDNIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDNIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:21:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2287AB8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:21:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so1900171a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681460467; x=1684052467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9w56sg0vFWPotW3ggjC58S0oDYkCPh83S4/DlaSQRs=;
        b=SvGZ5RwkfcAUFCPQAmlZ/0mT4BbyNtXUcqqzCOlcXeWRuG/zqOy94hFrJ2crZPKtYV
         l6i4oj3HMIiidbLCDbt0v7fNR35xocG/yWmtXQ4S5Hfgcj14WnVn7Gi0iBcg8HBKkzOv
         USmzu2OE0JBCOsWNQhcRBn13RShBPk/bpJaFefiwdqISsnn7sc8LRl9BfW5nsVy8GFZi
         /11ouHGEycuicUZ3xRN63ibLOITUEP0R0+iCjJ+xM/rSn4zu7UPJ1lsg8UyMqa0ySirR
         2n2LRYigvIctX0hKLww8sdNAHiFV35aIQDWQdsw1S37Z1ZeP+JAzLB0NoKAdTxWBZUnP
         E0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460467; x=1684052467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9w56sg0vFWPotW3ggjC58S0oDYkCPh83S4/DlaSQRs=;
        b=Vb3/96eOscZd/zE09+PwLvnnkeJ67MNbHGHSeRtKBSyIEWFrcqNVGdXg52dYQS2YSI
         gDFhR74UxEMMzp6CBL1J7cfUVTWtPtsRtvgug7t7nLXWBLYBU+e8IBZfH/C6N3nA98+J
         VO6UzYQEnbhGz5561OVj/VCMj990VuaymkQpJRj/8yWamCB1CkVJejoCCvvgEMoPVmSH
         xajJxRa87qtJRhxrZzwStkzdJi/Ma6Js6XTrgYBKGBXUHh0BIzfJOcNlEq1XnA9gGcgg
         C4Ou6qWOO6dWCnQ79vhC/+9MTdUfIil/P9HMW4mFVJt85U+JeQSg/bdprc/+EARGreWY
         cZWA==
X-Gm-Message-State: AAQBX9cuDQ2auFCBtavn8rNhqNRsrMvJdrC7yKtYtTyyrWWJTsWEkkAc
        wu6ne0CPGXHaqiveGoveIVsFRg==
X-Google-Smtp-Source: AKy350YM+MOz33eDaFgkCqQllKhNWwkLLpRA7eDwp2QztSKXE3waumiu5Xmot0TK+gNOB5bBXpOv7g==
X-Received: by 2002:a05:6402:511:b0:504:b606:32e0 with SMTP id m17-20020a056402051100b00504b60632e0mr5042292edv.34.1681460467297;
        Fri, 14 Apr 2023 01:21:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id vf13-20020a170907238d00b009475bf82935sm2096367ejb.31.2023.04.14.01.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:21:06 -0700 (PDT)
Message-ID: <aaeeb18d-f8e8-d6c1-1272-e5b797554b9e@linaro.org>
Date:   Fri, 14 Apr 2023 10:21:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
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
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 0088bc8e7c54..153e146df7d4 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -22,7 +22,9 @@ properties:
>            - mediatek,mt8173-disp-pwm
>            - mediatek,mt8183-disp-pwm
>        - items:
> -          - const: mediatek,mt8167-disp-pwm
> +          - enum:
> +              - mediatek,mt6795-disp-pwm
> +              - mediatek,mt8167-disp-pwm

This does not look correct. You do not add compatible, you replace
breaking all mt8167-disp-pwm. At least it looks like this from context.

Best regards,
Krzysztof

