Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFA97254B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjFGGuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjFGGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:49:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E591723;
        Tue,  6 Jun 2023 23:49:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98AE82B6;
        Wed,  7 Jun 2023 08:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686120561;
        bh=KjFaGkzgKPn0rqVPEjvc32sm1Awsw/gV5qKp3dzqOMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2Dqs7fjHNqRDUlghHGiItQqlIceJj4p4vt3VogeCV8ljxw5HRvqxsQ7J714h3D6X
         2dMdjiKOaUhccqqLJ7+ZG7C6h3zrPPAtN8UstjzuJsD8GytKVdJQkc36XUTe/s/M+w
         Ed8QtiF+NkMmUMhkpt9OMvkrYfaqakI1blN9ne5I=
Date:   Wed, 7 Jun 2023 09:49:44 +0300
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
Message-ID: <20230607064944.GA4663@pendragon.ideasonboard.com>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-1-faa8ad2bc404@wolfvision.net>
 <20230606103421.GA25774@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606103421.GA25774@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:34:21PM +0300, Laurent Pinchart wrote:
> On Tue, Apr 25, 2023 at 11:45:11AM +0200, Michael Riesch wrote:
> > The current unit description of the V4L2_CID_FOCUS_ABSOLUTE does not
> > make sense and was probably copy-pasted from V4L2_CID_FOCUS_RELATIVE.
> > Fix the unit description in the documentation.
> > 
> > Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> > ---
> >  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > index daa4f40869f8..df29150dce7b 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > @@ -140,8 +140,8 @@ enum v4l2_exposure_metering -
> >  
> >  ``V4L2_CID_FOCUS_ABSOLUTE (integer)``
> >      This control sets the focal point of the camera to the specified
> > -    position. The unit is undefined. Positive values set the focus
> > -    closer to the camera, negative values towards infinity.
> > +    position. The unit is undefined. Larger values move the focus closer to
> > +    the camera, smaller values move the focus to infinity.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I just noticed that the UVC specification states

  4.2.2.1.6 Focus (Absolute) Control

  The Focus (Absolute) Control is used to specify the distance to the
  optimally focused target. This value is expressed in millimeters. The
  default value is implementation-specific.

This is the opposite of the V4L2_CID_FOCUS_ABSOLUTE control :-( I
suppose this will need to be solved in the uvcvideo driver by converting
the value.

> >  
> >  ``V4L2_CID_FOCUS_RELATIVE (integer)``
> >      This control moves the focal point of the camera by the specified
> > 

-- 
Regards,

Laurent Pinchart
