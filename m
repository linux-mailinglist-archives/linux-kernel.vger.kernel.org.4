Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A76CA0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjC0KLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjC0KLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:11:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FD49E2;
        Mon, 27 Mar 2023 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679911886; x=1711447886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AFVzYvVscPBltqD3h18pegQlgEPHmun/Xuta2F8qlQs=;
  b=HyFWB70bCHkRkdLVYyl67ybl5NQNsX112NadxemVSCmN0DE6CblvtmGG
   3b9lL8kSzl9c0Xf6WuGYuL1mUK7ZJ7nNgFPqiXF0Gu9HKMEJuH9M7t8TY
   MP9NClOL9nS4+2c1+dIIGWJKJTosGGd3o0B7uylF0aLodgjOQgXGN65lu
   6WHCyBHKyVP4L5+AdPv0KzmucQuIp5fwTKrTki+XZ5G5GpN55PHUMYpBD
   nhptd+jcuMMvTNeYbxG9aYZAZ61xYyfaqV2wg25ChsOsf1YU1pY3g5giQ
   4AMGvD0rO3ZgdvsaDKpyW8eo9pBRB1Tmv7DDVLKFR9EXSJmyX71BjJtZ+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367972839"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="367972839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 03:11:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="716025223"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="716025223"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2023 03:11:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgjou-009Af5-2v;
        Mon, 27 Mar 2023 13:11:20 +0300
Date:   Mon, 27 Mar 2023 13:11:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Remove unused struct net_device
 forward declaration
Message-ID: <ZCFryP+yZ7w38Ix9@smile.fi.intel.com>
References: <20230323151519.58479-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323151519.58479-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:15:19PM +0200, Andy Shevchenko wrote:
> There is no users in the property.h for the struct net_device.
> Remove the latter for good.

Oh, this seems unfortunate as it doesn't Cc Greg. Folks, shall we add
the header to "DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS"?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index ee9cc1710d82..1dff38e930fc 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -16,7 +16,6 @@
>  #include <linux/types.h>
>  
>  struct device;
> -struct net_device;
>  
>  enum dev_prop_type {
>  	DEV_PROP_U8,

-- 
With Best Regards,
Andy Shevchenko


