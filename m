Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8726B0ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCHQdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCHQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:33:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CA348E11;
        Wed,  8 Mar 2023 08:32:59 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334911357"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="334911357"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 08:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="922847989"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="922847989"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2023 08:32:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1pZwim-00HVqn-16;
        Wed, 08 Mar 2023 18:32:56 +0200
Date:   Wed, 8 Mar 2023 18:32:56 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Peter Tyser <ptyser@xes-inc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
Message-ID: <ZAi4uJdqlNfq0q2/@smile.fi.intel.com>
References: <20230307165432.25484-1-afd@ti.com>
 <20230307165432.25484-3-afd@ti.com>
 <CAMRc=MeLM-S+HEuaDPp0UpbHJYmAXfLuFMU2TyvK5KEywSxtQA@mail.gmail.com>
 <CAMRc=MfAqx5Wz2d5K1wWM0ZZ4WBu+Jhercw-z95zGvo_-v=OTg@mail.gmail.com>
 <9c705260-c04c-da2e-db9a-df3ddfb69efc@ti.com>
 <CAHp75Vf9oMUmr473PSjcbXjEA+BFNpSPrLd22X=B378qNasrqA@mail.gmail.com>
 <f7561edb-be14-d78e-0f97-54ef6bd4eaea@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7561edb-be14-d78e-0f97-54ef6bd4eaea@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:20:13AM -0600, Andrew Davis wrote:
> On 3/8/23 9:53 AM, Andy Shevchenko wrote:
> > On Wed, Mar 8, 2023 at 5:50 PM Andrew Davis <afd@ti.com> wrote:
> > > On 3/8/23 4:32 AM, Bartosz Golaszewski wrote:
> > > > On Wed, Mar 8, 2023 at 11:24 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > > > I see there's v2 out, backing it out then.
> > > 
> > > Looks like I missed something that kernel test robot found, so there
> > > will be a v3.
> > 
> > Just split your series on a per driver basis. This will help with
> > understanding what's going on. Also use a cover letter to explain what
> > your series is for.
> 
> There is one patch per driver, not sure what you mean by split per driver?

In the future for similar cases it's better to split the series on the driver
basis, so each patch is sent separately and handled individually. That way
you won't need to resend the whole bunch over and over because of some subtle
mistake made in the middle.

-- 
With Best Regards,
Andy Shevchenko


