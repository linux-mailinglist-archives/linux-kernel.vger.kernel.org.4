Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233B66C2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjAPOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjAPOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:54:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CB26581;
        Mon, 16 Jan 2023 06:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673880188; x=1705416188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UhL5WT/iDZbiza1ZHyzkL+c6GHSVurVpiThwXMkPA34=;
  b=XsBbMviVWhMInJ9O9S8gtXQ3YShtZdaxrAM9/yDkiu8H1YLILW1KdRpN
   Ckm7mfl36vbQeW49ZAjaWvKSDvVbCxmo6+9o11SPrGH7GUlCY7U04TTeu
   1Tt4Dsvwhcpl6Xg80W6sSAiF5SgysiJY6FebcE8VnLeweWfN5bb03pKLB
   t1EOWh447ssKW6WGnLG+R+GOndaQhBC6icPGP+fOc/uXs04Y8Jl1XizNw
   03x3utwFdiG7/2pA4HVlYMEl5RY4KEOXSAQL6XPULmQkZwPPt3/MJrjb6
   h6X0AsRcEkQfJFW1Smb79CRJRV5edqvKCCaTF2Q+pbJua2Htj4wCwqVp2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323174043"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="323174043"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 06:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="691269043"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="691269043"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 16 Jan 2023 06:43:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHQhV-00A7tM-0O;
        Mon, 16 Jan 2023 16:43:05 +0200
Date:   Mon, 16 Jan 2023 16:43:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] gpio: wcd934x: Use proper headers and drop
 OF_GPIO dependency
Message-ID: <Y8VieDjXbO9Yj10F@smile.fi.intel.com>
References: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
 <20230113182619.16800-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdkgWBb5XTSMEEUQQGCO_3x1a3KK0KbvW4GmAQX1XGbxg@mail.gmail.com>
 <Y8U8bZ9+dOwmDgsb@smile.fi.intel.com>
 <CAMRc=Md65GUZ0XXd_35gzS8SJQAHXG9neE4ZCxZXBr0q2nOc-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md65GUZ0XXd_35gzS8SJQAHXG9neE4ZCxZXBr0q2nOc-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 02:56:23PM +0100, Bartosz Golaszewski wrote:
> On Mon, Jan 16, 2023 at 1:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jan 16, 2023 at 10:03:47AM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Jan 13, 2023 at 7:25 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > +#include <linux/mod_devicetable.h>
> > > >  #include <linux/module.h>
> > > > -#include <linux/gpio/driver.h>
> > > > +#include <linux/platform_device.h>
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/slab.h>
> > > > -#include <linux/of_device.h>
> > > > +
> > > > +#include <linux/gpio/driver.h>
> > >
> > > Any reason for having it separately here?
> >
> > Yes. The idea is to emphasize the relationship between the driver and
> > the subsystem it's written for.

> We almost never do it and I prefer all linux/ headers to be grouped
> together. I like separate sections for asm/ and local includes but
> this is overkill IMO.

OK!

-- 
With Best Regards,
Andy Shevchenko


