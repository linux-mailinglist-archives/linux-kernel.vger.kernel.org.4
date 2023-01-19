Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3785673EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjASQ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjASQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:27:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5753C4B740;
        Thu, 19 Jan 2023 08:27:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so2370504wru.13;
        Thu, 19 Jan 2023 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/U5zgB7p6OPqHMQlkEy+bwIc9R4WIoTQK22mTGWePo=;
        b=fehBeiL89VwQgVcafbZ9QQSKjqCm23MRx5+udadtSKvVH7KDt3+9ShdubuWImJZN/d
         hWHtyRDCOTanWJpvde1aFlT+v2Q+xYATcGL4q1NVrotOUXxUqFeTWXWJfgo9a0F/LrK7
         dcLbQMkXf057SiNAUXv2qK89NpwC8CGpy40BDeccLXhCdCcj8a7VaNsJsiX0m2GV50gJ
         f1a/OxIqlVSvdITWsbx6fVKoy/306HGBPBl8SfeZsONDZ2qrOfWfa+QDqBEVm6wSmGJI
         aDSoOaqcOOT4Yq4pcCZc1qO00QACoRO9B/3vJM6eiRtXluU2ClwyQznEWa5GZG72NLbB
         Js8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/U5zgB7p6OPqHMQlkEy+bwIc9R4WIoTQK22mTGWePo=;
        b=l0LUK/FISh5cqB2byZJcwGAf92pjepLTZO9pRd0mTCr/TKJOrSu6OqAeLvnjeblZu8
         RtRGeORsHY4Vn1QxJnhFMplxDjOiHMSFDQftsuRiX+aDliW4+khTd8N+n+2TgLWX0dJS
         vKsFO6W4FZ1oJUVqx2tmCOLuIVGBKjjGo9v8aG01mFu0waLLJ5eYXoMuBtJ4QNrcWGZ7
         icSIKXAD77GBlNYvSFHbmmbuLXKd+yj02b1Ft3ImtCLRMUM8t0+tlrdVTEg8Z0kzyRJC
         X1vVEVOEJYM1jfkO8BIchAKhNqrSpU+920lrhYSL2Up0NustEDOIcEYDR5Imnm6NuWJz
         3m7Q==
X-Gm-Message-State: AFqh2kq0jZ+tjVFIW1iJP8jA4+YjDagpm5rC2EqyX7E1lyL1S/tvFvQI
        IJVslheFWVngjZ7+hewuqHc=
X-Google-Smtp-Source: AMrXdXs9Cqz0kN5li7jUZKL9XHr8uTasSMBvof1S8Lp/gYpd11zsi5j9VtdWxlRUsSXtROeRulr9/w==
X-Received: by 2002:adf:ee10:0:b0:2bd:d5f5:8820 with SMTP id y16-20020adfee10000000b002bdd5f58820mr10124489wrn.27.1674145663376;
        Thu, 19 Jan 2023 08:27:43 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b002a01e64f7a1sm10707038wrb.88.2023.01.19.08.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:27:42 -0800 (PST)
Message-ID: <9d991211-4c5a-f6c7-6179-b5740a484a75@gmail.com>
Date:   Thu, 19 Jan 2023 17:27:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/9] dt-bindings: spmi: spmi-mtk-pmif: Document
 mediatek,mt8195-spmi as fallback of mediatek,mt8186-spmi
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
 <20230118091829.755-3-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118091829.755-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 10:18, Allen-KH Cheng wrote:
> The mt8186-spmi is used as compatible with mt8195-spmi on the MT8186,
> document this situation.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml   | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> index abcbbe13723f..e4f465abcfe9 100644
> --- a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> +++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> @@ -18,9 +18,14 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - mediatek,mt6873-spmi
> -      - mediatek,mt8195-spmi
> +    oneOf:
> +      - enum:
> +          - mediatek,mt6873-spmi
> +          - mediatek,mt8195-spmi
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-spmi
> +          - const: mediatek,mt8195-spmi
>   
>     reg:
>       maxItems: 2
