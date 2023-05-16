Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05824704D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjEPLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjEPLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:55:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD64EC9;
        Tue, 16 May 2023 04:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684238127; x=1715774127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=knujkUVORLngJkhlpo1TdAZbLfbVd1SEdQ2fkT8hbY4=;
  b=kRE/LNju3x/AZp0muIxgfY296vNPdH9zVscaiGy/MXb/Q7jr4nBw4Hg6
   Cucd6lpFv/SgufOJOpiTW5uTzT1ij0kBmkZyYJ13FMonRRo++q/Ce98IU
   Ww5ctmaPsxvLjiL/G8hKFE1NVTmWuefP4tKo57KegKFd6IFnMC2Zj/inK
   g0fdTQkXoU9u+vmTNMfzdGS/84OXWKStf7M89zlau6p5UTEs7QeANUYu4
   d1w9f/mIJH6dtNiAy/X7JyGnhuz9uTt4rDbYSVJ6+PUYB3lDui1f6QjKV
   I1rzsrOoJvfhTF6yPok0l5Jn36kDqy1c9SgFzK9L0CMO2rRq8jW4YsMr9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="379630432"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379630432"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="704371780"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="704371780"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:54:50 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 00AC6120279;
        Tue, 16 May 2023 14:54:47 +0300 (EEST)
Date:   Tue, 16 May 2023 11:54:47 +0000
From:   Sakari Ailus <sakari.ailus@intel.com>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Subject: Re: [PATCH v2] media: uapi: v4l: Intel metadata format update
Message-ID: <ZGNvBySOEbBQrflJ@kekkonen.localdomain>
References: <e16ddf4fdb83f30899e575b218e524f6346a9f50.camel@intel.com>
 <ZFoESmKficDbqwFv@kekkonen.localdomain>
 <6de8f9611e5bcf20d7d30e6d26d78f146316b164.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de8f9611e5bcf20d7d30e6d26d78f146316b164.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, May 16, 2023 at 11:10:02AM +0300, Dmitry Perchanov wrote:
> On Tue, 2023-05-09 at 11:28 +0300, Sakari Ailus wrote:
> > Hi Dmitry,
> > 
> > Thanks for the patch.
> > 
> > No need to cc me to my @iki.fi address, I do read both. :-)
> Good.
> > 
> > On Tue, May 09, 2023 at 11:24:53AM +0300, Dmitry Perchanov wrote:
> > > Update metadata structure for Intel RealSense UVC/MIPI cameras.
> > > Compliant to Intel Configuration version 3.
> > > 
> > > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > > ---
> > 
> > Please detail here what changed between patch versions in future versions
> > of the patch.
> Intel Configuration:
> version 2: gpioInputData added to md_configuration (with its flag)
> version 3: sub_preset_info added to md_configuration (with its flag)
> > 
> > >  .../media/v4l/pixfmt-meta-d4xx.rst            | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > > index 4e437ba97a0e..b5decde640c1 100644
> > > --- a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > > +++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> > > @@ -12,7 +12,7 @@ Intel D4xx UVC Cameras Metadata
> > >  Description
> > >  ===========
> > >  
> > > -Intel D4xx (D435 and other) cameras include per-frame metadata in their UVC
> > > +Intel D4xx (D435, D455 and others) cameras include per-frame metadata in their UVC
> > >  payload headers, following the Microsoft(R) UVC extension proposal [1_]. That
> > >  means, that the private D4XX metadata, following the standard UVC header, is
> > >  organised in blocks. D4XX cameras implement several standard block types,
> > > @@ -26,6 +26,8 @@ V4L2_META_FMT_UVC with the only difference, that it also includes proprietary
> > >  payload header data. D4xx cameras use bulk transfers and only send one payload
> > >  per frame, therefore their headers cannot be larger than 255 bytes.
> > >  
> > > +This document implements Intel Configuration version 3.
> > 
> > Which version was described here before this patch?
> Before that patch it was "Intel Configuration version 1"
> > 
> > Are there devices that use that presumably different version? Or does
> > this depend on e.g. firmware version?
> These changes are extensions and backward compatible with old firmware.
> Users are notified in case firmware too old and some features disabled.

The "Laser mode" below is replaced by three different fields. Was this a
bug in the document or a change between versions 1 and 3? In the former
case there should be another patch to fix it, in the latter both versions
should continue to be described as they are supported.

> > 
> > > +
> > >  Below are proprietary Microsoft style metadata types, used by D4xx cameras,
> > >  where all fields are in little endian order:
> > >  
> > > @@ -43,7 +45,7 @@ where all fields are in little endian order:
> > >      * - __u32 ID
> > >        - 0x80000000
> > >      * - __u32 Size
> > > -      - Size in bytes (currently 56)
> > > +      - Size in bytes (currently 60)
> > >      * - __u32 Version
> > >        - Version of this structure. The documentation herein corresponds to
> > >          version xxx. The version number will be incremented when new fields are
> > > @@ -72,8 +74,11 @@ where all fields are in little endian order:
> > >        - Bottom border of the AE Region of Interest
> > >      * - __u32 Preset
> > >        - Preset selector value, default: 0, unless changed by the user
> > > -    * - __u32 Laser mode
> > > +    * - __u8 Emitter mode
> > >        - 0: off, 1: on
> > > +    * - __u8 RFU byte
> > > +    * - __u16 LED Power
> > > +      - Led power value 0-360 (F416 SKU)
> > >      * - :cspan:`1` *Capture Timing*
> > >      * - __u32 ID
> > >        - 0x80000001
> > > @@ -124,6 +129,14 @@ where all fields are in little endian order:
> > >        - Requested frame rate per second
> > >      * - __u16 Trigger
> > >        - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external trigger
> > > +    * - __u16 Calibration count
> > > +    * - __u8 GPIO input data
> > > +      - GPIO readout
> > > +      - Supported from FW 5.12.7.0
> > > +    * - __u32 Sub-preset info
> > > +      - Sub-preset choice information
> > > +    * - __u8 reserved
> > > +      - RFU byte.

Could you add to the documentation of these fields they're only valid for
v3?

> > >  
> > >  .. _1:
> > >  
> 

-- 
Kind regards,

Sakari Ailus
