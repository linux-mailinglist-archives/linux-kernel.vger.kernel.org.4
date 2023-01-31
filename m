Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6F682DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjAaNZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjAaNZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:25:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1A41B6D;
        Tue, 31 Jan 2023 05:25:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l8so10330266wms.3;
        Tue, 31 Jan 2023 05:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDykM3xjoJqJ0kl5mL74IPEifh1EPorjz4JkjoCu2Ck=;
        b=CURwR0Lgn9WhsX6ywDQm13K/RhmiZivoGl4GvCyWc7PwAhJpbignBeXv5vigmQ5mZj
         OoCB8gMREUJGLd6cFDwESGZ6YSfutnNT4KTQbj05ipxpxkmSahMQI9K/w65C65Lbb3Wh
         d41drc6ykkp/N0MEO9RYJLc2hXLAfhP+q2UdaEbb97JF6OH5Ivdk3KSNlvjmqUUyBfew
         F/Oo0wOC2zoXCIQ/aC0/ZKb3FDdfxpLF2HApWFA9G01FvgZAGf0I8d68NULtliZIl8ph
         1LsmT5fjRKpHo3nU60H7MidQnMNfr6JH5xAuTVm6Eb8Y5nojh6Qnut1873pm+aF4D2Ts
         G6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDykM3xjoJqJ0kl5mL74IPEifh1EPorjz4JkjoCu2Ck=;
        b=NRhvYtXNCjVVd02rHL82/yFLI4FIEt1rdkoJiV4xStxfwbXjDyYUP6EpDlnrlheS/Y
         UfITfNlKtCGcmPg0bwj/bWD4WSy0x00tDkqhb1yF832/dM9STiV5YD8DONirTtc5iOLG
         3CsyNT11uULbly6SAeTAcgrl/RrkP9AKDLQSJJAxXfWdsvnKDvmHk2Lj28+DE+xfStjN
         DFJtScySALUxDi1FxHl7TrUmhakuKxYTabEL2eyG2zIg1Hg1EjgopkfsLcw6vYMgiC/U
         V0c+QCe7QvKC0WsCPh9WV0rId4EF45GC8JKt6hnBfzBkO+gRa7f+2nzPxjoZYA0kMqTd
         F41A==
X-Gm-Message-State: AO0yUKVmE7kl5fE6yLdDkYzNrXRavQ/BB8olvbHg7qAiAmRbBoBJCNdv
        VBu0J2ErV+CTu0EKVw/uLxQ=
X-Google-Smtp-Source: AK7set+SfF/7IYY5GviCD1PQ1TFPd91rN8Dki0ogSFZXZligftSvL1B0QOl7tXj5CqIA7yNb8/V70g==
X-Received: by 2002:a05:600c:a0e:b0:3dd:1b02:23b7 with SMTP id z14-20020a05600c0a0e00b003dd1b0223b7mr4163860wmp.10.1675171510655;
        Tue, 31 Jan 2023 05:25:10 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003db03725e86sm15793911wmi.8.2023.01.31.05.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:25:10 -0800 (PST)
Message-ID: <575d0d40-4a23-20af-f8c3-221c8fb0be1a@gmail.com>
Date:   Tue, 31 Jan 2023 14:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 10/14] soc: mediatek: mtk-svs: move svs_platform_probe
 into probe
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
 <20230111074528.29354-11-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-11-roger.lu@mediatek.com>
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
> Moving svs_platform_probe into driver probe function will allow us to
> reduce svs_platform members. This will be done in a follow-up patch.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 354582825082..9d9210c22289 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2387,17 +2387,17 @@ static const struct of_device_id svs_of_match[] = {
>   	},
>   };
>   
> -static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
> +static int svs_probe(struct platform_device *pdev)
>   {
>   	struct svs_platform *svsp;
>   	const struct svs_platform_data *svsp_data;
> -	int ret;
> +	int ret, svsp_irq;
>   
>   	svsp_data = of_device_get_match_data(&pdev->dev);
>   
>   	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
>   	if (!svsp)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>   
>   	svsp->dev = &pdev->dev;
>   	svsp->name = svsp_data->name;
> @@ -2408,19 +2408,7 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
>   
>   	ret = svsp_data->probe(svsp);
>   	if (ret)
> -		return ERR_PTR(ret);
> -
> -	return svsp;
> -}
> -
> -static int svs_probe(struct platform_device *pdev)
> -{
> -	struct svs_platform *svsp;
> -	int svsp_irq, ret;
> -
> -	svsp = svs_platform_probe(pdev);
> -	if (IS_ERR(svsp))
> -		return PTR_ERR(svsp);
> +		return ret;
>   
>   	if (!svs_is_efuse_data_correct(svsp)) {
>   		dev_notice(svsp->dev, "efuse data isn't correct\n");
