Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75AD6CA081
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjC0Jvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjC0Jvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:51:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB44206
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:51:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so4806747wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679910699;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dw1LG5rTwzXDNL719AXv6z2juGi0Us5LowRhvnwewB0=;
        b=kBrMSQqq20FQ8JmCbP6Cyj+53eKtSRwcXx7Etlok1GpZOMIY3IE58Une9sS2qzEa9j
         O4ZwXFGVniMDt35DmuHTKZmLrcUpyD0eUHCCROsY7Nn15E8kQ4KwojUMpDZ89JLiW62z
         o/s7mG/7JnnOdQfuu30EIv/op/KuXdOAvOt8T1PgEGE0P+QlOUbOCuq9GCGkNKVQ6OdI
         qyiSyu43O0lIoF5EjkzFUx5YpYPyvCjS+6ERcVBSdxMR0T00t9TRdLqc9WpGO83Y11/y
         EPH6eNpfDBaQcQDAH5vcoBxe61L9237RHoBOMT5lkbT54ZcrFkFuhC2EERYHPqcRsHir
         Dubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679910699;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dw1LG5rTwzXDNL719AXv6z2juGi0Us5LowRhvnwewB0=;
        b=Ro7TBmKMwOJ/S4nY6LIP+Zt/9GEnMKaYeLrvOfGSo6Ks/T60YUKomt6VOIvw0vRe0q
         p0oNiY46rMI1okAJFM4fiWck9D6U4e6M2/7vOp4Dk7oyI/8FY4mbjxx18TcLEVB1DJll
         SrNNFbpuDIA7iu6B5x6hxMXuib5qMhEUWa5FGWjXPidwrHPdb5AFYcsQ2uzInW1S7dDs
         GjEyUb+6O4ZMo/3x5j2RoWXhOHsTn4azbJ8km6JL+dj8u2gAT75K6Q7xI69kyR/qxtip
         neAwzeA8AFgktla51cXoEZ+Hq4ESwT8XgDc37p12BRmh64XUhzk2MgDsB2PI5831rMsW
         EVcg==
X-Gm-Message-State: AO0yUKWgFuJJFZZJqVqJDCjAn7AmmUsl4uhp6SnHalBv+ZKKQZlsX5Oa
        CgDs27LwcEqnolNCUE8EWKf1WQ==
X-Google-Smtp-Source: AK7set9PTgYDLsWSJMNeDj7o6fKvEl3jbnzCS+KtCELb+XLUymSkPmbCAVdFg+d634ftJfVGiIgmFw==
X-Received: by 2002:a7b:c008:0:b0:3eb:f59f:6daf with SMTP id c8-20020a7bc008000000b003ebf59f6dafmr8835221wmb.34.1679910699586;
        Mon, 27 Mar 2023 02:51:39 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b003ee1acdaf95sm8327789wmo.36.2023.03.27.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 02:51:39 -0700 (PDT)
Message-ID: <9fb414cc-fa4d-417e-7cad-111921595ef6@linaro.org>
Date:   Mon, 27 Mar 2023 11:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: it6505: Add range and selector_reg
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>, Robert Foss <rfoss@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kenneth.hung@ite.corp-partner.google.com,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
References: <20230327044804.3657551-1-hsinyi@chromium.org>
Organization: Linaro Developer Services
In-Reply-To: <20230327044804.3657551-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 06:48, Hsin-Yi Wang wrote:
> There are 2 banks on it6505, and when writing to different bank,
> REG_BANK_SEL needs to be set to the targeted bank. The current code set
> this additionally, which causes a race condition when a process is
> writing bank 0 registers while another process set the bank to 1. Set
> ranges in regmap config so the regmap API would handle the bank changes.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

