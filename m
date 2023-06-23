Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF373BB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjFWPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjFWPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:16:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF4A3C3D;
        Fri, 23 Jun 2023 08:15:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3CAF6D5F;
        Fri, 23 Jun 2023 17:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687533182;
        bh=keBSEwXRTk5UtRZ/0fenvLdSAenapjGMYjUaABKjGzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAvQCvHfEA6T6ZXTTjkgoU3PNPvxOGlACUqaoFD73T6XZIiz+YddRdCuw9Aw+2dhH
         l6Gu5LoOhUv1CCZAe3MiFcdHpxGHMXFM+qfWP3XEKiPtfWBPlV3OOqHL4FPTSrYnt8
         pBM29IBo1roToEb7JYDk5jRAdGreYEBDQmQLahZA=
Date:   Fri, 23 Jun 2023 18:13:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/39] drm: renesas: shmobile: Add missing YCbCr formats
Message-ID: <20230623151337.GN2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <b7b75a9e1170e1be5e9ecf9db91c6a21197b7df5.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7b75a9e1170e1be5e9ecf9db91c6a21197b7df5.1687423204.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:21:21AM +0200, Geert Uytterhoeven wrote:
> The primary plane supports various YCbCr formats, and the CRTC code
> already knows how to handle them.  Enable support for the missing
> formats by adding them to the table of supported modes.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 84dbf35025d7be63..cd492806105e5b5d 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -493,6 +493,12 @@ static const uint32_t modeset_formats[] = {
>  	DRM_FORMAT_RGB888,
>  	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_NV21,
> +	DRM_FORMAT_NV16,
> +	DRM_FORMAT_NV61,
> +	DRM_FORMAT_NV24,
> +	DRM_FORMAT_NV42,
>  };
>  
>  static const struct drm_plane_funcs primary_plane_funcs = {

-- 
Regards,

Laurent Pinchart
