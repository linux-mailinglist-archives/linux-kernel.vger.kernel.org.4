Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527F6343AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiKVSdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiKVSc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:32:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97B6B383;
        Tue, 22 Nov 2022 10:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669141978; x=1700677978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CYjJu2jD5nGhAN6mpi33YHUF126KTCULPJBBOaqN3ng=;
  b=h1l2LDH25JtwDCeGUKoCdw1kMu5l2ecQt0HRVjetfCJhybCDCadq7vuc
   FIJ/7MWdBQY+NAKg0ZLnF54tmyS9kAO3hzL6vqVNYurf635L7KygDIu4C
   xTLb2y5NzYtZrdruQTpSNdo2ZMjdkvrUC7bBoI29tNWWFZo6nvd/6dgda
   YtXGAjMZtqawjlhRG6U15QeebCzJVUIjLGWIkPx1rNUWfOl5tOj9O4Wz7
   GvzHleo/TYa3PNddSWcCFmvZng4yXBaosbhc940RTDP28Ub3jMcp6X7Eo
   zGusTQJ0Lo2e5j2V/t+y8kM7kAvy9tPdiU+uVnOzsMIEJez5ShzgyP5VU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340758160"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="340758160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 10:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="641510775"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="641510775"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2022 10:32:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxY4k-00Fx5i-0C;
        Tue, 22 Nov 2022 20:32:54 +0200
Date:   Tue, 22 Nov 2022 20:32:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 6/7] pwm: lpss: Add devm_pwm_lpss_probe() stub
Message-ID: <Y30V1aJcbyjC+Chu@smile.fi.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
 <20221117110806.65470-7-andriy.shevchenko@linux.intel.com>
 <20221122164703.e3z42rou7ivu3djv@pengutronix.de>
 <Y30IaslnbeKBkMhM@smile.fi.intel.com>
 <20221122181444.m74fa47ejp7nvgxj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122181444.m74fa47ejp7nvgxj@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 07:14:44PM +0100, Uwe Kleine-König wrote:
> On Tue, Nov 22, 2022 at 07:35:38PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 05:47:03PM +0100, Uwe Kleine-König wrote:
> > > On Thu, Nov 17, 2022 at 01:08:05PM +0200, Andy Shevchenko wrote:

...

> > > > +static inline
> > > > +struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
> > > > +					  const struct pwm_lpss_boardinfo *info)
> > > > +{
> > > > +	return ERR_PTR(-ENODEV);
> > > > +}
> > > > +#endif	/* CONFIG_PWM_LPSS */
> > > 
> > > Hmm, this is actually never used, because if
> > > !IS_REACHABLE(CONFIG_PWM_LPSS), the only caller (that is added in patch
> > > 7) has:
> > > 
> > > 	if (!IS_REACHABLE(CONFIG_PWM_LPSS))
> > > 		return 0;
> > > 
> > > before devm_pwm_lpss_probe() is called.
> > > 
> > > Not sure if it's safe to just drop this patch.
> > 
> > How is it supposed to be compiled and linked then?
> 
> The compiler optimizes everything away after that return 0 and so
> doesn't need that symbol at all.
> 
> I just tested compiling your series without patch #6, x86_64 allmodconfig + PWM=n.
> 
> nm doesn't report the need for devm_pwm_lpss_probe in
> drivers/pinctrl/intel/pinctrl-intel.o.

Sounds like you are right. I tried a brief test with m/m, y/m, m/y, and m/n
variants between PINCTRL_INTEL and PWM_LPSS and all were built fine.

That said, I will drop this patch and send a PR with the rest.

Thank you for thorough review!

-- 
With Best Regards,
Andy Shevchenko


