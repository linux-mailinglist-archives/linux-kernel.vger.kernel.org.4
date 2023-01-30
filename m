Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966F2680BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjA3L2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjA3L2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:28:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC1C31E03;
        Mon, 30 Jan 2023 03:28:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso2923562wms.5;
        Mon, 30 Jan 2023 03:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGao7bFNvayRLXYx+1NJAmEJ9xV7NpkTyTJLNdomiEY=;
        b=awYjgw8Ey+gXsNO+2+7zD6fJ9bbqNMH/gNO548BB9Kz1+2anZVVtWbhdudmAF55fy0
         OHZcn3DUgKKkwGtQbs+Z1xYWf+I+/u8IdMhzQOgbNm4dyxpG8AQJ4Z9qFCYPCUFFtf4F
         onQv92SJnk4i5Os1qTRN9Jg+b+kxTe029QuoQyCfG5Nh8PDkMhrDw6HVyjsyhKThxT32
         i3tm+BGCFlE2BTQWuk9dHXjdKAaiKTq/5lWPS0Y1S64XlOIoXBgDjiyRV1ot4X3QqWqA
         mLjX3M9ai0pLX0Sy0l4TFV4+l5VYvGzT2u2t/vwFfosrjic6XUazi2qN6HGyrDO+gl5/
         4rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGao7bFNvayRLXYx+1NJAmEJ9xV7NpkTyTJLNdomiEY=;
        b=EwppzRJXZ0g0fJV22trZpxmtAltkGdCghxZVj2Ay2ADKc7cggLwW0E0xMBuPvtdybv
         rYMdboiyfBkcQRrmfS8mkEiTdKtKt/RfiZvcEU3qaKN1zf1jbrQRPXF238sNOXQKWJrT
         DaXV+UcKpVnct33zPOBIDDuP6O+5yIgoe+5bjZw100Nv3QfhsPP34XQkoCcXRD+n2mVF
         Ulm9XmKj4hJh41AOGjP+okJAA/KV9aHgYQFG5Gadfah1uYDVoRhk6KaoTvK51kDxPlwQ
         Os3646V9qAwXZ3a3gQnU1yHm1dTUdI/SiAWBK20aRWZbjZZhyS1Q2tNtfuV0lQxYSCCZ
         RVaQ==
X-Gm-Message-State: AFqh2koxppZKNSQBQcIAbSR3NuHTBksoJmY0964tmm/qUhBDANSndKMt
        lHMu0TYqtZFW2ksduRBiYhI=
X-Google-Smtp-Source: AMrXdXuqwouNavCIzGS+zCP5ZhZ28lH6UR0DubxAWdWEi0qJwi71JGL+LChymyRIdN59GMOrNnlUrg==
X-Received: by 2002:a05:600c:4e4b:b0:3db:2e6d:9f79 with SMTP id e11-20020a05600c4e4b00b003db2e6d9f79mr37379881wmq.39.1675078100854;
        Mon, 30 Jan 2023 03:28:20 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003dafbd859a6sm15943157wmb.43.2023.01.30.03.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:28:20 -0800 (PST)
Message-ID: <3e88c585-5d45-7183-db50-030415bac9da@gmail.com>
Date:   Mon, 30 Jan 2023 12:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 4/4] soc: mediatek: mmsys: add support for MT8195
 VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-5-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118031509.29834-5-moudy.ho@mediatek.com>
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



On 18/01/2023 04:15, Moudy Ho wrote:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> Add MT8195 VPPSYS0 and VPPSYS1 driver data.
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 22 ++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.h |  1 +
>   2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 38f1dd92e7c6..176fdc866e22 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -88,6 +88,16 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data = {
>   	.num_routes = ARRAY_SIZE(mmsys_mt8195_routing_table),
>   };
>   
> +static const struct mtk_mmsys_driver_data mt8195_vppsys0_driver_data = {
> +	.clk_driver = "clk-mt8195-vpp0",
> +	.is_vppsys = true,
> +};
> +
> +static const struct mtk_mmsys_driver_data mt8195_vppsys1_driver_data = {
> +	.clk_driver = "clk-mt8195-vpp1",
> +	.is_vppsys = true,
> +};
> +
>   static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8365-mm",
>   	.routes = mt8365_mmsys_routing_table,
> @@ -264,6 +274,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   	if (IS_ERR(clks))
>   		return PTR_ERR(clks);
>   
> +	if (mmsys->data->is_vppsys)
> +		goto out_probe_done;
> +
>   	drm = platform_device_register_data(&pdev->dev, "mediatek-drm",
>   					    PLATFORM_DEVID_AUTO, NULL, 0);
>   	if (IS_ERR(drm)) {
> @@ -271,6 +284,7 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   		return PTR_ERR(drm);
>   	}
>   
> +out_probe_done:
>   	return 0;
>   }
>   
> @@ -323,6 +337,14 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>   		.compatible = "mediatek,mt8195-vdosys0",
>   		.data = &mt8195_vdosys0_driver_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt8195-vppsys0",
> +		.data = &mt8195_vppsys0_driver_data,
> +	},
> +	{
> +		.compatible = "mediatek,mt8195-vppsys1",
> +		.data = &mt8195_vppsys1_driver_data,
> +	},
>   	{
>   		.compatible = "mediatek,mt8365-mmsys",
>   		.data = &mt8365_mmsys_driver_data,
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index 77f37f8c715b..54a96b83afb4 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -91,6 +91,7 @@ struct mtk_mmsys_driver_data {
>   	const struct mtk_mmsys_routes *routes;
>   	const unsigned int num_routes;
>   	const u16 sw0_rst_offset;
> +	const bool is_vppsys;
>   };
>   
>   /*
