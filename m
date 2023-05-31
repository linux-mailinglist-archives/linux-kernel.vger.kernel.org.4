Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BEC7179A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjEaIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjEaIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:07:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E910F93;
        Wed, 31 May 2023 01:07:54 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FC7A6605840;
        Wed, 31 May 2023 09:07:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685520473;
        bh=syibSnSgVW/WgKtMEucS9UFVkWbwc3QJ4w7wcrUGNe4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lGTUTiov8cdSlXACf27Y27u3DUVUgRr0kpNk+qIvvL+OolmBZtQ5wUXE+v3DjRU9O
         vWfsHEwq/zp3+cCXfiHECRqp1uP39YNqAezjOLeQrHnrHYkVQzhnc55JK/gBGr95jw
         7qBUfGooI++rwUhkA+1B80kDqk6jYZy3aWgYDqTi5vi7MTUaGsQuAfz7MrWjtp/F5t
         bgNwAX3vYymrSOQMnz2ekb+i3RcXVcXbNyfwzZXb8BO5a+6RqQOj10kDxU0JV77vbT
         CBMMXdTbwSMdNNmdRc52NwUdcM+u0c1T2XUO+1n+iQJUUb/qkSlOLvh/fG7gg/da7a
         wEb3FxVeQmvWg==
Message-ID: <7acba6fc-e1f7-8711-cf4a-2c24b2ccaf36@collabora.com>
Date:   Wed, 31 May 2023 10:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192
 support
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <20230530195132.2286163-4-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230530195132.2286163-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/23 21:51, Bernhard Rosenkränzer ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS Driver support for MT8192.
> 
> Co-developed-by : Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 95 +++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 5ea8a9d569ea6..d5e5214784ece 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -80,6 +80,7 @@
>   #define LVTS_MSR_FILTERED_MODE		1
>   
>   #define LVTS_HW_SHUTDOWN_MT8195		105000
> +#define LVTS_HW_SHUTDOWN_MT8192		105000
>   
>   static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
>   static int coeff_b = LVTS_COEFF_B;
> @@ -1280,6 +1281,88 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
>   	}
>   };
>   
> +static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
> +	{
> +		.cal_offset = { 0x04, 0x08 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_MCU_BIG_CPU0 },
> +			{ .dt_id = MT8192_MCU_BIG_CPU1 }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x0,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	},
> +	{
> +		.cal_offset = { 0x0c, 0x10 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_MCU_BIG_CPU2 },
> +			{ .dt_id = MT8192_MCU_BIG_CPU3 }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x100,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	},
> +	{
> +		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_MCU_LITTLE_CPU0 },
> +			{ .dt_id = MT8192_MCU_LITTLE_CPU1 },
> +			{ .dt_id = MT8192_MCU_LITTLE_CPU2 },
> +			{ .dt_id = MT8192_MCU_LITTLE_CPU3 }
> +		},
> +		.num_lvts_sensor = 4,
> +		.offset = 0x200,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	}
> +};
> +
> +static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
> +		{
> +		.cal_offset = { 0x24, 0x28 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_AP_VPU0 },
> +			{ .dt_id = MT8192_AP_VPU1 }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x0,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
> +	},
> +	{
> +		.cal_offset = { 0x2c, 0x30 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_AP_GPU0 },
> +			{ .dt_id = MT8192_AP_GPU1 }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x100,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,

I'm unable to get readings for the GPU sensors, didn't really check
the others; `cat (xxxx)` gives a resource not available error, is that
the same for you?!

Regards,
Angelo

> +	},
> +	{
> +		.cal_offset = { 0x34, 0x38 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_AP_INFRA },
> +			{ .dt_id = MT8192_AP_CAM },
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x200,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
> +	},
> +	{
> +		.cal_offset = { 0x3c, 0x40, 0x44 },
> +		.lvts_sensor = {
> +			{ .dt_id = MT8192_AP_MD0 },
> +			{ .dt_id = MT8192_AP_MD1 },
> +			{ .dt_id = MT8192_AP_MD2 }
> +		},
> +		.num_lvts_sensor = 3,
> +		.offset = 0x300,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
> +	}
> +};
> +
>   static const struct lvts_data mt8195_lvts_mcu_data = {
>   	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
>   	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
> @@ -1290,9 +1373,21 @@ static const struct lvts_data mt8195_lvts_ap_data = {
>   	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
>   };
>   
> +static const struct lvts_data mt8192_lvts_mcu_data = {
> +	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
> +	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
> +};
> +
> +static const struct lvts_data mt8192_lvts_ap_data = {
> +	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
> +	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
> +};
> +
>   static const struct of_device_id lvts_of_match[] = {
>   	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
>   	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
> +	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
> +	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, lvts_of_match);


