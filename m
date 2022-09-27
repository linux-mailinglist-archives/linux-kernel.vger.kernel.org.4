Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22E5EC940
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiI0QSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiI0QSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:18:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A381C5CBD;
        Tue, 27 Sep 2022 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295519; x=1695831519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hoMnsdHSL/otoK4knDLGk7Hgdze88gWA9flLcFtU+LU=;
  b=AZPKWuPnIMg5qmb/JklOiVzjhpUyhzjp9/NN8Er0nRvFVfJuuKWLgNps
   1upSWxp/998dzgVi6rWsGBVL36T/TifCSntV//dhb6rnYG9sKEfzvNUkP
   BUNmXkIQR/8gk7Se2oruuJgOWIe3kwYskkZSYLoMxdruKgbDMRJKGvzds
   0M9O1zjfLxeeYdrYAUiloVl8NYfmJQAFu0NDXUHU2an6hPwhV3wujvnVL
   EDL4+a1YWexLvb26sqnsoKlu6pfvhzKMlpbl2Xp2BQhSkFCazrsziHq+b
   2C91lvQ4nsKqf0gM+9i3uWSNNYjTYctzZEfWxgDOyoAQb5Vn64FblLk7Y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302838825"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="302838825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="763933823"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="763933823"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2022 09:18:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odDI4-008WgJ-0h;
        Tue, 27 Sep 2022 19:18:36 +0300
Date:   Tue, 27 Sep 2022 19:18:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/8] pwm: lpss: Include headers we are direct user of
Message-ID: <YzMiW0rjFek8VTS7@smile.fi.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
 <20220927144723.9655-5-andriy.shevchenko@linux.intel.com>
 <20220927151053.7eh63stoganpgawr@pengutronix.de>
 <YzMWJFmeMAvn0e1c@smile.fi.intel.com>
 <20220927155521.t4hanojroe247lqr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927155521.t4hanojroe247lqr@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:55:21PM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 27, 2022 at 06:26:28PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 27, 2022 at 05:10:53PM +0200, Uwe Kleine-König wrote:
> > > On Tue, Sep 27, 2022 at 05:47:19PM +0300, Andy Shevchenko wrote:
> > > > For the sake of integrity, include headers we are direct user of.
> > > > 
> > > > While at it, add missed struct pwm_lpss_boardinfo one and replace
> > > > device.h with a forward declaration. The latter improves compile
> > > > time due to reducing overhead of device.h parsing with entire train
> > > > of dependencies.
> > > 
> > > Hm, I copied the cmdline for the compiler from a V=1 build and only run
> > > the compiler on drivers/pwm/pwm-lpss-pci.c.
> > > 
> > > With #include <device.h> I got:
> > > 
> > > 	real	0m0.421s
> > > 	user	0m0.354s
> > > 	sys	0m0.066s
> > > 
> > > With struct device; I got:
> > > 
> > > 	real	0m0.431s
> > > 	user	0m0.378s
> > > 	sys	0m0.052s
> > > 
> > > Are the numbers for you considerably different?
> > 
> > Why Ingo created thousands of patches to do something similar? Because for
> > a single user you won't see a big difference, but when amount of small pieces
> > are gathered together, you definitely will.
> 
> My doubt is that for me the effect of using struct device over #include
> <device.h> is even negative (looking at real and user). Is it sys which
> counts in the end?

The main time required for the header inclusion is mmap():ing it (that's what
I believe preprocessor does) and parsing. In any case, testing on a high-speed
machine one file case is not correct (scientific) approach. Of course with
your measurements will be in the error range.

As I have learnt at university the very first question for the experiment
we should ask ourselves is "what exactly have we measured?"

I'm not sure any continuation of this makes sense if we haven't answered
to this. When I measured preprocessor speed up (not in this case, though),
I used ccache tool, because it makes more clear the time spend for C
preprocessor (by caching the compiler results), so 10 runs of that maybe
closer to the real world (hot cache which should have no effect on the
iteration-to-iteration time).

That said, if you want to NAK this, please do it explicitly. I'm not going
to waste my time on this simple change anymore.

> > > > +struct device;

...

> > > > +struct pwm_lpss_boardinfo;
> > > 
> > > Hmm, I wonder why there is no compiler warning without that declaration.
> > > At least in my builds. Do you see a warning? IMHO it's better to fix
> > > that be swapping the order of struct pwm_lpss_chip and struct
> > > pwm_lpss_boardinfo.
> > 
> > Have I told about warning?
> 
> No, it's just me who expected there would be a warning if a pointer to
> struct pwm_lpss_boardinfo is used before struct pwm_lpss_boardinfo is
> defined (or declared).
> 
> Anyhow, I stand by my opinion that swapping the order of struct
> pwm_lpss_chip and struct pwm_lpss_boardinfo is a saner fix.

I agree on this. But I expect a NAK, so simplest to me is to drop this patch
from the series.

> > It's a proper C programming style.
> > You don't have a warning because all pointers are considered to be the same,
> > but it is better style to explicitly point that out.

-- 
With Best Regards,
Andy Shevchenko


