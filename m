Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5B55EC7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiI0P0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiI0P0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:26:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DFCE512B;
        Tue, 27 Sep 2022 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664292392; x=1695828392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z8FgthVjK3HQZ0A3apHAWKG6Ji7sJozTBBg/+WlDrgA=;
  b=KSuzBwLWAOtrolABnWp89VLoJdQW9oWAPI5kBvQEZ7D3phByQLSxgjDe
   4IeiHjy8uGwuvTF8A3VoPoEf4J7xVFZ9PMnNZG561R+Wx67Bvm4maQgNv
   xapH4LOdxAhT8LTPt6KTBxn7w/JEMd/oS/bH+n9ai++cW0r9O+sxevI0F
   I2M8AUednhyQLnTamhoouFl15Xmty4uJOhH1iIQ+2R5P9Noi2mC1oT06L
   QpC2uYDNLQbHnf+I/bRoI52HUbYIvl2y9McGGmI2SmhysdVj4ktCX3lCc
   6hTra/8P1nbZJGDgxU00S9nmaVL72K1ONdaGMPs2zA6KviSWE7RmESTk3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327703861"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327703861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 08:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652317491"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="652317491"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2022 08:26:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odCTc-008VUt-2k;
        Tue, 27 Sep 2022 18:26:28 +0300
Date:   Tue, 27 Sep 2022 18:26:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/8] pwm: lpss: Include headers we are direct user of
Message-ID: <YzMWJFmeMAvn0e1c@smile.fi.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
 <20220927144723.9655-5-andriy.shevchenko@linux.intel.com>
 <20220927151053.7eh63stoganpgawr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927151053.7eh63stoganpgawr@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:10:53PM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 27, 2022 at 05:47:19PM +0300, Andy Shevchenko wrote:
> > For the sake of integrity, include headers we are direct user of.
> > 
> > While at it, add missed struct pwm_lpss_boardinfo one and replace
> > device.h with a forward declaration. The latter improves compile
> > time due to reducing overhead of device.h parsing with entire train
> > of dependencies.
> 
> Hm, I copied the cmdline for the compiler from a V=1 build and only run
> the compiler on drivers/pwm/pwm-lpss-pci.c.
> 
> With #include <device.h> I got:
> 
> 	real	0m0.421s
> 	user	0m0.354s
> 	sys	0m0.066s
> 
> With struct device; I got:
> 
> 	real	0m0.431s
> 	user	0m0.378s
> 	sys	0m0.052s
> 
> Are the numbers for you considerably different?

Why Ingo created thousands of patches to do something similar? Because for
a single user you won't see a big difference, but when amount of small pieces
are gathered together, you definitely will.

> > +struct device;

...

> > +struct pwm_lpss_boardinfo;
> 
> Hmm, I wonder why there is no compiler warning without that declaration.
> At least in my builds. Do you see a warning? IMHO it's better to fix
> that be swapping the order of struct pwm_lpss_chip and struct
> pwm_lpss_boardinfo.

Have I told about warning? It's a proper C programming style.
You don't have a warning because all pointers are considered to be the same,
but it is better style to explicitly point that out.

OTOH you may go and clean all the forward declarations of the data structures
in the kernel, but I believe the work wouldn't be appreciated much.

-- 
With Best Regards,
Andy Shevchenko


