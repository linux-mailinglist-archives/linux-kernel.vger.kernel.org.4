Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23686342A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiKVRk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiKVRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:40:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159DE77228;
        Tue, 22 Nov 2022 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669138853; x=1700674853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=upNGSzzhJG+Wkw5diZX6WcxCtGWqwnN1eIHljJzi8h8=;
  b=iS80+t+Big4Iwer3KWUihlqd8vNY7KKD1WKZoUkXb4379WwDP7UOUiCQ
   MXS3yP9YNn9eHCEIs0wQCCBiUY3HuRWtAe5r07U00k1REcNEwg0k3DPQI
   FcPGqlr5g3qDT7V+OLUsmOagrfYenQMoTlFe3yko1elpirD1DgDRH2J9R
   0QlDXamngmige1OxSsIS8NoPPYcv856JwKjIaYpzIW92cu8jx7Fu2Qnwk
   BDvUlbUr7sUWBFsv80xwwbl/+rJenz3Mtve/j/GLflQY8i+fsSsUZtWDQ
   gkmuJc5d+0wmQ3yg42sP4uLe98Uq7G2gpScS7B6kQ0nXkTS6c4MZtawQj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340743558"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="340743558"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 09:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="619295185"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="619295185"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2022 09:35:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxXBL-00FvoQ-01;
        Tue, 22 Nov 2022 19:35:39 +0200
Date:   Tue, 22 Nov 2022 19:35:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 6/7] pwm: lpss: Add devm_pwm_lpss_probe() stub
Message-ID: <Y30IaslnbeKBkMhM@smile.fi.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
 <20221117110806.65470-7-andriy.shevchenko@linux.intel.com>
 <20221122164703.e3z42rou7ivu3djv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122164703.e3z42rou7ivu3djv@pengutronix.de>
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

On Tue, Nov 22, 2022 at 05:47:03PM +0100, Uwe Kleine-König wrote:
> On Thu, Nov 17, 2022 at 01:08:05PM +0200, Andy Shevchenko wrote:
> > In case the PWM LPSS module is not provided, allow users to be
> > compiled with the help of the devm_pwm_lpss_probe() stub.

...

> > +static inline
> > +struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
> > +					  const struct pwm_lpss_boardinfo *info)
> > +{
> > +	return ERR_PTR(-ENODEV);
> > +}
> > +#endif	/* CONFIG_PWM_LPSS */
> 
> Hmm, this is actually never used, because if
> !IS_REACHABLE(CONFIG_PWM_LPSS), the only caller (that is added in patch
> 7) has:
> 
> 	if (!IS_REACHABLE(CONFIG_PWM_LPSS))
> 		return 0;
> 
> before devm_pwm_lpss_probe() is called.
> 
> Not sure if it's safe to just drop this patch.

How is it supposed to be compiled and linked then?

>	The return value is
> neither -ENOSYS (which I would expect for a stub function like that)

This is not a generic library registration / addition of the device.
I don't see how ENOSYS and esp. EINVAL fits here.

>	nor
> -EINVAL (which for reasons unknown to me is used in the stub for
> pwmchip_add()).

This I explained already that _add() != _probe() semantically, I do not see the
link between their error codes.

> I would have a better feeling with -ENOSYS in your stub, but I don't
> feel really strong here.


-- 
With Best Regards,
Andy Shevchenko


