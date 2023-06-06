Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15372723FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjFFKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjFFKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:34:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2FE6B;
        Tue,  6 Jun 2023 03:34:33 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B40891221;
        Tue,  6 Jun 2023 12:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686047646;
        bh=3Lz2WwH045DCLuuNkD5PiOW6ef8Go3uox42/mpTxb1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wi3PjteNXSBn1kMMbT6bq1L85AyaEkyDzBq+iW4+sce2ecMxPHrCoPH+wy//h0JQ4
         tFSnI4xglZEceOSQCwwDQM6N9G7e6zlvJ5xUyPEO1ZCVgoMJqcqjPa/WEmOQwk9kDD
         mMsJMGYN4bM2t1t9DBHmuhMeNu95O1zTLmkiMAho=
Date:   Tue, 6 Jun 2023 13:34:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] media: v4l2-ctrls: fix documentation of
 V4L2_CID_FOCUS_ABSOLUTE unit
Message-ID: <20230606103421.GA25774@pendragon.ideasonboard.com>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-1-faa8ad2bc404@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406-feature-controls-lens-v2-1-faa8ad2bc404@wolfvision.net>
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

On Tue, Apr 25, 2023 at 11:45:11AM +0200, Michael Riesch wrote:
> The current unit description of the V4L2_CID_FOCUS_ABSOLUTE does not
> make sense and was probably copy-pasted from V4L2_CID_FOCUS_RELATIVE.
> Fix the unit description in the documentation.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> index daa4f40869f8..df29150dce7b 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> @@ -140,8 +140,8 @@ enum v4l2_exposure_metering -
>  
>  ``V4L2_CID_FOCUS_ABSOLUTE (integer)``
>      This control sets the focal point of the camera to the specified
> -    position. The unit is undefined. Positive values set the focus
> -    closer to the camera, negative values towards infinity.
> +    position. The unit is undefined. Larger values move the focus closer to
> +    the camera, smaller values move the focus to infinity.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  ``V4L2_CID_FOCUS_RELATIVE (integer)``
>      This control moves the focal point of the camera by the specified
> 

-- 
Regards,

Laurent Pinchart
