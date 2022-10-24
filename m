Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B6609D37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJXI5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJXI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:57:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1062704
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666601824; x=1698137824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMN9/Q2iqFoCUnVFfnXeADLtay2zchM31nc4c91Fb94=;
  b=eoT3cNri/sULiJa/92IGzO2NJGlQHfJmvzXsk30zQ7S60VwUNlPMHiVQ
   yHjF26DTuFdmwx1coQRnTI+GQLPGz2MwiuSnJ16MjODfIIoQOPknJnxZv
   sQRYZOh36Pf6ZEIynj+A0UGaxwvr77F84hN4sB8QGdEhwphLHhVN+FDCM
   n6wwLbuwhhl+VHwTyrf/q1vfmekRmpPC2FhquI6KIYQSxqd0KyZECD2+f
   cw4mkW+kAargiCTZUsqu0g1iM2x2KQluFb/Fl2gOxraeLuffugFygtpbu
   cVEB9pYokvfrB9IY077hKdP/VYlBvvf1EY7NUIhymgI5c0FsADLfjxp7D
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="306102329"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="306102329"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 01:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="736337867"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="736337867"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2022 01:57:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omtGX-001MGV-2j;
        Mon, 24 Oct 2022 11:57:01 +0300
Date:   Mon, 24 Oct 2022 11:57:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
Message-ID: <Y1ZTXa0VZrl9jvUU@smile.fi.intel.com>
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
 <Y1U0pINWo5yjUdc2@kroah.com>
 <Y1WZSysScBH0/6kd@smile.fi.intel.com>
 <Y1WbY903LjRATVwh@smile.fi.intel.com>
 <a762dca8-2458-c40b-7a35-80971c46ac84@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a762dca8-2458-c40b-7a35-80971c46ac84@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:10:53AM +0800, Chen, Rong A wrote:
> On 10/24/2022 3:52 AM, Andy Shevchenko wrote:
> > On Sun, Oct 23, 2022 at 10:43:07PM +0300, Andy Shevchenko wrote:
> > > On Sun, Oct 23, 2022 at 02:33:40PM +0200, Greg Kroah-Hartman wrote:
> > > > On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
> > > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> > > > > branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
> > > > > 
> > > > > Unverified Warning (likely false positive, please contact us if interested):
> > > > > 
> > > > > drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4
> > > > 
> > > > Andy, this is due to your changes, here's the offending code:
> > > > 
> > > > 	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
> > > > 
> > > > Now that dev_fwnode() is an inline function, the compiler is confused as
> > > > to what function to select?  Maybe, I don't know, it seems odd, can you
> > > > look into it?
> > > 
> > > Hmm... I can't reproduce on my side.
> > > Any (additional) information about compiler, architecture, etc?
> > 
> > I found the original report, but I don't see how to extract the defconfig /
> > config it used. Can you send that file to me?
> > 
> 
> Hi Andy,
> 
> The original report can be found at https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/thread/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/
> 
> and config file can be downloaded from https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/message/VE7CMY7FVIPYWHL4XMOCFWCNYTGZSTKP/attachment/2/config.ksh

Thanks!

Can't reproduce on my Debian (x86_64):

gcc (Debian 12.2.0-3) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Is it GCC issue?

Any pointers where I can download the compiler you are using?

-- 
With Best Regards,
Andy Shevchenko


