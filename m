Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A41750885
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjGLMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGLMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:40:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296ED170E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:40:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso70621765e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689165613; x=1691757613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkNQv7geS5CR2LiJ7vpq5fz0PNWmI57+KWeY+aP5fjo=;
        b=w9wh4Pkr8rOHj8Cbmzkuimk9nKuqBy9JUTg8kjwlj8n8OPSxsfutY+Kk8wexoYVZX+
         5xTPaDLVpb0WZ1xVXeOGb5YPK0rqIiTmWXMM+XytwPPKhxGylqcDYQxJnXSyIpgqBgDZ
         ZlC7q6y7wxiej8SzCDfSNI2BXCYXpQaTQ3lTCUT9hSlWjyY5RbocTNvWbnF8GZT3eY0U
         /eyMserg5zIMY1c+JA19IF6abF6bzOYSBc/fPK/AeOojgY/sKEhdFQ6jL+l7TkJgJCIh
         2xG/fV/JRFf6gwsisfocp8jKlghZoi7JjGzlH/dRcdCo8U9wvoJOnlsujx7JfLc4BxN6
         YDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165613; x=1691757613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkNQv7geS5CR2LiJ7vpq5fz0PNWmI57+KWeY+aP5fjo=;
        b=c7YfWF6INz+sS4D10qgZRda4uJTpXv3/MwpS432ZJU1juguQQZStM8OcNhtvf/14Qt
         lv81S/4GnUT7YWVoEsmYxefqGUWg5V+o8Vd+SjXkTPtHlpA5MSOIf3pXOgKECqd05AQL
         3toU4QUYU+3RuWwEWFvDiCgSTCSpP3y5yk3w6isV80wPCLo4xEMkaQMAAUkGvPVKVnv4
         2ybBkFvA+H9kkSUa6/EGX0DK8Qu8z8w1yiPetuhkl3WujhLL2kMyw6yYSlhxjcTr3GMz
         f02nRWNGkHvnai/PBDhhiXeg0zBJzIR2BT5OFypvDp0jDZ27ZAIcHk/ljl2qMmO/6iau
         nDXA==
X-Gm-Message-State: ABy/qLavCXcNbyXzUN/gKbBlyhhmqZvt5kOJu8Gva2g3ajFA/7d5hUOH
        6DDOZZG1JwykGJaGn2kZKWw7caf+KffvgjLrirk=
X-Google-Smtp-Source: APBJJlF5yLpkbdjZuR9UBaY6jqLSbZs8oxILlpMjHaH5n0w7cV1ebVwGScR6HD9FlErXpx3JbkAshg==
X-Received: by 2002:adf:d0c9:0:b0:314:1ce9:3c86 with SMTP id z9-20020adfd0c9000000b003141ce93c86mr16299116wrh.0.1689165613366;
        Wed, 12 Jul 2023 05:40:13 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003fb40ec9475sm4978175wme.11.2023.07.12.05.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:40:12 -0700 (PDT)
Message-ID: <fab21c8b-13d7-1046-6b13-51a3d6684a2f@baylibre.com>
Date:   Wed, 12 Jul 2023 14:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND 1/2] ASoC: mediatek: mt8188: add memory-region support
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230712070821.23971-1-trevor.wu@mediatek.com>
 <20230712070821.23971-2-trevor.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230712070821.23971-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2023 09:08, Trevor Wu wrote:
> In certain projects, it is necessary to utilize the reserved memory
> region for audio dma. The patch takes into account the dts property
> 'memory-region', allowing for the specification of memory for afe memif
> through device tree.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> index 6a24b339444b..5e14655c5617 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> @@ -16,6 +16,7 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/soc/mediatek/infracfg.h>
>   #include <linux/reset.h>
> @@ -3193,11 +3194,15 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
>   {
>   	struct mtk_base_afe *afe;
>   	struct mt8188_afe_private *afe_priv;
> -	struct device *dev;
> +	struct device *dev = &pdev->dev;

I think that make sense to replace all "&pdev->dev" by "dev" in the next 
called functions:
- dma_set_mask_and_coherent
- devm_kzalloc
- devm_kzalloc

>   	struct reset_control *rstc;
>   	struct regmap *infra_ao;
>   	int i, irq_id, ret;
>   
> +	ret = of_reserved_mem_device_init(dev);
> +	if (ret)
> +		dev_dbg(dev, "failed to assign memory region: %d\n", ret);
> +
>   	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(33));
>   	if (ret)
>   		return ret;
> @@ -3213,7 +3218,6 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
>   
>   	afe_priv = afe->platform_priv;
>   	afe->dev = &pdev->dev;
> -	dev = afe->dev;
>   
>   	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(afe->base_addr))

-- 
Regards,
Alexandre
