Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66E6A1FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBXQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:36:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E2196B9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677256594; x=1708792594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RRMkhSRZlR5BTaFoWzdHlOaF6RSQ2vYR2Y72uMx6Xdg=;
  b=nWXN3u1dHif/RhUwfKjNLZIuucJQMCQQWZNdkYn4HKnUH4ZwhGn5dTvO
   nyikreyHiAfjOKPV/EFk5Sco+s2QrN0jO+rAPeZVdqMWqnKWIzGEN3248
   Ifbt6cWHwbREJ6DogdA0HnrODV2YKJDc6/zc7Fu76if1la/uwW6jk3D86
   kaPULQ2f13TiBlzIu2TBjJW5Nw1eOUgS2NXrKwvwoGZzGV/4B6rOqC4LQ
   HZXdgob3X9Sr7NFgiS6SeQiRA9NYMuZjUIzeUdEqU4bc9tciMJqjuKcOB
   ca/iqihYLM6uLNr/UZjz2V0kBIRaqL8CL+sYlUVkiY5/xNjFza+g0Ryni
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="317276450"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="317276450"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:36:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="705331726"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="705331726"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 24 Feb 2023 08:36:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pVb3e-00BXAz-29;
        Fri, 24 Feb 2023 18:36:30 +0200
Date:   Fri, 24 Feb 2023 18:36:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-ID: <Y/jnjivxoIefKzlx@smile.fi.intel.com>
References: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
 <Y/ZGMDI9wcOwMUWI@fedora>
 <Y/e19Oqf1XwDo/aw@smile.fi.intel.com>
 <Y/ZU3YWmC+/sN2iq@fedora>
 <Y/jRNW0QXA6rznDj@smile.fi.intel.com>
 <Y/ZsB8GXdEAvgCtH@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ZsB8GXdEAvgCtH@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 02:24:55PM -0500, William Breathitt Gray wrote:
> On Fri, Feb 24, 2023 at 05:01:09PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 22, 2023 at 12:46:05PM -0500, William Breathitt Gray wrote:
> > > On Thu, Feb 23, 2023 at 08:52:36PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Feb 22, 2023 at 11:43:28AM -0500, William Breathitt Gray wrote:
> > > > > On Mon, Feb 20, 2023 at 05:33:34PM +0200, Andy Shevchenko wrote:
> > > > > >  	unsigned int use_ack:1;
> > > > > >  	unsigned int ack_invert:1;
> > > > > >  	unsigned int clear_ack:1;
> > > > > > +	unsigned int status_invert:1;
> > > > > >  	unsigned int wake_invert:1;
> > > > > > -	unsigned int runtime_pm:1;
> > > > > >  	unsigned int type_in_mask:1;
> > > > > >  	unsigned int clear_on_unmask:1;
> > > > > > +	unsigned int runtime_pm:1;
> > > > > >  	unsigned int not_fixed_stride:1;
> > > > > > -	unsigned int status_invert:1;
> > > > > 
> > > > > These don't look alphabetical, so what is the order for these?
> > > > 
> > > > Nope, the order is to follow:
> > > > a) kernel doc
> > > > b) semantics of each of the groups
> > > > 
> > > > Do you think the order can be improved? Can you point out how?
> > > 
> > > No, I don't have any particular improvement suggestions, I'm just want
> > > to understand the current order for when I introduce something new here
> > > (e.g. no_status). If I understand correctly, status_invert was moved up
> > > to be with the other "*_invert" flags,
> > 
> > As far as I read these there are IRQ related flags, and some others.
> 
> Okay, that makes sense to me too.
> 
> > > but why was runtime_pm moved
> > > to above not_fixed_stride rather than below it?
> > 
> > Do you think that not_fixed_stride belongs to "*mask" group?
> 
> However, I don't think runtime_pm belongs to a "*mask" group either
> because it's a lock for power management if I'm not mistaken. So if we
> can move runtime_pm below not_fixed_stride then we can avoid the
> respective runtime_pm kernel doc line move which makes the diff for this
> patch slightly simpler.

Good point! I will address this in v3.


-- 
With Best Regards,
Andy Shevchenko