It's aligned on how we did on it66121


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> ---
>   drivers/gpu/drm/bridge/ite-it6505.c | 34 +++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index bc451b2a77c28..abaf6e23775eb 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -258,12 +258,12 @@
>   #define REG_AUD_INFOFRAM_SUM 0xFB
>   
>   /* the following six registers are in bank1 */
> -#define REG_DRV_0_DB_800_MV 0x7E
> -#define REG_PRE_0_DB_800_MV 0x7F
> -#define REG_PRE_3P5_DB_800_MV 0x81
> -#define REG_SSC_CTRL0 0x88
> -#define REG_SSC_CTRL1 0x89
> -#define REG_SSC_CTRL2 0x8A
> +#define REG_DRV_0_DB_800_MV 0x17E
> +#define REG_PRE_0_DB_800_MV 0x17F
> +#define REG_PRE_3P5_DB_800_MV 0x181
> +#define REG_SSC_CTRL0 0x188
> +#define REG_SSC_CTRL1 0x189
> +#define REG_SSC_CTRL2 0x18A
>   
>   #define RBR DP_LINK_BW_1_62
>   #define HBR DP_LINK_BW_2_7
> @@ -489,7 +489,7 @@ static const struct it6505_audio_sample_rate_map audio_sample_rate_map[] = {
>   };
>   
>   static const struct regmap_range it6505_bridge_volatile_ranges[] = {
> -	{ .range_min = 0, .range_max = 0xFF },
> +	{ .range_min = 0, .range_max = 0x1FF },
>   };
>   
>   static const struct regmap_access_table it6505_bridge_volatile_table = {
> @@ -497,11 +497,27 @@ static const struct regmap_access_table it6505_bridge_volatile_table = {
>   	.n_yes_ranges = ARRAY_SIZE(it6505_bridge_volatile_ranges),
>   };
>   
> +static const struct regmap_range_cfg it6505_regmap_banks[] = {
> +	{
> +		.name = "it6505",
> +		.range_min = 0x00,
> +		.range_max = 0x1FF,
> +		.selector_reg = REG_BANK_SEL,
> +		.selector_mask = 0x1,
> +		.selector_shift = 0,
> +		.window_start = 0x00,
> +		.window_len = 0x100,
> +	},
> +};
> +
>   static const struct regmap_config it6505_regmap_config = {
>   	.reg_bits = 8,
>   	.val_bits = 8,
>   	.volatile_table = &it6505_bridge_volatile_table,
>   	.cache_type = REGCACHE_NONE,
> +	.ranges = it6505_regmap_banks,
> +	.num_ranges = ARRAY_SIZE(it6505_regmap_banks),
> +	.max_register = 0x1FF,
>   };
>   
>   static int it6505_read(struct it6505 *it6505, unsigned int reg_addr)
> @@ -1267,7 +1283,6 @@ static void it6505_init(struct it6505 *it6505)
>   	it6505_write(it6505, REG_TIME_STMP_CTRL,
>   		     EN_SSC_GAT | EN_ENHANCE_VID_STMP | EN_ENHANCE_AUD_STMP);
>   	it6505_write(it6505, REG_INFOFRAME_CTRL, 0x00);
> -	it6505_write(it6505, REG_BANK_SEL, 0x01);
>   	it6505_write(it6505, REG_DRV_0_DB_800_MV,
>   		     afe_setting_table[it6505->afe_setting][0]);
>   	it6505_write(it6505, REG_PRE_0_DB_800_MV,
> @@ -1277,7 +1292,6 @@ static void it6505_init(struct it6505 *it6505)
>   	it6505_write(it6505, REG_SSC_CTRL0, 0x9E);
>   	it6505_write(it6505, REG_SSC_CTRL1, 0x1C);
>   	it6505_write(it6505, REG_SSC_CTRL2, 0x42);
> -	it6505_write(it6505, REG_BANK_SEL, 0x00);
>   }
>   
>   static void it6505_video_disable(struct it6505 *it6505)
> @@ -1506,11 +1520,9 @@ static void it6505_setup_ssc(struct it6505 *it6505)
>   	it6505_set_bits(it6505, REG_TRAIN_CTRL0, SPREAD_AMP_5,
>   			it6505->enable_ssc ? SPREAD_AMP_5 : 0x00);
>   	if (it6505->enable_ssc) {
> -		it6505_write(it6505, REG_BANK_SEL, 0x01);
>   		it6505_write(it6505, REG_SSC_CTRL0, 0x9E);
>   		it6505_write(it6505, REG_SSC_CTRL1, 0x1C);
>   		it6505_write(it6505, REG_SSC_CTRL2, 0x42);
> -		it6505_write(it6505, REG_BANK_SEL, 0x00);
>   		it6505_write(it6505, REG_SP_CTRL0, 0x07);
>   		it6505_write(it6505, REG_IP_CTRL1, 0x29);
>   		it6505_write(it6505, REG_IP_CTRL2, 0x03);

