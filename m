Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E62693138
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBKNTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKNTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:19:13 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724C2386F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:19:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jg8so22047513ejc.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoCibpSqg2rz3F023zEQU7EC9jiWBnWIK3VDqI2xikw=;
        b=nN5YFYUg/UBSTsTyuYNbFNNjUAw4XYL1W8wijeqs6KHgCMJz5zjOLoi5txXFBfEUmA
         yPWeNpe0rBv7OkeDEoOjYttPq8OngGp1zdQnc13aos0XvDwEEVHu6NwXQeX3ScGVtr/h
         uFt/keHjYcQyz/ePck4cKiGGeOhiZaMNDvc7HNFlkirB2A0ISX8psje/UVkjoA9rdoym
         7nbQAcD/9alt2htUYhxx0RPvnVZC6YMsdYyY4ge3hJmAxyk7q4HzEkj0KYfpBnyV6ivg
         S1QjdhJJlozxi95oiWvlXCMUXjImE8IY4W4FsfIv/4siVypYQM0pY5J7/p0E/Y5SOaL0
         kS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoCibpSqg2rz3F023zEQU7EC9jiWBnWIK3VDqI2xikw=;
        b=l3tThHKc+yNIF8MSZtQrrBwHd0p6OFJol78a2+FIEsJTwQiXRuM4FqiQwnYzED+gjS
         7ksuoErzdq7oMtg8jTLY2CkeL8itnH04QOZqE8yNfLUdKu0qLeivI5l5TyydHVEi6JMy
         Yq20MZeGNtFuT7AF5SPlZ0SSpst1Rwa2hkA6STngLl6LSgnC7VuKnLs9sT0eBsHnFdXz
         R/gDaORlWjix9YsWz9m1G0OIBElK2csNjhdxoq781O+/7UWiR9yvtIriYAWHodbBF0LF
         nby/flr/Pg2c0FxamTwL9nMykp3zfrNH/584XoXD0U5IvCT1UVB1L8cb1k1We+pGpUco
         XwwA==
X-Gm-Message-State: AO0yUKVHM5UCVmsrHLB1Z82gnyQSdfcj6HyoQDk2mpicyaKJGQOhM3T6
        Tg40bWttVHCHZB/YfGOqVQSIxw==
X-Google-Smtp-Source: AK7set/QtagN9d/76+8jrm/L7TGfLWwfG7p4rczHRYj2w7dbNQAdsDmKkIIsucDulPPQoUOuyIpllA==
X-Received: by 2002:a17:907:720b:b0:8a5:8620:575 with SMTP id dr11-20020a170907720b00b008a586200575mr25527352ejc.3.1676121550728;
        Sat, 11 Feb 2023 05:19:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906469200b007c0f217aadbsm3819770ejr.24.2023.02.11.05.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 05:19:10 -0800 (PST)
Message-ID: <71b63ae5-1b2c-b0a9-913c-99b657133f0f@linaro.org>
Date:   Sat, 11 Feb 2023 15:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 03/10] drm/msm/dsi: Zero-terminate
 msm_dsi_config::io_start
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
 <20230211115110.1462920-4-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230211115110.1462920-4-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 13:51, Konrad Dybcio wrote:
