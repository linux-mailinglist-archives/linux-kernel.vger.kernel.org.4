Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD15E9EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiIZKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiIZKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:11:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0713AE5A;
        Mon, 26 Sep 2022 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664187014; x=1695723014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=incQH2Dto+dCjnAkW9zHBf/lKL8d+xXml11ziotBF6o=;
  b=NnbbdZeS0wgw8SiRC+/JofX4POqGNfFYCSuZuo+bNygMG49/5zet0RSW
   S+zGEl+0JShjDiu6sfb4FPU0JTlv/X9hsqWA9XzJOZPbdIBDCI1R3Qd9y
   QP38e75iF2YJNEHHwWMTTB8LSDCMClzars1bXUXrPGMFpV/mFvLIHPvMz
   ycWfdmyU4ldxiDsuHhNUmiw9eZH/7r3Sa2ntCLMdIMjzoAy38wE/ma+WC
   kDOTSeO0YFMo6BXxSyWuTiAG3JONi/YHjmLWKF9tJK8GfhASTI3jUO8ar
   zThhqR2SO/ckvWj8X84P/25aRY0iMwnaCmTmKu9nxQmNCkDZiZspWKnXG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="302458319"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="302458319"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="866068060"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="866068060"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2022 03:10:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ocl3z-007kCD-0c;
        Mon, 26 Sep 2022 13:10:11 +0300
Date:   Mon, 26 Sep 2022 13:10:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/9] pwm: lpss: Move exported symbols to PWM_LPSS
 namespace
Message-ID: <YzF6ggfpyZSMfkIN@smile.fi.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-3-andriy.shevchenko@linux.intel.com>
 <20220924095945.pzyhc24jhjwlfdin@pengutronix.de>
 <YzF0U7q5Fl0UaogR@smile.fi.intel.com>
 <20220926095547.be5bbtyqqlm4ytgy@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926095547.be5bbtyqqlm4ytgy@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:55:47AM +0200, Uwe Kleine-König wrote:
> On Mon, Sep 26, 2022 at 12:43:47PM +0300, Andy Shevchenko wrote:
> > On Sat, Sep 24, 2022 at 11:59:45AM +0200, Uwe Kleine-König wrote:
> > > On Thu, Sep 08, 2022 at 04:56:51PM +0300, Andy Shevchenko wrote:

...

> > > > +MODULE_IMPORT_NS(PWM_LPSS);
> > > 
> > > Each user of the lpss.h header needs that, right? Then the
> > > MODULE_IMPORT_NS statement can go into the header, too.
> > 
> > With the same answer as for v1: any user that might include the header for
> > the sake of data types will get the NS inclusion even if they don't need
> > that (yes, I don't think it's practical, but slightly better to make sure
> 
> I'm not sure I understand you correctly here. For some headers you
> cannot assume that a file including the header also needs the namespace
> macro, but for pwm-lpss.h that should be a safe assumption.

Yes, it's a safe assumption for _this_ case (as I pointed out above that
there is probably no practical to assume otherwise), in general it may be
not the case.

-- 
With Best Regards,
Andy Shevchenko


