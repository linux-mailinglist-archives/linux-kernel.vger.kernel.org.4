Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2B5FB48C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJKO2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJKO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:28:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3AE95ACE;
        Tue, 11 Oct 2022 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665498495; x=1697034495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDN8pO8vkYfi7aIzDYMNy5iW/C9igDir6WIyp4TE2LA=;
  b=cotYo2t6Ne9FNYFfNrWKnm4db6LluQCGULKVaJ9ShTzpdpqVMIiHA27E
   J1TlMTwF7ROnzimPkxnbp7hrNKM9GeI/hC9WSWe7cJT9hQPTnwRFfDYaH
   QiImui79lUbFjSB5juSO9qSAMd4n3WS7wmxa2l/9VHjk8iEOkMB66I6m6
   Y3VVr8NnM5VwIB2saL+bcQTAylfEsO528e1LG3ZuHL6/ZEprltnvEOvPe
   E9EJfLzkMfTJMF7zaEwRnjBhipmhYmNHeaQ0zdW7QmmRV8ZYweK4T1STs
   s2gB0vUUD+Tm3igz+aqv1g4wd9sSFnIeonhMIJzjx51hs4akTJJUuD731
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="284245094"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="284245094"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 07:28:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="628713444"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="628713444"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2022 07:28:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oiGEq-005LfS-1Y;
        Tue, 11 Oct 2022 17:28:08 +0300
Date:   Tue, 11 Oct 2022 17:28:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
Message-ID: <Y0V9eJX7a0fe6EfX@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol>
 <CAHp75Vf4oS8g0zxgismtLrzsJ7AE-bdMEq+GAzx2=Mwnhuk3UA@mail.gmail.com>
 <Y0V0IXF3sASTGdMU@smile.fi.intel.com>
 <Y0V57gI75ik4ki3A@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0V57gI75ik4ki3A@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 10:13:02PM +0800, Kent Gibson wrote:
> On Tue, Oct 11, 2022 at 04:48:17PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 11, 2022 at 11:05:42AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 11, 2022 at 3:02 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:

...

> > > > > -#include <linux/gpio.h>
> > > > >  #include <linux/gpio/driver.h>
> > > > > +#include <linux/gpio.h>
> > > > > +#include <linux/hte.h>
> > > >
> > > > Ok with the hte re-order.
> > > >
> > > > But moving the gpio subsystem header after the gpio/driver is not
> > > > alphabetical ('.' precedes '/') and it read better and made more sense
> > > > to me the way it was.
> > > 
> > > I see, I guess this is vim sort vs shell sort. Strange, they should
> > > follow the locale settings...
> > 
> > I have checked, the shell and vim sort gave the same result as in this patch.
> > 
> 
> The original order (sans hte.h) was done by VSCode Sort Lines Ascending,
> and that still returns the same result.  That matches what I would
> expect to see given the content of the text.
> 
> And for me vim also gives the original order.
> 
> Just to confirm - is '.' 0x2e and '/' 0x2f in your universe?

$ LC_COLLATE=C sort test1.txt
#include <linux/gpio.h>
#include <linux/gpio/driver.h>

$ LC_COLLATE= sort test1.txt
#include <linux/gpio/driver.h>
#include <linux/gpio.h>

I guess this explains the difference. Currently I have en_US.UTF-8.

-- 
With Best Regards,
Andy Shevchenko


