Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D8633F04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiKVOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiKVOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:34:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477EA26AC9;
        Tue, 22 Nov 2022 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669127667; x=1700663667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iGOi60MjsLH6H5niW3521ZCn7+NgvKjNwOVxB84to18=;
  b=kChnQ6ZF4GqnhptFxWCLO20bQQ+mpWc/Klk+S6XSbAadXGso/3kjVj1m
   7oUw++0X9/sf91qXWgnj/O8uQGWwGGpomtiyr5u37QCjM1PzJxs9l7q9I
   sGupaAs80k5GGQUI3nbtL/aOJDLBi3ZRAi1UPCPrzmL+mRuwCGlI7d1Y6
   pl8LvbW8S825OJ5SvNkJ2ABFd8ZK9aF+e2yfuN7wGVwrdgjgkestvsK+t
   +z7hwpb3Dcc7hlT7Qb/cWwy0l3fcoLB1ZWddtNwOlzGnA2krnqltX8Czh
   A8fDVDv64JUpuCoZp7+EGRR7wEpougYV+FQXgtZZ20M/0cx3p/nA46Gsw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="375970149"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="375970149"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 06:34:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="674365422"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="674365422"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2022 06:34:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxULt-00FriJ-1c;
        Tue, 22 Nov 2022 16:34:21 +0200
Date:   Tue, 22 Nov 2022 16:34:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 3/7] pwm: lpss: Include headers we are the direct user
 of
Message-ID: <Y3zd7be5LJZWkSjl@smile.fi.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
 <20221117110806.65470-4-andriy.shevchenko@linux.intel.com>
 <20221122133933.iwo76w4h6wuvp3v4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122133933.iwo76w4h6wuvp3v4@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:39:33PM +0100, Uwe Kleine-König wrote:
> On Thu, Nov 17, 2022 at 01:08:02PM +0200, Andy Shevchenko wrote:
> > For the sake of integrity, include headers we are the direct
> > user of.
> > 
> > Replace the inclusion of device.h by a forward declaration
> > of struct device plus a (cheaper) of types.h as device.h is
> > an expensive include (measured in compiler effort).

...

> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thank you!

Patch 6 is still in question.

-- 
With Best Regards,
Andy Shevchenko


