Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2164F0CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiLPSQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLPSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:16:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B161DDD1;
        Fri, 16 Dec 2022 10:16:20 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9CECBA31;
        Fri, 16 Dec 2022 19:16:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671214577;
        bh=OuefztTKQUALROWv85YCLijIiQmQk5IUdDdU8uFi/tI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQoCm9L+WoIKJp4FqqFiQT5952wyMP0m94s2rvhMGvDJYs5iwTqoJUvH9A/EVQq98
         C/w2y9TmFwY2sG4QzTpZIZcGBwaAEioT1WunUnNwfXoYvNxiyj1KJS4GHMcy79tdvz
         u4h6JI9PKJRO3cm1LuIqkPvg8lTJ5ipOAotd0lig=
Date:   Fri, 16 Dec 2022 20:16:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] drm/omap: Fix kernel docs
Message-ID: <Y5y17ZNQtpNMbx4w@pendragon.ideasonboard.com>
References: <20220916082206.167427-1-tomi.valkeinen@ideasonboard.com>
 <20220916082206.167427-2-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220916082206.167427-2-tomi.valkeinen@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Fri, Sep 16, 2022 at 11:22:06AM +0300, Tomi Valkeinen wrote:
> Fix doc related warnings seen with W=1: the function names have changed
> but the docs have not been changed accordingly.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/omapdrm/omap_gem.c | 2 +-
>  drivers/gpu/drm/omapdrm/omap_irq.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
> index cf571796fd26..d6b4934fa0fd 100644
> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
> @@ -605,7 +605,7 @@ int omap_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>  }
>  
>  /**
> - * omap_gem_dumb_map	-	buffer mapping for dumb interface
> + * omap_gem_dumb_map_offset - create an offset for a dumb buffer
>   * @file: our drm client file
>   * @dev: drm device
>   * @handle: GEM handle to the object (from dumb_create)
> diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
> index 4aca14dab927..a6f0bbc879d2 100644
> --- a/drivers/gpu/drm/omapdrm/omap_irq.c
> +++ b/drivers/gpu/drm/omapdrm/omap_irq.c
> @@ -99,7 +99,7 @@ int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
>  }
>  
>  /**
> - * enable_vblank - enable vblank interrupt events
> + * omap_irq_enable_vblank - enable vblank interrupt events
>   * @crtc: DRM CRTC
>   *
>   * Enable vblank interrupts for @crtc.  If the device doesn't have
> @@ -129,7 +129,7 @@ int omap_irq_enable_vblank(struct drm_crtc *crtc)
>  }
>  
>  /**
> - * disable_vblank - disable vblank interrupt events
> + * omap_irq_disable_vblank - disable vblank interrupt events
>   * @crtc: DRM CRTC
>   *
>   * Disable vblank interrupts for @crtc.  If the device doesn't have

-- 
Regards,

Laurent Pinchart
