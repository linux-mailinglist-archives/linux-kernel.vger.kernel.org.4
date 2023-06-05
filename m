Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F0722485
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjFEL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFEL0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:26:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297AE6;
        Mon,  5 Jun 2023 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685964388; x=1717500388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwNB4RZ0FUp6zBMrJssU4IpQ7KWD6Nr8beFbi60ZnHw=;
  b=nP79rtDp5Xo8IHvbUX/inF/7ykEqdXib1qky6sNzcbi/VcRxrTqLGfwe
   QC4r9RiCGzzGVyaES1WH0q2iPUQdPhL4y41UKv0X7BR1/zIalkj6dSCoX
   gufw+U9d/i2MYp+imfJcCvWmW0Uj9XuwtuK8SQZrHZ7KUUf9OLJepQwmu
   ZwIHXCRoxvx4/CdaLe9tEp7ZI4TYQaL23wkICyKhCNQD2Uk3BTP7IHocG
   cfnrsNb5NhD2uC/dUds4YqmXqEYdQ2KF2YPCWR++Mst0eit79Ds5eZYzJ
   6vXV5ozQ6BFDU30F1GzgMa+V2WWlV+PzoNuANGmhgb9R6E22wjSz5cF6P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="359657102"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359657102"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="778521796"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="778521796"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2023 04:26:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q68Lr-001MFM-2V;
        Mon, 05 Jun 2023 14:26:19 +0300
Date:   Mon, 5 Jun 2023 14:26:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 28/43] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <ZH3GW9Y+id4EelU9@smile.fi.intel.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-10-nikita.shubin@maquefel.me>
 <ZHjNR1n6tZbTAJWS@smile.fi.intel.com>
 <61b9be215d7eb9908b2dd6750f1598cbb6842f65.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b9be215d7eb9908b2dd6750f1598cbb6842f65.camel@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 10:14:52PM +0300, Nikita Shubin wrote:
> On Thu, 2023-06-01 at 19:54 +0300, Andy Shevchenko wrote:
> > On Thu, Jun 01, 2023 at 08:45:33AM +0300, Nikita Shubin wrote:

...

> > > +static int ep93xx_keypad_flags;
> > > +module_param(ep93xx_keypad_flags, int, 0);
> > > +MODULE_PARM_DESC(ep93xx_keypad_flags, "EP93XX keypad flags.");
> > 
> > Why? This pretty much looks like missing DT description.
> 
> From other patches from this series, i learned NOT to add new DT
> entities, not even with vendor prefix, no way!
> 
> May be i missing something of course...

We do not add module parameters to a new code either. So this will be
a dead end.

...

> Was never used in different ways than initializing all to zeroes
> including flags since 2.6 (didn't look before through), so i would
> prefer to drop this completely than moving it into device tree.

This sounds the best!

-- 
With Best Regards,
Andy Shevchenko


