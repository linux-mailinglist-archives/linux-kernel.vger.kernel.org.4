Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7F671973
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjARKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjARKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:42:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845DFC925C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:46:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso1084501wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AcvYWHjrshjvlHCFoqgs+85kq2cE7G+/UYa9XkteDYk=;
        b=ERiDmPHKrVvtYncxwPc5bkfftwkEVXZAtyAluxA87v1+zzSqDGsYO8ZdqvT/3WdM1R
         bS2Ov3gDCmbcG/2sCcLE1Ah7wNjvDrkGDtiPgAhuYJWn8SdKr5PgBNLpDy9mZZ+mIWKM
         LH6eYz8fbKs/z+voezobT+SCVWvMnmY2aJ0Z9I0MA7z2eza5LIx2sZLF8zbCvRHVJ1kg
         oxgfFGTKBKSseIj4uj+Hvhv8YFGGnIovulttKIthOyrz6MTqNdmLYL/jVaYrJeVnF2kZ
         o164YUscNNEuMdBprgPJhXDzP2XHwmsS4CNDCpdTYctz+EJoAbmmtc04wORSSPF5rYQV
         fLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcvYWHjrshjvlHCFoqgs+85kq2cE7G+/UYa9XkteDYk=;
        b=gqi7HyfRWTn/gPCeQAyd73kcTs0kMwT22CgM2dQbLSsXU+h+qmrBJYyLEyvfvck/wk
         jDBBMhC9syGN/tcUVssAlsUUezw633d9Xzwcp2wnbevDuLy1SrRBLx5rBhSKweYWMv45
         2kKexwfCdNT1fBllVdcXitpHuOuzu7GfHYau9ihBNUaZdWiq9v/zWiShfpY+OEn7OjII
         HzgaeXN7uYCacWSRICPBuU0/M0QOEEwhioeRqmNyNITT5mF3lZWIuQomQX7rkb+wtD5d
         6tdp1gwyUoBhCZBIp1Zg1Ad1CE/rjk03hTvsB6X7oIfC7JvYhkWHapHBQykqPRPhAzeU
         iWMg==
X-Gm-Message-State: AFqh2kqdRC22iEVXD7W6oLN/rX6Y3HL/No5N5b9apl+34o8utKT+DaDD
        yPPeCatCFBfQCCNcPGbnKlROJA==
X-Google-Smtp-Source: AMrXdXutHA7fuYdnbPOodo7ojhJT3cWLGOONzzUtZnEbiganEwcSc5GgaohVIT1/n4tK3qxhN9U7OA==
X-Received: by 2002:a05:600c:4928:b0:3d9:a5a2:65fa with SMTP id f40-20020a05600c492800b003d9a5a265famr5971933wmp.7.1674035168039;
        Wed, 18 Jan 2023 01:46:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c1d8400b003da286f8332sm1532050wms.18.2023.01.18.01.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 01:46:07 -0800 (PST)
Message-ID: <ec93ad0b-ebc0-127a-93e1-492c14d5b49c@linaro.org>
Date:   Wed, 18 Jan 2023 10:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v3 2/3] drm/panel: sofef00: Use 16-bit brightness
 function
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>
References: <20230116224909.23884-1-mailingradian@gmail.com>
 <20230116224909.23884-3-mailingradian@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230116224909.23884-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 23:49, Richard Acayan wrote:
> These panels communicate brightness in big endian. This is not a quirk
> of the panels themselves, but rather, a part of the MIPI standard. Use
> the new mipi_dsi_dcs_set_display_brightness_large() function that
> properly handles 16-bit brightness instead of doing special processing
> of the brightness values.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Tested-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   drivers/gpu/drm/panel/panel-samsung-sofef00.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> index 9db49a028930..1ebb79e3103c 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> @@ -10,7 +10,6 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/regulator/consumer.h>
> -#include <linux/swab.h>
>   #include <linux/backlight.h>
>   
>   #include <video/mipi_display.h>
> @@ -213,13 +212,9 @@ static int sofef00_panel_bl_update_status(struct backlight_device *bl)
>   {
>   	struct mipi_dsi_device *dsi = bl_get_data(bl);
>   	int err;
> -	u16 brightness;
> +	u16 brightness = (u16)backlight_get_brightness(bl);
>   
> -	brightness = (u16)backlight_get_brightness(bl);
> -	// This panel needs the high and low bytes swapped for the brightness value
> -	brightness = __swab16(brightness);
> -
> -	err = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	err = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>   	if (err < 0)
>   		return err;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
