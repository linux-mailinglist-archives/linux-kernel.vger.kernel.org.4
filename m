Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF57C600F15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJQMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJQMUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:20:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F22A72C;
        Mon, 17 Oct 2022 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666009208; x=1697545208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RmYFEN28phqSp8mG6aCLWFWEADNDyPYb/TiMHr0QPNc=;
  b=bVrtCfRzZZIwP1YbPM3XmRuzNXEqz+fQAYCNhezuppRKF/9rPVJRZf/i
   GHi6Cg5886LJa+CG4OPtuG4EZe+nzoLzYAswlVoEwKGx23DvxQ3X3MXye
   sYcZOxYsrbIPYTwXOddhqDu+Jo5zOzIqC1skO9k74UDSlhvKcBIqmEnWz
   5xQrfHmwi8bXZL4Wo6TZV+kLE1EDjNpCAOkhFbW6TqlZLqLdoW7xDiQFc
   gNFWxuP/2BxjKj/BeUQQtWmhtvg7d5+t9Y+3BL+Xwxfg3199PbuP7b18p
   gcBOjG2N4j+oTWx2HNZz936uYkf0PshtHGwCdzUBhZK1BLzyYjB4gB3Ve
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="332320293"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="332320293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="623207818"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="623207818"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2022 05:18:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okP4U-008mkH-2E;
        Mon, 17 Oct 2022 15:18:18 +0300
Date:   Mon, 17 Oct 2022 15:18:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
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
Subject: Re: [rft, PATCH v2 00/36] pinctrl: Clean up and add missed headers
Message-ID: <Y01ICtqd8uy/4/Mb@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZ1M3ckw+jFgvMqG4jvR-t_44GPoZ6ZDXszwZCJr-cDpg@mail.gmail.com>
 <Y00f5exY2fM6IwZ+@smile.fi.intel.com>
 <CACRpkdYmSOGtFz8W_RRkDqMXRRBOSB9jqSn65Sah90bf3Gm59g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYmSOGtFz8W_RRkDqMXRRBOSB9jqSn65Sah90bf3Gm59g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        SUSPICIOUS_RECIPS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:58:03AM +0200, Linus Walleij wrote:
> On Mon, Oct 17, 2022 at 11:27 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Oct 17, 2022 at 11:02:09AM +0200, Linus Walleij wrote:
> > > On Mon, Oct 10, 2022 at 10:15 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > Currently the header inclusion inside the pinctrl headers seems more arbitrary
> > > > than logical. This series is basically out of two parts:
> > > > - add missed headers to the pin control drivers / users
> > > > - clean up the headers of pin control subsystem
> > > >
> > > > The idea is to have this series to be pulled after -rc1 by the GPIO and
> > > > pin control subsystems, so all new drivers will utilize cleaned up headers
> > > > of the pin control.
> > >
> > > Aha I see you want to send a pull request so I backed out the applied patches
> > > from the series for now.
> >
> > Can I consider all that you answered to as Rb tag?
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

> I haven't reviewed in detail but I fully trust you to do the right thing
> and fix any fallout so will happily pull this.

The plan is to push this to Linux Next for a couple of days and then I'll send
PR to you and Bart.

-- 
With Best Regards,
Andy Shevchenko


