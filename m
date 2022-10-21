Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8298E6075E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJULQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJULQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:16:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA523923A;
        Fri, 21 Oct 2022 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666350965; x=1697886965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAn3ijLl8vdyojji+zoDVIBj6GTriBASs9iZAxj3n/E=;
  b=GceQTu+C5wmuPI/9NM4xIGX2+5P+RSLLTd8DXBqdfZN3mrghpRW6KbKE
   wQe2O6Ph82cCV5w3W86Yz+bMgIO3WeymeFgNmSdsWpU0XmK74oMW+GYX9
   kFpqwbZJ6Y/d2ss9XHhEQJz4OXRPSqaoDBpWZ1u1HRbbJ4MbuyQ+UoEv2
   nQZwCPNiXpALA/b6qQfED+k33/JOAKk406e5JBYNbMuyW3CcrIW99A2NF
   +Yls5pltMhXeVGLX4PhhbZwIYPOCMvtSBeTAVkseYTwk4ItWCHk6uKfRU
   OPepVIJOaj7x+rYkIWkttk8W/ZEBj5zGguDT12N3g+CRPafbxx9/oKUG2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="371189588"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="371189588"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 04:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="632875295"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="632875295"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Oct 2022 04:16:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olq0O-00B7Xg-0E;
        Fri, 21 Oct 2022 14:16:00 +0300
Date:   Fri, 21 Oct 2022 14:15:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1J/by2TGbaYgoDq@smile.fi.intel.com>
References: <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
 <Y1GOTtYIeOFmrmm7@sirena.org.uk>
 <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
 <Y1J3lyrygPvVGUJw@sirena.org.uk>
 <Y1J5wx63bzq4tnik@smile.fi.intel.com>
 <Y1J7iJ967d0I83oZ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1J7iJ967d0I83oZ@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:59:20AM +0100, Mark Brown wrote:
> On Fri, Oct 21, 2022 at 01:51:47PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 21, 2022 at 11:42:31AM +0100, Mark Brown wrote:
> 
> > > > That's exactly what I'm talking about when said "named resource check".
> 
> > > Like I say a property can come from any firmware interface.
> 
> > But I'm talking about resource (not a property) as IO memory. It doesn't come
> > via firmware at all. Have you had a chance to look into the v4?
> 
> On DT based systems resources can be named by the firmware, I don't know
> if that's possible with ACPI but as the name suggests the driver gets
> used on PXA systems too.

And how is it related to DT if the enumeration happens via platform driver
code? As for PXA this is all comes via board files:

$ git grep -n -w '"pxa2xx-spi"'
Documentation/spi/pxa2xx.rst:66:        .name = "pxa2xx-spi", /* MUST BE THIS VALUE, so device match driver */
arch/arm/mach-pxa/devices.c:1082:       pd = platform_device_alloc("pxa2xx-spi", id);
arch/arm/mach-pxa/icontrol.c:127:       .name          = "pxa2xx-spi",
arch/arm/mach-pxa/icontrol.c:135:       .name          = "pxa2xx-spi",
drivers/mfd/intel-lpss.c:123:   .name = "pxa2xx-spi",
drivers/spi/spi-pxa2xx-pci.c:298:       pi.name = "pxa2xx-spi";
drivers/spi/spi-pxa2xx.c:1765:          .name   = "pxa2xx-spi",

In the current code and after my patch series the priority is that
the driver data from the spi-pxa2xx.c is the first. So, if compatible
(which is by fact the only "marvell,mmp2-ssp") has named resources
that exactly the same as LPSS for MFD, nothing will change the driver
behaviour.

For the ACPI there is no names for the resources so far.

-- 
With Best Regards,
Andy Shevchenko


