Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E160D66A861
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjANBhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjANBgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:36:52 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0C96451
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:36:49 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h11so609946ilc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cztox3VQWAGD7VJtq66xAo2OI+Ymfrijibk8U2ZTQQ=;
        b=itprcvnoV+gXF8F0qWTBkuZYK6Gwa9X26pPiPzoRbes04XWpL86Dzn0rwnU9xkREYY
         YklbOWRiF8LHNZXRTBxrJ5M1YY/W5FA+eejAJgj1SmoEON0UBI+jnqSomIhcp6HB1OqR
         g9ya3+La2i0MuY7SZ+KOoP8i2RhnOnw7hQUSVb0ocsgieUpezlSCChCWznXccbzvWQ7K
         OLd7pPjFR1mCAdYXBTEb+7A8XtCMju1bSga8oDd6iK0+6AoHqraPjIXCIrGJrLTo1VlC
         B2+tZI1zYo8mWkUdLloxvr5RwenV1aG0z/2CzYjEoXrvneFuDKA+VsY3QiRvPcOWNUdB
         k2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cztox3VQWAGD7VJtq66xAo2OI+Ymfrijibk8U2ZTQQ=;
        b=te1gaj6ZUD/PQEztYSdr9ta45Avjg4XiBFARneHtoGH4SfV/7BX6Glch6jo9Kqw9Zt
         7+vtKw8aLqfLhxUvU+yfHkvP3LBymUTsvd1GBJG2sA+warLiucvdjEU4UTBiMt1cf4r0
         3r/zxNmFVIb7lWCCVV8sKGEClhEvOqJY+CGAvhN9XPiCN0NQ3IT+4163aGq+HbooDDxQ
         7tzV6Nf0ApQ8SnZhfAIMMCL/3hCteC/ACml1p9fFNIhuHmReUp7H0ljaERsyVnbCYIUV
         gXPdrbWJF43ZERDbmfbjkzPpzL7YShPCnpRUSrMDiqVI7bPg+Pdri1KvQAlACkSgriIK
         CNpA==
X-Gm-Message-State: AFqh2krjCn9hnb+W9pDRr7N+ykzSlTHB+oNJnsibHKR12U+Q87icrvhJ
        AbOUrRayH83qsdBGkn3gicY=
X-Google-Smtp-Source: AMrXdXu02A3ABLGe/YECWUP9zRAUCo2IPgTTM6/tHx8VwVFshmCZf7apiHLp61d74UboOAv12p//pg==
X-Received: by 2002:a92:d186:0:b0:30d:b66e:e4e3 with SMTP id z6-20020a92d186000000b0030db66ee4e3mr10818826ilz.1.1673660209198;
        Fri, 13 Jan 2023 17:36:49 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::6463])
        by smtp.gmail.com with ESMTPSA id l14-20020a056e0205ce00b0030d84876f1fsm6530194ils.56.2023.01.13.17.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:36:48 -0800 (PST)
Date:   Fri, 13 Jan 2023 20:36:47 -0500
From:   Richard Acayan <mailingradian@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Caleb Connolly <caleb@connolly.tech>,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] drm/dsi-mipi: Fix byte order of DCS set/get
 brightness
Message-ID: <Y8IHLwrYH1sKMH6t@radian>
References: <20230114010006.50471-1-mailingradian@gmail.com>
 <20230114010006.50471-2-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114010006.50471-2-mailingradian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:00:05PM -0500, Richard Acayan wrote:
> From: Daniel Mentz <danielmentz@google.com>
> 
> The MIPI DCS specification demands that brightness values are sent in
> big endian byte order. It also states that one parameter (i.e. one byte)
> shall be sent/received for 8 bit wide values, and two parameters shall
> be used for values that are between 9 and 16 bits wide.
> 
> Fixes: 1a9d759331b8 ("drm/dsi: Implement DCS set/get display brightness")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Change-Id: I24306e21ec6a5ff48ea121d977419a81d5b44152
I need to check which local commits I'm actually emailing...

This line will be removed in v3.

> Link: https://android.googlesource.com/kernel/msm/+/754affd62d0ee268c686c53169b1dbb7deac8550
> [richard: fix 16-bit brightness_get]
> [richard: use separate functions instead of switch/case]
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 52 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  4 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 497ef4b6a90a..4bc15fbd009d 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -1224,6 +1224,58 @@ int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>  }
>  EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness);
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
>  static int mipi_dsi_drv_probe(struct device *dev)
>  {
>  	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 4f503d99f668..16f30975b22b 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -296,6 +296,10 @@ int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
>  					u16 brightness);
>  int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>  					u16 *brightness);
> +int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
> +					     u16 brightness);
> +int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
> +					     u16 *brightness);
>  
>  /**
>   * mipi_dsi_generic_write_seq - transmit data using a generic write packet
> -- 
> 2.39.0
> 
