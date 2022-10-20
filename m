Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC36066A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJTREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJTREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:04:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C75F4A;
        Thu, 20 Oct 2022 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666285464; x=1697821464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y7WqdeDS4dawTDyQA71EE8SCYvz9ou77OqXY2KoNYVs=;
  b=TTASB++G68DQRV7FEe7dpMaxj+22OIYl1ejalm9+KjAtQowdxGgeU6OT
   xTkhKe79szQ2ossP/4DLF+9MZ3Be7IRRpudtTbKWp3J0N+qPQzD+NyvfD
   7eE4KmlUzhxPwLDUOufxaW7MfHr49viQBAnb3Vjk01vxud8VSmqQzVF7r
   JrMwSBXSuPdaenD69wBPXc5ZTCwl1VyJsdwpXT8uc09DZ4Ks2ezYlw4W6
   i579DmhM08qnDDbGAWxfbCk+tSAbH8CGqt+L/VCfk5VSCdIO+vVpCYecJ
   IYQmKLgDhY+5/rYcnI5slRnmJOVlzzYWw6TYUjENQsURn9do+z8HAj3+8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306768334"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="306768334"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693113499"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="693113499"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2022 10:03:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olYxF-00Aeq1-20;
        Thu, 20 Oct 2022 20:03:37 +0300
Date:   Thu, 20 Oct 2022 20:03:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
References: <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1F+Pw52nN195qDO@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 05:58:39PM +0100, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 07:42:09PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 20, 2022 at 05:25:15PM +0100, Mark Brown wrote:
> 
> > > That's true currently since you're matching based on ACPI ID and then
> > > have the lookup done with the ID information in the acpi_device_id table
> > > but IIRC the patch was replacing that with some device property stuff.
> 
> > But that one also based on the IDs, it's not assigned without real IDs of
> > the devices on the certain platforms. I don't see how it's different in
> > this sense.
> 
> The driver won't even match and therefore load if it doesn't have a
> lookup for the device with the current code, the type code comes from
> the match.  If it has to go querying a device property then the driver
> can load but end up with a device property it hasn't ever heard of and
> end up misbehaving as a result.

That's how all MFD devices work nowadays, right? What's so special about
this driver? It's being used as a child by MFD. If what you are telling
is a real concern, we have to have a way to assure that all drivers that
are children of the MFDs should provide a match. IIRC there is no such
mechanism exists in the kernel these days.

-- 
With Best Regards,
Andy Shevchenko


