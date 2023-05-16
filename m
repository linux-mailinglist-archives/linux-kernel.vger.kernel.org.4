Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD87A704641
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjEPHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjEPHYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:24:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0341FDA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:24:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090408e09bso2628681f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684221866; x=1686813866;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mriKUD+ePrXG2DRWD5gePTJ4sodjlKWYwwduKOxs8DI=;
        b=ST7RVOqLOXdhN4AiR9ZC4VSzODuLCFiQUdBe6NgMcrufpcWwPo6JVRYDK5b+vltIZP
         1kfmvNZ4dqGp0NINctE6TF4Uho6L+j7NuBrkGaybeHGliwi9c4ARwxdSfYI067feVfJ6
         PLs1SyMVNcrw2cVCuXKWzPQJ4tucHmRMrBQi0yNye/HqqcEl2JBTY79hrHoIbNA/VO/m
         8yx/rM9qno6IF7169ccBU5OoNTegeJqbnQXGOfD1IlaIcx+/FgsFkq020uoXm/H+r9WM
         DSdn34eAIwgarpCEaQs/evNpITPAlBQrwwxCkWgMqRaMIGDGbEV4vXE+kEoNifFU31+T
         WGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221866; x=1686813866;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mriKUD+ePrXG2DRWD5gePTJ4sodjlKWYwwduKOxs8DI=;
        b=PfJiyqdA+sqqsTrGWxwPbg+ngF9LqOKSp1k9j2MMr799bDs7tW8k6BVbbeAdYhV0SI
         620K3shR02GbyGqGugUyLhyz3hoNuf31DjxsvU8lm/KVPWM2iJ/QiP1MSTja4hCwQpsJ
         PdmkF6o90OZy3oFOyQonnphocn8i5RvdyRFV0dsuYbwabEShLzZxz4ij383xW5dMCo+K
         YVvOr+kUkXf1Xen62T7cd+6e1dIPsRAK1TA93ywv17r6R7+pq6+MRCk8p3WvtWcQOQ/t
         /QkY7UNBl4P4WyqC9pJKdvoyx9FXuO3PA/rxuQ5ml/UyzLvgMzBDXaYFLh9vL8k/KK7K
         S4ZQ==
X-Gm-Message-State: AC+VfDxObsEgV1gg6oB0GvFgs0mF/8Z88VJIz1aWb8LhDtjiPqf9C27Z
        DY4nJ+MKRUFNPl4+Eceddh0o7Q==
X-Google-Smtp-Source: ACHHUZ5eFVgdU2s3k3MqpDCk0kG6vETBeL0nlTrXDSSeUAK0qUoOayOQCHMXkBKW56cq1tLSWvBWMQ==
X-Received: by 2002:adf:f245:0:b0:306:2d28:d556 with SMTP id b5-20020adff245000000b003062d28d556mr22320151wrp.34.1684221866463;
        Tue, 16 May 2023 00:24:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:86be:97a:a043:77a8? ([2a01:e0a:982:cbb0:86be:97a:a043:77a8])
        by smtp.gmail.com with ESMTPSA id r7-20020adff107000000b003012030a0c6sm1548409wro.18.2023.05.16.00.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:24:25 -0700 (PDT)
Message-ID: <b43f0808-8ac8-746f-6cbc-5396722261aa@linaro.org>
Date:   Tue, 16 May 2023 09:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 4/8] drm/bridge: mhdp8546: Set input_bus_flags from
 atomic_check
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230509093036.3303-1-a-bhatia1@ti.com>
 <20230509093036.3303-5-a-bhatia1@ti.com>
Organization: Linaro Developer Services
In-Reply-To: <20230509093036.3303-5-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 11:30, Aradhya Bhatia wrote:
> From: Nikhil Devshatwar <nikhil.nd@ti.com>
> 
> input_bus_flags are specified in drm_bridge_timings (legacy) as well
> as drm_bridge_state->input_bus_cfg.flags
> 
> The flags from the timings will be deprecated. Bridges are supposed
> to validate and set the bridge state flags from atomic_check.
> 
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> [a-bhatia1: replace timings in cdns_mhdp_platform_info by input_bus_flags]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
> 
> Notes:
> 
>      changes from v5:
>      * removed the wrongly addded return statement in tfp410 driver.
>      * replaced the timings field in cdns_mhdp_platform_info by
>        input_bus_flags field, in order to get rid of bridge->timings
>        altogether.
> 
>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c  | 11 ++++++++---
>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h  |  2 +-
>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c |  9 ++++-----
>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h |  2 +-
>   4 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 623e4235c94f..a677b1267525 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2189,6 +2189,13 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * There might be flags negotiation supported in future.
> +	 * Set the bus flags in atomic_check statically for now.
> +	 */
> +	if (mhdp->info)
> +		bridge_state->input_bus_cfg.flags = *mhdp->info->input_bus_flags;
> +
>   	mutex_unlock(&mhdp->link_mutex);
>   	return 0;
>   }
> @@ -2554,8 +2561,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>   	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
>   			   DRM_BRIDGE_OP_HPD;
>   	mhdp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
> -	if (mhdp->info)
> -		mhdp->bridge.timings = mhdp->info->timings;

Won't this cause a breakage because at this point in time bridge.timings->input_bus_flags
seems to be still used by tidss right ?

Neil

>   
>   	ret = phy_init(mhdp->phy);
>   	if (ret) {
> @@ -2642,7 +2647,7 @@ static const struct of_device_id mhdp_ids[] = {
>   #ifdef CONFIG_DRM_CDNS_MHDP8546_J721E
>   	{ .compatible = "ti,j721e-mhdp8546",
>   	  .data = &(const struct cdns_mhdp_platform_info) {
> -		  .timings = &mhdp_ti_j721e_bridge_timings,
> +		  .input_bus_flags = &mhdp_ti_j721e_bridge_input_bus_flags,
>   		  .ops = &mhdp_ti_j721e_ops,
>   	  },
>   	},
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> index bedddd510d17..bad2fc0c7306 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> @@ -336,7 +336,7 @@ struct cdns_mhdp_bridge_state {
>   };
>   
>   struct cdns_mhdp_platform_info {
> -	const struct drm_bridge_timings *timings;
> +	const u32 *input_bus_flags;
>   	const struct mhdp_platform_ops *ops;
>   };
>   
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
> index dfe1b59514f7..12d04be4e242 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
> @@ -71,8 +71,7 @@ const struct mhdp_platform_ops mhdp_ti_j721e_ops = {
>   	.disable = cdns_mhdp_j721e_disable,
>   };
>   
> -const struct drm_bridge_timings mhdp_ti_j721e_bridge_timings = {
> -	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> -			   DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
> -			   DRM_BUS_FLAG_DE_HIGH,
> -};
> +const u32
> +mhdp_ti_j721e_bridge_input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +				       DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
> +				       DRM_BUS_FLAG_DE_HIGH;
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
> index 97d20d115a24..5ddca07a4255 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
> @@ -14,6 +14,6 @@
>   struct mhdp_platform_ops;
>   
>   extern const struct mhdp_platform_ops mhdp_ti_j721e_ops;
> -extern const struct drm_bridge_timings mhdp_ti_j721e_bridge_timings;
> +extern const u32 mhdp_ti_j721e_bridge_input_bus_flags;
>   
>   #endif /* !CDNS_MHDP8546_J721E_H */

