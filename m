Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03CC5BEC05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiITRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiITR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:29:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68522290;
        Tue, 20 Sep 2022 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663694983; x=1695230983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w8/YG0nidbb5+vN2FkxNfJIceA5A1DLzUcR7puogyMM=;
  b=VzkeQCrlK2dphaCiKaJAiP1rKVJFEljLiV2OOvW6prDsjZwZt9g8bj7R
   AZS1GxZVbuDrAmUE1PGikU53/kb9ieoWPOvtw+7YXzlMB6HBgPtr+uVfR
   P5Tkunu4acXndNHIQKr4BqGAzhxqcbV9o39dt0xaa+PaxPNXkZaS8TOau
   9i/swg9W4oHFFdUz1sI9+rlFzed5kVaRt7Wlq5CW0TBeZ389PlzMPS5sY
   tmnlAftf5GHAMY02A40mgAqJGmOVRssGPYhIgMoV78MBo9rs5L1byN9nl
   LQODRmNnwbkAk4sQjnL58KEIKNKLjQd1iSQ3qTv3/IaS7UwVdvZXbwx0d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="297360289"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="297360289"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 10:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="947766882"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2022 10:29:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oah3p-0059IS-1s;
        Tue, 20 Sep 2022 20:29:29 +0300
Date:   Tue, 20 Sep 2022 20:29:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: add fdinfo output for line request file
 descriptors
Message-ID: <Yyn4eUKCOSxcLKdi@smile.fi.intel.com>
References: <20220920135435.15593-1-brgl@bgdev.pl>
 <Yyn2HEBPPWlJ3E0W@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyn2HEBPPWlJ3E0W@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:19:25PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 20, 2022 at 03:54:35PM +0200, Bartosz Golaszewski wrote:

...

> Also don't forget that sizes over PAGE_SIZE in sysfs sometimes problematic and
> racy.(the commit 888be6067b97 ("ACPI: sysfs: Fix a buffer overrun problem with
> description_show()") for the reference).

This is not the commit I wanted to point to... But suddenly can't find easily
the one I remembered happened in the kernel.

-- 
With Best Regards,
Andy Shevchenko


