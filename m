Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439E9609DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJXJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJXJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:24:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543066170A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666603454; x=1698139454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asnkFs2mwKK5aEC7/H9w+AlQeh9SV1riCLgwtzwlkwY=;
  b=T3FdUmJnfZJ9VDD1AyeE2gzIpSRNSMYGKoskcuk/23CD8KDBd7tLXBHf
   qBG1vBU3O4tj9/NCWMg2ZmLAAFXJOYJKTy2gS6onD0MvnaKExurIci3WD
   1NF9DvCxykm2PmmlO7zg8lhrSZ2HZpGyYWkGsXADRxewzpHJdLRp46Wd2
   7PWj6SDAxY1c9g3ApvWArpN68iorTBdLIYHy0ypdGDbwY7UvjWBe+MvA9
   lIpc1/M9LlTQzLZoZAPYWHIOEbyLqZ+hR4phwNtO/e3QxL0PZg6BsmMkp
   ZXNJeO2/KE4+2pNlwCesrGyeTSTNZABaHlDNcSqWuSXuSOCsSapvYKUPa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="371593768"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="371593768"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="876380745"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="876380745"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2022 02:24:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omtgo-001MpB-0T;
        Mon, 24 Oct 2022 12:24:10 +0300
Date:   Mon, 24 Oct 2022 12:24:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
Message-ID: <Y1ZZuY/cS/zePKTe@smile.fi.intel.com>
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
 <Y1U0pINWo5yjUdc2@kroah.com>
 <Y1WZSysScBH0/6kd@smile.fi.intel.com>
 <Y1WbY903LjRATVwh@smile.fi.intel.com>
 <a762dca8-2458-c40b-7a35-80971c46ac84@intel.com>
 <Y1ZTXa0VZrl9jvUU@smile.fi.intel.com>
 <86cafe81-004b-8a0f-b50b-2bad38f84635@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cafe81-004b-8a0f-b50b-2bad38f84635@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:08:37PM +0800, Chen, Rong A wrote:
> On 10/24/2022 4:57 PM, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 09:10:53AM +0800, Chen, Rong A wrote:
> > > On 10/24/2022 3:52 AM, Andy Shevchenko wrote:
> > > > On Sun, Oct 23, 2022 at 10:43:07PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, Oct 23, 2022 at 02:33:40PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
> > > > > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> > > > > > > branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
> > > > > > > 
> > > > > > > Unverified Warning (likely false positive, please contact us if interested):
> > > > > > > 
> > > > > > > drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4
> > > > > > 
> > > > > > Andy, this is due to your changes, here's the offending code:
> > > > > > 
> > > > > > 	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
> > > > > > 
> > > > > > Now that dev_fwnode() is an inline function, the compiler is confused as
> > > > > > to what function to select?  Maybe, I don't know, it seems odd, can you
> > > > > > look into it?
> > > > > 
> > > > > Hmm... I can't reproduce on my side.
> > > > > Any (additional) information about compiler, architecture, etc?
> > > > 
> > > > I found the original report, but I don't see how to extract the defconfig /
> > > > config it used. Can you send that file to me?
> > > > 
> > > 
> > > Hi Andy,
> > > 
> > > The original report can be found at https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/thread/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/
> > > 
> > > and config file can be downloaded from https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/message/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/attachment/2/config.ksh
> > 
> > Thanks!
> > 
> > Can't reproduce on my Debian (x86_64):
> > 
> > gcc (Debian 12.2.0-3) 12.2.0
> > Copyright (C) 2022 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > 
> > Is it GCC issue?
> > 
> > Any pointers where I can download the compiler you are using?
> > 
> 
> Hi Andy,
> 
> It's a smatch warning, it may be a false positive since Dan didn't forward
> the report. +Dan
> 
> smatch warnings:
> drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine
> type of argument 4

Ah, okay, pretty much looks like false positive due to smatch unable to handle
_Generic().

-- 
With Best Regards,
Andy Shevchenko


