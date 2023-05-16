Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6676670476D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjEPIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEPIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:10:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974033C03;
        Tue, 16 May 2023 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684224612; x=1715760612;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NF9NvwTdXXqVhIHz9LF/D+48Yj0cNaUd22qY6gHOA5I=;
  b=kw6gyES7/vaOHpOGii74iZeJ7DPOA+dWjG2ClALeafKaLUeInvE5tpmp
   gyZH4A/d+3Fv+LDJccMDyBeFSs7pGUcHnu8BOVqGOHxHYXCFjWZLumuhy
   6Jyi18okpKSjPz/0lkXdkfrl4bvFw9CPT6sdjn3gjy+JUBSV7OqtKeTia
   6QMy04pFlCswytrT77+CVHsibJbVlEA0dKuF4eHn7jGwQ9wp3zk+Lc7Ib
   MOULXrYz6m1fFRzCm/UT/outoLhqPEkWCFJtA25nYqgpbZy4kphPwasum
   BMJrty8LNm6+9TDpyEbKS1Dq1aLF0fOPvg1bUuoNCkudonPpRaRCkNv0M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331776786"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331776786"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="875522820"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="875522820"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([143.185.115.141])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:10:04 -0700
Message-ID: <6de8f9611e5bcf20d7d30e6d26d78f146316b164.camel@intel.com>
Subject: Re: [PATCH v2] media: uapi: v4l: Intel metadata format update
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Sakari Ailus <sakari.ailus@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Date:   Tue, 16 May 2023 11:10:02 +0300
In-Reply-To: <ZFoESmKficDbqwFv@kekkonen.localdomain>
References: <e16ddf4fdb83f30899e575b218e524f6346a9f50.camel@intel.com>
         <ZFoESmKficDbqwFv@kekkonen.localdomain>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-09 at 11:28 +0300, Sakari Ailus wrote:
> Hi Dmitry,
> =

> Thanks for the patch.
> =

> No need to cc me to my @iki.fi address, I do read both. :-)
Good.
> =

> On Tue, May 09, 2023 at 11:24:53AM +0300, Dmitry Perchanov wrote:
> > Update metadata structure for Intel RealSense UVC/MIPI cameras.
> > Compliant to Intel Configuration version 3.
> > =

> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > ---
> =

> Please detail here what changed between patch versions in future versions
> of the patch.
Intel Configuration:
version 2: gpioInputData added to md_configuration (with its flag)
version 3: sub_preset_info added to md_configuration (with its flag)
> =

> >  .../media/v4l/pixfmt-meta-d4xx.rst            | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > =

> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst=
 b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > index 4e437ba97a0e..b5decde640c1 100644
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

> > +This document implements Intel Configuration version 3.
> =

> Which version was described here before this patch?
Before that patch it was "Intel Configuration version 1"
> =

> Are there devices that use that presumably different version? Or does
> this depend on e.g. firmware version?
These changes are extensions and backward compatible with old firmware.
Users are notified in case firmware too old and some features disabled.
> =

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
> > +      - Size in bytes (currently 60)
> >      * - __u32 Version
> >        - Version of this structure. The documentation herein correspond=
s to
> >          version xxx. The version number will be incremented when new f=
ields are
> > @@ -72,8 +74,11 @@ where all fields are in little endian order:
> >        - Bottom border of the AE Region of Interest
> >      * - __u32 Preset
> >        - Preset selector value, default: 0, unless changed by the user
> > -    * - __u32 Laser mode
> > +    * - __u8 Emitter mode
> >        - 0: off, 1: on
> > +    * - __u8 RFU byte
> > +    * - __u16 LED Power
> > +      - Led power value 0-360 (F416 SKU)
> >      * - :cspan:`1` *Capture Timing*
> >      * - __u32 ID
> >        - 0x80000001
> > @@ -124,6 +129,14 @@ where all fields are in little endian order:
> >        - Requested frame rate per second
> >      * - __u16 Trigger
> >        - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external=
 trigger
> > +    * - __u16 Calibration count
> > +    * - __u8 GPIO input data
> > +      - GPIO readout
> > +      - Supported from FW 5.12.7.0
> > +    * - __u32 Sub-preset info
> > +      - Sub-preset choice information
> > +    * - __u8 reserved
> > +      - RFU byte.
> >  =

> >  .. _1:
> >  =


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

