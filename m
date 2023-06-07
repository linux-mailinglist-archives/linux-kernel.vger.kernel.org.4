Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6449B726A68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFGUIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFGUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:08:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3931BD3;
        Wed,  7 Jun 2023 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686168517; x=1717704517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pUSZIpe/J0jTPfU5urMpVkLRgOeCUkwl1+FBN7ZGbjE=;
  b=iyBhZRsLfPcN/t7em7bJ7gpdMaZsmJl/dafNeecsR2UehY8eRgELUhkP
   nXo7VM5+ePvfkHwdMltxxG39Xmgs0lebrP18zoyfTmU5w0YrDmmx8zDhU
   6ezWx4hfVcWyNVFWhwn4/AKocpDukVhg9tq1qCXrV7M8B4GM2W81dJNP3
   1nObMFG1KhR7GFx/tkwBJKcy9QbNg+P7nDyryCDkeTby5PiMI+z4UsjEv
   TyhM0kAjEyzSlI8vtxsYH/kahfEWwZg7gvF3ZT649JZpHjDxSSejNJ/Y1
   KjT7/nUfsIdimHCrV32n3niEdUh7bghh0t+YPjIQqTYEQLQv6hzgqIzyo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="336723941"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="336723941"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 13:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854040032"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="854040032"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2023 13:08:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6zSM-001zei-28;
        Wed, 07 Jun 2023 23:08:34 +0300
Date:   Wed, 7 Jun 2023 23:08:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] pktdvd: Clean up the driver
Message-ID: <ZIDjwjRbX+YkA5J1@smile.fi.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
 <ZH9JnPAL8x2GPSV3@smile.fi.intel.com>
 <c00870f9-9ae4-27b1-3362-444aa76d7671@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c00870f9-9ae4-27b1-3362-444aa76d7671@kernel.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:23:03PM -0600, Jens Axboe wrote:
> On 6/6/23 8:58 AM, Andy Shevchenko wrote:
> > On Fri, Mar 10, 2023 at 06:45:40PM +0200, Andy Shevchenko wrote:
> >> Some cleanups to the recently resurrected driver.
> > 
> > Anybody to pick this up, please?
> 
> I can pick it up, I'm assuming this is all untested?

Compile tested only. So I assume the answer is yes, untested.

-- 
With Best Regards,
Andy Shevchenko


