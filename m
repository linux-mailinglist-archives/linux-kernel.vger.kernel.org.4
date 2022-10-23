Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33C6095E1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJWTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:43:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A586D9E4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666554190; x=1698090190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xp5Pci4q5yMQDVFclxASw/sPQ/p2M+cUd1XOZbOa8ow=;
  b=PenkcLQdDxM9srqKkuMQi4cPlA25zp6O6UR1eijG/x6VTfQsumGFFmdN
   /FNxWJZYMaEkQ/Vf+7dXhr4t1sRNE2FP7jKdM0feEya8zNIk+48qNWG1G
   QwTicPoS0SNzK5tnlkid/n/seu+QSOLr/jpGbDLdsfQP93K8dKBp5wpi1
   vWL8q7aW1kYea2zHSWEzbi70H+xKd696/jP2kxlw8/g1KGu4ZJmbNSoGP
   5U7ycxXLS16paMxEJy0wqP61VSWTrwECGtwgFLkD++8qDH2L3XADvG2hM
   ivUJXPoCxkiKfNrvKcRpM1j6ew/elLt4scX80HvwfrMYvLmfEjDQEp68/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="307286057"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="307286057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 12:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="773614725"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="773614725"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2022 12:43:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omgsF-0016hK-2C;
        Sun, 23 Oct 2022 22:43:07 +0300
Date:   Sun, 23 Oct 2022 22:43:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
Message-ID: <Y1WZSysScBH0/6kd@smile.fi.intel.com>
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
 <Y1U0pINWo5yjUdc2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1U0pINWo5yjUdc2@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 02:33:40PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> > branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
> > 
> > Unverified Warning (likely false positive, please contact us if interested):
> > 
> > drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4
> 
> Andy, this is due to your changes, here's the offending code:
> 
> 	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
> 
> Now that dev_fwnode() is an inline function, the compiler is confused as
> to what function to select?  Maybe, I don't know, it seems odd, can you
> look into it?

Hmm... I can't reproduce on my side.
Any (additional) information about compiler, architecture, etc?

-- 
With Best Regards,
Andy Shevchenko


