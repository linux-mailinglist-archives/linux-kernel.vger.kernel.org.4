Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91390682DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjAaNYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjAaNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:24:48 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD33B668;
        Tue, 31 Jan 2023 05:24:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12451460wmb.2;
        Tue, 31 Jan 2023 05:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxhhcNLD9sL5NmLXF8g0WapveH6yAh/sTiu1KtKU5hw=;
        b=en3JHQMZLrTmM8qbHgMjJaXpvDU8yI8g7QuilWw5521Cam0BttosV4MMSnWLoHf5ws
         DnpcwE1BRzEHnwoAl5B7voNCTJst5DU98sNh9/NaUCQ+XeZnFBYKHS0L8U2ZK85v3QkK
         HFrH0aYdyG/Eq7dhcacKP272aJ+Dom75XIi9JCoDb+hJZYHEjgI7Yf5sGrzdPFFC9ybk
         zxvYnyx90ZZOvHTfXHVCAXlU/H6c2I3VXwzUriaqMrefs7ROYUflXMUcg/sNSoChFsa6
         62EEl/jWIabDEv+6emNcKdjzg92+oUSPlLT5Ce7OelY14JEM6z9YzmQUOkNaiX56R2zr
         5FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxhhcNLD9sL5NmLXF8g0WapveH6yAh/sTiu1KtKU5hw=;
        b=T+m8+jm5WSnDM3T9VBjmrVvRmD+tI/DOVCbiGcy1m8uksIeLwaMPnJTWTWIR5dRZjv
         5TLeoAFC1vpcktfVYyOutz5WP6Numz1p2HOTp+8fviAgR/7S5U2E9RsRw7nuUhaUvWiy
         kPKct/bOz8dpQQPKNvn01bz4DH3RGEH2sCdyEP7Aw3XOlpXeec++hTMFIOLFk/DO4dZS
         FWVfF/F35iZbozx2OhzQUHMk4i7ezC923f9ShJMMykVpQP3l4Aq0ZXGzI13V+cV9QHbL
         ysFIxOcjkYxUjIjLo5b+Ljukn6W/RqdO5YWiITtDmG+vRgI0+LU2SEE8FbUq1Otpmrci
         yIKg==
X-Gm-Message-State: AO0yUKUX1F3O31BF3CtvS9TbP9PtgJP4EW9uW92cRZhnNAw+hn2XGWRZ
        /O6/CkgLHSlx7IbHv2JWewI=
X-Google-Smtp-Source: AK7set+urS00mY19tuZGxh19k2nPNudaVX0PteOfgnQnWnR7Tf5PHTMazYdwKUobsbo6ou0QBDRGjw==
X-Received: by 2002:a05:600c:4f06:b0:3dc:5321:8457 with SMTP id l6-20020a05600c4f0600b003dc53218457mr3680464wmq.5.1675171470151;
        Tue, 31 Jan 2023 05:24:30 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b002be0b1e556esm14549932wrt.59.2023.01.31.05.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:24:29 -0800 (PST)
Message-ID: <23de3e2e-81d9-5d23-748b-ee25cd5e39ba@gmail.com>
Date:   Tue, 31 Jan 2023 14:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 08/14] soc: mediatek: mtk-svs: clean up platform
 probing
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-9-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-9-roger.lu@mediatek.com>
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



On 11/01/2023 08:45, Roger Lu wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> We only ever call the SoC specific probe function from
> svs_platform_probe. No need to carry that function in a global
> datastructure around.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 70ca9c9acae0..41c0ac5ed8d3 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -321,7 +321,6 @@ static const u32 svs_regs_v2[] = {
>    * @banks: svs banks that svs platform supports
>    * @rst: svs platform reset control
>    * @efuse_parsing: svs platform efuse parsing function pointer
> - * @probe: svs platform probe function pointer
>    * @efuse_max: total number of svs efuse
>    * @tefuse_max: total number of thermal efuse
>    * @regs: svs platform registers map
> @@ -339,7 +338,6 @@ struct svs_platform {
>   	struct svs_bank *banks;
>   	struct reset_control *rst;
>   	bool (*efuse_parsing)(struct svs_platform *svsp);
> -	int (*probe)(struct svs_platform *svsp);
>   	size_t efuse_max;
>   	size_t tefuse_max;
>   	const u32 *regs;
> @@ -2409,11 +2407,10 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
>   	svsp->name = svsp_data->name;
>   	svsp->banks = svsp_data->banks;
>   	svsp->efuse_parsing = svsp_data->efuse_parsing;
> -	svsp->probe = svsp_data->probe;
>   	svsp->regs = svsp_data->regs;
>   	svsp->bank_max = svsp_data->bank_max;
>   
> -	ret = svsp->probe(svsp);
> +	ret = svsp_data->probe(svsp);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
