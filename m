Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59C61E023
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiKFDSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKFDR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:17:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF05FB9;
        Sat,  5 Nov 2022 20:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 408F3B80683;
        Sun,  6 Nov 2022 03:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D965C433D6;
        Sun,  6 Nov 2022 03:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667704672;
        bh=iXN6QTp9N3xZfo64V68cgv+Kq1hePQWIpnKArPOxGcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtMWU6CXuHFVtmmuBuLxQc47wWBR+J8RMjieWFPlDveugMk2zCiN9HjMZgxBLuZPp
         a+JoBlXf/36BGSbhfezWqtJS+eXHJL5HNN/pQCXIdL9WSLzDFdd/RDeKKpYIawsbuL
         rBwe2zF9X0f+DrU6tNMWZbLkxqoxjN969qfPypBxIjJ1Y2VIMSOxrJbyEz+oDMet3L
         cNZC1kDpGebXhBflMVGxhyWwiztRsPBOSVufiT43kWRd/85ox6hqpDyHK2kGC1oWE5
         VjvwMsY4Amhm/VB5MkAeAo2QChGeyNC5BvIjgUjuckn8YtBRzxcXZzEahwlJJxwgYL
         UATBe6OQrrofQ==
Date:   Sat, 5 Nov 2022 22:17:50 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nia Espera <a5b6@riseup.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v3 1/2] drivers: gpu: drm: add driver for samsung
 s6e3fc2x01 cmd mode panel
Message-ID: <20221106031750.juw3fsy27wchqdqp@builder.lan>
References: <20221008131201.540185-1-a5b6@riseup.net>
 <20221008131201.540185-2-a5b6@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008131201.540185-2-a5b6@riseup.net>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 03:12:01PM +0200, Nia Espera wrote:
> Adds a dedicated driver for the Samsung s6e3fc2x01 panel used in OnePlus
> 6T smartphones which was previously driven by the sofef00 panel driver
> 
> Signed-off-by: Nia Espera <a5b6@riseup.net>
> Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  MAINTAINERS                                   |   5 +
>  drivers/gpu/drm/panel/Kconfig                 |  12 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-samsung-s6e3fc2x01.c  | 388 ++++++++++++++++++

git log --oneline drivers/gpu/drm/panel indicates that the $subject
prefix should be "drm/panel:"

[..]
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 6d493b9d64fe..b54de8812e91 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI) += panel-samsung-s6e63m0-dsi.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01) += panel-samsung-s6e88a0-ams452ef01.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_SOFEF00) += panel-samsung-sofef00.o
> +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3FC2X01) += panel-samsung-s6e3fc2x01.o
>  obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
>  obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
>  obj-$(CONFIG_DRM_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
[..]
> +static int s6e3fc2x01_panel_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	int err;
> +	u16 brightness;
> +
> +	brightness = (u16)backlight_get_brightness(bl);
> +	// This panel needs the high and low bytes swapped for the brightness value

/* */ please

> +	brightness = __swab16(brightness);
> +
> +	err = mipi_dsi_dcs_set_display_brightness(dsi, brightness);

This returns a valid <= 0, so it would be nicer with just

	return mipi_dsi_dsc_set_display_brightness(...);

> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops s6e3fc2x01_panel_bl_ops = {
> +	.update_status = s6e3fc2x01_panel_bl_update_status,
> +};
> +

Regards,
Bjorn
