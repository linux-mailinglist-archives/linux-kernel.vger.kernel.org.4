Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00D0725488
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjFGGmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjFGGmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:42:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FCF196;
        Tue,  6 Jun 2023 23:42:12 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B0AF2B6;
        Wed,  7 Jun 2023 08:41:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686120104;
        bh=cH1WjxZXB0Q95UrEgS6nQTqmxFYodH8lXytDlFCSxEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9RXxatOayeh6jXiCSpYbaC7LmIXFRv/3LANilIw80P+KNO8TFTYyAcZaZItzJBjh
         XCe1x8PWt51lldPTI3ePCxGaC774np+KvzIFiB3UFf5l93UCVRbStKGZHaPR02ZcG9
         OGD3Z8ZNdbfYOJwVEe+5dZWdz5P9bnnfVJ7KhSms=
Date:   Wed, 7 Jun 2023 09:42:07 +0300
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
Message-ID: <20230607064207.GG14101@pendragon.ideasonboard.com>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-2-faa8ad2bc404@wolfvision.net>
 <20230606103618.GB25774@pendragon.ideasonboard.com>
 <46e0aac3-e238-1f32-264c-eed8a849d156@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46e0aac3-e238-1f32-264c-eed8a849d156@wolfvision.net>
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

On Tue, Jun 06, 2023 at 03:15:33PM +0200, Michael Riesch wrote:
> On 6/6/23 12:36, Laurent Pinchart wrote:
> > On Tue, Apr 25, 2023 at 11:45:12AM +0200, Michael Riesch wrote:
> >> The control V4L2_CID_FOCUS_RELATIVE only makes sense if the device cannot
> >> handle absolute focal point positioning with V4L2_CID_FOCUS_ABSOLUTE.
> >> Clarify this in the documentation.
> >>
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >> ---
> >>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >> index df29150dce7b..42cf4c3cda0c 100644
> >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >> @@ -147,7 +147,9 @@ enum v4l2_exposure_metering -
> >>      This control moves the focal point of the camera by the specified
> >>      amount. The unit is undefined. Positive values move the focus closer
> >>      to the camera, negative values towards infinity. This is a
> >> -    write-only control.
> >> +    write-only control. It should be implemented only if the device cannot
> >> +    handle absolute values.
> >> +
> > 
> > Extra blank line.
> 
> Will fix that.
> 
> > I don't think this is right. The control was added for the UVC driver,
> > and there are devices that implement both absolute and relative focus.
> 
> I am by no means an expert here and just following Sakari's suggestion
> here (see [0]). I can drop the patch, leave it as-is, or modify it.
> Whatever makes sense to you guys. But maybe I should leave this to
> someone more knowledgeable in this area and drop the patch from my
> series. The changes above are completely orthogonal to my work.

V4L2_CID_FOCUS_RELATIVE is an annoying control. It was introduced for
UVC, and to my surprise, it turns out it has never been implemented in
the uvcvideo driver. The 3 devices I know of that implement the UVC
relative focus control also implement the UVC absolute focus control.

I'm tempted to deprecate this control completely. Sakari, any opinion ?

> >>  
> >>  ``V4L2_CID_FOCUS_AUTO (boolean)``
> >>      Enables continuous automatic focus adjustments. The effect of manual
> >>
> > 
> 
> [0] https://lore.kernel.org/all/ZDbChgZJHVaaX3%2Fx@kekkonen.localdomain/

-- 
Regards,

Laurent Pinchart
