Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE86C90DF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 22:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCYVBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 17:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 17:01:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846FB2689;
        Sat, 25 Mar 2023 14:01:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F75A7FA;
        Sat, 25 Mar 2023 22:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679778073;
        bh=njmuQz/sfEKPGfRI9pv6Y5D/S1KWAHOVfjfyE6XFLmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPhj0ux7fzLYIDnh1/Gen8aj3qj2by2GDykyH3ZSjGJCvkO8TBNmA3TVxAZYe1ghj
         3nHHkcnJ1uVVObmsMI7STb0dKLkcGtzdNYgUJ2ng46AsFlXUJWWvQu4GxvPv70kyfU
         XmrS0j3kjkmepTunuW5joI8BA6vftdTepCdNT7y4=
Date:   Sat, 25 Mar 2023 23:01:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/9] media: v4l2: Add NV12_16L16 pixel format to v4l2
 format info
Message-ID: <20230325210120.GB22214@pendragon.ideasonboard.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324151228.2778112-3-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Fri, Mar 24, 2023 at 04:12:21PM +0100, Paul Kocialkowski wrote:
> Represent the NV12_16L16 pixel format in the v4l2 format info table.
> This is a 16x16 tiled version of NV12.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/v4l2-core/v4l2-common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index 3d044b31caad..5101989716aa 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -280,6 +280,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		/* Tiled YUV formats */
>  		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>  		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> +		{ .format = V4L2_PIX_FMT_NV12_16L16,	.pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2,
> +		  .block_w = { 16, 16, 0, 0 }, .block_h = { 16, 16, 0, 0 } },

Not necessarily related to this patch, but I'm a bit puzzled by why
V4L2_PIX_FMT_NV12_4L4 doesn't list block sizes.

>  
>  		/* YUV planar formats, non contiguous variant */
>  		{ .format = V4L2_PIX_FMT_YUV420M, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },

-- 
Regards,

Laurent Pinchart
