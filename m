Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5373064087F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiLBOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiLBOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:33:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D60D388C;
        Fri,  2 Dec 2022 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669991599; x=1701527599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n2a/CpHAAbyq8nKYEBLb4Z+TMWPhb76u70lEuNyc05Y=;
  b=URtaxaqGFZltZ8Yn7PQfqcCXVd9C+u25zAtpIGicWBrtJGxzipzXDPMk
   q9lDVL28bvoEdY1m3oPxR4whJtV84/Ue5WctraId/CiFwdFMAQPY07Fel
   IjAuR+zM6SWFphKUl36qn+cuQzRELoRcG29OIVEzqqLP6LTZCILbAaRnu
   YVeaYagK19+t3WfwVMySru1UDRupySiE9fJeVkIwxLzK/AQDlR+zZXkHV
   dpn5QL8iXM7bsaHF8oSxC9KYozQdAlh0GBAKe/28SDGpuoGVo8STobEqh
   jxpAf+pN3dzwRpzsJUgBDX8RtaZPdbT+I7fDE5Rn57dCWqGt03fq3sH/H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314665456"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="314665456"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 06:33:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="677614996"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="677614996"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 06:33:14 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id F0A3220363;
        Fri,  2 Dec 2022 16:24:28 +0200 (EET)
Date:   Fri, 2 Dec 2022 14:24:28 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jammy Huang <jammy_huang@aspeedtech.com>
Cc:     eajames@linux.ibm.com, mchehab@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, xavier.roumegue@oss.nxp.com,
        ezequiel@vanguardiasur.com.ar, stanimir.varbanov@linaro.org,
        nicolas.dufresne@collabora.com, ming.qian@nxp.com,
        andrzej.p@collabora.com, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/5] media: Documentation: aspeed-video: Add user
 documentation for the aspeed-video driver
Message-ID: <Y4oKnBDnvliD8cJb@paasikivi.fi.intel.com>
References: <20221028023554.928-1-jammy_huang@aspeedtech.com>
 <20221028023554.928-4-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028023554.928-4-jammy_huang@aspeedtech.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jammy,

On Fri, Oct 28, 2022 at 10:35:52AM +0800, Jammy Huang wrote:
> Add user documentation for the aspeed-video driver.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
> v11:
>   - update the way to change format
> v10:
>   - new
> ---
>  .../media/drivers/aspeed-video.rst            | 61 +++++++++++++++++++
>  .../userspace-api/media/drivers/index.rst     |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.rst
> 
> diff --git a/Documentation/userspace-api/media/drivers/aspeed-video.rst b/Documentation/userspace-api/media/drivers/aspeed-video.rst
> new file mode 100644
> index 000000000000..e5656a8d990e
> --- /dev/null
> +++ b/Documentation/userspace-api/media/drivers/aspeed-video.rst
> @@ -0,0 +1,65 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: <isonum.txt>
> +
> +ASPEED video driver
> +===================
> +
> +ASPEED Video Engine found on AST2400/2500/2600 SoC supports high performance
> +video compressions with a wide range of video quality and compression ratio
> +options. The adopted compressing algorithm is a modified JPEG algorithm.
> +
> +There are 2 types of compressions in this IP.
> +
> +* JPEG JFIF standard mode: for single frame and management compression
> +* ASPEED proprietary mode: for multi-frame and differential compression.
> +  Support 2-pass (high quality) video compression scheme (Patent pending by
> +  ASPEED). Provide visually lossless video compression quality or to reduce
> +  the network average loading under intranet KVM applications.
> +
> +VIDIOC_S_FMT can be used to choose which format you want. V4L2_PIX_FMT_JPEG
> +stands for JPEG JFIF standard mode; V4L2_PIX_FMT_AJPG stands for ASPEED
> +proprietary mode.
> +
> +More details on the ASPEED video hardware operations can be found in
> +*chapter 6.2.16 KVM Video Driver* of SDK_User_Guide which available on
> +AspeedTech-BMC/openbmc/releases.

Same comment on this, what does this refer to?

> +
> +The ASPEED video driver implements the following driver-specific control:
> +
> +``V4L2_CID_ASPEED_HQ_MODE``
> +-------------------------------
> +    Enable/Disable ASPEED's High quality mode. This is a private control
> +    that can be used to enable high quality for aspeed proprietary mode.
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 4
> +
> +    * - ``(0)``
> +      - ASPEED HQ mode is disabled.
> +    * - ``(1)``
> +      - ASPEED HQ mode is enabled.
> +
> +``V4L2_CID_ASPEED_HQ_JPEG_QUALITY``
> +-------------------------------
> +    Define the quality of ASPEED's High quality mode. This is a private control
> +    that can be used to decide compression quality if High quality mode enabled
> +    . Higher the value, better the quality and bigger the size.
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 4
> +
> +    * - ``(1)``
> +      - minimum
> +    * - ``(12)``
> +      - maximum
> +    * - ``(1)``
> +      - step
> +    * - ``(1)``
> +      - default
> +
> +**Copyright** |copy| 2022 ASPEED Technology Inc.
> diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
> index 32f82aed47d9..46a494e00b72 100644
> --- a/Documentation/userspace-api/media/drivers/index.rst
> +++ b/Documentation/userspace-api/media/drivers/index.rst
> @@ -31,6 +31,7 @@ For more details see the file COPYING in the source distribution of Linux.
>  	:maxdepth: 5
>  	:numbered:
>  
> +	aspeed-video
>  	ccs
>  	cx2341x-uapi
>  	dw100

-- 
Kind regards,

Sakari Ailus
