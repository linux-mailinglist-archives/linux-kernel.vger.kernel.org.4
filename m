Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90A273BD35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjFWQwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjFWQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:52:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8E6297A;
        Fri, 23 Jun 2023 09:51:58 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7362440;
        Fri, 23 Jun 2023 18:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687539080;
        bh=dJCcFznGmgjBPGYO8VLPgFvS4koMqtbBK7r2v0bvXUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYtUs7WU+jw/hk8NuEYdCiHY8kTs2riXrvglC+xZqsfpSkAnUYNP8q20J7DdN6I78
         fIRzvGJ8/mvv9x1FBKL46Ael13WBGe7Okh1so3cRHBjS18EAMzXCuWy4Nnb8irbEGk
         ULDkx81wg7vQ00nFv5JoxeuspVuTK8fMPtRXx27U=
Date:   Fri, 23 Jun 2023 19:51:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/39] drm: renesas: shmobile: Rename
 shmob_drm_connector.connector
Message-ID: <20230623165156.GD2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <34065943fb616180779936aa5b1d20c3c5e06886.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34065943fb616180779936aa5b1d20c3c5e06886.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:38AM +0200, Geert Uytterhoeven wrote:
> Rename the "connector" member of the shmob_drm_connector subclass
> structure to "base", to improve readability.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 4 ++--
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 3f0b71253ed929c9..2c0ca802d36026f4 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -608,7 +608,7 @@ int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
>  
>  static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connector *connector)
>  {
> -	return container_of(connector, struct shmob_drm_connector, connector);
> +	return container_of(connector, struct shmob_drm_connector, base);
>  }
>  
>  static int shmob_drm_connector_get_modes(struct drm_connector *connector)
> @@ -669,7 +669,7 @@ shmob_drm_connector_init(struct shmob_drm_device *sdev,
>  	if (!scon)
>  		return ERR_PTR(-ENOMEM);
>  
> -	connector = &scon->connector;
> +	connector = &scon->base;
>  	info = &connector->display_info;
>  	info->width_mm = sdev->pdata->panel.width_mm;
>  	info->height_mm = sdev->pdata->panel.height_mm;
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
> index 79cce0a0ada4cfce..2c6d7541427581a6 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
> @@ -33,7 +33,7 @@ struct shmob_drm_crtc {
>  };
>  
>  struct shmob_drm_connector {
> -	struct drm_connector connector;
> +	struct drm_connector base;
>  	struct drm_encoder *encoder;
>  	const struct videomode *mode;
>  };

-- 
Regards,

Laurent Pinchart
