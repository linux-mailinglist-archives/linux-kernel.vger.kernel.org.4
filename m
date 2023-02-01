Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263566866BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjBANW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjBANWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:22:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E82D58944
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:22:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a3so10600460wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXh9Bl5IlPDLRFf6zXorjLZOfKA/sZ6eA3cRR5AR1ac=;
        b=MBkzwzB5cIqpfo4uf9VGvAGPE4J+oDWOEOh4LaRsbqfUBgwavSl5ZFMXAk78HAY7sX
         Xuz5YPADNH1fJiZUQ/pUa1Pg1JtbQUGShrfRCUWfRpV3K+6b6h8cnH87e3JQ5t9N1Smk
         pF5Gm0f52xkU0ANVtL2Am0nJCQuEGwGOKC1EiEwXuD7YzWqYUnt+w9IUnVwLxxukW+RX
         ecDXies8ED4YXhnE5c/Iq4P7da+ue5zxdmgEsJ+tF9jlaqATJnIgch8WaqVTELFd5LA+
         CmyLQUhOlSjwZThN2fElwry16MmCHfIuEP+tSxF6eEsDJa28JzjG4PYZ7Z1cCwWSn6MO
         QmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXh9Bl5IlPDLRFf6zXorjLZOfKA/sZ6eA3cRR5AR1ac=;
        b=hP4X7XPhUrcNwE49sEWRDkDdHl4jLcbZoS7ab4FXlVl03Xo8a+eEtWTwYMLF9hF4xI
         PGnSjw32kClmNSBOjAh1FI9s/uPrBTyKniCKJ5dgiqZ+ctNve1EnAj1C5dbQr18HWnuW
         56xxKycuD+fpEIZfjHJgn91h3mG6cwuq/x5orAjwfgJf5RUuy6YiIJH40HADqmfUM0bX
         V4O9o2j/22v+G03XU0e5qGlhGa+6W2mgXehwV0YdD5gQI4nNTzbdqpeYFw8xaoyjltc8
         E6gJNfbRDjB2uxXgQzosPuGEkD5gn1hn4SKudB8Q3SDiR5tvra3ZjEF1pWEAQZJkiVzG
         mQkw==
X-Gm-Message-State: AO0yUKUG5hRD8KJtbQ/vRlHnJ/bnzmScaSQJO7P0HLiJ3iaFvyGxRhto
        qRukz7ncMWmXxdvkFqhevkKg+1ScXEQ=
X-Google-Smtp-Source: AK7set8YzROljVYpUMD7B3LLaCaYBj5PhZDEWhOO7u6nhd2XLVL+UL+VKfwcMlMCb8yU8lN1xZUQYQ==
X-Received: by 2002:a5d:570b:0:b0:2bf:c01a:f24f with SMTP id a11-20020a5d570b000000b002bfc01af24fmr1651657wrv.5.1675257771086;
        Wed, 01 Feb 2023 05:22:51 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d53d1000000b0024cb961b6aesm16920717wrw.104.2023.02.01.05.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:22:50 -0800 (PST)
Message-ID: <136b0d6f-0523-8019-35d9-792211e22d2a@gmail.com>
Date:   Wed, 1 Feb 2023 14:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: mediatek: mtk-devapc: Switch to
 devm_clk_get_enabled()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221006110935.59695-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221006110935.59695-1-angelogioacchino.delregno@collabora.com>
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



On 06/10/2022 13:09, AngeloGioacchino Del Regno wrote:
> This driver does exactly devm_clk_get() and clk_prepare_enable() right
> after, which is exactly what devm_clk_get_enabled() does: clean that
> up by switching to the latter.
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, sorry for the delay.

Matthias

> ---
>   drivers/soc/mediatek/mtk-devapc.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index fc13334db1b1..bad139cb117e 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -276,19 +276,14 @@ static int mtk_devapc_probe(struct platform_device *pdev)
>   	if (!devapc_irq)
>   		return -EINVAL;
>   
> -	ctx->infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
> +	ctx->infra_clk = devm_clk_get_enabled(&pdev->dev, "devapc-infra-clock");
>   	if (IS_ERR(ctx->infra_clk))
>   		return -EINVAL;
>   
> -	if (clk_prepare_enable(ctx->infra_clk))
> -		return -EINVAL;
> -
>   	ret = devm_request_irq(&pdev->dev, devapc_irq, devapc_violation_irq,
>   			       IRQF_TRIGGER_NONE, "devapc", ctx);
> -	if (ret) {
> -		clk_disable_unprepare(ctx->infra_clk);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	platform_set_drvdata(pdev, ctx);
>   
> @@ -303,8 +298,6 @@ static int mtk_devapc_remove(struct platform_device *pdev)
>   
>   	stop_devapc(ctx);
>   
> -	clk_disable_unprepare(ctx->infra_clk);
> -
>   	return 0;
>   }
>   
