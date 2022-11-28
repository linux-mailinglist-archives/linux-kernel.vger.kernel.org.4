Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE463B1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiK1TBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiK1TBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:01:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB64C26AC0;
        Mon, 28 Nov 2022 11:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669662085; x=1701198085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DnYg4XqVVvxprNVrqnW/iQllU52ccsTpeN+jbAJ6iS0=;
  b=f0/QqnORBWLQoNiTaM1KlH+I4MlTNSDtUJakyl8meEfR2KDsdLJzq4BM
   URNAkb3Ivt6r6s0D01mv0Nqb1JRkFAmA5UKm+R8s4fLbj9voQA45iINMv
   AtnHLTnEUIXzO/2OWOZucy4puSD2hvDmgBkXQxuVDYK6c8t4MvO3AObsS
   I5DkCasxPbuTNPlyr1c4CB94ng6Q5xDkp0BNXng4HFIlotL+RfcIdc2Fj
   yB3g+vFDCq6zethlvVlPotD7lV2HPgILNassqawzCQpZF97ogJM5S/d2N
   LBnGRAoynu8oOObhy1f5O3CFCMx/cpcI+Fs6tqNvAV90xVokLVsHfS+c1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313629213"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313629213"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785749910"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="785749910"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2022 11:01:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozjNY-001MCf-2U;
        Mon, 28 Nov 2022 21:01:20 +0200
Date:   Mon, 28 Nov 2022 21:01:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] gpiolib: Provide to_gpio_device() helper
Message-ID: <Y4UFgMeqK+n9ya90@smile.fi.intel.com>
References: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MccBY8ov4CGB3uWNBsWSAw48vWY8mekZg53QB1pF+itLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MccBY8ov4CGB3uWNBsWSAw48vWY8mekZg53QB1pF+itLg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:04:28PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 25, 2022 at 7:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > +#define to_gpio_device(_dev_)  container_of(_dev_, struct gpio_device, dev)
> > +
> 
> Just make it a static inline, please.

Made in v2. Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


