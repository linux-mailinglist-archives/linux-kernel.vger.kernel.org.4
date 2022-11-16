Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08D62C116
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiKPOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKPOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:39:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B410D7;
        Wed, 16 Nov 2022 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668609584; x=1700145584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dMJUjykNKADStdZo7f5j0sBe1wB738x6p9hf/XRGPRM=;
  b=RihTZkHiaswqBM+GSm0dwlJr2YNTA8CUxPPk1fmskCZWTSNH5QCRarnv
   g13/VkwUkjr693yYiY0rNdeTsP6EFQAAhXWI8hfGtxoPksUqPccMbbywj
   ykoKhQUOciEyg4qrsyj/Ew+sUkPAwjhRJa7jRcdrd2aW3MzzpEdwWb4oR
   UbejcpmbqxixAs3t2KYA37CC7LMLr049Qc1BZAMlW6TnIej44lCixpqVP
   UDOQ6c48aPw9r+SH8ByHbHD7HdNKS6NOhc4laxKrsT7M9LFJxNT/kulir
   A70qGjSbmD86AumwXxo88FKRyMOTe6mAo9D4P/pafenQDYjFEwicN8v2S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398844897"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398844897"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="708189680"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="708189680"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 06:39:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovJZW-00DAJe-28;
        Wed, 16 Nov 2022 16:39:26 +0200
Date:   Wed, 16 Nov 2022 16:39:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [rft, PATCH v3 1/1] gpiolib: Get rid of not used of_node member
Message-ID: <Y3T2HolVIeHQR8Kz@smile.fi.intel.com>
References: <20221116091859.64725-1-andriy.shevchenko@linux.intel.com>
 <Y3Tp2y9U8PcDh1r/@orome>
 <Y3TvKJAejVAZEVPJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TvKJAejVAZEVPJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:09:44PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 16, 2022 at 02:47:07PM +0100, Thierry Reding wrote:
> > On Wed, Nov 16, 2022 at 11:18:59AM +0200, Andy Shevchenko wrote:

...

> > > +	/* If the calling driver did not initialize firmware node, do it here */
> > >  	if (gc->fwnode)
> > >  		fwnode = gc->fwnode;
> > >  	else if (gc->parent)
> > >  		fwnode = dev_fwnode(gc->parent);
> > > +	gc->fwnode = fwnode;
> > 
> > I'm not sure we want to set this one. We recently discussed this in
> > another thread and my reading is that gc->fwnode is supposed to be used
> > only to explicitly override which fwnode to use if the default isn't
> > appropriate. Right now the standard way to access the device's fwnode
> > seems to be dev_fwnode(&gdev->dev), with only very few exceptions, so
> > it'd be great if we could settle on that, rather than introduce a second
> > field that contains the same value and use them interchangeably.
> > 
> > One way we could enforce this is by setting gc->fwnode to NULL here
> > instead of fwnode. That should cause a crash anywhere it's used after
> > this, so we should be able to easily weed out any abuses.
> > 
> > Of course if people prefer to use gc->fwnode instead, then we may want
> > to remove all uses of gdev->dev.fwnode. There's simply no point in
> > keeping the same value in two different place, it's just going to lead
> > to a big mess.
> 
> I prefer that we explicitly use GPIO device firmware node.
> Independently on this message I came up with another patch
> (I'm just about to sent it right away) which I think it
> the best to have in current case.
> 
> Ideally I would like to see const struct gpio_chip *gc to be a parameter
> to the GPIO chip add(). But it may happen in distant future.

I have updated this patch locally to use dev_of_node() instead of
to_of_node(chip->fwnode), and also relying on the patch I just sent.

Nevertheless, for of_gpiochip_add()/of_gpiochip_remove() and
of_mm_gpiochip_add_data() I still left use of fwnode, because it feels
the right thing to do: we are taking reference on the input data in
such cases.

-- 
With Best Regards,
Andy Shevchenko


