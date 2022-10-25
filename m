Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E760D1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiJYQtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiJYQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:48:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0739E987A;
        Tue, 25 Oct 2022 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666716539; x=1698252539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i1Qd/K9vj0ttOD2SAsM1cENFsK3EztLG/4JIM2IjEyo=;
  b=YKvmDxV0adnpBk437ELB0YaWnfji+ZVqoBmaaoFjzdy/nNjFAgUvSZ79
   4LsJo9qRMRUbJo31eT+Ij1LFLiLFhAckkoGFoVYc8aiDBWnTKwpt9ny0i
   YrV6fZKe0+TqdFOIhFSMecANUXptUeKRKPZ6KpvIuV0YOUCP3F8dr0tNT
   DPROUr/oNcsOS7FHDoZlhB7ANmgSD6N6xQdUEr1R0BWKyTHupyBXwYbHd
   AvALEIAi4cbQnEm0+HSz1ZlEYLWWmUSZ/kMebIO7g059dHT5Cssn7jYs1
   G82Oa/QNv1nz6Xxc0RP4gpusHXtsz81T1kV+Rdlz5o/EqCzsyyL690EPQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306460829"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="306460829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="582842417"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="582842417"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2022 09:48:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1onN6g-0026we-2J;
        Tue, 25 Oct 2022 19:48:50 +0300
Date:   Tue, 25 Oct 2022 19:48:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix typo in kernel doc for struct
 line
Message-ID: <Y1gTcttL3hbPe8a3@smile.fi.intel.com>
References: <20221020153914.63260-1-andriy.shevchenko@linux.intel.com>
 <Y1KWULsdyTvmuN/k@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1KWULsdyTvmuN/k@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 08:53:36PM +0800, Kent Gibson wrote:
> On Thu, Oct 20, 2022 at 06:39:14PM +0300, Andy Shevchenko wrote:
> > When eflags has been renamed to the edflags, the kernel doc change were
> > missed. Update kernel doc accordingly.
> > 
> > Fixes: b1a92e94560d ("gpiolib: cdev: consolidate edge detector configuration flags")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Kent Gibson <warthog618@gmail.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


