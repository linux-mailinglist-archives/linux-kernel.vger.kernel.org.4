Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550F166BD6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjAPMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjAPMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:01:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4641CF7D;
        Mon, 16 Jan 2023 04:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673870448; x=1705406448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D2anxR+FvRYBPshSagDI1N1YyqBlRNyqR+Fxhg3WoYE=;
  b=Jul23TcTyZapAHDCYj/QC6A99ISiOMhMPZudF20IDbVrIMtnANOXlN27
   0YHWJ5ELYEN1K1vPRTHgP1YOZ1eCtN6djrW1Gy8lRoBqELZoCVOdvoFM+
   uGkqfNZUHQok6bQD1R6IAcs8xRxKbDr7YWQxrb8L+letP5KY31SMkbHqB
   Jy4TH1msurMBrOFdJrbTbxNGs3WMlR5h39QLrW0meqbLTC3fnoikzDJ6w
   lnzCnFdk1ThAeFm4OC/4xZ0BrS6VqYQSQUCSXmIMMLu7JMrJx/Lr9dt8O
   CHawTSK0AQCxsH7B60Nz+V6OYmtr+xcW0doLTZRgo2Dl/nEQCBOCMJCcT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="312299098"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="312299098"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 04:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="904312857"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="904312857"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jan 2023 04:00:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHOAP-00A3WN-1K;
        Mon, 16 Jan 2023 14:00:45 +0200
Date:   Mon, 16 Jan 2023 14:00:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] gpio: wcd934x: Use proper headers and drop
 OF_GPIO dependency
Message-ID: <Y8U8bZ9+dOwmDgsb@smile.fi.intel.com>
References: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
 <20230113182619.16800-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdkgWBb5XTSMEEUQQGCO_3x1a3KK0KbvW4GmAQX1XGbxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdkgWBb5XTSMEEUQQGCO_3x1a3KK0KbvW4GmAQX1XGbxg@mail.gmail.com>
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

On Mon, Jan 16, 2023 at 10:03:47AM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 13, 2023 at 7:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > +#include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > -#include <linux/gpio/driver.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> > -#include <linux/of_device.h>
> > +
> > +#include <linux/gpio/driver.h>
> 
> Any reason for having it separately here?

Yes. The idea is to emphasize the relationship between the driver and
the subsystem it's written for.

P.S. Thanks for applying the rest of my contribution.

-- 
With Best Regards,
Andy Shevchenko


