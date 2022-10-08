Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA05F869F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiJHSbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJHSa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:30:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FE140DA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665253856; x=1696789856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BifqXZw3yYyhG0K+GcXhmir6p4iw7qMpWqww99d3wPo=;
  b=mIyepV3rFubstVAdKLGsZTRl0WvjDhcPux8ypz8PEdhLERaiqlvqcbX9
   fP8eQS8OBYI38gJpVkNhQRJafh5J1J2jay2GfSy4Ah4bsTKI6eUyrx6gd
   R4sqUMvIfNFdnE+bipruH58B63ZGOEpRGDdm7lcUdErgtP72UTo2bI3V7
   IjZc+vGFCUjgoFPYGn0lkdemHjXc78avM2Dlpg5HmtEA38QhdVBOCKZkn
   HLaqYUO4tI8TZcswfgpBhmaGS+LolwqywZss3S4/IhKBV1bfQzDBolj9C
   wDBLW1vpx5Ke4Iuzr6lzr7xXmFwR/TiyiBGbXgL6MxkLYUqzDkxNR5PQB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="284344270"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="284344270"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 11:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="714636011"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="714636011"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2022 11:30:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohEb6-0048v0-2t;
        Sat, 08 Oct 2022 21:30:52 +0300
Date:   Sat, 8 Oct 2022 21:30:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Backlight for v6.1
Message-ID: <Y0HB3K8IRVhX5IvT@smile.fi.intel.com>
References: <Yz18QA27+gN0oaM3@google.com>
 <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com>
 <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:45:27AM -0700, Linus Torvalds wrote:
> On Fri, Oct 7, 2022 at 6:16 AM Lee Jones <lee@kernel.org> wrote:
> >
> > PR satisfying this dependency was submitted the following day:
> 
> .. you ignored the whole "another driver hit v6.0 without ever getting
> the dependency".
> 
> So this whole thing with "dead driver because the config option it
> depended on didn't even exist" wasn't some little temporary thing.
> It's literally there in a released kernel, which has a whole driver in
> it that cannot actually even be enabled.
> 
> And now that I *did* get the MFD update, I notice that the build
> coverage of *that* is pitiful too.
> 
> In particular, there was a silent semantic conflict in the Crystal
> Cove (intel PMIC) driver with the i2c changes. I noticed it because
> there were other things going on, and I went and looked.
> 
> But most notably I *didn't* notice it due to any build coverage,
> because the Kconfig for that thing seems designed to hide the driver.
> It does have
> 
>         depends on (X86 && ACPI) || COMPILE_TEST
> 
> so that it *looks* like it should get compile test coverage even
> outside of x86, but in reality,  even on x86 it's actually really hard
> to test, because it also has
> 
>         depends on I2C_DESIGNWARE_PLATFORM=y

The Intel PMICs are the beasts when we want to run the code on the real
hardware.  The above mentioned dependency is required due to ACPI wants
to poke some PMIC registers via OpRegion in the AML. And since it may
happen quite early at the boot time, we can't wait for I2C host controller
driver to be loaded later on. I don't remember all the details of what will
go bad for the user in such cases, perhaps Hans can clarify these bits.

> so if you do a regular "allmodconfig" build, that driver doesn't
> actually get any build testing at all, because while that platform is
> indeed enabled, it's only a module.
> 
> So I caught this particular issue, but I really think that code that
> cannot be enabled at all even for build testing - or code that is
> quite hard to enable either intentionally or by mistake - is a
> problem. And right now MFD was involved in both of the issues I've
> noticed this merge window.
> 
> That's not a great look.

-- 
With Best Regards,
Andy Shevchenko


