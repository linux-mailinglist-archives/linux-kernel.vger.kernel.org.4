Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492296A1DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBXPBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:01:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C503B3CE00
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677250874; x=1708786874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCbz+HnX8Zt2lin4xH/VG/zEHbkPsij3HMcrv5NxLgs=;
  b=G6nBo0Yq/njBjXmvRlZZ2Lf9llsOnSCQ4Y6o89XbgN37hk1TC0ge4GW5
   JiJKsGRoGDeYtQMpFtEyJY6uvz48lBs4ELk2g7iYAEL2fy70/0wy+rk7C
   naPpuErFfkxBRsJuIMiYbLL+HaYvMRzXpF6z+aDyeEkAOAJaVfHfpvPHk
   dBs4Yy37iTuLVItQq7UyCzSML5Dh84OqJ49QTw2QW3M4s1lyBUHaaw4bj
   SCbTKZPXAfjNzvaeABdHUGXpcrs3w/itroePfgEYMBCBSmitMMzpWbcId
   8uuf1dQO9kVDqExKDl500YbUw9cHdYHWfI6siE51hFjK/CsTlTFjYEYg1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="321691711"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="321691711"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 07:01:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="741691593"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="741691593"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2023 07:01:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pVZZO-00BUtg-0j;
        Fri, 24 Feb 2023 17:01:10 +0200
Date:   Fri, 24 Feb 2023 17:01:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-ID: <Y/jRNW0QXA6rznDj@smile.fi.intel.com>
References: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
 <Y/ZGMDI9wcOwMUWI@fedora>
 <Y/e19Oqf1XwDo/aw@smile.fi.intel.com>
 <Y/ZU3YWmC+/sN2iq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ZU3YWmC+/sN2iq@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 12:46:05PM -0500, William Breathitt Gray wrote:
> On Thu, Feb 23, 2023 at 08:52:36PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 22, 2023 at 11:43:28AM -0500, William Breathitt Gray wrote:
> > > On Mon, Feb 20, 2023 at 05:33:34PM +0200, Andy Shevchenko wrote:
> > > >  	unsigned int use_ack:1;
> > > >  	unsigned int ack_invert:1;
> > > >  	unsigned int clear_ack:1;
> > > > +	unsigned int status_invert:1;
> > > >  	unsigned int wake_invert:1;
> > > > -	unsigned int runtime_pm:1;
> > > >  	unsigned int type_in_mask:1;
> > > >  	unsigned int clear_on_unmask:1;
> > > > +	unsigned int runtime_pm:1;
> > > >  	unsigned int not_fixed_stride:1;
> > > > -	unsigned int status_invert:1;
> > > 
> > > These don't look alphabetical, so what is the order for these?
> > 
> > Nope, the order is to follow:
> > a) kernel doc
> > b) semantics of each of the groups
> > 
> > Do you think the order can be improved? Can you point out how?
> 
> No, I don't have any particular improvement suggestions, I'm just want
> to understand the current order for when I introduce something new here
> (e.g. no_status). If I understand correctly, status_invert was moved up
> to be with the other "*_invert" flags,

As far as I read these there are IRQ related flags, and some others.

> but why was runtime_pm moved
> to above not_fixed_stride rather than below it?

Do you think that not_fixed_stride belongs to "*mask" group?

-- 
With Best Regards,
Andy Shevchenko


