Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE4728258
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjFHOJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjFHOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:09:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FCB2726;
        Thu,  8 Jun 2023 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233358; x=1717769358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7gNlb5Ws7TsWLFBW0xpUZk48cAEveB9ZFyNwMafwQuE=;
  b=SycFZnTZ4mxi/S3quOWmg4hYG97BeqDiWcnRqbIwH9HP0cZYwD/uS1Js
   w6xqBBcgwpOI/FlKHwkkw6thFTUiEFSf7XT5vWLdRHdU6WN4s0EGvyLUX
   GMqbFEFDQ9c0YJy2ulvm2hZAwJma1euGDqB2rXgy/YjvKLfC558hNKsGm
   Tcn0bmZ7W0qK6AByrV54Uo2kfXjyKMSuOqhUDF6j7BdTdJlFgVmatJ5sO
   lqy3BjmYacmZwFESRbXmXzjCEAEA7Ivl+QOB+TySfCbpQTkb21d20sxNz
   jhi7R3Aa5OaWw0wtXj3dnJv+IbjCirxDSiUd8q+XOcHeIi2/xGbJZN5bj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423177066"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423177066"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687383705"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="687383705"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:41:45 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 9F674120BF8;
        Thu,  8 Jun 2023 16:41:42 +0300 (EEST)
Date:   Thu, 8 Jun 2023 13:41:42 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        libcamera-devel@lists.libcamera.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/6] media: v4l2-ctrls: clarify documentation of
 V4L2_CID_FOCUS_RELATIVE
Message-ID: <ZIHalhJgLNCU+Mbt@kekkonen.localdomain>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-2-faa8ad2bc404@wolfvision.net>
 <20230606103618.GB25774@pendragon.ideasonboard.com>
 <46e0aac3-e238-1f32-264c-eed8a849d156@wolfvision.net>
 <20230607064207.GG14101@pendragon.ideasonboard.com>
 <20230607065520.GB4663@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607065520.GB4663@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Jun 07, 2023 at 09:55:20AM +0300, Laurent Pinchart wrote:
> On Wed, Jun 07, 2023 at 09:42:07AM +0300, Laurent Pinchart wrote:
> > On Tue, Jun 06, 2023 at 03:15:33PM +0200, Michael Riesch wrote:
> > > On 6/6/23 12:36, Laurent Pinchart wrote:
> > > > On Tue, Apr 25, 2023 at 11:45:12AM +0200, Michael Riesch wrote:
> > > >> The control V4L2_CID_FOCUS_RELATIVE only makes sense if the device cannot
> > > >> handle absolute focal point positioning with V4L2_CID_FOCUS_ABSOLUTE.
> > > >> Clarify this in the documentation.
> > > >>
> > > >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> > > >> ---
> > > >>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 +++-
> > > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > > >> index df29150dce7b..42cf4c3cda0c 100644
> > > >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > > >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> > > >> @@ -147,7 +147,9 @@ enum v4l2_exposure_metering -
> > > >>      This control moves the focal point of the camera by the specified
> > > >>      amount. The unit is undefined. Positive values move the focus closer
> > > >>      to the camera, negative values towards infinity. This is a
> > > >> -    write-only control.
> > > >> +    write-only control. It should be implemented only if the device cannot
> > > >> +    handle absolute values.
> > > >> +
> > > > 
> > > > Extra blank line.
> > > 
> > > Will fix that.
> > > 
> > > > I don't think this is right. The control was added for the UVC driver,
> > > > and there are devices that implement both absolute and relative focus.
> > > 
> > > I am by no means an expert here and just following Sakari's suggestion
> > > here (see [0]). I can drop the patch, leave it as-is, or modify it.
> > > Whatever makes sense to you guys. But maybe I should leave this to
> > > someone more knowledgeable in this area and drop the patch from my
> > > series. The changes above are completely orthogonal to my work.
> > 
> > V4L2_CID_FOCUS_RELATIVE is an annoying control. It was introduced for
> > UVC, and to my surprise, it turns out it has never been implemented in
> > the uvcvideo driver. The 3 devices I know of that implement the UVC
> > relative focus control also implement the UVC absolute focus control.
> > 
> > I'm tempted to deprecate this control completely. Sakari, any opinion ?
> 
> This is how the UVC relative focus control is defined.
> 
>   4.2.2.1.7 Focus (Relative) Control
> 
>   The Focus (Relative) Control is used to move the focus lens group to
>   specify the distance to the optimally focused target.
> 
>   The bFocusRelative field indicates whether the focus lens group is
>   stopped or is moving for near or for infinity direction. A value of 1
>   indicates that the focus lens group is moved for near direction. A
>   value of 0 indicates that the focus lens group is stopped. And a value
>   of 0xFF indicates that the lens group is moved for infinity direction.
>   The GET_MIN, GET_MAX, GET_RES and GET_DEF requests will return zero
>   for this field.
> 
>   The bSpeed field indicates the speed of the lens group movement. A low
>   number indicates a slow speed and a high number indicates a high
>   speed. The GET_MIN, GET_MAX and GET_RES requests are used to retrieve
>   the range and resolution for this field. The GET_DEF request is used
>   to retrieve the default value for this field. If the control does not
>   support speed control, it will return the value 1 in this field for
>   all these requests.
> 
>   If both Relative and Absolute Controls are supported, a SET_CUR to the
>   Relative Control with a value other than 0x00 shall result in a
>   Control Change interrupt for the Absolute Control at the end of the
>   movement (see section 2.4.2.2, “Status Interrupt Endpoint”). The end
>   of movement can be due to physical device limits, or due to an
>   explicit request by the host to stop the movement. If the end of
>   movement is due to physical device limits (such as a limit in range of
>   motion), a Control Change interrupt shall be generated for this
>   Relative Control. If there is no limit in range of motion, a Control
>   Change interrupt is not required.
> 
> It seems there's no way we can just map this to V4L2_CID_FOCUS_RELATIVE,
> making the V4L2 relative focus control quite useless.

I'd deprecate this control as it doesn't have any use.

The control documentation + other references in V4L2 control framework
could be even removed but the control ID definition needs to stay as user
space may refer to it.

-- 
Regards,

Sakari Ailus
