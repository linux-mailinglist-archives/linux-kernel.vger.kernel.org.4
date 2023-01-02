Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DD165B6C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjABS5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjABS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:56:45 -0500
X-Greylist: delayed 800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Jan 2023 10:56:44 PST
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084591C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=6Ex6QvqzRk8OslgWWwZIjEjxsTcgZXOQs/9jQxMcHYU=;
        b=NlR5MRCaTTgRchjs6XUCXMuWPhCWxqHoi/ouhjB9162Tv+EOquO8KeI5ZfKMCd6HEOTEV3DK4eoWE
         0ZMS1Z0QBkq0IW2z5jQT78+g9MGwf4Dh45ZIOngQXhUOSaFdkibgXuheUzmCK5tUiauJk70/BpKvHt
         8YqfWLQs8e3Fasn7yk/DvLgJuBF9Jgv3eJRIKQQlZBPaPv9DCqOTySC0ejLYnOYoRiOrYupTXJmosX
         9oFif5sXlvGvHxRGMAIvIMllf7SgXm+OBxxrUiEw2znBedXFR4eC2x6BH7B7AQWKJHIpWixZfHXTxO
         CyysGMqLqaND3YIPEATYNSeVEOpvSsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=6Ex6QvqzRk8OslgWWwZIjEjxsTcgZXOQs/9jQxMcHYU=;
        b=ej9AvfELS5UNjkpNOuxMfFGm4ylBILx1bFybYEGE1gbV8zrP8a8jw5dK2bU/H72fiX44pgbm2pEAs
         mYoryZsBQ==
X-HalOne-ID: 30e4afd7-8acf-11ed-a2ba-93f0a866dfbb
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 30e4afd7-8acf-11ed-a2ba-93f0a866dfbb;
        Mon, 02 Jan 2023 18:56:41 +0000 (UTC)
Date:   Mon, 2 Jan 2023 19:56:40 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 12/14] drm/panel-mantix-mlaf057we51: Drop custom DSI
 write macro
Message-ID: <Y7Mo6OcEtE6mIHm2@ravnborg.org>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-13-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014757.3170486-13-javierm@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 02:47:55AM +0100, Javier Martinez Canillas wrote:
> There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
> that instead and delete the custom DSI write macro defined in the driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
>  .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 24 +++++++------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> index 772e3b6acece..9243b2ad828d 100644
> --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> @@ -45,14 +45,6 @@ static inline struct mantix *panel_to_mantix(struct drm_panel *panel)
>  	return container_of(panel, struct mantix, panel);
>  }
>  
> -#define dsi_generic_write_seq(dsi, seq...) do {				\
> -		static const u8 d[] = { seq };				\
> -		int ret;						\
> -		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
> -		if (ret < 0)						\
> -			return ret;					\
> -	} while (0)
> -
>  static int mantix_init_sequence(struct mantix *ctx)
>  {
>  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> @@ -61,18 +53,18 @@ static int mantix_init_sequence(struct mantix *ctx)
>  	/*
>  	 * Init sequence was supplied by the panel vendor.
>  	 */
> -	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> +	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
>  
> -	dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
> -	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> -	dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
> +	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> +	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
>  
> -	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> -	dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> +	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
>  	msleep(20);
>  
> -	dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
> -	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
> +	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
> +	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
>  	msleep(20);
>  
>  	dev_dbg(dev, "Panel init sequence done\n");
> -- 
> 2.38.1
