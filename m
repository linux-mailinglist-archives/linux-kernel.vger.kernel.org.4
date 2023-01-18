Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766267196B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjARKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjARKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:41:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB2C79E6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:45:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k16so3571978wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lrUX/Kg3NoRa31wbbje+S4lImexuDVGCZWRb0tomIAI=;
        b=WaxyMTsW9kQE/WMVU5QzULSg1HN1MRAKgs7H+p7OxdWLUnVeFKFlLxyFECHcGSSI8c
         7hDI5QRqG0YTCodSKm8TNbpLwPmrAfQls3J55zYi0PA+v/1rl6JprxkeeDo+Q+xImLTy
         ZNBkn8UZXqt/DpvunTAh7eIOC0ArdAPSotFC2xRbG5eTk9/4Sm/hS0vLzxYZK2LQynT6
         V8L2VOq1Ao8oHChHiMv4IGvjY0OoOnJSh3iGhFpwIUQ7ZpkAibyjl6CR3YkXaBvlDp1H
         cZxEw27IbEvJHtHu6ukQAnoJHDy1evACP4xC5H8G2h9JU8lf7a1lNux2mqh15y3ueXFr
         Y0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrUX/Kg3NoRa31wbbje+S4lImexuDVGCZWRb0tomIAI=;
        b=lpMeaJoyu3DLwd5H2pYf3NbefwckuVw/V02LDy34bDEykVmUGrzjhCTL4w0BHQzdnf
         zBVhvMdjoaRTBBfkHgPyxUzjd7sWwdn5a227kMOmfG6oX5rLZR7OQN45hIgnvBy5Rs5v
         OO/ZCV/cL+1Fq+E6s8TZqoXfmy7xekzeOWwU9xpRVPxmV1scYSVImLpFQuLUrqb1O251
         6pGI7lFv8YmnEKusjSQeknAY3deqFINyVdXkuXBpi78iSvHnu/GTFn6EruxlM+IpC1hP
         nFXVkc2lf93mlbMx07x6BL2FEHlkx4YDdUFPb2nm8WkM0t/EmUJODzWqa3BDDjQkG0GV
         QQVw==
X-Gm-Message-State: AFqh2krU9sa5uLup//uyMkICANFpkwbP52MB+nAbg9SajLlrCH6uGWiX
        0d2NmTgvxSH+6zzYCNDqpXL4iQ==
X-Google-Smtp-Source: AMrXdXuWFjI8jqgfiykpXK3AM90rahR3UE8WbZL6P/U1COVUVPK9V9pmUN6kxKHbBHvv+VlJlHxMwg==
X-Received: by 2002:a05:600c:3b07:b0:3d9:c6f5:c643 with SMTP id m7-20020a05600c3b0700b003d9c6f5c643mr6046833wms.29.1674035127968;
        Wed, 18 Jan 2023 01:45:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id fm11-20020a05600c0c0b00b003c21ba7d7d6sm1392944wmb.44.2023.01.18.01.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 01:45:27 -0800 (PST)
Message-ID: <f3c24686-2cef-7c0a-f9e2-b35e3c4caf8e@linaro.org>
Date:   Wed, 18 Jan 2023 10:45:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v3 1/3] drm/mipi-dsi: Fix byte order of 16-bit DCS
 set/get brightness
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
 <20230116224909.23884-2-mailingradian@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230116224909.23884-2-mailingradian@gmail.com>
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
> From: Daniel Mentz <danielmentz@google.com>
> 
> The MIPI DCS specification demands that brightness values are sent in
> big endian byte order. It also states that one parameter (i.e. one byte)
> shall be sent/received for 8 bit wide values, and two parameters shall
> be used for values that are between 9 and 16 bits wide.
> 
> Add new functions to properly handle 16-bit brightness in big endian,
> since the two 8- and 16-bit cases are distinct from each other.
> 
> Fixes: 1a9d759331b8 ("drm/dsi: Implement DCS set/get display brightness")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Link: https://android.googlesource.com/kernel/msm/+/754affd62d0ee268c686c53169b1dbb7deac8550
> [richard: fix 16-bit brightness_get]
> [richard: use separate functions instead of switch/case]
> [richard: split into 16-bit component]
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Tested-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   drivers/gpu/drm/drm_mipi_dsi.c | 52 ++++++++++++++++++++++++++++++++++
>   include/drm/drm_mipi_dsi.h     |  4 +++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 497ef4b6a90a..4bc15fbd009d 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -1224,6 +1224,58 @@ int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>   }
>   EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness);
>   
> +/**
> + * mipi_dsi_dcs_set_display_brightness_large() - sets the 16-bit brightness value
> + *    of the display
> + * @dsi: DSI peripheral device
> + * @brightness: brightness value
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
> +					     u16 brightness)
> +{
> +	u8 payload[2] = { brightness >> 8, brightness & 0xff };
> +	ssize_t err;
> +
> +	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
> +				 payload, sizeof(payload));
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness_large);
> +
> +/**
> + * mipi_dsi_dcs_get_display_brightness_large() - gets the current 16-bit
> + *    brightness value of the display
> + * @dsi: DSI peripheral device
> + * @brightness: brightness value
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
> +					     u16 *brightness)
> +{
> +	u8 brightness_be[2];
> +	ssize_t err;
> +
> +	err = mipi_dsi_dcs_read(dsi, MIPI_DCS_GET_DISPLAY_BRIGHTNESS,
> +				brightness_be, sizeof(brightness_be));
> +	if (err <= 0) {
> +		if (err == 0)
> +			err = -ENODATA;
> +
> +		return err;
> +	}
> +
> +	*brightness = (brightness_be[0] << 8) | brightness_be[1];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_large);
> +
>   static int mipi_dsi_drv_probe(struct device *dev)
>   {
>   	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 4f503d99f668..16f30975b22b 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -296,6 +296,10 @@ int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
>   					u16 brightness);
>   int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>   					u16 *brightness);
> +int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
> +					     u16 brightness);
> +int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
> +					     u16 *brightness);
>   
>   /**
>    * mipi_dsi_generic_write_seq - transmit data using a generic write packet

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
