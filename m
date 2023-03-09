Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA456B2C42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCIRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCIRrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:47:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34650FB257;
        Thu,  9 Mar 2023 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678384021; x=1709920021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I8UicG17Q/faH5uDUFSsbeEZfZYosSYwUWWJFsU2Qzo=;
  b=SgSHIFSt86SSWe4jioQG5+qYiIDiRV5/XiaAuftm9VL20MyT+DZeqb3f
   ptJEa6gIvJId/+m5TE7ezuc/4agjvDqHU6saCfpLVewGjIhR+sRx5UPTe
   kv0I9ma2+JMmqyk0Aqk3GLz+0FDh7V/vQRJVX8uupWHtDqDpAMD917jOO
   P21j+Gefz+nevjjJ8Q6gBhySmjAY0Ip7LxIJEKE4xHfafuoAyYvM36Xkz
   FMQqkslEFieBRcMF8hwwdx6MEt20MuNE3AgWxIC7KClkuYgYXMZJrbIna
   imaGDhmT3PuQUESQ/+ysuN0PpRADQ4l5y8XiCQE9CG2JeYvutFuzpeBP8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338062370"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="338062370"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="627451541"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="627451541"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2023 09:46:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paKLv-000SVg-1X;
        Thu, 09 Mar 2023 19:46:55 +0200
Date:   Thu, 9 Mar 2023 19:46:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v2] sh: mach-x3proto: Add missing #include
 <linux/gpio/driver.h>
Message-ID: <ZAobj3hZuhQ2pLb6@smile.fi.intel.com>
References: <20230309144113.3922386-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309144113.3922386-1-geert+renesas@glider.be>
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

On Thu, Mar 09, 2023 at 03:41:13PM +0100, Geert Uytterhoeven wrote:
> shx3_defconfig:
> 
>     arch/sh/boards/mach-x3proto/setup.c: In function ‘x3proto_devices_setup’:
>     arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of undefined type ‘struct gpio_chip’
>       246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
> 	  |                                                              ^
> 
> Fix this by replacing the include of the legacy <linux/gpio.h> by
> <linux/gpio/driver.h>.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


