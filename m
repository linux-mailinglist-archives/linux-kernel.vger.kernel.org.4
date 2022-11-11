Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC888625946
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKLXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiKKLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:23:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812E60EA6;
        Fri, 11 Nov 2022 03:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668165832; x=1699701832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DZ+7M8Sz2Iz2R8LiJXdGG6ZSQkKE2WtjQiib3s+VEZ0=;
  b=j97Z+p0CE0wZ5THqIeR9p6WToG5UOcSIraxdtACXliiatc1y/oktXMPy
   8WPasqzNoqTYWPO64WPnnPyABwoUV1M6fQOFHsTFGKELeCUTtUbNreCn0
   QXp9sJRngbEYUy8erR4LPNPuU20x1xCuNQHuysd4s48KJ9Ub/PxYht3kj
   xBTl1vxW9hNpaeGOHNb/8m6301SIiBaRz1uoOOGwc6gQFvkFV7/d6juUZ
   HYbzon3k3v3ZMmukXDgq8WX9g0Os2J8jEJ1SjDtmJI22/hhybioMkLLBO
   0ap2onvUvqN+vAS6qQ7+AwdAMYrxIJMl0JbO/EpJoTRHPMlkI+EBC/cD/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310292505"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="310292505"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:23:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668786074"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668786074"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 03:23:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1otS8S-00AfWi-22;
        Fri, 11 Nov 2022 13:23:48 +0200
Date:   Fri, 11 Nov 2022 13:23:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: [PATCH v8 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Message-ID: <Y24wxDsrLf1ACQsG@smile.fi.intel.com>
References: <20221109061122.786-1-zhuyinbo@loongson.cn>
 <Y2vJ953qKHQTalru@smile.fi.intel.com>
 <1c8b897b-9dca-cb36-3281-e98ab29e0921@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c8b897b-9dca-cb36-3281-e98ab29e0921@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:53:37AM +0800, Yinbo Zhu wrote:
> ÔÚ 2022/11/9 ÏÂÎç11:40, Andy Shevchenko Ð´µÀ:
> > On Wed, Nov 09, 2022 at 02:11:21PM +0800, Yinbo Zhu wrote:

...

> > > +static const unsigned int lio_pins[]    = {};
> > > +static const unsigned int uart2_pins[]  = {};
> > > +static const unsigned int uart1_pins[]  = {};
> > > +static const unsigned int camera_pins[] = {};
> > > +static const unsigned int dvo1_pins[]   = {};
> > > +static const unsigned int dvo0_pins[]   = {};
> > 
> > No sure what this means.
> There are some fuzzy reuse relationships on loongson2, e.g., lio can be
> reused as gpio, which is one of the reserved gpios but the manual not
> indicates this gpio index.

The rule of thumb is to avoid putting something you are not able to test.

...

> > > +	unsigned long reg = (unsigned long)pctrl->reg_base +
> > > +				loongson2_pmx_groups[group_num].reg;
> > 
> > Why casting?!
> There are some registers that determine the pin reuse relationship. For
> example, register A determines the sdio reuse relationship, and register
> A+offset determines the uart reuse relationship

I'm asking about something different. Why do you need casting for iomem offset?

...

> > > +	val = readl((void *)reg);
> > 
> > Ouch.

^^^ You see, this is a real issue with code, without fix which it's no go.

...

> > > +	writel(val, (void *)reg);
> > 
> > Ouch!
> I will keep writel/readl.

Yes, but you need to take care about annotations of the addresses (__iomem)
and remove ugly castings.

-- 
With Best Regards,
Andy Shevchenko


