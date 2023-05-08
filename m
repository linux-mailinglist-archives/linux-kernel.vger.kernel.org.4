Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A86FAFDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEHMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjEHMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:23:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE0A36118;
        Mon,  8 May 2023 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683548594; x=1715084594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zz7Se8uLfJ5do6eJ9dnQKSDFhvQo/6NrKd6fODnc9/Q=;
  b=WmUa5swwOISjt0LbJjkSZqXjZSLEDgDOxvB5AzCYSZTTrIL8gvLlco0Q
   HExdPz97pQZuZwUvTzXjGv4g58EcUeGgo6oBbagC6rb5+tc/dp2d4B34n
   xDGsh+MeUh0GDNNoQbQBRA3PMkx1ZCebvvaUT4O/TJM70wtFRGRcyhYhr
   Tb2jxgeKGBvuO+frM2/4cWhAfiyCLnA/kFS+UWktDk0Lg3CwwznnsULlA
   i7TlQXqrYb3kuMW5eT7uGAplNaG+rmyBwGAQ3+Lsi2FfAVf8hz6j+j6YL
   g16WCJUahVAmvPaT++bRiPnoEq6TnxGuef/M8woYgNAWneM8kolG/2lSK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="352685955"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="352685955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 05:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="692589247"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="692589247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2023 05:23:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pvztT-00Ar4Y-1a;
        Mon, 08 May 2023 15:23:07 +0300
Date:   Mon, 8 May 2023 15:23:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <ZFjpqwOo3DxnWahM@smile.fi.intel.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
 <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
 <ZFPCUJ81aw/GkJgT@smile.fi.intel.com>
 <c63c5271-3973-3bd4-c683-ab9ab64b67e4@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63c5271-3973-3bd4-c683-ab9ab64b67e4@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 04:56:47AM +0000, Vaittinen, Matti wrote:
> On 5/4/23 17:33, Andy Shevchenko wrote:
> > On Wed, May 03, 2023 at 12:50:14PM +0300, Matti Vaittinen wrote:

...

> >> +config ROHM_BU27008
> >> +	tristate "ROHM BU27008 color (RGB+C/IR) sensor"
> >> +	depends on I2C
> >> +	select REGMAP_I2C
> >> +	select IIO_GTS_HELPER
> >> +	help
> >> +	  Enable support for the ROHM BU27008 color sensor.
> >> +	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,
> >> +	  blue, clear and IR) with four configurable channels. Red and
> >> +	  green being always available and two out of the rest three
> >> +	  (blue, clear, IR) can be selected to be simultaneously measured.
> >> +	  Typical application is adjusting LCD backlight of TVs,
> >> +	  mobile phones and tablet PCs.
> > 
> > Module name?
> 
> We have discussed this several times already.
> 
> https://lore.kernel.org/all/10c4663b-dd65-a545-786d-10aed6e6e5e9@fi.rohmeurope.com/
> 
> Module name is completely irrelevant when selecting a kernel configuration.

This option is also selectable by user.

...

> > Do you need regmap lock? If so, why (since you have mutex)?
> 
> I believe you know that regmap uses a default lock when no external lock 
> is given. So, I assume you mean that maybe we could set 
> 'disable_locking' for the regmap here.

Correct.

> It's nice to be occasionally pushed to think "out of the box". And yes, 
> disabling regmap lock is really out of my "normal box" :)
> 
> I didn't go through all of the code yet, but I think pretty much all of 
> the sequences which end up to register writes are indeed protected by 
> the mutex. (Well, probe is not but it is expected to only update one bit 
> while rest of the register should stay fixed).
> 
> It may be we could live without regmap_lock when driver is in it's 
> current state, but I am not convinced the performance improvement is 
> worth the risk. Having regmap unprotected is not common, and it is also 
> not easy to spot when making changes to the driver. In my opinion it is 
> a bit like asking for a nose-bleed unless there is really heavy reasons 
> to drop the lock... In this case, having the regmap_lock (which is 
> pretty much never locked because we have the mutex as you said) is 
> probably not a penalty that matters.

Basically you try to justify a hidden mine field in case somebody will think
"oh, we are protected by regmap lock, so why to bother call mutex_lock()" and
at the end it become a subtle bugs in the code. With disable_locking = true
I can see that code author _carefully thought through_ the locking schema and
understands the hardware and the code.

P.S. I'm wondering why your lines of text have a single trailing whitespace
but the last line.

-- 
With Best Regards,
Andy Shevchenko


