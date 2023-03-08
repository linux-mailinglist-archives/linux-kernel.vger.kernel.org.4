Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F226B07E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjCHNEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjCHNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:04:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6951C85AD;
        Wed,  8 Mar 2023 05:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678280521; x=1709816521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cwwPgUT/6iCi8/PdF/JupDJbGBv9MyxIHRz/u56mKO4=;
  b=Z5+tIfPokxHQ6Z1A3KDB3x9JApa6j89SsQnE/U5BiRgqD5JFcyOgSb6h
   h/hgC1CHrKh7EwEU87SHWLxsf5gVnmDgw0sXjgmJiSTXzgtLOzmdtdq3R
   UHsJSSDylg+7MNeNk9cDt25PcRTyG6MtTbCse4+++n0k3VtBxOD0kXo8z
   b8G+KNcmrMMxjGCPEG0UIkRYlghZXCYZkbZmsvrxbVqvJMKPWeNF0zoxE
   yIlyzxr6upIM01eVeeYf793Mwj4rN+aqfspreq4k2CrcIOFXI1h0osMYe
   QsP3q40t2duCRROId2bSe6e/DRv/PfRC0Pr8KD1oo1qwYCL9oHFdC70hW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337662496"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="337662496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787114848"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="787114848"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 08 Mar 2023 05:00:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZtPS-00HQtx-0K;
        Wed, 08 Mar 2023 15:00:46 +0200
Date:   Wed, 8 Mar 2023 15:00:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-next <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, lkft-triage@lists.linaro.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: next: arch/mips/ar7/gpio.c:19:33: error: field 'chip' has
 incomplete type
Message-ID: <ZAiG/fy0BQ7aP6Qq@smile.fi.intel.com>
References: <CA+G9fYvX8W6R6FtxZbCmdeKhSikmdD9Tten8U5qXX4cG3+-1VQ@mail.gmail.com>
 <76be6056-2057-4199-9dd2-52d28bbb37e8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76be6056-2057-4199-9dd2-52d28bbb37e8@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:46:26PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 7, 2023, at 18:10, Naresh Kamboju wrote:
> > Following build regression found while building mips ar7_defconfig
> > on Linux next-20230307 tag.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Please find the build log and details below.
> >
> > build log:
> > --------
> > arch/mips/ar7/gpio.c:19:33: error: field 'chip' has incomplete type
> >    19 |         struct gpio_chip        chip;
> 
> It sounds like a result of 21d9526d13b5 ("gpiolib: Make the
> legacy <linux/gpio.h> consumer-only"). I haven't tried it,
> but I think this should fix it, unless there is another bug:
> 
> --- a/arch/mips/ar7/gpio.c
> +++ b/arch/mips/ar7/gpio.c
> @@ -7,7 +7,7 @@
>  
>  #include <linux/init.h>
>  #include <linux/export.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  
>  #include <asm/mach-ar7/ar7.h>

Thank you!
Can you send this as a formal patch?

-- 
With Best Regards,
Andy Shevchenko


