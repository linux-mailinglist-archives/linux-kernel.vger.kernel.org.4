Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0061F73BB01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjFWPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjFWPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:04:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED322112;
        Fri, 23 Jun 2023 08:04:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E4AA6838;
        Fri, 23 Jun 2023 17:04:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687532646;
        bh=L0JeIL/kTtYp3SuxU1Cw3iCGkCrTf5TOpTRBzOxuPI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SnqG14c9ZlrSv6RYws6+chxA6XcvR5lgl/UtI9Mhrruu8b/kotLR8WwZqCWmu3Op7
         a6SE9NjQKSWqvaVl0aiPZjSQsUuBdE7XPxZ8w7kibqK83Au3CtJeXKLNseXDwi/G0S
         3dpP8lsopodJ6vRbEtVL3C95mQCDM2Spn19Khytw=
Date:   Fri, 23 Jun 2023 18:04:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/39] drm: renesas: shmobile: Use %p4cc to print fourcc
 code
Message-ID: <20230623150441.GJ2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <7eb153878ffa1242d537aade655936f33b7eec62.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7eb153878ffa1242d537aade655936f33b7eec62.1687423204.git.geert+renesas@glider.be>
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

On Thu, Jun 22, 2023 at 11:21:20AM +0200, Geert Uytterhoeven wrote:
> Replace the last printing of an hexadecimal fourcc format code by a
> pretty-printed format name, using the "%p4cc" format specifier.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> index 7e49e2873da1bb6f..36fedb2b74c8b7a2 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> @@ -184,8 +184,8 @@ shmob_drm_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
>  
>  	format = shmob_drm_format_info(fb->format->format);
>  	if (format == NULL) {
> -		dev_dbg(sdev->dev, "update_plane: unsupported format %08x\n",
> -			fb->format->format);
> +		dev_dbg(sdev->dev, "update_plane: unsupported format %p4cc\n",
> +			&fb->format->format);
>  		return -EINVAL;
>  	}
>  

-- 
Regards,

Laurent Pinchart
