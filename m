Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2D6FC0BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjEIHtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjEIHtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:49:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40998E53
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:49:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so15636645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683618569; x=1686210569;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n5+JiC0I5gP228X6r4a8yAeiJ+ahwljWHkdcn9hVFHU=;
        b=oCsmEbxcSrS9fTumk/9hNm4iyOc0wgGTiSxcnZMVB1hgfni9OyJKEG/cA4f9ACrlcL
         cfZSuxFvmmdlHPQ1W7j+vRThfApssKDMwj8lUnyjZevkNaLFryIfvoXmdVEWwFJGxEYl
         6C4g8CudWx3QtGXZ70q/aM/a6los0WD8o5azEyGCMXWTmJ9WgzzuKnysJZ9UDH0MBHid
         2HvBPCRRg5eAtqCg3F/oo3hFay+nP2GBdNRa0k8osVaXNwPcO8jRUxHGgjm+58Jkbgx+
         PoKn0ibZlKwKKR6ZFZbIQ4Obmn+QcCMWXY0rM4JQ7YjawN1GbvJ0Qgp0hNkqHw5SDZMF
         LvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683618569; x=1686210569;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5+JiC0I5gP228X6r4a8yAeiJ+ahwljWHkdcn9hVFHU=;
        b=DtuEBaLiiej2mn4/hCrvjn+lQV9E7OgSaU7iNvP0clsk6L36sU9EzNjWRN/WoflbVr
         IHfhFyvIW8PDWGsb7mltAD0CZ7WCu8BTgZ/AVx8fpbGFv5ik8pAWSLppELltdiDtVtDH
         j9o/im/8Umd0QaYyROg2adQbj4NoRvcFkkv7jekDiWJUdyetuDGLGMLO1GFJqC6G7YXp
         MCst6j0lwBDEq/759ekgHhh2grrRMo0Pf8+sC6V3/rrZRPdpws7LSlDqUtHCq2LjvNWD
         Bkz4biUvusgEfJcwhO/v6j0/L7pYPm40idu0lLEAHqipsWJAHEbVIV+Df6ZtbwSNGOfO
         dCig==
X-Gm-Message-State: AC+VfDz3tEzVimC86HHuF2kIPI7RAnqVqMnqMQlLTa9SY81tB+OAzTr8
        BcHARWdrWun8QPFrwEKkASc+jw==
X-Google-Smtp-Source: ACHHUZ4yynn9msHKgmLCvEzHT/V+P2Hi9gTLIbA/PMn158nlQNkmuboK7Aq7amfbTaFt2D5kBZyvsA==
X-Received: by 2002:a05:600c:21c1:b0:3f4:21ff:b91f with SMTP id x1-20020a05600c21c100b003f421ffb91fmr4852606wmj.28.1683618568716;
        Tue, 09 May 2023 00:49:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79ab:8da0:d16d:9990? ([2a01:e0a:982:cbb0:79ab:8da0:d16d:9990])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm19038405wmk.35.2023.05.09.00.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 00:49:28 -0700 (PDT)
Message-ID: <4db4b940-8060-b785-e83a-f13eaae382f0@linaro.org>
Date:   Tue, 9 May 2023 09:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] drm/panel: panel-simple: Add BOE EV121WXM-N10-1850
 panel support
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, thierry.reding@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org
References: <20230508083826.1016206-1-victor.liu@nxp.com>
 <20230508083826.1016206-3-victor.liu@nxp.com>
Organization: Linaro Developer Services
In-Reply-To: <20230508083826.1016206-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 10:38, Liu Ying wrote:
> Add BOE EV121WXM-N10-1850 12.1" WXGA (1280x800) TFT LCD panel support.
> The panel has a LVDS display interface.
> 
> The panel's product specification can be found at:
> http://www.onetech.com.tw/files/EV121WXM-N10-1850ProductSpecification_20180801.pdf
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * Use struct display_timing to tell minimum and maximum pixel clock rates.
> * Set bus_flags to DRM_BUS_FLAG_DE_HIGH in struct panel_desc.
> 
>   drivers/gpu/drm/panel/panel-simple.c | 34 ++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 065f378bba9d..b1590a7e2cda 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1211,6 +1211,37 @@ static const struct panel_desc bananapi_s070wv20_ct16 = {
>   	},
>   };
>   
> +static const struct display_timing boe_ev121wxm_n10_1850_timing = {
> +	.pixelclock = { 69922000, 71000000, 72293000 },
> +	.hactive = { 1280, 1280, 1280 },
> +	.hfront_porch = { 48, 48, 48 },
> +	.hback_porch = { 80, 80, 80 },
> +	.hsync_len = { 32, 32, 32 },
> +	.vactive = { 800, 800, 800 },
> +	.vfront_porch = { 3, 3, 3 },
> +	.vback_porch = { 14, 14, 14 },
> +	.vsync_len = { 6, 6, 6 },
> +};
> +
> +static const struct panel_desc boe_ev121wxm_n10_1850 = {
> +	.timings = &boe_ev121wxm_n10_1850_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 261,
> +		.height = 163,
> +	},
> +	.delay = {
> +		.prepare = 9,
> +		.enable = 300,
> +		.unprepare = 300,
> +		.disable = 560,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct drm_display_mode boe_hv070wsa_mode = {
>   	.clock = 42105,
>   	.hdisplay = 1024,
> @@ -3984,6 +4015,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "bananapi,s070wv20-ct16",
>   		.data = &bananapi_s070wv20_ct16,
> +	}, {
> +		.compatible = "boe,ev121wxm-n10-1850",
> +		.data = &boe_ev121wxm_n10_1850,
>   	}, {
>   		.compatible = "boe,hv070wsa-100",
>   		.data = &boe_hv070wsa

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
