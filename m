Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED1625C52
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiKKOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiKKOEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:04:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED486D74;
        Fri, 11 Nov 2022 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668175130; x=1699711130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L/FQc/AZs3Ei3xk31ePXcOsPPfQIhow5g5Op2Rjvb7g=;
  b=iTMk8I71/ZqKg3nqhBDQdL+7Ei+LWVV3clLmO1BFGCK0bj9BlbhxxEP/
   y3knZu+77OwLRmFHlIXpyoBnocjT4oamKcVEpIrUD2J9jRkAaNWC1CM62
   VI0XjSrLov7z8Qkl+lERDjk+PrdEX29+7X6vqEUTXymhFOiNj5fYUXIIW
   +5mSKztNkHj/ynwvUY/TX5lP0EvdBB3rO/sXb7uR6KFAGLAZ7yGckhsje
   BQX00NIITHxQ58/0bcLjr+BTjtmwvJluq5ZCdtf5RBCczs97fiVzMGydK
   pRN3w8e0bx6w10QT9ERLIHZ5dTeBgRGVnetsVpQGzwbuUxgNFbdX+/vZK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="397893595"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="397893595"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 05:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="632038222"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="632038222"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2022 05:57:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otUXZ-00AjQU-2g;
        Fri, 11 Nov 2022 15:57:53 +0200
Date:   Fri, 11 Nov 2022 15:57:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/6] pwm: lpss: Add pwm_lpss_probe() stub
Message-ID: <Y25U4S2OAOskKI60@smile.fi.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-6-andriy.shevchenko@linux.intel.com>
 <20221110073831.ggudvgl6jzgbo2vb@pengutronix.de>
 <CAHp75Ve837d_2UEQRMJEcmOdPVdqSAKv+dJje057uJouCPAe9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve837d_2UEQRMJEcmOdPVdqSAKv+dJje057uJouCPAe9Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:01:50PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 10, 2022 at 9:38 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 08, 2022 at 04:22:25PM +0200, Andy Shevchenko wrote:
> > > In case the PWM LPSS module is not provided, allow users to be
> > > compiled with a help of a pwm_lpss_probe() stub.

...

> > > +static inline
> > > +struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
> > > +                                  const struct pwm_lpss_boardinfo *info)
> > > +{
> > > +     return ERR_PTR(-ENODEV);
> >
> > Would it be more consistent to return the same value as the pwmchip_add
> > stub does?
> 
> Then I will lose the ability to distinguish between absent driver (or
> device) and actual error during the probing of it. Any suggestions on
> how to do that better?

Independently on the above, I think that _probe() != _chip_add() semantically
and having the same, and we know weird, return code doesn't make it anyhow
better. I believe that -ENODEV is the best fit here.

That said, I leave it as is for v3 and we may continue discussing it there.

-- 
With Best Regards,
Andy Shevchenko


