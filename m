Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878936DF548
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjDLMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDLMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:31:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA8106;
        Wed, 12 Apr 2023 05:31:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so4120118wmq.5;
        Wed, 12 Apr 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302660; x=1683894660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LH8FUEh+YJu8DH3rQ9pd4R0sfMJTPR3+WipwFABmNG4=;
        b=SKj8hts1928ziujgAoLnuqVkvDvGcPZx36SBJHxw+/0D/ZFODDY4QCuDaPwslggRoY
         AL0fHbhDZ54IiymSNRpgOcztfTVCMYJBahVeQxJRhHfMUx1zzQkD5fAr1uhNC8NkJj+2
         TlI+Xs2wdnQ4C2SbpWPLQAgzPsSE96He+YrPPhFhhWu7QXZIA7tL25TZaWLHKmmfolOT
         mgk5iGo1cZD7lug3KA6VJnE9zKrDfk0tJNM1YvwkgmiDXk29Cjt9H6nW/pcdYSMAbLPj
         FwqojBdj6zG94Wa5EDAvxojVaN46+6GMtSP1CZ/UqkOysvuH+mRZNQ5kNfJvr74I9E9u
         j1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302660; x=1683894660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LH8FUEh+YJu8DH3rQ9pd4R0sfMJTPR3+WipwFABmNG4=;
        b=76P81HEHbm6IJIqMchUb4xioqh+6gbFBLo5LyLmYen5kCJtUiEHMxyInXv9MsvtoQK
         /Cgj5/bTmQDz9krvr4mbgVLiM1AZFM5TBk+q3heJ7vVOOOm2pTic00juYIZHzE3+0Z5/
         EUq402WFN0wz6qvujo+nqBGuJo+YzuK2up3ht/n8lo1pew7fSAZ1Wr7eFfEBOLfF7T8/
         fx1NySHclWA18w54tElSlzPKFDLuQh7oP9576yENuYDKCVKq8mVoEIkDyxASpmUbGBYG
         uXtiG0ZmXDz7NXAYNEAIlIhOccZHvBaTblEKMDontID5Gbn0g+oIiCrJQ/xodBFBSy+D
         VdCw==
X-Gm-Message-State: AAQBX9fxzQOEvo3EFKZC7JBsSEXh9aNP0Vz0IseK2xMDIzh5WXYB19PA
        ToC//fKYOdMkbv9f8dT3jGg=
X-Google-Smtp-Source: AKy350bn9uF0IQIwzgop3ifBPq286Rptgb8qr/QNLk/Ydb6m3Rimef/MNKrhRejMvnS2eP3FRuoY/A==
X-Received: by 2002:a05:600c:21c4:b0:3f0:4428:9444 with SMTP id x4-20020a05600c21c400b003f044289444mr11979874wmj.10.1681302660547;
        Wed, 12 Apr 2023 05:31:00 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b002de99432fc8sm17058331wrs.49.2023.04.12.05.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:30:59 -0700 (PDT)
Message-ID: <40b46002-fad7-9751-fc2c-5d96a5ce6b75@gmail.com>
Date:   Wed, 12 Apr 2023 14:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
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
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 0088bc8e7c54..153e146df7d4 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -22,7 +22,9 @@ properties:
>             - mediatek,mt8173-disp-pwm
>             - mediatek,mt8183-disp-pwm
>         - items:
> -          - const: mediatek,mt8167-disp-pwm
> +          - enum:
> +              - mediatek,mt6795-disp-pwm
> +              - mediatek,mt8167-disp-pwm
>             - const: mediatek,mt8173-disp-pwm
>         - items:
>             - enum:
