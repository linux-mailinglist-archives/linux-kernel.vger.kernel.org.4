Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C161A2CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKDU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKDU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:57:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB651A83F;
        Fri,  4 Nov 2022 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667595456; x=1699131456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y2AirDq8Rlml5OeUQuA1igcC34yYZte4OVjx6y/iNcY=;
  b=SsiL6e/B3T6dYfFTc4dtZx50qPgmAajNLrF0LbZMO2nDRxJ2RMpwbngi
   V4D8ac+Fs1yAcFirmlmKlDl1GCZaNmUnjnRnxy1BXRyET6ROdvyew0hbY
   nN9axr7T4ka1Taj/0Wk6vn4OpwWo7S8oC3cA3gFmjtnK8I5S2nSox6wE+
   bg/DPzeLS3NwOfSs+Zwb6YD504O6opywUi/95jrX8HC7ivDy4MqYSuUXN
   Gh8gk4vZDWVJKeR2QAgHmnl8r3X+LyBId/BNOcb4FZVQ+ANUEUXOcca0Z
   BZgTWZ92A5fGAAS+w5HlngSBNObKC6355rO0CGb80VNzkgsBHZeMSylWi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="372177901"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="372177901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 13:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="810191258"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="810191258"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2022 13:57:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1or3kq-007ZJ5-0v;
        Fri, 04 Nov 2022 22:57:32 +0200
Date:   Fri, 4 Nov 2022 22:57:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2V8uwTHYw2McL5S@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
 <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
 <Y2Vo8g5HfvSi7Bck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Vo8g5HfvSi7Bck@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 12:33:06PM -0700, Dmitry Torokhov wrote:
> On Fri, Nov 04, 2022 at 08:08:03PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 03, 2022 at 11:10:16PM -0700, Dmitry Torokhov wrote:

...

> > > const struct property_entry simone_key_enter_props[] __initconst = {
> > > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > 
> > > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > 
> > Okay, can we have an example for something like reset-gpios? Because from
> > the above I can't easily get what label is and how in the `gpioinfo` tool
> > the requested line will look like.
> 
> The label is something unrelated to gpio. The example was supposed to
> match gpio-keys binding found in
> Documentation/devicetree/bindings/input/gpio-keys.yaml

Yes, but what would be output of `gpioinfo` for the above  example and
if GPIO is named properly (with con_id)?

> > > 	{ }
> > > };

...

> > > +	/*
> > > +	 * We expect all swnode-described GPIOs have GPIO number and
> > > +	 * polarity arguments, hence nargs is set to 2.
> > > +	 */
> > 
> > Maybe instead you can provide a custom macro wrapper that will check the number
> > of arguments at compile time?
> 
> We could have PROPERTY_ENTRY_GPIO() built on top of PROPERTY_ENTRY_REF()
> that enforces needed arguments.

Yes, that's what I meant.

...

> > > +		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
> > > +			__func__, prop_name, fwnode, idx);
> > 
> > __func__ is not needed. Dynamic Debug can automatically add it.
> > Since you have an fwnode, use that as a marker.
> 
> I was mimicking gpiolib-of.c::of_get_named_gpiod_flags(). I guess we can
> guess the function from other log messages we emit, but does it hurt
> having it?

I think it's redundant. You can modify message itself to improve its
uniqueness.

...

> > > +	/*
> > > +	 * This is not very efficient, but GPIO lists usually have only
> > > +	 * 1 or 2 entries.
> > > +	 */
> > > +	count = 0;
> > > +	while (fwnode_property_get_reference_args(fwnode, prop_name, NULL,
> > > +						  0, count, &args) == 0)
> > 
> > I would put it into for loop (and looking into property.h I think propname
> > is fine variable name):
> > 
> > 	for (count = 0; ; count++) {
> > 		if (fwnode_property_get_reference_args(fwnode, propname, NULL, 0, count, &args))
> > 			break;
> > 	}
> 
> OK on name, but I like explicit counting with the "while" loop as it
> shows the purpose of the code.

OK, let's see how it will look like with the proper dropped reference.

> > Btw, what about reference counting? Do we need to care about it?
> 
> Yes, indeed, we need to drop the reference, thank you for noticing!

...

> > > +	/*
> > > +	 * First look up GPIO in the secondary software node in case
> > > +	 * it was used to store updated properties.
> > 
> > Why this is done first? We don't try secondary before we have checked primary.
> 
> I believe we should check secondary first, so that secondaries can be
> used not only to add missing properties, but also to override existing
> ones in case they are incorrect.

It contradicts all code we have in the kernel regarding the use of software
nodes, you need very strong argument to justify that.

Personally I think this must be fixed.

> > > +	 */

-- 
With Best Regards,
Andy Shevchenko


