Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A985F70095E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjELNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjELNml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:42:41 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567A132AB
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kCbfSGhpx6BG3Y85FCM7+ZWFiOvGH/+ky4jCu6U8rM8=;
        b=s0IRJNcYvQ6w806hURAZZNVic53VTPtnlhMCq3SmRiB82VvY97R/PK2RaV+HtWp6mxT/9ckMydHh8
         RTZBZDTVPeQBiyqAJazFeXS227KwSw2jm96+6cvacB6EKm8E0snGNQn8BdpM6Jq7LgWBq/GzcuEaZ2
         3Uo7yYEmUDEIo/EJvipJqyuECDUPT6/EZcLDI4syUeeNxTRbADIJJh1zHQjrlyPHPfImXcGMv37QiD
         qJwzJjhxJ3he7CYTvpM1D/Dd/1yLQ/hpZZ0+jtRohgxAsnd/h0HcjkY48PFtJpJPJ4GyFXGwLZ3gWr
         J3vyeT2nP0sInEHvg/tINR/n1yeUFqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kCbfSGhpx6BG3Y85FCM7+ZWFiOvGH/+ky4jCu6U8rM8=;
        b=/MvE5WN6gXd8lqokL8jrjuWlDFgzBG8+aHqtOtq0tyY6hVZjoaRtTfRdSvjGX0hYhq7wd0OeWn7DV
         YBbbtTHDw==
X-HalOne-ID: db3af462-f0ca-11ed-9c06-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id db3af462-f0ca-11ed-9c06-99461c6a3fe8;
        Fri, 12 May 2023 13:42:38 +0000 (UTC)
Date:   Fri, 12 May 2023 15:42:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Fix include guard name
Message-ID: <20230512134237.GB1395037@ravnborg.org>
References: <20230512120232.304603-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512120232.304603-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:02:31PM +0200, Javier Martinez Canillas wrote:
> This is a leftover from an early iteration of the driver when it was still
> named ssd1307 instead of ssd130x. Change it for consistency with the rest.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
>  drivers/gpu/drm/solomon/ssd130x.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
> index 03038c1b6476..db03ee5db392 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.h
> +++ b/drivers/gpu/drm/solomon/ssd130x.h
> @@ -10,8 +10,8 @@
>   * Copyright 2012 Free Electrons
>   */
>  
> -#ifndef __SSD1307X_H__
> -#define __SSD1307X_H__
> +#ifndef __SSD130X_H__
> +#define __SSD130X_H__
>  
>  #include <drm/drm_connector.h>
>  #include <drm/drm_crtc.h>
> @@ -94,4 +94,4 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap);
>  void ssd130x_remove(struct ssd130x_device *ssd130x);
>  void ssd130x_shutdown(struct ssd130x_device *ssd130x);
>  
> -#endif /* __SSD1307X_H__ */
> +#endif /* __SSD130X_H__ */
> -- 
> 2.40.1
