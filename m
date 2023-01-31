Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D58682D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjAaM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:59:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226A4DCE8;
        Tue, 31 Jan 2023 04:59:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h12so14109464wrv.10;
        Tue, 31 Jan 2023 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UndeySbwJtYhBstLS+7W0sTuNpKqoxWhQG5bKCKu1E=;
        b=kcA47SugyoASWc7ydEtwePhQFM0twx4+y19Z7wadyt7XQFZsZEJSpna+gvXiMiscEq
         IFOkCKqb6zFJl8Hll5lSlYJu8amy7v6m6HNpc7AB9o177uxiIjaCKPFc5aRo5PGFxVyM
         N23MA+9g8B+nUGHIW9Quq4A9Sveb1HSRp+4DNsKCP3RuIeVz14NU5O9RVD3WVhrkrhSi
         cW4H8Mnj8bCiB/ngDAqhyGzFIbm3qfrp0Ki3vJdRZ8cyBKvwWmUFbvPcgGIxNETLk0ZI
         gnslR4N/O0vXCZbyvSER8rWmxvarMbqbS+BGhLdFvPRPiNwKx0TUzkj0BOC1LoqtbaWw
         d4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UndeySbwJtYhBstLS+7W0sTuNpKqoxWhQG5bKCKu1E=;
        b=UzBLMJ0qv30AYvfjVxtGt5ttmjP4l09pHe6rJOvvt3Fzf//XkDNctMzZ8R3481eEMP
         Js2y6fZSof4IgeHsUiidLf6WeB8aalEABrsRHxQstVEvsLTTrkJIOidauaBv/zn67S9r
         Q4EEPmH1gMvAlJZobiLDT7XNxaIjwoIpPK76HdF3k33SW3k204o8p2vMxNh4j0rQet5c
         BYEg45ykXVRJY8TclEDVHb8xruh57DI+MPQwkgOqFD6wJQrVhBiybKLr0nBsusLb44Rt
         RpXQrztRBMU6DXRBh2YRwPsTETpklmPMQHtZfsy5QzABXzW4hoUB9jJWIhVGKlZZv8vL
         efXA==
X-Gm-Message-State: AFqh2kqnT3Y+wPvX/Vfy/5eAm+7qzZlHkhAghwaRtIBrcJVMysGWE7gv
        65JLw1EwP8UAI13hjPXy9AM=
X-Google-Smtp-Source: AMrXdXuQTnI7ooh6atfJ1l+iKecwB8hqvSyt3CFwVI9zZ+9rWAa4lGHia0YO6Ocu7iA5lZ7l35q2iw==
X-Received: by 2002:adf:a31a:0:b0:2bf:96ae:7cc8 with SMTP id c26-20020adfa31a000000b002bf96ae7cc8mr33668033wrb.4.1675169977792;
        Tue, 31 Jan 2023 04:59:37 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm14798814wrx.115.2023.01.31.04.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:59:37 -0800 (PST)
Message-ID: <561d9a97-64c7-6633-ff10-d85ae2c7f314@gmail.com>
Date:   Tue, 31 Jan 2023 13:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 03/14] soc: mediatek: mtk-svs: enable the IRQ later
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
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Ricardo Ribalda <ribalda@chromium.org>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-4-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-4-roger.lu@mediatek.com>
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
> From: Ricardo Ribalda <ribalda@chromium.org>
> 
> If the system does not come from reset (like when is booted via
> kexec(), the peripheral might trigger an IRQ before the data structures
> are initialized.
> 
> Fixes:
> 
> [    0.227710] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000f08
> [    0.227913] Call trace:
> [    0.227918]  svs_isr+0x8c/0x538
> 

This patch is different from
https://lore.kernel.org/r/20221127-mtk-svs-v2-0-145b07663ea8@chromium.org

If you think the patch from Ricardo is wrong, then you should have mentioned 
that in the review.

Regards,
Matthias

> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index a803b92afc3d..64d4d03ab71c 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2403,20 +2403,6 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_free_resource;
>   	}
>   
> -	svsp_irq = platform_get_irq(pdev, 0);
> -	if (svsp_irq < 0) {
> -		ret = svsp_irq;
> -		goto svs_probe_free_resource;
> -	}
> -
> -	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> -					IRQF_ONESHOT, svsp->name, svsp);
> -	if (ret) {
> -		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
> -			svsp_irq, ret);
> -		goto svs_probe_free_resource;
> -	}
> -
>   	svsp->main_clk = devm_clk_get(svsp->dev, "main");
>   	if (IS_ERR(svsp->main_clk)) {
>   		dev_err(svsp->dev, "failed to get clock: %ld\n",
> @@ -2438,6 +2424,20 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_clk_disable;
>   	}
>   
> +	svsp_irq = platform_get_irq(pdev, 0);
> +	if (svsp_irq < 0) {
> +		ret = svsp_irq;
> +		goto svs_probe_iounmap;
> +	}
> +
> +	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> +					IRQF_ONESHOT, svsp->name, svsp);
> +	if (ret) {
> +		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
> +			svsp_irq, ret);
> +		goto svs_probe_iounmap;
> +	}
> +
>   	ret = svs_start(svsp);
>   	if (ret) {
>   		dev_err(svsp->dev, "svs start fail: %d\n", ret);
