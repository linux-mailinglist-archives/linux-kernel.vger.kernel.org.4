Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519A360E016
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiJZL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiJZL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:56:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC92AEA24;
        Wed, 26 Oct 2022 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666785373; x=1698321373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oHWjrYPTLePjtfatiI6ltoxxvdXJoi/nWWd7TE5RE9Y=;
  b=Ps5P7fxvzFEhpzKp4cDXLt7co5ko/l+QKB4OLD+mTu6BOnIfSsrc50lI
   e9T/fAmxKDLcylXAq4PWUR+tNn2zQfNIxmKexu8eOf8EIG182z5RIp2pP
   taM79g0VilxHtFXCwDepXZV+VfO/L3dcoToIm6ltASQarFXXdtIH3G4OE
   aZXXmUvGsx/B5z2e6f9PpvoiUU7TJMsPlNBKQfFH5pJGtMwuWT5h3S/6m
   ru8B8u61OdsyQdlSYoQ/0Pey0XGJ2SA+8gPfLf8JdXGMXRg0Cjjcn3qAD
   qEkqFvcKFuysvdcNjsWBzUcHrTdqooG8mhPiUg2xC3Z+/3k84qjkSvq1I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="307919389"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="307919389"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="695333083"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="695333083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2022 04:56:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1onf11-002d4E-0d;
        Wed, 26 Oct 2022 14:56:11 +0300
Date:   Wed, 26 Oct 2022 14:56:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/5] pinctrl: alderlake: Deduplicate COMMUNITY macro
 code
Message-ID: <Y1kgWnCGpx2RVABH@smile.fi.intel.com>
References: <20221018223427.43579-1-andriy.shevchenko@linux.intel.com>
 <Y1TkJ0r6PIM/7ng4@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1TkJ0r6PIM/7ng4@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 09:50:15AM +0300, Mika Westerberg wrote:
> On Wed, Oct 19, 2022 at 01:34:23AM +0300, Andy Shevchenko wrote:
> > Define a common COMUNITY macro and supply a variant to it.
>                   ^^^^^^^^
> COMMUNITY
> 
> (ditto for other commit messages)
> 
> > This removes some verbosity in macros.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

All with mentioned typo fix and added tag are pushed to my review and
testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


