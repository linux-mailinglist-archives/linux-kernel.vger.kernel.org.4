Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B690E70467C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjEPHdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjEPHdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:33:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0D46A0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:33:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4ad71b00eso42950015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684222414; x=1686814414;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P1CBJQZk3nGmqnh1NX99wMR8/HbaWCbVhluByi1E/gg=;
        b=pMUTGbpAVkJpZjmzKAwmaGe0oxW+idx19mZBzGO8T7sASsXGOoszO7B9g24JwqctTg
         Q/C+mLYjgX3HmsYGFYXv66qaTGxhfovd9fZKGXUOPhO+IyF+waGh7wERbv8FSpqwaqJU
         WWjwvSn3twE+l36M2A4x1HzAlDIdjL0KN/y6tlO6t3bjFSz4Mg8fSQj9X4N9DvvmC2/7
         M4/qpi4jxvX6ZlqfoO4H4+vJMy6k/rFKxVi6ttQaUWU9wTrA9d274OuHjDoup0SaudzR
         hfJCJHNPZXqnhxDujYeFK6LY6JtevZ6s8jqmq6jJ9XHw3UbTFE1KU/movbkrq65O8Bpb
         5s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222414; x=1686814414;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1CBJQZk3nGmqnh1NX99wMR8/HbaWCbVhluByi1E/gg=;
        b=YSoEuaTqZgsAoJ6JpExe3mB3/9mdy1f8zdtnCclYjJeYc4oRiMCfMyBiZAmWJ8TJu0
         w+1aplXCW/Bv2cNNmeD01L3e0RL+qt/qCVxvAOvNO/Xt4oAgWTTRNCeVwLv44kTGIoVu
         3VzjqVTAW1qyfaMWcI4kzeXXH86iZDDdZyQ4bHh8sjjh85QxshLWiwaWLHj5rzGeFtFQ
         IcrW8XeqgyzsIdTrzoKMAanEP62COseV4Lcp1lTz+u1iTg2kWCvix58go7m/+LmBeile
         L3sZErOUPUlICD1nVNHCWNowns50pK5tQclzs0C7ObxvvNLqe9qnYH5sH6OaUznWjVQm
         2gpA==
X-Gm-Message-State: AC+VfDy5q0Tts9cuJuyDREo3fW78BokISeheEbKPx/KcQYDAiROVlzVF
        5Ex7ARjUiYwinwlr1HL8/rwOig==
X-Google-Smtp-Source: ACHHUZ6GJ0ORKzdRChRfD5ma+PIzXWFlPMPfAWorlFKHdguQ2khCw+kSy3PYMaaIMfb1ppTLM1mlkg==
X-Received: by 2002:a1c:7703:0:b0:3f4:2c8f:d2d3 with SMTP id t3-20020a1c7703000000b003f42c8fd2d3mr15548980wmi.20.1684222414539;
        Tue, 16 May 2023 00:33:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:86be:97a:a043:77a8? ([2a01:e0a:982:cbb0:86be:97a:a043:77a8])
        by smtp.gmail.com with ESMTPSA id c6-20020a7bc846000000b003f3157988f8sm1305903wml.26.2023.05.16.00.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:33:34 -0700 (PDT)
Message-ID: <e819f7c7-5023-ce9b-3787-1fb152745f0e@linaro.org>
Date:   Tue, 16 May 2023 09:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi83: Fix enable/disable flow
 to meet spec
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robert Foss <rfoss@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20230503163313.2640898-1-frieder@fris.de>
 <20230503163313.2640898-3-frieder@fris.de>
Organization: Linaro Developer Services
In-Reply-To: <20230503163313.2640898-3-frieder@fris.de>
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

On 03/05/2023 18:33, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The datasheet describes the following initialization flow including
> minimum delay times between each step:
> 
> 1. DSI data lanes need to be in LP-11 and the clock lane in HS mode
> 2. toggle EN signal
> 3. initialize registers
> 4. enable PLL
> 5. soft reset
> 6. enable DSI stream
> 7. check error status register
> 
> To meet this requirement we need to make sure the host bridge's
> pre_enable() is called first by using the pre_enable_prev_first
> flag.
> 
> Furthermore we need to split enable() into pre_enable() which covers
> steps 2-5 from above and enable() which covers step 7 and is called
> after the host bridge's enable().
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
> * Drop RFC
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 75286c9afbb9..a82f10b8109f 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -321,8 +321,8 @@ static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *ctx)
>   	return dsi_div - 1;
>   }
>   
> -static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
> -				    struct drm_bridge_state *old_bridge_state)
> +static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
> +					struct drm_bridge_state *old_bridge_state)
>   {
>   	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
>   	struct drm_atomic_state *state = old_bridge_state->base.state;
> @@ -484,11 +484,22 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
>   	/* Trigger reset after CSR register update. */
>   	regmap_write(ctx->regmap, REG_RC_RESET, REG_RC_RESET_SOFT_RESET);
>   
> +	/* Wait for 10ms after soft reset as specified in datasheet */
> +	usleep_range(10000, 12000);
> +}
> +
> +static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_bridge_state *old_bridge_state)
> +{
> +	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
> +	unsigned int pval;
> +
>   	/* Clear all errors that got asserted during initialization. */
>   	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);
>   	regmap_write(ctx->regmap, REG_IRQ_STAT, pval);
>   
> -	usleep_range(10000, 12000);
> +	/* Wait for 1ms and check for errors in status register */
> +	usleep_range(1000, 1100);
>   	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);
>   	if (pval)
>   		dev_err(ctx->dev, "Unexpected link status 0x%02x\n", pval);
> @@ -555,6 +566,7 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
>   	.attach			= sn65dsi83_attach,
>   	.detach			= sn65dsi83_detach,
>   	.atomic_enable		= sn65dsi83_atomic_enable,
> +	.atomic_pre_enable	= sn65dsi83_atomic_pre_enable,
>   	.atomic_disable		= sn65dsi83_atomic_disable,
>   	.mode_valid		= sn65dsi83_mode_valid,
>   
> @@ -697,6 +709,7 @@ static int sn65dsi83_probe(struct i2c_client *client)
>   
>   	ctx->bridge.funcs = &sn65dsi83_funcs;
>   	ctx->bridge.of_node = dev->of_node;
> +	ctx->bridge.pre_enable_prev_first = true;
>   	drm_bridge_add(&ctx->bridge);
>   
>   	ret = sn65dsi83_host_attach(ctx);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
