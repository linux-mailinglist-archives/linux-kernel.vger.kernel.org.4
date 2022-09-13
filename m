Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA265B791C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIMSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiIMSG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:06:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253E70E7F;
        Tue, 13 Sep 2022 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663088984; x=1694624984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1LkvIeAXL1BK+1/xVWZdecSTR4YLdwGpQFhRg4i+kzA=;
  b=TpOr/kLi1kOqe3aWncsw1/zOkhO3RE56/ZFHk7cJ6EXiYUQZzMNSaSpA
   Iiby+kkynhvftYW1crZltBWnlfZOKT1VSltETW1EyOnq8E40iGRJx2rFE
   aR1qZoc03T52AmCu+jb26VxBje5hb4borJBfO3cX5D9u5/Ac7h/APpQet
   oUkzQ5/8/jJRdhUWO9Z+/lBKu5Lngo656VJQ4QSDqGydjBP2TrWesO2r/
   BYb4/DFqN7LqsMT8JQFvQPCuRfAU8TFh5vbXJlAErMNPyFc+RBSagOoeO
   emPY4+mBZHkfrCb8vRU7bMjxyFy4q2ulXfzPJAhFkd/B3X/L505Z4hPD6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="277929433"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="277929433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:09:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="567662661"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:09:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oY9Ne-001qr0-2D;
        Tue, 13 Sep 2022 20:07:26 +0300
Date:   Tue, 13 Sep 2022 20:07:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YyC4zq2YEmzQMkBL@smile.fi.intel.com>
References: <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol>
 <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol>
 <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
 <YyCTmZocN/CY4Pg6@sol>
 <CAMRc=MdBRGW0skXOgPbZy=w4EiWcyKmKwKSZuAj+k4EtbPmvdg@mail.gmail.com>
 <YyCZ7TN8fyVyuWXY@sol>
 <CAMRc=MfyD5iyfB5f5hx_Kq4p7NZv+0o8HVOysiy6DaKANpGNKQ@mail.gmail.com>
 <YyCtI/WPngP9InsD@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyCtI/WPngP9InsD@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 12:17:39AM +0800, Kent Gibson wrote:
> On Tue, Sep 13, 2022 at 05:58:32PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Sep 13, 2022 at 4:55 PM Kent Gibson <warthog618@gmail.com> wrote:

...

> > We'd need of course first expose that info like:
> > 
> > gpio chip:gpiochip2 lines:0,3,4,7
> > 
> > Does that make sense?
> 
> Makes sense to me, though I don't claim to know anything about fdinfo
> field formatting.
> 
> e.g. I also see fdinfo fields like this:
> 
> eventfd-count:                0
> eventfd-id: 1
> 
> so
> 
> gpio-chip:  gpiochip2
> gpio-lines: 0,3,4,7
> 
> might be ok too.

Always think about two or more GPIO chips in the same process with 1 or more
lines requested from each of them.

-- 
With Best Regards,
Andy Shevchenko


