Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BEF6B266B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjCIOM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCIOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:11:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4CCF16B6;
        Thu,  9 Mar 2023 06:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678371043; x=1709907043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ke25aAr1RwAUHCxg3kvQY9jKyxSYBDAeHeJlTlHQ8tk=;
  b=DrALIIB7DTWDubX9UArfOo0BY9fsiot0MCTu64Y6Uu1FkPxeKcTGCQsM
   h3vNZYoOGe5/+8gvsUXnsVm9K3MVXhfYiPy8LI+TkCoWJ5Zdubkg6e8A3
   V5cIWF+TgQKXUyIHwCcWcIrT7wZwNnWLFEZFINJl0PLG9dzZAtS71EHC8
   MQmSgqjLoo23n+70aPni+06vdWkoyh60YXyIJAWD4/uMeGCFrvqT1hEVW
   +0uCuVxVMdB3vELWgoCTpnCh8tz/+FYbq4ef62qtY/D4+IJlrYhFMZ8PP
   SseE6vUfr3JkQCF8414nrTyJBxifozaGMCarn2PD1GZdaZ0a7DwV5NnAO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338789586"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="338789586"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="801180904"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="801180904"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 06:04:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paGsd-000LqH-2E;
        Thu, 09 Mar 2023 16:04:27 +0200
Date:   Thu, 9 Mar 2023 16:04:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] sh: mach-x3proto: Add missing #include
 <linux/gpio/driver.h>
Message-ID: <ZAnna6xIhBZPG/nD@smile.fi.intel.com>
References: <20230309135255.3861308-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309135255.3861308-1-geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:52:55PM +0100, Geert Uytterhoeven wrote:
> shx3_defconfig:
> 
>     arch/sh/boards/mach-x3proto/setup.c: In function ‘x3proto_devices_setup’:
>     arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of undefined type ‘struct gpio_chip’
>       246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
> 	  |                                                              ^
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/r/CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com
> Fixes: 21d9526d13b5467b ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you!

...

>  #include <linux/gpio.h>
> +#include <linux/gpio/driver.h>

Do we still need the legacy header?

-- 
With Best Regards,
Andy Shevchenko


