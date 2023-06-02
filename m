Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4511E72050B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbjFBPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjFBPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:00:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42311BD;
        Fri,  2 Jun 2023 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685718011; x=1717254011;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9sLuH+8IQ/Ika7mvXVBVV2ehXzIOipelj6cZtL2v0E=;
  b=GBfxFXOe9zZVi1L297ejKlaKiSefxq6qiA3/JZFaPi2dperxfuw9fuAL
   1ro6tgSu38isZ24d6BPMYbCeCXmeoOQY5oqbWiD3eBM1L7FRzaJ9I2UVo
   kbhuEx/LuctttpUCLS9IO5kclruH9Z0M8x7gK+9iFqKGJ3S/QYHuNdtzI
   EsysSeWDmoHnY6CZOTyYvI0k0VY1tdP/KzaRi+zS2mRO4LqKgxhEKbWHd
   Q25FHoNPrzEBkXThrn8t1T4uZ2k5clSsqOLK9nCTMxu8av/fxBQewjLYN
   4N/Aeqm1QUhfMU6o8nV0X6UhIJsOzs49/NP/M2wffDJWbq1f6Nq+gS0aN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354737148"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="354737148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="740851728"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="740851728"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([10.214.199.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:00:07 -0700
Message-ID: <2eef3b075da7e91b938222a345e3f18f3765619f.camel@intel.com>
Subject: Re: [PATCH v4] media: uapi: v4l: Intel metadata format update
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, sakari.ailus@intel.com,
        Evgeni Raikhel <evgeni.raikhel@intel.com>, demisrael@gmail.com,
        Nir Azkiel <nir.azkiel@intel.com>
Date:   Fri, 02 Jun 2023 18:00:04 +0300
In-Reply-To: <20230602144624.GA3343@pendragon.ideasonboard.com>
References: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
         <944dd3c67fc7e9c1b8d6bd0491d61fdbb9489e70.camel@intel.com>
         <20230602144624.GA3343@pendragon.ideasonboard.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks for review!
I will gladly accept your proposed changes.

Comments inline.

On Fri, 2023-06-02 at 17:46 +0300, Laurent Pinchart wrote:
> Hi Dmitry,
> =

> Thank you for the patch.
> =

> On Thu, Jun 01, 2023 at 07:08:46PM +0300, Dmitry Perchanov wrote:
> > Update metadata structure for Intel RealSense UVC/MIPI cameras.
> > Compliant to Intel Configuration version 3.
> > =

> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > ---
> >  .../media/v4l/pixfmt-meta-d4xx.rst            | 52 ++++++++++++++++---
> >  1 file changed, 46 insertions(+), 6 deletions(-)
> > =

> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst=
 b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > index 4e437ba97a0e..7482f298d0cc 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > @@ -12,7 +12,7 @@ Intel D4xx UVC Cameras Metadata
> >  Description
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  =

> > -Intel D4xx (D435 and other) cameras include per-frame metadata in thei=
r UVC
> > +Intel D4xx (D435, D455 and others) cameras include per-frame metadata =
in their UVC
> >  payload headers, following the Microsoft(R) UVC extension proposal [1_=
]. That
> >  means, that the private D4XX metadata, following the standard UVC head=
er, is
> >  organised in blocks. D4XX cameras implement several standard block typ=
es,
> > @@ -26,6 +26,8 @@ V4L2_META_FMT_UVC with the only difference, that it a=
lso includes proprietary
> >  payload header data. D4xx cameras use bulk transfers and only send one=
 payload
> >  per frame, therefore their headers cannot be larger than 255 bytes.
> >  =

> > +This document implements Intel Configuration version 3 [9_].
> > +
> >  Below are proprietary Microsoft style metadata types, used by D4xx cam=
eras,
> >  where all fields are in little endian order:
> >  =

> > @@ -43,7 +45,7 @@ where all fields are in little endian order:
> >      * - __u32 ID
> >        - 0x80000000
> >      * - __u32 Size
> > -      - Size in bytes (currently 56)
> > +      - Size in bytes, include ID (all protocol versions: 60)
> >      * - __u32 Version
> >        - Version of this structure. The documentation herein correspond=
s to
> >          version xxx. The version number will be incremented when new f=
ields are
> =

> Should this read "version 3" instead of "version xxx" ?

This can read 1, 2 or 3, depends on firmware version.
All cameras have same firmware. The latest will report 3.
> =



> > @@ -72,13 +74,17 @@ where all fields are in little endian order:
> >        - Bottom border of the AE Region of Interest
> >      * - __u32 Preset
> >        - Preset selector value, default: 0, unless changed by the user
> > -    * - __u32 Laser mode
> > -      - 0: off, 1: on
> > +    * - __u8 Emitter mode (v3 only) (__u32 Laser mode for v1) [8_]
> > +      - 0: off, 1: on, same as __u32 Laser mode for v1
> > +    * - __u8 RFU byte (v3 only)
> > +      - Spare byte for future use
> > +    * - __u16 LED Power (v3 only)
> > +      - Led power value 0-360 (F416 SKU)
> >      * - :cspan:`1` *Capture Timing*
> >      * - __u32 ID
> >        - 0x80000001
> >      * - __u32 Size
> > -      - Size in bytes (currently 40)
> > +      - Size in bytes, include ID (all protocol versions: 40)
> >      * - __u32 Version
> >        - Version of this structure. The documentation herein correspond=
s to
> >          version xxx. The version number will be incremented when new f=
ields are
> > @@ -101,7 +107,7 @@ where all fields are in little endian order:
> >      * - __u32 ID
> >        - 0x80000002
> >      * - __u32 Size
> > -      - Size in bytes (currently 40)
> > +      - Size in bytes, include ID (v1:36, v3:40)
> >      * - __u32 Version
> >        - Version of this structure. The documentation herein correspond=
s to
> >          version xxx. The version number will be incremented when new f=
ields are
> > @@ -124,6 +130,14 @@ where all fields are in little endian order:
> >        - Requested frame rate per second
> >      * - __u16 Trigger
> >        - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external=
 trigger
> > +    * - __u16 Calibration count (v3 only)
> > +      - Calibration counter, see [4_] below
> > +    * - __u8 GPIO input data (v3 only)
> > +      - GPIO readout, see [4_] below (Supported from FW 5.12.7.0)
> > +    * - __u32 Sub-preset info (v3 only)
> > +      - Sub-preset choice information, see [4_] below
> > +    * - __u8 reserved (v3 only)
> > +      - RFU byte.
> >  =

> >  .. _1:
> >  =

> > @@ -140,6 +154,8 @@ where all fields are in little endian order:
> >    0x00000010 Exposure priority
> >    0x00000020 AE ROI
> >    0x00000040 Preset
> > +  0x00000080 Emitter mode
> > +  0x00000100 LED Power
> >  =

> >  .. _3:
> >  =

> > @@ -165,6 +181,8 @@ where all fields are in little endian order:
> >    0x00000040 Framerate
> >    0x00000080 Trigger
> >    0x00000100 Cal count
> > +  0x00000200 GPIO Input Data
> > +  0x00000400 Sub-preset Info
> >  =

> >  .. _5:
> >  =

> > @@ -211,3 +229,25 @@ Left sensor: ::
> >  Fish Eye sensor: ::
> >  =

> >    1 RAW8
> > +
> > +.. _8:
> > +
> > +[8] The "Laser mode" is replaced by three different fields.
> =

> "... has been replaced in version 3 by ..."
> =

> > +"Laser" renamed to "Emitter" as there multiple technologies
> =

> s/there/there are/
Accepted. Thanks!

> =

> > +for camera projectors. As we have another field for "Laser Power"
> > +we introduced "LED Power" for extra emitter.
> > +
> > +The __u32 "Laser mode" integer is divided by two bytes and short: ::
> =

> The "Laser mode" __u32 field has been split into: ::
> =

> =

Accepted. Thanks!

> > +   1 __u8 Emitter mode
> > +   2 __u8 RFU byte
> > +   3 __u16 LED Power
> > +
> > +This is a change between versions 1 and 3. All versions 1,2 and 3
> =

> s/1,2/1, 2/
> =

Accepted. Thanks!

> > +are backward compatible with same data format and they are supported.
> > +See [2_] for which attributes are valid.
> > +
> > +.. _9:
> > +
> > +[9]
> > +LibRealSense SDK metadata source:
> =

> I'll remove the blank line after '[9]', that is
> =

> > +[9] LibRealSense SDK metadata source:
> =

Accepted. Thanks!

> I can fix all this when applying if you're fine with the changes.
> =

Yes, I agree. Thank You for your effort!
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> =

> > +https://github.com/IntelRealSense/librealsense/blob/master/src/metadat=
a.h

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

