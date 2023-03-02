Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC756A85AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCBPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:54:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B839CFF;
        Thu,  2 Mar 2023 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677772448; x=1709308448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/pGc/l0UZNElD4950MH0FyT13pafdH9fGL+HJomWsQ=;
  b=LVX3dAg5RfhvVE4Q1+eH7tQV0UVWxT7xt4YD1CyA/kWbHFjo+H9qCf8B
   V1v+QDncPHN4Cvi/IbtYhr0qh6tcJXP84Vn8pOJd6/QD4Pq9CRN5yHFae
   QQUEp9iQQ2Xei3LCy8e4E8UxHm3yoyoxwqxN9Jem/3i9+tiTPvlZVxrE+
   5HDAVroiDscVpMSqDEkp0s6bNtxVVijUgqT8yVdEnL1ljJiIilqGVTW4e
   qzPMisS2USBEpayoPgrMXZWgAjW47X2wALYn6Z53HPTMdSwyPbf21zeTN
   I+0XwGjYOtqY7rgfVOc1WixhLpkutm1b2Tya2TpeWyj4XhkZo826QHClu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="421018389"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="421018389"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 07:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="1004150417"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="1004150417"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2023 07:54:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXlFt-00EPmp-24;
        Thu, 02 Mar 2023 17:54:05 +0200
Date:   Thu, 2 Mar 2023 17:54:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <ZADGnRILByq1/1ch@smile.fi.intel.com>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
 <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 02:04:35PM +0100, Mehdi Djait wrote:
> Move the kernel-doc of the function to industrialio-trigger.c
> Add a note on the context where the function is expected to be called.

...

> v2:
> - Changed the expected context of from interrupt to hard IRQ context

Thank you for an update.

But it seems I messed up with this and my previous remark shouldn't be
taken into consideration.

The "relevant hardware interrupt handler" may be hard and threaded IRQ context,
which looks like your first version was correct.

Let's wait for Jonathan opinion on this as he is a native speaker.

-- 
With Best Regards,
Andy Shevchenko


