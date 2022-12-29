Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D1659267
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiL2WNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiL2WN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:13:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95486F24;
        Thu, 29 Dec 2022 14:13:26 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 148EB283;
        Thu, 29 Dec 2022 23:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672352004;
        bh=G+C0Y4D8jXrYSM4UkJuyTvJmgZ4ZwyhxuWpB4DOX70o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=utnUdHhYswEMsfYom1MOSzmMwkBMsGM5ctenMnZGsMT0OBdgJ4vEwnLcab3vA9ftC
         bOaLVPTgGien2lxCLs5Q/nPRWFy/1ZXfRLi7wqEHq927pONseelYPlZoMoZL9ottOc
         nPMHtJbQWnDNKAFLMIcJfnUbmpzEaeRL4zR6vf9Q=
Date:   Fri, 30 Dec 2022 00:13:19 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH RESEND v2 0/7] Follow-up patches for uvc v4l2-compliance
Message-ID: <Y64Q/yRRzxt8IByG@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Fri, Dec 02, 2022 at 06:21:34PM +0100, Ricardo Ribalda wrote:
> This patchset contains the fixes for the comments on "v10 of Fix
> v4l2-compliance errors series". In particular to the patches
> 
> -uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
> -uvcvideo: improve error handling in uvc_query_ctrl()
> 
> And the patch:
> -uvcvideo: Fix handling on Bitmask controls

Patches 1/7, 3/7, 4/7 and 6/7 are fine (possibly with changes mentioned
in my review comments that I can handle when applying). I can apply them
to my tree already (with a minor conflict resolution between 2/7 and
3/7), but it may be easier for you to send a v3 of the whole series.
Please let me know what you'd prefer.

> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> ---
> Changes in v2:
> - Include "Get menu names from framework series"
>   https://lore.kernel.org/r/20220920-standard-menues-v2-0-a35af3243c2f@chromium.org
> - Link to v1: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org
> 
> ---
> Hans Verkuil (2):
>       media: uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
>       media: uvcvideo: improve error logging in uvc_query_ctrl()
> 
> Ricardo Ribalda (5):
>       media: uvcvideo: Return -EACCES for Wrong state error
>       media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
>       media: uvcvideo: Fix handling on Bitmask controls
>       media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
>       media: uvcvideo: Use standard names for menus
> 
>  drivers/media/usb/uvc/uvc_ctrl.c   | 230 ++++++++++++++++++++++++++++---------
>  drivers/media/usb/uvc/uvc_driver.c |   9 +-
>  drivers/media/usb/uvc/uvc_v4l2.c   |  85 ++++++++++----
>  drivers/media/usb/uvc/uvc_video.c  |  15 +--
>  drivers/media/usb/uvc/uvcvideo.h   |   8 +-
>  include/uapi/linux/uvcvideo.h      |   3 +-
>  6 files changed, 258 insertions(+), 92 deletions(-)
> ---
> base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> change-id: 20220920-resend-v4l2-compliance-4fdbe4fbd7b5

-- 
Regards,

Laurent Pinchart
