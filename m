Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD60717F47
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjEaLzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjEaLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:55:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556E9D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:55:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-309382efe13so4207221f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685534150; x=1688126150;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WEd36hy3ThKcCMH7ZROUO7i+4T8Tnu5cbXYxxpHoTZ4=;
        b=HjcxddE0x6MCnxfyBMOC8XOYj6XdEjqr/ESEz9M5yOwpl4YJnPdYHvvV1iqIf3v21E
         O9ewxMjGP7NGtBImWjcISEUrHrio3Df39lB+Cqnmtp5B79ddpZXtXaD5GlsqmArbUBlD
         cCRJk8hnW+Le5/VATO8eqvi8km/jw3x43GUGivLxu8ziY5DzV3pJBce7bZnv4+U9U/7/
         JrB56aFQdMRyP18ac2OjG/VKp1d6mGkc9dA3KW7fRBDyxRQIiMv4M7Mlt8tN5YJqWlFE
         Cgnd7NG5SIlBkYR23/fdurP7Y+irjhmM9aDCnSNeP6JSEef+q4nLMap55fEYOeeTsbGM
         6QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685534150; x=1688126150;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEd36hy3ThKcCMH7ZROUO7i+4T8Tnu5cbXYxxpHoTZ4=;
        b=gg2ZN5RgyXWhX6cRwkzpqOCk0SGV/xtJmgjzfzaStMH9doGMAW4lDcCDp9sOl9zNPy
         NdIDeWAEZEsbBa6qiYaXJXB11VyVFIWw5HGI16zPpgQgzSmKgM79duV365itSpp+Uu2E
         wul2vgsFwyjCDnqee2n6tNUhUAf9ms37Y09gHG/ONMQAMjLCteZ6R4tAYG6JAqz6HRZd
         KNtf/XbIrPFO98vgj/ot+OnJQq/kOTPQqc0cvBeUVq9I3pgvrSI+/IWUQWmrFHYoGpbP
         OEBaUVHVp9lLLQ75wB5oK/qyzB035Qumg3Y08xd16Hy0tu1DvRkpdWbfPl0uXYevLhFX
         mzFA==
X-Gm-Message-State: AC+VfDyxDhQv5cCQkNX/Im9c1xvR0WFMwYeGGj8wBqmydRKn5EaZcefx
        VlMDM5GKSIKwvBXrzhCp7vqWyQ==
X-Google-Smtp-Source: ACHHUZ6kI8X8NP8AILCSybWYqTSH9EIv2i0NCD4qX88A8syY5ugQq66sKeWBuq74lTYGATWVWvPxRA==
X-Received: by 2002:a5d:448b:0:b0:306:3e96:6c5f with SMTP id j11-20020a5d448b000000b003063e966c5fmr4104805wrq.15.1685534149989;
        Wed, 31 May 2023 04:55:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5c28:3ad5:fcda:7779? ([2a01:e0a:982:cbb0:5c28:3ad5:fcda:7779])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b0030903371ef9sm6562204wrv.22.2023.05.31.04.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 04:55:49 -0700 (PDT)
Message-ID: <f7ef5cda-9372-17ed-89db-2f857b4d5971@linaro.org>
Date:   Wed, 31 May 2023 13:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] gpu: drm/panel: Optimize the workflow of s6d7aa0_lock
To:     Lu Hongfei <luhongfei@vivo.com>,
        Artur Weber <aweber.kernel@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230531110717.36896-1-luhongfei@vivo.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20230531110717.36896-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/05/2023 13:07, Lu Hongfei wrote:
> This patch optimized s6d7aa0_lock's workflow.
> Once mipi_dsi_dcs_write_seq failed, s6d7aa0_lock return immediately
> and no further actions will be taken.
> 
> Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 30 ++++++++++++++-----
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index 102e1fc7ee38..f98df32d1c55
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -69,15 +69,29 @@ static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>   	int ret = 0;
>   
>   	if (lock) {
> -		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> -		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0xa5, 0xa5);
> -		if (ctx->desc->use_passwd3)
> -			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0x5a, 0x5a);
> +		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> +		if (ret < 0)
> +			return ret;

mipi_dsi_dcs_write_seq() is a macro that already calls "return ret" on error,
so this is wrong, and there's nothing wrong with the currently upstream driver.

Neil

> +		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0xa5, 0xa5);
> +		if (ret < 0)
> +			return ret;
> +		if (ctx->desc->use_passwd3) {
> +			ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0x5a, 0x5a);
> +			if (ret < 0)
> +				return ret;
> +		}
>   	} else {
> -		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
> -		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0x5a, 0x5a);
> -		if (ctx->desc->use_passwd3)
> -			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
> +		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
> +		if (ret < 0)
> +			return ret;
> +		ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0x5a, 0x5a);
> +		if (ret < 0)
> +			return ret;
> +		if (ctx->desc->use_passwd3) {
> +			ret = mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
> +			if (ret < 0)
> +				return ret;
> +		}
>   	}
>   
>   	return ret;

