Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5957254E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbjFGGzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbjFGGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:55:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13181993;
        Tue,  6 Jun 2023 23:55:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 67D9F2B6;
        Wed,  7 Jun 2023 08:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686120897;
        bh=pl8iHrx1+eJV9KarURsCW13zafYyh7TW6Czobu2+Kw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=We95JnrrNqMUhclAID1oiOb3eL6ui9ellrIcRl4e3HlzJitsiO6LpY/i34EpaVvGV
         ZhZg0f7qx7y5ohVvsfG6D5HBBYD3cuhEumaTLdVPQmbz35p1eUTeysPrnRmAJzWqWI
         agtL7iSWYjMTcwXT0laPeHSF0xrLOoDpOJdxMGKA=
Date:   Wed, 7 Jun 2023 09:55:20 +0300
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
Message-ID: <20230607065520.GB4663@pendragon.ideasonboard.com>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-2-faa8ad2bc404@wolfvision.net>
 <20230606103618.GB25774@pendragon.ideasonboard.com>
 <46e0aac3-e238-1f32-264c-eed8a849d156@wolfvision.net>
 <20230607064207.GG14101@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607064207.GG14101@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:42:07AM +0300, Laurent Pinchart wrote:
> On Tue, Jun 06, 2023 at 03:15:33PM +0200, Michael Riesch wrote:
> > On 6/6/23 12:36, Laurent Pinchart wrote:
> > > On Tue, Apr 25, 2023 at 11:45:12AM +0200, Michael Riesch wrote:
> > >> The control V4L2_CID_FOCUS_RELATIVE only makes sense if the device cannot
> > >> handle absolute focal point positioning with V4L2_CID_FOCUS_ABSOLUTE.
> > >> Clarify this in the documentation.
> > >>
> > >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> > >> ---
> > >>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 +++-
> > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > >> index df29150dce7b..42cf4c3cda0c 100644
> > >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > >> @@ -147,7 +147,9 @@ enum v4l2_exposure_metering -
> > >>      This control moves the focal point of the camera by the specified
> > >>      amount. The unit is undefined. Positive values move the focus closer
> > >>      to the camera, negative values towards infinity. This is a
> > >> -    write-only control.
> > >> +    write-only control. It should be implemented only if the device cannot
> > >> +    handle absolute values.
> > >> +
> > > 
> > > Extra blank line.
> > 
> > Will fix that.
> > 
> > > I don't think this is right. The control was added for the UVC driver,
> > > and there are devices that implement both absolute and relative focus.
> > 
> > I am by no means an expert here and just following Sakari's suggestion
> > here (see [0]). I can drop the patch, leave it as-is, or modify it.
> > Whatever makes sense to you guys. But maybe I should leave this to
> > someone more knowledgeable in this area and drop the patch from my
> > series. The changes above are completely orthogonal to my work.
> 
> V4L2_CID_FOCUS_RELATIVE is an annoying control. It was introduced for
> UVC, and to my surprise, it turns out it has never been implemented in
> the uvcvideo driver. The 3 devices I know of that implement the UVC
> relative focus control also implement the UVC absolute focus control.
> 
> I'm tempted to deprecate this control completely. Sakari, any opinion ?

This is how the UVC relative focus control is defined.

  4.2.2.1.7 Focus (Relative) Control

  The Focus (Relative) Control is used to move the focus lens group to
  specify the distance to the optimally focused target.

  The bFocusRelative field indicates whether the focus lens group is
  stopped or is moving for near or for infinity direction. A value of 1
  indicates that the focus lens group is moved for near direction. A
  value of 0 indicates that the focus lens group is stopped. And a value
  of 0xFF indicates that the lens group is moved for infinity direction.
  The GET_MIN, GET_MAX, GET_RES and GET_DEF requests will return zero
  for this field.

  The bSpeed field indicates the speed of the lens group movement. A low
  number indicates a slow speed and a high number indicates a high
  speed. The GET_MIN, GET_MAX and GET_RES requests are used to retrieve
  the range and resolution for this field. The GET_DEF request is used
  to retrieve the default value for this field. If the control does not
  support speed control, it will return the value 1 in this field for
  all these requests.

  If both Relative and Absolute Controls are supported, a SET_CUR to the
  Relative Control with a value other than 0x00 shall result in a
  Control Change interrupt for the Absolute Control at the end of the
  movement (see section 2.4.2.2, “Status Interrupt Endpoint”). The end
  of movement can be due to physical device limits, or due to an
  explicit request by the host to stop the movement. If the end of
  movement is due to physical device limits (such as a limit in range of
  motion), a Control Change interrupt shall be generated for this
  Relative Control. If there is no limit in range of motion, a Control
  Change interrupt is not required.

It seems there's no way we can just map this to V4L2_CID_FOCUS_RELATIVE,
making the V4L2 relative focus control quite useless.

> > >>  
> > >>  ``V4L2_CID_FOCUS_AUTO (boolean)``
> > >>      Enables continuous automatic focus adjustments. The effect of manual
> > >>
> > 
> > [0] https://lore.kernel.org/all/ZDbChgZJHVaaX3%2Fx@kekkonen.localdomain/

-- 
Regards,

Laurent Pinchart
