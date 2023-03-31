Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADFC6D1B59
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjCaJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjCaJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:07:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6021E721
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:06:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q19so18602756wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680253606;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n/qHDI2XATx2TdwwrGZWbe9ANXTDDjSuUckU4tumIIg=;
        b=hnrhqzRTrMQRhfBU8NZ73fIzzb4Zmbq3p6PCkrRBm9CxE2RxUcwt/22PASFM3iqAti
         oysh2iwzb70hD4b47BnDnOruFckF73k40iXKH3WeNHDuQ7ELCstnZr8ngccej7rNNklR
         lSaFYeMj+PyVdZGPWwbSslcySKbwlKsyX2tC+/+o2H1iVfn4ZEbgaIblJrEDVhNlGDXr
         +uK7jN1FxkgDP5KzhDCsaYtYNy7RWBNgo3FFPr2IsKhZgFCrUIjj7WJwsTJKmpzI0gwU
         3jrtEi1bzimgCSatXmRFGDfXFHukhR8czFIDhXqCUICwYrMlNyJ9ckEjMNyN9CnwU9xb
         hjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253606;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/qHDI2XATx2TdwwrGZWbe9ANXTDDjSuUckU4tumIIg=;
        b=1paKiu0GdpucPlDyUOj+LIObCGl1qo076F/y/UBl853Sg2bZnwxx6sU7b0T30KuPnP
         nZ3mFJ1+fP595iJc+PBeQYPs/fGnl9rBbRes2tyyXA6HCveE2hk1DWfrQ6mQufEhDljq
         /f+nuldjo2b4Pm/mkb3hAasjuR4hu8whb2kmKgT1xsTswNXJbpjKu1Kua8+oHJueearI
         NtvrU6t3s08uEiuD1SvR9EVlWMRmBFKtb/jxzISiNx0Mynd3358ZGuLZuqXFeEQhcPHn
         WQF16ICUueDjxnvpeG7I/aOyYiIbQeCqVFT1+2JzdHsVfP4EkGN9xwDSLFhlyTWgI+Tz
         TlDA==
X-Gm-Message-State: AAQBX9drNWVk/oOGIzHUcNqpOShmkFRS1+866J1gv99lOiGPs3aNuX0c
        55uHWo5NDZYATTvoYvluPlHEcA==
X-Google-Smtp-Source: AKy350aTrYnc9UuG9bJ66DZ/1QaY7OCh8DB9/Nw+qIDm2v5EajtM9gla/uJHB27+0JWtb6ZpZdpKbQ==
X-Received: by 2002:a05:6000:ca:b0:2d6:5afe:7b91 with SMTP id q10-20020a05600000ca00b002d65afe7b91mr6225734wrx.30.1680253606228;
        Fri, 31 Mar 2023 02:06:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:74cb:1a96:c994:e7e0? ([2a01:e0a:982:cbb0:74cb:1a96:c994:e7e0])
        by smtp.gmail.com with ESMTPSA id f9-20020adff989000000b002c71dd1109fsm1662892wrr.47.2023.03.31.02.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:06:45 -0700 (PDT)
Message-ID: <6a386ff3-2af6-a544-674f-7c60d4d89e4e@linaro.org>
Date:   Fri, 31 Mar 2023 11:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] drm/bridge: ti-sn65dsi83: Add DSI video mode
 configuration
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20230330101752.429804-1-francesco@dolcini.it>
 <20230330101752.429804-3-francesco@dolcini.it>
Organization: Linaro Developer Services
In-Reply-To: <20230330101752.429804-3-francesco@dolcini.it>
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

Hi,

On 30/03/2023 12:17, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Enable configuration of the DSI video mode instead of hard-coding
> MIPI_DSI_MODE_VIDEO_BURST. The bridge support any of burst-mode,
> non-burst with sync event or non-burst with sync pulse
> 
> With this change is possible to use the bridge with host DSI
> that do not support burst mode.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 91ecfbe45bf9..144d0de0d278 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -145,6 +145,7 @@ struct sn65dsi83 {
>   	struct drm_bridge		*panel_bridge;
>   	struct gpio_desc		*enable_gpio;
>   	struct regulator		*vcc;
> +	u32				dsi_video_mode;
>   	bool				lvds_dual_link;
>   	bool				lvds_dual_link_even_odd_swap;
>   };
> @@ -603,6 +604,9 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
>   		return dev_err_probe(dev, PTR_ERR(ctx->vcc),
>   				     "Failed to get supply 'vcc'\n");
>   
> +	ctx->dsi_video_mode = 0;
> +	of_property_read_u32(dev->of_node, "dsi-video-mode", &ctx->dsi_video_mode);
> +
>   	return 0;
>   }
>   
> @@ -642,7 +646,25 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
>   
>   	dsi->lanes = dsi_lanes;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
> +
> +	switch (ctx->dsi_video_mode) {
> +	case 0:
> +		/* burst mode */
> +		dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_BURST;
> +		break;
> +	case 1:
> +		/* non-burst mode with sync event */
> +		break;
> +	case 2:
> +		/* non-burst mode with sync pulse */
> +		dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +		break;
> +	default:
> +		dev_warn(dev, "invalid video mode %d\n", ctx->dsi_video_mode);
> +		break;
> +	}
> +
>   
>   	ret = devm_mipi_dsi_attach(dev, dsi);
>   	if (ret < 0) {

As I understand from DSI spec is that those are dynamic, so they are hardcoded in driver now
but they shouldn't be hardcoded in DT.

The problem is larger and we should add some sort of "supported features" we can get
from the DSI controller and set the flags accordingly because the features support accross the
DSI controllers isn't linear.

Neil

