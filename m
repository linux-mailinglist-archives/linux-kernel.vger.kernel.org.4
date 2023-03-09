Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D296B2859
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCIPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjCIPGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:06:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035062DB2;
        Thu,  9 Mar 2023 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678374261; x=1709910261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tt3B9Fexw4wbXb5Yt6Q5BrpLm009eJmCrL/GUqJ/75k=;
  b=gsepB0da1+RRgZvHAS4iCSHVisLfklDGzyglVTDTcHkMBFntEqH8sCbq
   CxqKBRtF3GzsyTHVJgxmEiEGvbITJKXLIZHinddfbtAv7QihUNyo7Mty8
   L/j2pEGBjsdfgugTQEdSCDQ947TFoiPmi69eAJBfWRfW6/VhKbfNmFiiF
   8WM6fBSCuuSPQ825UlVcpwxd+vjmLshU1GpPw1P6hVTIc5b3KXrDZnCcW
   XeQJz/6arTXFE8/pocGHZVmHDkzUAZzunXlcGlXHAXYGaW2R9PDTlmFYx
   KvgvVK4ANXT9RP8YCZCezpK5/AqN68zdKwAm/tK3hfZplBWnB2qDUmBaz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320309154"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="320309154"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:36:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="820618114"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="820618114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2023 06:36:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paHNI-000Mtx-2e;
        Thu, 09 Mar 2023 16:36:08 +0200
Date:   Thu, 9 Mar 2023 16:36:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] sh: mach-x3proto: Add missing #include
 <linux/gpio/driver.h>
Message-ID: <ZAnu2LwZWm3wi2l5@smile.fi.intel.com>
References: <20230309135255.3861308-1-geert+renesas@glider.be>
 <CACRpkdant3mQJX0FM3q65mBaS0fXJ=7tag5dx-1Jp5xpc3EQJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdant3mQJX0FM3q65mBaS0fXJ=7tag5dx-1Jp5xpc3EQJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:08:47PM +0100, Linus Walleij wrote:
> On Thu, Mar 9, 2023 at 2:52 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> 
> > shx3_defconfig:
> >
> >     arch/sh/boards/mach-x3proto/setup.c: In function ‘x3proto_devices_setup’:
> >     arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of undefined type ‘struct gpio_chip’
> >       246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
> >           |                                                              ^
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Link: https://lore.kernel.org/r/CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com
> > Fixes: 21d9526d13b5467b ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> This is fallout from cleanups in Bartosz GPIO tree, so it will be applied there.
> Make sure Bartosz gets the patch (now on To:)
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, as for previous patch on the same topic, I am collecting this one.

I will sent a new PR to Bart including all fixes, but I would wait one or a
couple of weeks before doing that. Meanwhile these will be in Linux Next.

-- 
With Best Regards,
Andy Shevchenko


