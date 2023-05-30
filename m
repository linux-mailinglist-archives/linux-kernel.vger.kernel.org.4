Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD8715645
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjE3HMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE3HMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:12:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01ED90;
        Tue, 30 May 2023 00:12:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so26488965e9.3;
        Tue, 30 May 2023 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685430756; x=1688022756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhiYOnsYcT5eT162fH50ozvyNeO9MUK81ojzqXqppDY=;
        b=U83neCvrC1S8vKrCVu6eew6hp0L1KaCWdX+0LE6hOcZvfUkVF3y9EJvWzgJDTtj4Ed
         n4M3B8h4PCfuB2DdbM9zErpdK8206Dx8woGg27lb5kyuDd/yMjCclmDFb0stcl5A9UWr
         uxU4I0ObOSXW2BlMzr/L3HliTb6Cer24nlCyqV0T+CnIdOsQjgUMkP7IPCKsZtOZsven
         MTAhXEPrXhWWSAcCb6ySl6h7wipC2u9xKdiHnTDlgEtdSX6H2QLJ+9zxe03Pg7faC1AA
         1mb7c6alVJYHJJMUl5DqFW6S6/Wq8djM9+m2qXbk+Kd4QkPOn9ybxBr/AGWSu9KE7WP9
         kDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685430756; x=1688022756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhiYOnsYcT5eT162fH50ozvyNeO9MUK81ojzqXqppDY=;
        b=U8yt7+suts1fU19oJKBM0w+c7c8AF/2PHVr4O7PFYniji4JYW+riany/dzXYKYMUp6
         hHypJFfu4q+16aBMU/0WVuaZRk46r959CMET9md2ZR8CpsCcd1aW1mTIMx+/m7jXsTkC
         wKBxaoyd9NOd8P71tIQo/mJvt4NVfMrv0CP/1ztc+6qFmRiWmnNHAZI+iojzGE1XuUnT
         gapa9066uCM5u7VPNKThu8x0s0XAktiQxiUYYxEePgrX8KT/uBQGLPCjLLD4ve9wrkMP
         VmKGF8cfWVMPU3bRxgC58/jHPyvJaH5NzPsTyAlox4T8w+kdJg8hRNb3fz4I6G0HzaAp
         2fLQ==
X-Gm-Message-State: AC+VfDybh8EA7M7BTGvI3YJFNlwhSvqhD9DjTQy+quFPIwVQMDcRdHbI
        XVzCX012JymDUXUu18gDckQ=
X-Google-Smtp-Source: ACHHUZ4TXP7FM+FJLQx0g9zOkQnADdQ6DuE8ZawqR+xzm9uue4UInlabGeS+fHbG8n0MP2sy32jqHg==
X-Received: by 2002:a05:600c:21c7:b0:3f5:176:c398 with SMTP id x7-20020a05600c21c700b003f50176c398mr809351wmj.31.1685430756217;
        Tue, 30 May 2023 00:12:36 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003f080b2f9f4sm19926196wmi.27.2023.05.30.00.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 00:12:34 -0700 (PDT)
Message-ID: <34d3298c-7d50-468b-b8e6-36440ccc0790@gmail.com>
Date:   Tue, 30 May 2023 09:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192
 support
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230529164605.3552619-1-bero@baylibre.com>
 <20230529164605.3552619-4-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230529164605.3552619-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2023 18:46, Bernhard Rosenkränzer wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS Driver support for MT8192.
> 
> Co-developed-by : Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

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
