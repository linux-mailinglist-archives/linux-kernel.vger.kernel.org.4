Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D912D5FF0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJNPLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJNPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:11:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C871CF54B;
        Fri, 14 Oct 2022 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665760302; x=1697296302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/njfTWM92urhDh1tc8kt06mInCQV3hTHb5sdf7xqk0=;
  b=bYM9g6tVvtVxav3WaIrakhmyROkTIIboxfH+Snti7Ci8xFZNO4FolujL
   thOBhsuC2TfFHL04DoRxG5S2eUY/pAV0ZXb0LWpYmunDj/ubmUPdfkPSY
   lNHnGkeaZMzKLb684jH0zXNvWWJdgTnh0v0EcW4qCAjgpfJ+TBq5lwWg2
   1euRJ0TRDrJx5ddSw44StElwH8iUvgQNGC6z3xIaZe9/ef+zoNkL0R21m
   AGZv/jOUPRKHS0+dy0loDJ4uj3Bzkmpsh04Qo5X4rRcPoI2vhFmADfEF4
   D/1eSZezcYNv2aMlKCnX02TtPb5jFtE3vkhoYLsQg15GaZf6PSNlwT/Er
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369587630"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="369587630"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="660758830"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="660758830"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2022 08:11:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ojMLW-006yCQ-0e;
        Fri, 14 Oct 2022 18:11:34 +0300
Date:   Fri, 14 Oct 2022 18:11:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
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
Message-ID: <Y0l8JTQQvLzRejk1@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <0684f480-2092-d520-2c8e-bd9a2dca47e3@gmail.com>
 <CAHp75VdDjyUAZBTaoPOe5oA3f_5xRznAooq08=Eff4F1AZyVOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdDjyUAZBTaoPOe5oA3f_5xRznAooq08=Eff4F1AZyVOQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:04:10PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 11, 2022 at 11:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 10/10/2022 1:14 PM, Andy Shevchenko wrote:
> > > Currently the header inclusion inside the pinctrl headers seems more arbitrary
> > > than logical. This series is basically out of two parts:
> > > - add missed headers to the pin control drivers / users
> > > - clean up the headers of pin control subsystem
> > >
> > > The idea is to have this series to be pulled after -rc1 by the GPIO and
> > > pin control subsystems, so all new drivers will utilize cleaned up headers
> > > of the pin control.
> > >
> > > Please, review and comment.
> >
> > Did you really need to split this on a per-driver basis as opposed to
> > just a treewide drivers/pinctrl, drivers/media and drivers/gpiolib patch
> > set?
> >
> > 36 patches seems needlessly high when 4 patches could have achieve the
> > same outcome.
> 
> I can combine them if maintainers ask for that, nevertheless for Intel
> pin control and GPIO drivers, which I care more about, I would like to
> leave as separate changes (easy to see in history what was done).

I can now tell why I don't like to combine. While doing a revert (it's not
related to GPIO nor to pin control), it appears that I reverted extra bits
as merge conflict resolution. This is per se is not an issue, but when
I tried to find and reapply that missed piece I can't, because the patch
is combined and Git simply ignores to have
`git cherry-pick _something in the past_` done.

But again, up to maintainers.

-- 
With Best Regards,
Andy Shevchenko


