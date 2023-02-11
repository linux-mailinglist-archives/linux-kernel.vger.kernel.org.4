Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB50693134
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBKNRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:17:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A02FCFF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:17:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hx15so21974500ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hnPlrmBySkYBFU7owUqg2j/7POIVQjuCzNJqWFwOZI=;
        b=a1Z0sVdmW6lOeW2Z2tapf8svdqOSHLS3oVLC7eZscpV9wNDIlcyU11YNLh9hIAEhYm
         HqLiatCEGBPYxSdymhVix2yeDfJ6DHCThOdu/qrH8+JL1f+IFICBvtQKEbVFNIG6oEji
         FAroGl/7Kujl+7o4rHvkdK6ZlEJzrSlduQJgTs+E1z1gANQsk2NqElaam6aG1ea/jpvo
         HTGuBLiWCpFUYEpc4TtO9DY28dlwrY25UhlQpsauErnbyCX86q3NJVL/7s/+mqQOoCaB
         ubrVJmK5OxHmGXCsu0anojo9qZILkzCAj7QerWOYCz5nP3K+n3zEBMOkHkOpBZyCMY8Y
         aBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hnPlrmBySkYBFU7owUqg2j/7POIVQjuCzNJqWFwOZI=;
        b=x/xtn3dqeS9piYyeHgF4JIyi77O6ied8vE/CebKdrTohShqRo7PHcmobIbpBHogrYu
         fJGioI6l9MZTIVQDG2kc/pms38fCrhBPAY06/YTrmdWTfHc3czORGK8BlVcTon2VajdC
         EE0JRZYfaoBmmJVxsZSF9mhf3SBgq7yU/ugab4HbvumfcdjN7INIbbCm96XV2TqNuJ9P
         ea66pigMbNoS5Wpl5afQ2s/e8QkqxwzGoQSO0sHUUi06FFABafnrY4LdsZFuLR0OH6nN
         oj2oN/tjxFwMPRWVQv69yta6EMZ05P/LdycrXfNRdrx0qkEOleJ2C0zZ44eNkyQEGCr5
         rw+Q==
X-Gm-Message-State: AO0yUKUdCXyId5iRMXSSu1NNn2AsNuXvx4b0CaIuzyNufAKmRv5kJY/z
        wndXUNnitaUwD7etlzigI+CdXw==
X-Google-Smtp-Source: AK7set+gaHmF3yQEmHq6oB//dcVYWSPLpZv8707Pl4fg5sojad4cNB5Q8ONNtKB092zH2KWZ6QbalQ==
X-Received: by 2002:a17:906:dc89:b0:8af:54d0:181d with SMTP id cs9-20020a170906dc8900b008af54d0181dmr6025468ejc.35.1676121427184;
        Sat, 11 Feb 2023 05:17:07 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060dc900b0088c804c4ae2sm3789201eji.201.2023.02.11.05.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 05:17:06 -0800 (PST)
Message-ID: <4748cb49-0a17-2839-f99b-7578c0a4354b@linaro.org>
Date:   Sat, 11 Feb 2023 15:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/10] drm/msm/dsi: Turn msm_dsi_config::io_start into a
 2d array
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
 <20230211115110.1462920-3-konrad.dybcio@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230211115110.1462920-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 13:51, Konrad Dybcio wrote:
> Currently, we allow for MAX_DSI entries in io_start to facilitate for
> MAX_DSI number of DSI hosts at different addresses. The configuration
> is matched against the DSI CTRL hardware revision read back from the
> component. We need a way to resolve situations where multiple SoCs
> with different register maps may use the same version of DSI CTRL. In
> preparation to do so, make msm_dsi_config a 2d array where each entry
> represents a set of configurations adequate for a given SoC.
> 
> This is totally fine to do, as the only differentiating factors
> between same-version-different-SoCs configurations are the number of
> DSI hosts (1 or 2, at least as of today) and the set of registers.

s/set of registers/starting address/ ?

