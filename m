Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC75BA293
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIOWFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiIOWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:05:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA64BD15;
        Thu, 15 Sep 2022 15:05:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x14so95379wrv.2;
        Thu, 15 Sep 2022 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zpqoR6zYZaDbnVePsdH4FdM+xRD3zWKF1Haict6bhus=;
        b=XsVZUp1G1GndrcNDmonhqsYyg8HENAjE19GNzlYPa/9kJbmBwf5y8+EJXbj0+cAhPJ
         K/d+4UWOFoDSxeoGXdWIdcZR/FU8eOo0ROvShTuaP1k0e9WN9d9NxzdivNQz1SyuC1s0
         HFknvEWVqwQWonj6Hjtb2csapqZ8tthlClB/YlLzrIPHCGItCQSFE+PoO6evABmQEIL6
         0cXE5lJQ/WGwcjbX8iAqVaG+8Ae5a3o16RGAV+/bFA27j1PzMp2FoCDIx8yMhVjblA2Y
         fao53K60h9ADNAbZt+b5wHD7mhvKx+8h3JPGzSkufm6Rixa6jeUaX0bsQyWwPVD1Cx7Y
         DhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zpqoR6zYZaDbnVePsdH4FdM+xRD3zWKF1Haict6bhus=;
        b=1OTQ/pzZvp6RKoGc1oAizfChnEXyoiyjAdDFThZJ/7FrnGO5uoUPvigJ/hZ3FLa36h
         fjsfifcwNBXrV2trZnK4N1wU/PECcIljlvB8n8E8s6A7lhQFRsCFeuZjJ7XmWVnWBlxx
         a0YyYXANSO2QvpSR2etmu5nG8Q9SC/2pg8BytVYIDDpVrjCSrI3Jof5BmAi4mFPUhNsE
         wm57R6O2Bigkx4Xxu19gRC7M3a3KVGUDCu1fUx20nwZI0NoPtkLpXxq1BqPAIZRZ9lxx
         ePvNMW718L9qUmf3x8P0KRlHyS9/5/JAznV9/9CdO4mCaTeEV6YkUGwiM7O5NHWv/Wz7
         G3kg==
X-Gm-Message-State: ACrzQf2BY2ScjnkzF3N5VfW03z1dj3Zeh+w0cx7jchsyV2YbdbDTqeQV
        B3MYE4AUocoq3jt8ZTMbTrk=
X-Google-Smtp-Source: AMsMyM5AwDHR+8oZ+u3KaLAwxnWLC8Cjl6pFCJwRn0zoZVRLZeruSgKYx2FpwJShdi51jWomIYHDfQ==
X-Received: by 2002:a5d:5963:0:b0:22a:47ed:f98f with SMTP id e35-20020a5d5963000000b0022a47edf98fmr1022216wri.155.1663279536730;
        Thu, 15 Sep 2022 15:05:36 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003b33943ce5esm217457wmq.32.2022.09.15.15.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 15:05:35 -0700 (PDT)
Message-ID: <e6921ed7-a14c-aadb-abd4-1e7ee0a63be9@gmail.com>
Date:   Fri, 16 Sep 2022 00:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
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
References: <20220915161817.10307-1-jason-jh.lin@mediatek.com>
 <20220915161817.10307-2-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220915161817.10307-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2022 18:18, Jason-JH.Lin wrote:
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> and they makes VDOSYS0 supports PQ function while they are not
> including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component). It makes VDOSYS1 supports the HDR function while it's not
> including in VDOSYS0.
> 
> To summarize0:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Therefore, we need to separate these two different mmsys hardwares to
> 2 different compatibles for MT8195.
> 
> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..0e267428eaa6 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -31,7 +31,7 @@ properties:
>                 - mediatek,mt8183-mmsys
>                 - mediatek,mt8186-mmsys
>                 - mediatek,mt8192-mmsys
> -              - mediatek,mt8195-mmsys
> +              - mediatek,mt8195-vdosys0

Nack, we miss the fallback compatible, as I already said twice.

Regards,
Matthias

>                 - mediatek,mt8365-mmsys
>             - const: syscon
>         - items:
