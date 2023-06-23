Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E81473BD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjFWQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFWQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:53:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401182727;
        Fri, 23 Jun 2023 09:53:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4428B440;
        Fri, 23 Jun 2023 18:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687539142;
        bh=YJ3yOXbzBwOA7XqInoA3P8Y2N6ErXUdW7tXjVgzSU1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlRE08XWEpA/3WiAtLmtr4QhSVqBYLWSFmgG8O8tIu1gA8lbdcqLoEfZYLQUQkuDM
         1FKORhiqQdMEHgUTb97uS8t0makkemU6wWVH687RHzZGiVMn/YQyaMFoIUyGoNZIrE
         dSz3wANBci0ADTqsJzAZWa8ATef1rhUUmZ8Qi8yg=
Date:   Fri, 23 Jun 2023 19:52:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/39] drm: renesas: shmobile: Rename
 shmob_drm_plane.plane
Message-ID: <20230623165257.GE2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <ecd392c966c967ac6826e20f8888e10161c9cbf7.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecd392c966c967ac6826e20f8888e10161c9cbf7.1687423204.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thu, Jun 22, 2023 at 11:21:39AM +0200, Geert Uytterhoeven wrote:
> Rename the "plane" member of the shmob_drm_plane subclass structure to
> "base", to improve readability.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> index 63886015baaebfc0..e300e5c0de70a9b1 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> @@ -20,7 +20,7 @@
>  #include "shmob_drm_regs.h"
>  
>  struct shmob_drm_plane {
> -	struct drm_plane plane;
> +	struct drm_plane base;
>  	unsigned int index;
>  	unsigned int alpha;
>  
> @@ -37,7 +37,7 @@ struct shmob_drm_plane {
>  
>  static inline struct shmob_drm_plane *to_shmob_plane(struct drm_plane *plane)
>  {
> -	return container_of(plane, struct shmob_drm_plane, plane);
> +	return container_of(plane, struct shmob_drm_plane, base);
>  }
>  
>  static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
> @@ -64,7 +64,7 @@ static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
>  static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
>  				    struct drm_framebuffer *fb)
>  {
> -	struct shmob_drm_device *sdev = to_shmob_device(splane->plane.dev);
> +	struct shmob_drm_device *sdev = to_shmob_device(splane->base.dev);
>  	unsigned int ovl_idx = splane->index - 1;
>  	u32 format;
>  
> @@ -221,7 +221,7 @@ struct drm_plane *shmob_drm_plane_create(struct shmob_drm_device *sdev,
>  	}
>  
>  	splane = drmm_universal_plane_alloc(&sdev->ddev,
> -					    struct shmob_drm_plane, plane, 1,
> +					    struct shmob_drm_plane, base, 1,
>  					    funcs, formats,
>  					    ARRAY_SIZE(formats),  NULL, type,
>  					    NULL);
> @@ -231,5 +231,5 @@ struct drm_plane *shmob_drm_plane_create(struct shmob_drm_device *sdev,
>  	splane->index = index;
>  	splane->alpha = 255;
>  
> -	return &splane->plane;
> +	return &splane->base;
>  }

-- 
Regards,

Laurent Pinchart
