Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15165E9E41
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiIZJtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiIZJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:48:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372866328;
        Mon, 26 Sep 2022 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664185690; x=1695721690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rFbdK+TnkebQ/ebOKxQtSt/l+qNTLawZB70V4CVhIXw=;
  b=VBZfKlcI60pm02Di3RETVVEqU/TQD09kTztYajGnolRMNOtvl22cbEH4
   wuVTAorEeDO6OPQcByuV8ruqd5E8lm1+hVprdO2h/oGfl4b6O63KrkcU4
   NcXKJ1F8hp31bxQEtnVThjj6XlV2H+kDsbNtUbl76Wygf+uDqB4PChvwQ
   CeeKlqRe7ejnuqGmq2GRWR4pueaY8C61Jcb5F7QjUtNNv0h8cB+cgyvf+
   X0ay3k06eKdDXZ1rd3QwHVYkAhxuuRxnW+U6kkrlJEH66qx5YUjK7WcLW
   kckIlBKspRui6Z3WuTJ1lXIfJEpLouFmwN8eXZh9BbYfU8crkY6ucu5kl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="300967957"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="300967957"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 02:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="796265739"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="796265739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 26 Sep 2022 02:48:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ockic-007jXR-18;
        Mon, 26 Sep 2022 12:48:06 +0300
Date:   Mon, 26 Sep 2022 12:48:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 4/9] pwm: lpss: Include headers we are direct user of
Message-ID: <YzF1VmChe+MyXxJF@smile.fi.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-5-andriy.shevchenko@linux.intel.com>
 <20220924100453.hupbeotwqrehc4yq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924100453.hupbeotwqrehc4yq@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 12:04:53PM +0200, Uwe Kleine-König wrote:
> On Thu, Sep 08, 2022 at 04:56:53PM +0300, Andy Shevchenko wrote:
> > For the sake of integrity, include headers we are direct user of.
> > 
> > While at it, replace device.h with a forward declaration and add
> > missed struct pwm_lpss_boardinfo one.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pwm/pwm-lpss.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> > index c344921b2cab..839622964b2a 100644
> > --- a/drivers/pwm/pwm-lpss.h
> > +++ b/drivers/pwm/pwm-lpss.h
> > @@ -10,11 +10,15 @@
> >  #ifndef __PWM_LPSS_H
> >  #define __PWM_LPSS_H
> >  
> > -#include <linux/device.h>
> >  #include <linux/pwm.h>
> > +#include <linux/types.h>
> >  
> >  #define MAX_PWMS			4
> >  
> > +struct device;
> 
> It's not clear to me how this is an improvment. Isn't it saner to
> include <linux/device.h>?

The compilation time improvement. You don't need to include entire
train of unrelated stuff when compile something.

Moreover, the rule of thumb for the headers is avoid as much as possible
unrelated inclusions not only due to compilation time rising, but also
due to potential circular dependencies and increasing dependency hell
of headers. Believe me, we suffer a lot in the kernel due to this
(I have an example). Also you may check the Ingo's work of improving
headers breakage (APIs vs. implementation vs. data types, etc) to see
the achievement(s).

> > +struct pwm_lpss_boardinfo;
> 
> Why is this necessary? The struct is defined a few lines below the
> context of this patch and I see no user that would benefit.

This is clean way of how we program in C. We should forward declare
the types _before_ using them. Since this is a pointer, forward
declaration is enough.

-- 
With Best Regards,
Andy Shevchenko