> In preparation for supporting multiple sets of possible base registers,
> Zero-terminate the array that contains them to remove the need of
> specifying num_dsi for each set.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 39 ++++++++++--------------------
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  4 +--
>   drivers/gpu/drm/msm/dsi/dsi_host.c |  2 +-
>   3 files changed, 16 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 068d45b3a8f0..5f62c563bd1c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -22,9 +22,8 @@ static const struct msm_dsi_config apq8064_dsi_cfg = {
>   	.bus_clk_names = dsi_v2_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_v2_bus_clk_names),
>   	.io_start = {
> -		{ 0x4700000, 0x5800000 },
> +		{ 0x4700000, 0x5800000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const char * const dsi_6g_bus_clk_names[] = {
> @@ -44,9 +43,8 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
>   	.bus_clk_names = dsi_6g_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
>   	.io_start = {
> -		{ 0xfd922800, 0xfd922b00 },
> +		{ 0xfd922800, 0xfd922b00, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const char * const dsi_8916_bus_clk_names[] = {
> @@ -65,9 +63,8 @@ static const struct msm_dsi_config msm8916_dsi_cfg = {
>   	.bus_clk_names = dsi_8916_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_8916_bus_clk_names),
>   	.io_start = {
> -		{ 0x1a98000 },
> +		{ 0x1a98000, 0 },
>   	},
> -	.num_dsi = 1,
>   };
>   
>   static const char * const dsi_8976_bus_clk_names[] = {
> @@ -86,9 +83,8 @@ static const struct msm_dsi_config msm8976_dsi_cfg = {
>   	.bus_clk_names = dsi_8976_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_8976_bus_clk_names),
>   	.io_start = {
> -		{ 0x1a94000, 0x1a96000 },
> +		{ 0x1a94000, 0x1a96000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const struct regulator_bulk_data msm8994_dsi_regulators[] = {
> @@ -107,9 +103,8 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
>   	.bus_clk_names = dsi_6g_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
>   	.io_start = {
> -		{ 0xfd998000, 0xfd9a0000 },
> +		{ 0xfd998000, 0xfd9a0000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const char * const dsi_8996_bus_clk_names[] = {
> @@ -129,9 +124,8 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
>   	.bus_clk_names = dsi_8996_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_8996_bus_clk_names),
>   	.io_start = {
> -		{ 0x994000, 0x996000 },
> +		{ 0x994000, 0x996000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const char * const dsi_msm8998_bus_clk_names[] = {
> @@ -150,9 +144,8 @@ static const struct msm_dsi_config msm8998_dsi_cfg = {
>   	.bus_clk_names = dsi_msm8998_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_msm8998_bus_clk_names),
>   	.io_start = {
> -		{ 0xc994000, 0xc996000 },
> +		{ 0xc994000, 0xc996000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const char * const dsi_sdm660_bus_clk_names[] = {
> @@ -170,9 +163,8 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
>   	.bus_clk_names = dsi_sdm660_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sdm660_bus_clk_names),
>   	.io_start = {
> -		{ 0xc994000, 0xc996000 },
> +		{ 0xc994000, 0xc996000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const char * const dsi_sdm845_bus_clk_names[] = {
> @@ -194,9 +186,8 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
>   	.bus_clk_names = dsi_sdm845_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>   	.io_start = {
> -		{ 0xae94000, 0xae96000 },
> +		{ 0xae94000, 0xae96000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const struct regulator_bulk_data sm8550_dsi_regulators[] = {
> @@ -210,9 +201,8 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>   	.bus_clk_names = dsi_sdm845_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>   	.io_start = {
> -		{ 0xae94000, 0xae96000 },
> +		{ 0xae94000, 0xae96000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
> @@ -226,9 +216,8 @@ static const struct msm_dsi_config sc7180_dsi_cfg = {
>   	.bus_clk_names = dsi_sc7180_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sc7180_bus_clk_names),
>   	.io_start = {
> -		{ 0xae94000 },
> +		{ 0xae94000, 0 },
>   	},
> -	.num_dsi = 1,
>   };
>   
>   static const char * const dsi_sc7280_bus_clk_names[] = {
> @@ -246,9 +235,8 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>   	.bus_clk_names = dsi_sc7280_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
>   	.io_start = {
> -		{ 0xae94000, 0xae96000 },
> +		{ 0xae94000, 0xae96000, 0 },
>   	},
> -	.num_dsi = 2,
>   };
>   
>   static const char * const dsi_qcm2290_bus_clk_names[] = {
> @@ -266,9 +254,8 @@ static const struct msm_dsi_config qcm2290_dsi_cfg = {
>   	.bus_clk_names = dsi_qcm2290_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_qcm2290_bus_clk_names),
>   	.io_start = {
> -		{ 0x5e94000 },
> +		{ 0x5e94000, 0 },
>   	},
> -	.num_dsi = 1,
>   };
>   
>   static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index df9f09876ccb..03493cc6b772 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -41,8 +41,8 @@ struct msm_dsi_config {
>   	int num_regulators;
>   	const char * const *bus_clk_names;
>   	const int num_bus_clks;
> -	const resource_size_t io_start[VARIANTS_MAX][DSI_MAX];
> -	const int num_dsi;
> +	/* Allow + 1 entry for the zero-terminator */
> +	const resource_size_t io_start[VARIANTS_MAX][DSI_MAX + 1];
>   };
>   
>   struct msm_dsi_host_cfg_ops {
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 22ba8726b0ea..f5092b4d0757 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1868,7 +1868,7 @@ static int dsi_host_get_id(struct msm_dsi_host *msm_host)
>   	if (!res)
>   		return -EINVAL;
>   
> -	for (i = 0; i < cfg->num_dsi; i++) {
> +	for (i = 0; cfg->io_start[0][i]; i++) {
>   		if (cfg->io_start[0][i] == res->start)
>   			return i;
>   	}

I think we have the easier way to do this: always loop towards DSI_MAX. 
Empty cells will contain the value of 0 which can not match against 
valid starting address.

Also please shift this patch to the first place, it will be logical to 
add VARIANT_MAX after removing num_dsi.

-- 
With best wishes
Dmitry

