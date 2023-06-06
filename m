Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4722723C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFFJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjFFJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:05:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BAB8F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:05:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30c4775d05bso4310981f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686042320; x=1688634320;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wwgj8k1ofjFPTMWJGTpnmuKpMNoWPqWb68cZdGx1NL4=;
        b=yRq6Q4OBl2P63tGLKgbTRbW4zjkreFWFvg/pJSnL/vPBKEbMlNlDMKP3q5VRhJYVh0
         JbF0EIEEcl4HULNeCq8LM9RJUDAkOWe9jdYppiMQbdFucVJl995AAK4W6GSwahTwJir7
         IQCUVgRZDVUdKT9PvCEeAhnvjCg98MIZlTbObeRWk66qgDhQtni5DTiyQdWfEo033LGI
         lNuuZUpQKFTtg0TL+0oTlJsr+mqTzKNSZ31zjewiog3hLyaMyTnQbOuV+DZpPrMmHdpj
         lkPy1AS/se4xUgi2NUq+x2U8ETBCtW9KPQqyKOD1oGugADxNzAcmHu1Q4XVETlhg3GcP
         OERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042320; x=1688634320;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwgj8k1ofjFPTMWJGTpnmuKpMNoWPqWb68cZdGx1NL4=;
        b=eLH0v8MJaXO4IVQ3OsSjHeQMnUx9Y+JFtsv39QsagDXH0DbBep8Hb9J6OhObtIRHUK
         UNY1D6zq6993Z6hizN2PLScXH69Ok2FoRIFYZaLKLMgnjrR9tsquYanrxInKxreiF4kT
         OZkpGHfMADPJlTylUxEJAN0mosNm3JQCoWxdsS5LPjrA/PhgcUTJVNuTwDYjrc/HRxyU
         31mkknys6r4wgc8As7YEQJrV+y3LtoCLuL8VdstWOWw1JFULAx6D6mkB1ZO1FW33mkdr
         heH+MJTz/ZsNm+Cf0g6dLlHk8YXDEucDrhn3XfQgh6BD94boHDpugEedIAK2paTeCELr
         LWVQ==
X-Gm-Message-State: AC+VfDzBqc6TfZlblzUw1gnGvs4q+0ze4/G3KbXXyAVCQ9jPZllosFip
        Le7OfvJvHxtQ4g6RbTJGhaNjvg==
X-Google-Smtp-Source: ACHHUZ4OZMcdol/nUB9cASf0i7t5RKdy/Xf2x73R0rdrOofi3ztvlKw3U50b0I+1PoeBk3uN3U6Xwg==
X-Received: by 2002:adf:f1c6:0:b0:30c:7183:b2dc with SMTP id z6-20020adff1c6000000b0030c7183b2dcmr1385939wro.14.1686042320314;
        Tue, 06 Jun 2023 02:05:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4973:1165:b171:fa69? ([2a01:e0a:982:cbb0:4973:1165:b171:fa69])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f6050d35c9sm13268321wmb.20.2023.06.06.02.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:05:19 -0700 (PDT)
Message-ID: <b3a1712c-7b4d-3f3b-e3b2-f71bf1060db0@linaro.org>
Date:   Tue, 6 Jun 2023 11:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 3/8] drm/bridge: mhdp8546: Add minimal format
 negotiation
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
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230606082142.23760-1-a-bhatia1@ti.com>
 <20230606082142.23760-4-a-bhatia1@ti.com>
Organization: Linaro Developer Services
In-Reply-To: <20230606082142.23760-4-a-bhatia1@ti.com>
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

On 06/06/2023 10:21, Aradhya Bhatia wrote:
> From: Nikhil Devshatwar <nikhil.nd@ti.com>
> 
> With new connector model, mhdp bridge will not create the connector and
> SoC driver will rely on format negotiation to setup the encoder format.
> 
> Support minimal format negotiations hooks in the drm_bridge_funcs.
> Complete format negotiation can be added based on EDID data.
> This patch adds the minimal required support to avoid failure
> after moving to new connector model.
> 
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> [a-bhatia1: Drop the output_fmt check condition]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
> 
> Notes:
> 
>      changes from v1:
>      * cosmetic fixes, commit message update.
> 
>      changes from v5:
>      * drop the default_bus_format variable and directly assigned
>        MEDIA_BUS_FMT_RGB121212_1X36 to input_fmts.
> 
>      changes from v6:
>      * Drop the output_fmt check condition and hence drop Tomi
>        Valkeinen's R-b tag.
> 
>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index f6822dfa3805..afd4e353f37a 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2146,6 +2146,27 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
>   	return &cdns_mhdp_state->base;
>   }
>   
> +static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
> +					 struct drm_bridge_state *bridge_state,
> +					 struct drm_crtc_state *crtc_state,
> +					 struct drm_connector_state *conn_state,
> +					 u32 output_fmt,
> +					 unsigned int *num_input_fmts)
> +{
> +	u32 *input_fmts;
> +
> +	*num_input_fmts = 0;
> +
> +	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	*num_input_fmts = 1;
> +	input_fmts[0] = MEDIA_BUS_FMT_RGB121212_1X36;
> +
> +	return input_fmts;
> +}
> +
>   static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>   				  struct drm_bridge_state *bridge_state,
>   				  struct drm_crtc_state *crtc_state,
> @@ -2210,6 +2231,7 @@ static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
>   	.atomic_duplicate_state = cdns_mhdp_bridge_atomic_duplicate_state,
>   	.atomic_destroy_state = cdns_mhdp_bridge_atomic_destroy_state,
>   	.atomic_reset = cdns_mhdp_bridge_atomic_reset,
> +	.atomic_get_input_bus_fmts = cdns_mhdp_get_input_bus_fmts,
>   	.detect = cdns_mhdp_bridge_detect,
>   	.get_edid = cdns_mhdp_bridge_get_edid,
>   	.hpd_enable = cdns_mhdp_bridge_hpd_enable,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