> The regulator setup is the same, because the DSI hardware is the same,
> regardless of the SoC it was implemented in.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 52 ++++++++++++++++++++++--------
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  5 ++-
>   drivers/gpu/drm/msm/dsi/dsi_host.c |  2 +-
>   3 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 6d21f0b33411..068d45b3a8f0 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -21,7 +21,9 @@ static const struct msm_dsi_config apq8064_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(apq8064_dsi_regulators),
>   	.bus_clk_names = dsi_v2_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_v2_bus_clk_names),
> -	.io_start = { 0x4700000, 0x5800000 },
> +	.io_start = {
> +		{ 0x4700000, 0x5800000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -41,7 +43,9 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(msm8974_apq8084_regulators),
>   	.bus_clk_names = dsi_6g_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
> -	.io_start = { 0xfd922800, 0xfd922b00 },
> +	.io_start = {
> +		{ 0xfd922800, 0xfd922b00 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -60,7 +64,9 @@ static const struct msm_dsi_config msm8916_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(msm8916_dsi_regulators),
>   	.bus_clk_names = dsi_8916_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_8916_bus_clk_names),
> -	.io_start = { 0x1a98000 },
> +	.io_start = {
> +		{ 0x1a98000 },
> +	},
>   	.num_dsi = 1,
>   };
>   
> @@ -79,7 +85,9 @@ static const struct msm_dsi_config msm8976_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(msm8976_dsi_regulators),
>   	.bus_clk_names = dsi_8976_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_8976_bus_clk_names),
> -	.io_start = { 0x1a94000, 0x1a96000 },
> +	.io_start = {
> +		{ 0x1a94000, 0x1a96000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -98,7 +106,9 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(msm8994_dsi_regulators),
>   	.bus_clk_names = dsi_6g_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
> -	.io_start = { 0xfd998000, 0xfd9a0000 },
> +	.io_start = {
> +		{ 0xfd998000, 0xfd9a0000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -118,7 +128,9 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(msm8996_dsi_regulators),
>   	.bus_clk_names = dsi_8996_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_8996_bus_clk_names),
> -	.io_start = { 0x994000, 0x996000 },
> +	.io_start = {
> +		{ 0x994000, 0x996000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -137,7 +149,9 @@ static const struct msm_dsi_config msm8998_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(msm8998_dsi_regulators),
>   	.bus_clk_names = dsi_msm8998_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_msm8998_bus_clk_names),
> -	.io_start = { 0xc994000, 0xc996000 },
> +	.io_start = {
> +		{ 0xc994000, 0xc996000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -155,7 +169,9 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(sdm660_dsi_regulators),
>   	.bus_clk_names = dsi_sdm660_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sdm660_bus_clk_names),
> -	.io_start = { 0xc994000, 0xc996000 },
> +	.io_start = {
> +		{ 0xc994000, 0xc996000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -177,7 +193,9 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(sdm845_dsi_regulators),
>   	.bus_clk_names = dsi_sdm845_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
> -	.io_start = { 0xae94000, 0xae96000 },
> +	.io_start = {
> +		{ 0xae94000, 0xae96000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -191,7 +209,9 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(sm8550_dsi_regulators),
>   	.bus_clk_names = dsi_sdm845_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
> -	.io_start = { 0xae94000, 0xae96000 },
> +	.io_start = {
> +		{ 0xae94000, 0xae96000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -205,7 +225,9 @@ static const struct msm_dsi_config sc7180_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(sc7180_dsi_regulators),
>   	.bus_clk_names = dsi_sc7180_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sc7180_bus_clk_names),
> -	.io_start = { 0xae94000 },
> +	.io_start = {
> +		{ 0xae94000 },
> +	},
>   	.num_dsi = 1,
>   };
>   
> @@ -223,7 +245,9 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(sc7280_dsi_regulators),
>   	.bus_clk_names = dsi_sc7280_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
> -	.io_start = { 0xae94000, 0xae96000 },
> +	.io_start = {
> +		{ 0xae94000, 0xae96000 },
> +	},
>   	.num_dsi = 2,
>   };
>   
> @@ -241,7 +265,9 @@ static const struct msm_dsi_config qcm2290_dsi_cfg = {
>   	.num_regulators = ARRAY_SIZE(qcm2290_dsi_cfg_regulators),
>   	.bus_clk_names = dsi_qcm2290_bus_clk_names,
>   	.num_bus_clks = ARRAY_SIZE(dsi_qcm2290_bus_clk_names),
> -	.io_start = { 0x5e94000 },
> +	.io_start = {
> +		{ 0x5e94000 },
> +	},
>   	.num_dsi = 1,
>   };
>   
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 44be4a88aa83..df9f09876ccb 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -32,13 +32,16 @@
>   
>   #define DSI_6G_REG_SHIFT	4
>   
> +/* Maximum number of configurations matched against the same hw revision */
> +#define VARIANTS_MAX			2
> +
>   struct msm_dsi_config {
>   	u32 io_offset;
>   	const struct regulator_bulk_data *regulator_data;
>   	int num_regulators;
>   	const char * const *bus_clk_names;
>   	const int num_bus_clks;
> -	const resource_size_t io_start[DSI_MAX];
> +	const resource_size_t io_start[VARIANTS_MAX][DSI_MAX];
>   	const int num_dsi;
>   };
>   
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 18fa30e1e858..22ba8726b0ea 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1869,7 +1869,7 @@ static int dsi_host_get_id(struct msm_dsi_host *msm_host)
>   		return -EINVAL;
>   
>   	for (i = 0; i < cfg->num_dsi; i++) {
> -		if (cfg->io_start[i] == res->start)
> +		if (cfg->io_start[0][i] == res->start)
>   			return i;
>   	}
>   

-- 
With best wishes
Dmitry

