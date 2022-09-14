Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39B5B8FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiINUqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiINUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:46:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B16B6BD62;
        Wed, 14 Sep 2022 13:46:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l8so7081910wmi.2;
        Wed, 14 Sep 2022 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=m9bGoBe8wCBmkc6gud9Cy1Iqu9DMXje49H2FW2XThhI=;
        b=k/LW+8FU6dXTiCSildtV6+lus8xNFn/xqGPYUXzcghwZeYb6llePcT4d7wf0rZbEXX
         hyppBJay9AZGyBAsr8kHRkKFM0j9D6+yLwXVYrftrkWLHjzvaZbEH2dj2kRk5YGz+C4A
         jj6ktBTgFgGl0j5aqSOdDtqj3HMK43KfFdOk1FIneIRFyeNLS7YalGI5t3khH5lIgrId
         b5uD/UFf44ISwEcj9Q1OXjluUCNAYiu+0vT3jEZhqfyi4/i3zbLiurGcVdppBt3gDfvV
         GMUhEDVbNCshYWBKs85YZ4BsVeqk/duyZnAPsCHEwlQfcvOJxbEWW6kJDuxpHaqZ880s
         CWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=m9bGoBe8wCBmkc6gud9Cy1Iqu9DMXje49H2FW2XThhI=;
        b=XBpESllyigDmvJv8yFoYfkjva3Vs+y/uOpRjIXd9WpnZ2q+RV041bCllk8PO1a5uRD
         j4FTOiLnscAx+rEZOeuxoihjfpVhmG/n1Z52tq1UyAPq4QOsR1WAN8SASeEt0unz1wEG
         7CdF8ujO5MU4hIrESnYembNyw1/zs06pkNxxQUaM9Y7z03lhvO5w64SXfKVQSXdR9qwT
         Ix0isoQCmiRulOZmv2mu48AJhq6jK88oVPvhgJ4MFToBqUed0afYYCD2vCYKBLXqd3V8
         wMMqFKgOT7uQQ0Q/xcrCX0XhMRyrAnCYeK96wx+MJQAbDCpCx0lotL+91Uo1k+ma46q+
         27zA==
X-Gm-Message-State: ACgBeo3NA50KWgB53KnHRe2yY0j0MLmYuwiX045kRh5wSdXcoceiQj4W
        7Qb1NbWjoN/lalCEi26LFRw=
X-Google-Smtp-Source: AA6agR5j+dsaEcuIMXF56rsR2ctpU5gvF4j1nF5xUwvAX9FmtpqOU5JxXYVEgUIZukydfLNl1VMa5Q==
X-Received: by 2002:a05:600c:4a9a:b0:3b4:78ab:bae5 with SMTP id b26-20020a05600c4a9a00b003b478abbae5mr4551567wmp.114.1663188358968;
        Wed, 14 Sep 2022 13:45:58 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d13-20020adff2cd000000b00228dcf471e8sm215086wrp.56.2022.09.14.13.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 13:45:57 -0700 (PDT)
Message-ID: <1b3a880f-06a2-1865-3791-03021aa34175@gmail.com>
Date:   Wed, 14 Sep 2022 22:45:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 5/5] dt-bindings: arm: mediatek: mmsys: remove the unused
 compatible for mt8195
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220914182331.20515-1-jason-jh.lin@mediatek.com>
 <20220914182331.20515-6-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220914182331.20515-6-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/09/2022 20:23, Jason-JH.Lin wrote:
> The compatible properties of mt8195 have changed to mediatek,mt8195-vdosys0
> and mediatek,mt8195-vdosys1 from mediatek,mt895-mmsys, so remove the unused
> compatible.
> 
> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml         | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index a53b32c0a608..bfbdd30d2092 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -31,7 +31,6 @@ properties:
>                 - mediatek,mt8183-mmsys
>                 - mediatek,mt8186-mmsys
>                 - mediatek,mt8192-mmsys
> -              - mediatek,mt8195-mmsys

Should be part of the first patch. As described in the review.

Regards,
Matthias

>                 - mediatek,mt8195-vdosys0
>                 - mediatek,mt8195-vdosys1
>                 - mediatek,mt8365-mmsys
