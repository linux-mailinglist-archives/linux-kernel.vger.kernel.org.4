Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774BB63C65A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiK2RWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiK2RWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:22:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA6A1A4;
        Tue, 29 Nov 2022 09:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669742561; x=1701278561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kISIMw8JT051+G5GMquysEX+2T4slewd3zmpmeqLw/U=;
  b=arrYDfScCUXY5TcUBQyXxlI90lfJuJSB1Iiq5FmqPknOn2fzxCJmwXHX
   L1/NCmDY1UdgI4RacdtZCGZdXjdxiRxGgAhqq2ea+4oFNaFX7k+Fifrkg
   P/gEGhJViTX6iU9k5lV+ySBH7h8e1WAqoLMV1cXHUwd1c/OmFr9ZccWWq
   yfA9IRItA+nrxl12AfMlSXm0On5+1WZhCexjm9xNZVPK1sPcWForPpzch
   kbc79B4Wz0ovNO0vbV5oWUEZUJWZ18Iqta9hsBqU4VADeNMtj23A+DrUO
   t0BIK+mm6tH5xCDw98G1cKnTiN/MDPR8xwZdYv87VwFyLEm3yk26n02bE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="302774422"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="302774422"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="888917446"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="888917446"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2022 08:54:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03sE-001nJC-1r;
        Tue, 29 Nov 2022 18:54:22 +0200
Date:   Tue, 29 Nov 2022 18:54:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
Message-ID: <Y4Y5Pomzhc/uK5c4@smile.fi.intel.com>
References: <20221129123553.353410-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129123553.353410-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 01:35:51PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This is a second iteration of the changes that aim at fixing the situation
> in which the user-space can provoke a NULL-pointer derefence in the kernel
> when a GPIO device that's in use by user-space is removed.
> 
> I didn't add the review tags as the code changes significantly.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Some nit-picks are in the individual reply(ies).

> v2 -> v3:
> - drop the helper variable in patch 1/2 as we won't be using it in 2/2
> - refactor patch 2/2 to use locking wrappers around the syscall callbacks
> 
> v1 -> v2:
> - add missing gdev->chip checks in patch 1/2
> - add a second patch that protects the structures that can be accessed
>   by user-space calls against concurrent removal
> 
> Bartosz Golaszewski (2):
>   gpiolib: cdev: fix NULL-pointer dereferences
>   gpiolib: protect the GPIO device against being dropped while in use by
>     user-space
> 
>  drivers/gpio/gpiolib-cdev.c | 190 +++++++++++++++++++++++++++++++-----
>  drivers/gpio/gpiolib.c      |   3 +
>  drivers/gpio/gpiolib.h      |   5 +
>  3 files changed, 176 insertions(+), 22 deletions(-)
> 
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


