Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5321A6FC1C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjEII3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjEII3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:29:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242347AA4;
        Tue,  9 May 2023 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683620943; x=1715156943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QklFANz41zfHggoGCeqeOq85zsRdgLvTCf5+ZZoErWs=;
  b=IQvFyLyD9pGpgG+N9wVHS+4T3BtxKt2PTHZkjPXTgvo0JbQ+2k0nQqmd
   IYg/ZtqtbkVt/EDGK7QxAtZoFoxDIgEZXn+hh/7N2xLT6CiCaNxgnR0GH
   n2p4wq6mbERBphGzbN9CRuhTN8iHPkS625lrUh7MWoNnfaDLSIOiCSQOc
   so/KWL34uc3ZjBGBWAX4SmodDhiZb5YWpPbf0nZSsOjSMiRg1HGZn6kKk
   f30F0HYWolRkyU1WYHcu7Tmo7xI+q7bWrVx1/D7yl7oL1KO8/8uBebocn
   PylpT5BkgV/ciZ+U31c0RhbHV3yu8NazdTytcP8+CPy6/CXbCntABnXrM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334286453"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="334286453"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 01:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="873083056"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="873083056"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 01:29:00 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 226B212231C;
        Tue,  9 May 2023 11:28:58 +0300 (EEST)
Date:   Tue, 9 May 2023 11:28:58 +0300
From:   Sakari Ailus <sakari.ailus@intel.com>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Subject: Re: [PATCH v2] media: uapi: v4l: Intel metadata format update
Message-ID: <ZFoESmKficDbqwFv@kekkonen.localdomain>
References: <e16ddf4fdb83f30899e575b218e524f6346a9f50.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16ddf4fdb83f30899e575b218e524f6346a9f50.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for the patch.

No need to cc me to my @iki.fi address, I do read both. :-)

On Tue, May 09, 2023 at 11:24:53AM +0300, Dmitry Perchanov wrote:
> Update metadata structure for Intel RealSense UVC/MIPI cameras.
> Compliant to Intel Configuration version 3.
> 
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> ---

Please detail here what changed between patch versions in future versions
of the patch.

>  .../media/v4l/pixfmt-meta-d4xx.rst            | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> index 4e437ba97a0e..b5decde640c1 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
> @@ -12,7 +12,7 @@ Intel D4xx UVC Cameras Metadata
>  Description
>  ===========
>  
> -Intel D4xx (D435 and other) cameras include per-frame metadata in their UVC
> +Intel D4xx (D435, D455 and others) cameras include per-frame metadata in their UVC
>  payload headers, following the Microsoft(R) UVC extension proposal [1_]. That
>  means, that the private D4XX metadata, following the standard UVC header, is
>  organised in blocks. D4XX cameras implement several standard block types,
> @@ -26,6 +26,8 @@ V4L2_META_FMT_UVC with the only difference, that it also includes proprietary
>  payload header data. D4xx cameras use bulk transfers and only send one payload
>  per frame, therefore their headers cannot be larger than 255 bytes.
>  
> +This document implements Intel Configuration version 3.

Which version was described here before this patch?

Are there devices that use that presumably different version? Or does
this depend on e.g. firmware version?

> +
>  Below are proprietary Microsoft style metadata types, used by D4xx cameras,
>  where all fields are in little endian order:
>  
> @@ -43,7 +45,7 @@ where all fields are in little endian order:
>      * - __u32 ID
>        - 0x80000000
>      * - __u32 Size
> -      - Size in bytes (currently 56)
> +      - Size in bytes (currently 60)
>      * - __u32 Version
>        - Version of this structure. The documentation herein corresponds to
>          version xxx. The version number will be incremented when new fields are
> @@ -72,8 +74,11 @@ where all fields are in little endian order:
>        - Bottom border of the AE Region of Interest
>      * - __u32 Preset
>        - Preset selector value, default: 0, unless changed by the user
> -    * - __u32 Laser mode
> +    * - __u8 Emitter mode
>        - 0: off, 1: on
> +    * - __u8 RFU byte
> +    * - __u16 LED Power
> +      - Led power value 0-360 (F416 SKU)
>      * - :cspan:`1` *Capture Timing*
>      * - __u32 ID
>        - 0x80000001
> @@ -124,6 +129,14 @@ where all fields are in little endian order:
>        - Requested frame rate per second
>      * - __u16 Trigger
>        - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external trigger
> +    * - __u16 Calibration count
> +    * - __u8 GPIO input data
> +      - GPIO readout
> +      - Supported from FW 5.12.7.0
> +    * - __u32 Sub-preset info
> +      - Sub-preset choice information
> +    * - __u8 reserved
> +      - RFU byte.
>  
>  .. _1:
>  

-- 
Kind regards,

Sakari Ailus
