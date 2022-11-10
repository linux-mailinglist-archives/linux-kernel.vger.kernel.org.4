Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A052624636
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiKJPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiKJPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:42:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A8B2F00B;
        Thu, 10 Nov 2022 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668094966; x=1699630966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LC2L/hmMUfJwbVtlPTFkYwSMZRvvYUassvI7OZCmWqc=;
  b=KspzCzQiDsgxq5mkegArXVd3MG6vnkurIz7X3MR1RlNjTYlMutCUN7/u
   81WzGnF4NnQFL1UnLVp414x2uE/9NtsiGW0Rq6slDNEJAMsdF3af1cBtJ
   DNOeWYItvsx1BZ6nfCuSmOPohmM8id7Ai2sCebDVui/fjOBhAZiY1PE+c
   oSRaw19KuqYT75lfuoBaJxER/VjhMB0Cy7g7b91AunUwA1RvNH2AASMpq
   O59XqSzKTUJFBDTkHcYMIny7U8z2z2l5Dr7unN38U8pRYdTZjJnTWeuj1
   +r0jxiIEW2FMFlz+FvvW4e9AHLd/jKGp3J2XIFsSh2B7hNTLBX8JUDUB5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291059792"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="291059792"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 07:42:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882397801"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882397801"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 10 Nov 2022 07:42:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot9hR-00ADQ5-1U;
        Thu, 10 Nov 2022 17:42:41 +0200
Date:   Thu, 10 Nov 2022 17:42:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gazzillo <paul@pgazz.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1]: iio: light: rpr0521: add missing Kconfig
 dependencies
Message-ID: <Y20b8Ty71+qk8aDZ@smile.fi.intel.com>
References: <20221110144448.wexu6neb67krqhla@device>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110144448.wexu6neb67krqhla@device>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:44:48AM -0500, Paul Gazzillo wrote:
> Steps to reproduce (v6.1-rc2, x86_64):
> 
> 1. make defconfig menuconfig
> 2. Enable the driver:
>     -> Device Drivers
>       -> Industrial I/O support (IIO [=y])
>         -> Light sensors
>           -> ROHM RPR0521 ALS and proximity sensor driver
> 3. make drivers/iio/light/rpr0521.o
> 
> Causes "implicit declaration of function" errors, e.g.,

>     CC      drivers/iio/light/rpr0521.o
>   drivers/iio/light/rpr0521.c: In function 'rpr0521_drdy_irq_thread':

These two lines can be removed.

>   drivers/iio/light/rpr0521.c:434:3: error: implicit declaration of function
>            'iio_trigger_poll_chained' [-Werror=implicit-function-declaration]
>     434 |   iio_trigger_poll_chained(data->drdy_trigger0);
>         |   ^~~~~~~~~~~~~~~~~~~~~~~~

> (This bug was found with the help of a tool, krepair, that generates
> configuration files for commits: https://github.com/paulgazz/kmax)

I'm not sure we need this in the commit message. Do we have a tag for
the static analyzers?

> The following patch ensures that the code controlled by IIO_BUFFER and
> IIO_TRIGGERED_BUFFER is available:

> Reported-by: Paul Gazzillo <paul@pgazz.com>

Without SoB this may not be anyhow proceeded. Please, read Submitting Patches
documentation and try again.

(Btw, Reported-by above contradicts the commit message that refers to the tool,
 and not human)

-- 
With Best Regards,
Andy Shevchenko


