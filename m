Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC38625E64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKKPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:32:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5FB623A9;
        Fri, 11 Nov 2022 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668180746; x=1699716746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8f1G6QBRRQMnGS7B8ki7nr3TYj0v6oeggtwfgfF/mBc=;
  b=BSDQr/7nhiqv8h+KHFaEMvsM21IbOwjuvDNzIBHFBRCnGyWqKQ9q4sT3
   32VTlozfQTn7HC2NYKfUeuViG7nSR0FqJ0Ka65FEHZu0S155iugjyJ52k
   1MQq0RxIGME4BVDsMYpqCKvWwNr1bEKL9LcwjbQm8BFrLW4O0afx1qtup
   4tgpHPxTdF/I440ZXknfu6/J/Yp/+uosAW+iqsGQa+BU0PVXuGv92oGBm
   iMdOFiej6ccU17z8vHmQF/F3OhWeaUZOGZQYPBOWofn8r9JmRS4e/8EOx
   UnOWK4Q0MMbDdgwzzEs4Uz11+7nQeC0TaKk8Fn1OiD5D8leIEzkISkYW+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="294975384"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="294975384"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 07:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="882789300"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="882789300"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 11 Nov 2022 07:29:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otVy1-00AlmY-0w;
        Fri, 11 Nov 2022 17:29:17 +0200
Date:   Fri, 11 Nov 2022 17:29:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/8] media: ov2740: Remove duplicative pointer in
 struct nvm_data
Message-ID: <Y25qTDJvZtWKVlBD@smile.fi.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <YwTf22gkWxeyNKlR@smile.fi.intel.com>
 <Y246keIq4a541ooO@smile.fi.intel.com>
 <Y247UMkAUafPTBYI@smile.fi.intel.com>
 <Y25jJd24+Aq53gKE@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y25jJd24+Aq53gKE@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:45PM +0000, Sakari Ailus wrote:
> On Fri, Nov 11, 2022 at 02:08:48PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 11, 2022 at 02:05:37PM +0200, Andy Shevchenko wrote:
> > > On Tue, Aug 23, 2022 at 05:10:35PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Jul 26, 2022 at 03:05:49PM +0300, Andy Shevchenko wrote:
> > > > > The struct i2c_client pointer is used only to get driver data,
> > > > > associated with a struct device or print messages on behalf.
> > > > > Moreover, the very same pointer to a struct device is already
> > > > > assigned by a regmap and can be retrieved from there.
> > > > > No need to keep a duplicative pointer.
> > > > 
> > > > Thanks, Bungbu, for the review. Can it be now applied?
> > > 
> > > Don't see this being applied or commented why not...
> > > 
> > > Mauro? Or who is taking care of this driver nowadays?
> > 
> > Okay, found a private response by Mauro where he tells that Sakari can take
> > care of this. Sakari, should I resend this to you with all tags applied?
> > Or you can use `b4` tool that allows to avoid unneeded resend.
> 
> No need to. But please cc me on the next time. I'll take a look now...

How should I know whom to Cc? Can we update MAINTAINERS accordingly, please?

-- 
With Best Regards,
Andy Shevchenko


