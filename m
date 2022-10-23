Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C079A6095E6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJWTwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:52:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391226745F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666554726; x=1698090726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BRbExdeTLMCh5C1ujc64g/GF9GvYQkNjjrMuS0UrLOc=;
  b=QwC1P77x/6PfBr6eNrp2pl7BTarT9tWhGnYpiHBJtg+vZRuDtjaENnEu
   VNREPK3sM7Tj0bx/VDtwES4fHzSy+/z0zpui/s20GFd86tpRtJ+6OAEIj
   q3SWnpkENH8KXrm0GxXnr/LQ/Ziszg0vjOe13ckqwSuNTl+vfKBF2O9gN
   u3nvC1kSnQ/slN/1qBbgDE9WItrqlomhisENxOz7/VdwbjtyboXhUuMBV
   xDn7hyDofLXdPqLZY0kvnKKzoeID11t22xG4oOw2QdXJ7yioiz94sBm0A
   AciQ3OxvI5OyucGb+0zUQ+tSmkl6sc5wsB/OnDTmKWNKa2c4NZDmAcH5l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="369363186"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="369363186"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 12:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="736182222"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="736182222"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2022 12:52:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omh0t-0016rz-1M;
        Sun, 23 Oct 2022 22:52:03 +0300
Date:   Sun, 23 Oct 2022 22:52:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
Message-ID: <Y1WbY903LjRATVwh@smile.fi.intel.com>
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
 <Y1U0pINWo5yjUdc2@kroah.com>
 <Y1WZSysScBH0/6kd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1WZSysScBH0/6kd@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 10:43:07PM +0300, Andy Shevchenko wrote:
> On Sun, Oct 23, 2022 at 02:33:40PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> > > branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
> > > 
> > > Unverified Warning (likely false positive, please contact us if interested):
> > > 
> > > drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4
> > 
> > Andy, this is due to your changes, here's the offending code:
> > 
> > 	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
> > 
> > Now that dev_fwnode() is an inline function, the compiler is confused as
> > to what function to select?  Maybe, I don't know, it seems odd, can you
> > look into it?
> 
> Hmm... I can't reproduce on my side.
> Any (additional) information about compiler, architecture, etc?

I found the original report, but I don't see how to extract the defconfig /
config it used. Can you send that file to me?

-- 
With Best Regards,
Andy Shevchenko


