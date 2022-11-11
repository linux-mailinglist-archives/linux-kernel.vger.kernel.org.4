Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CBF626261
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiKKTsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKKTr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:47:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFFE637C;
        Fri, 11 Nov 2022 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668196077; x=1699732077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6b+dcWERZr5M4/rvE+db2cvLv8jJM9qL7BKy4l+FOBE=;
  b=YkKR4w6qOOZSGcHsVmhrfDpxxPBvrHio28Ehxq4QyoiDHkdZwako4rdw
   2+tKwPu+hx3wPwpnTL35eaBNhiMmgRLg28KE/GvHw8RhTV/b7hxpiBIEX
   YKy5vM64g104NbuKQrYuNb3TzMBCJptqboikT5NAFmAKaDfpFHSXG/5pI
   UzMWFZQmzUqmY6MogM8IXX8ckV13QAWOi1wKCDOmHQp57A9KGbzOjMfCX
   RYHrZbDJeYp4/jnmvfzTm0aeYRifc3xycLoXqsv5bD1LJkHGO1cr9HRwK
   pApl5l0PpUWlyT9G2qe7QbTNT5OlMNfHeYyHKh4DESD2WT0+UReJbx+B2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313456596"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313456596"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 11:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="966912267"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="966912267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2022 11:47:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ota0H-00AseS-1W;
        Fri, 11 Nov 2022 21:47:53 +0200
Date:   Fri, 11 Nov 2022 21:47:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hans.verkuil@xs4all.nl
Subject: Re: [PATCH v1 1/8] media: ov2740: Remove duplicative pointer in
 struct nvm_data
Message-ID: <Y26m6a4983Gl97+2@smile.fi.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <YwTf22gkWxeyNKlR@smile.fi.intel.com>
 <Y246keIq4a541ooO@smile.fi.intel.com>
 <Y247UMkAUafPTBYI@smile.fi.intel.com>
 <Y25jJd24+Aq53gKE@paasikivi.fi.intel.com>
 <Y25qTDJvZtWKVlBD@smile.fi.intel.com>
 <Y26lVCOy0Dfx+ybK@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26lVCOy0Dfx+ybK@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 07:41:28PM +0000, Sakari Ailus wrote:
> On Fri, Nov 11, 2022 at 05:29:16PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 11, 2022 at 02:58:45PM +0000, Sakari Ailus wrote:
> > > On Fri, Nov 11, 2022 at 02:08:48PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Nov 11, 2022 at 02:05:37PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Aug 23, 2022 at 05:10:35PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Jul 26, 2022 at 03:05:49PM +0300, Andy Shevchenko wrote:
> > > > > > > The struct i2c_client pointer is used only to get driver data,
> > > > > > > associated with a struct device or print messages on behalf.
> > > > > > > Moreover, the very same pointer to a struct device is already
> > > > > > > assigned by a regmap and can be retrieved from there.
> > > > > > > No need to keep a duplicative pointer.
> > > > > > 
> > > > > > Thanks, Bungbu, for the review. Can it be now applied?
> > > > > 
> > > > > Don't see this being applied or commented why not...
> > > > > 
> > > > > Mauro? Or who is taking care of this driver nowadays?
> > > > 
> > > > Okay, found a private response by Mauro where he tells that Sakari can take
> > > > care of this. Sakari, should I resend this to you with all tags applied?
> > > > Or you can use `b4` tool that allows to avoid unneeded resend.
> > > 
> > > No need to. But please cc me on the next time. I'll take a look now...
> > 
> > How should I know whom to Cc? Can we update MAINTAINERS accordingly, please?
> 
> Good question. In media tree we've listed the maintainers in wiki, as
> the information would be hard to keep up-to-date file-wise:
> 
> <URL:https://www.linuxtv.org/wiki/index.php/Media_Maintainers>

Unfortunately get_maintainer.pl doesn't know about this.

> So it helps if you cc me to camera sensor driver patches, but they're
> neither ignored if you don't. It usually takes a little bit more time
> but not nearly as much as this time.
> 
> Cc Hans.

-- 
With Best Regards,
Andy Shevchenko


