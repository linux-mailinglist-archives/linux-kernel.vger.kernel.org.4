Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F686723FC2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbjFFKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjFFKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:37:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88B10FB;
        Tue,  6 Jun 2023 03:36:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D356A1221;
        Tue,  6 Jun 2023 12:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686047755;
        bh=biVLKsT44hZdITyP0tgFesm18vuBods/TDQ/DGnqbVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMo32PpiPT6GyJLXuZOrPei9Uztqe/JW3nOkL3fO/YVxXKItPyK8S5PktZX3FfbQ7
         5UB0lP52cBUvMBO23hh91xRpKL6ZBbajA2wHvOG5l1eB37HHNP8pm2UYnjqSNAdw8V
         dab1OhIP8MssRPcnLLVHV0tQj83PrENqtXpNTFrw=
Date:   Tue, 6 Jun 2023 13:36:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/6] media: v4l2-ctrls: clarify documentation of
 V4L2_CID_FOCUS_RELATIVE
Message-ID: <20230606103618.GB25774@pendragon.ideasonboard.com>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-2-faa8ad2bc404@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406-feature-controls-lens-v2-2-faa8ad2bc404@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch.

On Tue, Apr 25, 2023 at 11:45:12AM +0200, Michael Riesch wrote:
> The control V4L2_CID_FOCUS_RELATIVE only makes sense if the device cannot
> handle absolute focal point positioning with V4L2_CID_FOCUS_ABSOLUTE.
> Clarify this in the documentation.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> index df29150dce7b..42cf4c3cda0c 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> @@ -147,7 +147,9 @@ enum v4l2_exposure_metering -
>      This control moves the focal point of the camera by the specified
>      amount. The unit is undefined. Positive values move the focus closer
>      to the camera, negative values towards infinity. This is a
> -    write-only control.
> +    write-only control. It should be implemented only if the device cannot
> +    handle absolute values.
> +

Extra blank line.

I don't think this is right. The control was added for the UVC driver,
and there are devices that implement both absolute and relative focus.

>  
>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>      Enables continuous automatic focus adjustments. The effect of manual
> 

-- 
Regards,

Laurent Pinchart
