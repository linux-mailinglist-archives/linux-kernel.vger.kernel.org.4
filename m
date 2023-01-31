Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE76D682DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjAaNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjAaNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:25:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1942DE5;
        Tue, 31 Jan 2023 05:24:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k16so10337548wms.2;
        Tue, 31 Jan 2023 05:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfZfyT/Vvj+XVZkKWfK1JVlF+kIO3JnmZX9PXK0es3k=;
        b=YyzFmDzZYXunsXWpS+omE61fG+I6kwtrGZcleEGZjyd+s6DFwgv71lCGpJiqxrz7zC
         4TLlZGft167i58+Bt5gDYp6LnQE6d9iBpyPUxdx7D0jRUlzervAz9045RtJJLjjkP7G+
         h9cTDcoaiJ5mTCvg2ryGVIU7ID42L0En/eRnTQRdXyF5XQhZpVml1hdwDylNn4w4QNAw
         +d92gCbkBnr3BQl2Eut9JhfSxsDgekSn+AHU4Wq3JBF2bFWPShApmA6ZoJaLmaLs/0Su
         7dY0JuEDZvwVuJM9DwOWRc7rnc8SeY2yFQYWSflYRBi+pZgPiHo/Z6bb7XusKomPNyM2
         Nj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfZfyT/Vvj+XVZkKWfK1JVlF+kIO3JnmZX9PXK0es3k=;
        b=SA4yk736Z4+ww8PWsdrJGxN4+AwQLUpPjCzETv94/AvfeE7f3+pV0PjhHBSF6feAXb
         xRmR6XqwjXXZXBVj+wLWIHnwU4teZsxOuEgR1y2n8cdw7kuwad2yG/oPWpBZ3gXoldgI
         jYxKA552HHFLZClNqTelM0vyoHWUfOenvE8HJw5NG9L5wWApRKyFRZXxQdu/qXOhZrAd
         Xp6icOcgugXI+aWCiguzXH7YMczy+wQlR5BHwkB7T0S6awAfGXaZcBj05uRcvN9nsdQn
         pnro8n2Miw46STdGqFkV4BVV8LnVkEsraC//RG4npi1V5FV6vvd7HgHis+Wyy85ZVcYE
         IpgQ==
X-Gm-Message-State: AO0yUKVoUJiCFBt+pYiDmQAEk0tNhfrwH3P1fjjMWcYz3AKaUb4I3Nfl
        GvMymfcaW6FoVes8ZM5sQjE=
X-Google-Smtp-Source: AK7set8VL7QkCMInXUnEBkwTl1JaZ0iii2TwwlogkxDEyM9c8pDA647tjls+yCjV36AYJJkRGVPCQQ==
X-Received: by 2002:a05:600c:19d1:b0:3dc:1dc3:7a05 with SMTP id u17-20020a05600c19d100b003dc1dc37a05mr23396109wmq.10.1675171491939;
        Tue, 31 Jan 2023 05:24:51 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c254500b003dc47fb33dasm11446087wma.18.2023.01.31.05.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:24:51 -0800 (PST)
Message-ID: <6de52a34-2e59-4a9c-5c7f-b374676be987@gmail.com>
Date:   Tue, 31 Jan 2023 14:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 09/14] soc: mediatek: mtk-svs: improve readability of
 platform_probe
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
 <20230111074528.29354-10-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-10-roger.lu@mediatek.com>
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
> If a compatible misses a match data entry, then something is wrong in
> the development phase, we don't need to check for that at runtime.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 41c0ac5ed8d3..354582825082 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2394,10 +2394,6 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	svsp_data = of_device_get_match_data(&pdev->dev);
> -	if (!svsp_data) {
> -		dev_err(&pdev->dev, "no svs platform data?\n");
> -		return ERR_PTR(-EPERM);
> -	}
>   
>   	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
>   	if (!svsp)
