Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F839622F79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKIP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKIP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:56:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2365817E07;
        Wed,  9 Nov 2022 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668009394; x=1699545394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xo7G88qj6ob5jmRFCAQuRAuziNegSNfDATamLTIqWcA=;
  b=CY1Ol9BaCFS6tgDQVZ//bOqkjajfzoP1U2coeX4cwxeLrTWsONJ1C4y1
   TKS293sEWVIXc/erJLusQ/uSaHhk7iQ+Z0sR7QzOzGyuVc+YSCbQKaVGV
   fR+EYp+5+6cINcN2LAj6fOaDbncMJ0I0vjYESkP1zJ65vxjnUYhDapsdJ
   KKLw9blMxfWisq8VKb8ii8oaZSfDtmLC/1z/KEgZtTirf6ydWJ8+jzNfe
   RCeoGhuEz88pAxacDh/kv9fNnbh3qiitEe6lX2wrnK+1l2kfppGSXq3DH
   SI15xggi60Sd/1o/kNF4f8TVG2scJmweW7yRNOV2wIQzPpuK1zP3q5wu+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312175960"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312175960"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="881974205"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="881974205"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2022 07:56:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osnRB-009oaF-0j;
        Wed, 09 Nov 2022 17:56:25 +0200
Date:   Wed, 9 Nov 2022 17:56:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] resource: Replace printk(KERN_WARNING) by
 pr_warn()
Message-ID: <Y2vNqBAnPfb/aFda@smile.fi.intel.com>
References: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gxM80EKiiMJKkN6t1CVgf1=6yYA3D4=TfOHVh1chaJuw@mail.gmail.com>
 <Y2uOd+mCwmh4qdm8@smile.fi.intel.com>
 <Y2us/RKHYLMTrje0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2us/RKHYLMTrje0@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 02:37:01PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 09, 2022 at 01:26:47PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 09, 2022 at 12:12:03PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Nov 9, 2022 at 11:51 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > +       resource_size_t end = addr + size - 1;
> > > 
> > > And this change could be mentioned in the changelog too.
> > 
> > And it's (indirectly). This is to have a variable to be consistent in the
> > print. But I can add more explicit mention.
> 
> Please do.

v2 has been sent, thank you for review!

-- 
With Best Regards,
Andy Shevchenko


