Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB3723C80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjFFJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjFFJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:05:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A0A109
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:05:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30ad458f085so5175927f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686042346; x=1688634346;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YQjR7ZjT+c34sTTvl9bgQE8546DBP6GtYLvI5TvdXPw=;
        b=WRQvW+BGtmNNHIOxd18rspLcEyfmAjrmgVOGgfYM1ye0rG+/AWnPdlLsKtBqWKusjC
         qImwMKKp3DMw+DAwlaI1+uV/oQmQko5tzGFIDvT0XsONMtD77WYAmExxt1lU3ZwIkZsV
         OW/h/GfDEGqQiS+zu4ZZ788CXoKN0ve+a1ppw5zKmkbEIkp3/oS9EDKG0m4FO0apscp0
         yD++KP1stZEiZyHVm1Jd0eFWheDJkA0UdcDqxv8v/y1poJ/M+QApwiG4MKsHRFJwEzIe
         jtY0KtyOVNNl2/gP74fWE03rJoeWjb+bixUlE6xl2HwNV3zv0eWY2fQeZ/pvDfSp51U+
         s5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042346; x=1688634346;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQjR7ZjT+c34sTTvl9bgQE8546DBP6GtYLvI5TvdXPw=;
        b=SrCFliJYIkmH62mwzwLeHHCY3yTE1/l0zCMHuHg50zaLcB4aNC2NNx3luuzmCFfpAi
         dz0ybMIZ9kRYAz7aMj63rzMWtvRffK5nIxkaZDRuvR03scdDujaY18LS1kE/O4zodcVY
         +kvG9c87wJNU0VQAHIU0APp355nw9rGrTjsAi6BArQudfTC6EcN6X2crsWlIFXCI4waf
         4wHnO1n8CZKdycMjlcC+c5/qC4Gc45/mNJ8LtsM3ybxMsoNgJBMvJWic89p0v23lb3kj
         yiDH/d1FDRaZkoAEjAs99/iQQW1Ua8a61jVkByhNR1N442p3odxmDPX42sZZl3RG5dwy
         4D/w==
X-Gm-Message-State: AC+VfDwVV6HcKKegXTxRAVgNgcWJMklgs5BGa3IzpZ8l80NAUWOMUsgN
        oEtlHqDL3zysot0QE0wfkP0FnA==
X-Google-Smtp-Source: ACHHUZ48BIkT8rw0aeVU9Vpg/P9VXfEJY4xJ0BuDwHZcfz2LJzC4tKesSpo8k9MAtOuc6Vbj0gjv+A==
X-Received: by 2002:adf:e40f:0:b0:307:9081:d355 with SMTP id g15-20020adfe40f000000b003079081d355mr1304757wrm.26.1686042345718;
        Tue, 06 Jun 2023 02:05:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4973:1165:b171:fa69? ([2a01:e0a:982:cbb0:4973:1165:b171:fa69])
        by smtp.gmail.com with ESMTPSA id g8-20020adfe408000000b003078a3f3a24sm11987498wrm.114.2023.06.06.02.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:05:45 -0700 (PDT)
Message-ID: <36c793bf-42c8-8fe0-9e60-fb5eb6b0aa93@linaro.org>
Date:   Tue, 6 Jun 2023 11:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 1/8] drm/bridge: tfp410: Support format negotiation
 hooks
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
 <20230606082142.23760-2-a-bhatia1@ti.com>
Organization: Linaro Developer Services
In-Reply-To: <20230606082142.23760-2-a-bhatia1@ti.com>
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
> With new connector model, tfp410 will not create the connector and
> SoC driver will rely on format negotiation to setup the encoder format.
> 
> Support format negotiations hooks in the drm_bridge_funcs.
> Use helper functions for state management.
> 
> Input format is the one selected by the bridge from DT properties.
> 
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> [a-bhatia1: Removed output fmt condition check]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
> 
> Notes:
>      changes from v1:
>      * Use only MEDIA_BUS_FMT_FIXED for output
> 
>      changes from V5:
>      * Drop the output format check condition because the output
>        format for HDMI bridges should be RGB888_1X24 and not FIXED.
>        Hence, also drop Tomi Valkeinen's and Laurent Pinchart's R-b
>        tags.
> 
>   drivers/gpu/drm/bridge/ti-tfp410.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
> index ab63225cd635..7dacc7e03eee 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> @@ -206,12 +206,38 @@ static enum drm_mode_status tfp410_mode_valid(struct drm_bridge *bridge,
>   	return MODE_OK;
>   }
>   
> +static u32 *tfp410_get_input_bus_fmts(struct drm_bridge *bridge,
> +				      struct drm_bridge_state *bridge_state,
> +				      struct drm_crtc_state *crtc_state,
> +				      struct drm_connector_state *conn_state,
> +				      u32 output_fmt,
> +				      unsigned int *num_input_fmts)
> +{
> +	struct tfp410 *dvi = drm_bridge_to_tfp410(bridge);
> +	u32 *input_fmts;
> +
> +	*num_input_fmts = 0;
> +
> +	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	*num_input_fmts = 1;
> +	input_fmts[0] = dvi->bus_format;
> +
> +	return input_fmts;
> +}
> +
>   static const struct drm_bridge_funcs tfp410_bridge_funcs = {
>   	.attach		= tfp410_attach,
>   	.detach		= tfp410_detach,
>   	.enable		= tfp410_enable,
>   	.disable	= tfp410_disable,
>   	.mode_valid	= tfp410_mode_valid,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_get_input_bus_fmts = tfp410_get_input_bus_fmts,
>   };
>   
>   static const struct drm_bridge_timings tfp410_default_timings = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
