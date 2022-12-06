Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F766447CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiLFPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiLFPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:16:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5BAE59;
        Tue,  6 Dec 2022 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670339556; x=1701875556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQPpoMYHgojZ0s9I/vYi4H/g6UU0D10ansdSCf8jK0c=;
  b=ijN4fQwf305Hp7GZB8DInTtwuofxS3O635wJ86UrZ6X36WoPvuXP0lwr
   B7xE2OdFwYoi3ByN4Wq98ekykg3IiO0wVQjReMFHQb1NjpuFJle7szdQ6
   ezZJMZU00ti5Cvvp9TALL7W7+IrQbUBZMGT/zPxl7toGKhSPkfWAnZHmk
   mnAYizn98lODQ5hl/WX2jZ9zZC341lIK6Goz52xyQuIIKV/Fv7EiMxsBA
   W3TPit80AJH6NXf19SWRi3uzmN+2hmkZSxj9Sl3m1lYbndSndGxrkUBDm
   Yx9x3mwgbVC9KjV0RQYgUxeKG4+XlVQQgcMeouKloRRO3LprcHThVE4ri
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="378807875"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="378807875"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 07:12:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="639904605"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="639904605"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2022 07:12:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2ZcB-005MBU-0N;
        Tue, 06 Dec 2022 17:12:11 +0200
Date:   Tue, 6 Dec 2022 17:12:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ye.xingchen@zte.com.cn
Cc:     jic23@kernel.org, michael.hennerich@analog.com, lars@metafoo.de,
        u.kleine-koenig@pengutronix.de, jk@codeconstruct.com.au,
        wsa@kernel.org, ddrokosov@sberdevices.ru, hdegoede@redhat.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: Convert to use sysfs_emit_at() API
Message-ID: <Y49byhJ/Yn5/I28d@smile.fi.intel.com>
References: <202212061953201070549@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212061953201070549@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 07:53:20PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.

Please split on per device driver basis (3 patches here).

The code looks fine to me, thanks.

-- 
With Best Regards,
Andy Shevchenko


