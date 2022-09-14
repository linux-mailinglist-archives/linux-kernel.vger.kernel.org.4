Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D95B8A03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiINOJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiINOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:09:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC82DC;
        Wed, 14 Sep 2022 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663164556; x=1694700556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OwYNO3a8InLSODjAfcrLz6U5+3IJkzjM9iu7hhTzQXY=;
  b=fpT9RZjupaJsjY7HhGmyV5bXeCHeEfm5MVK0i2woOPfdAtv9nEMcQKL4
   0XwG6bnblOxa7qs2Ykl4HKodeNScaU/garUPb2q8nCqNiQD+C5EfhyUeP
   IBumLSs7bMfY3hx1WudauIEAoN5FSUV4XyGgK5nlbPv2bBVpA6KvnUmx5
   qC+e7nVYOMPoepxMOk2Z669SePcBJXcKouEb1L6KP8Of88oRTCsH1JO+K
   MvPVYPOoampqTnzrO6OoL/ICNFY3reSXe+TDpY2TKsbpnVwOjxTAjnWHE
   WX7fb8e87NNVanShGSDoUZbQovXYf4612ZXj0j3tUSkC0VePVThg7bzt8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="297168169"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297168169"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:08:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="616875619"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:08:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oYT4L-002F3E-1e;
        Wed, 14 Sep 2022 17:08:49 +0300
Date:   Wed, 14 Sep 2022 17:08:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <YyHgce96oZYJsHZn@smile.fi.intel.com>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-21-farbere@amazon.com>
 <YxowTBIODMLjf1Ek@smile.fi.intel.com>
 <581a4a0b-8e0e-b7a2-f873-77ed74b54e96@amazon.com>
 <3b121ab4-dd64-68b3-ee89-8571b5d3651e@amazon.com>
 <YyC3hsNhbQGIlReU@smile.fi.intel.com>
 <bdb73546-f309-60dd-3c40-d749654228fe@amazon.com>
 <YyGfvzlCu9qgtgA0@smile.fi.intel.com>
 <YyHfHSIz9F+1SGnX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyHfHSIz9F+1SGnX@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:03:09PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 14, 2022 at 12:32:47PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 14, 2022 at 07:26:36AM +0300, Farber, Eliav wrote:
> > > On 9/13/2022 8:01 PM, Andy Shevchenko wrote:
> > > > On Tue, Sep 13, 2022 at 05:40:16PM +0300, Farber, Eliav wrote:
> > > > > On 9/13/2022 4:06 PM, Farber, Eliav wrote:

...

> > > > > It seems like debugfs_attr_write() calls simple_attr_write() and it uses
> > > > > kstrtoull(), which is why it fails when setting a negative value.
> > > > > This is the same also in v6.0-rc5.
> > > > > 
> > > > > debugfs_attr_read() on the other hand does show the correct value also
> > > > > when j is negative.
> > > > 
> > > > Which puzzles me since there is a few drivers that use %lld.
> > > > Yeah, changing it to
> > > > 
> > > >        ret = sscanf(attr->set_buf, attr->fmt, &val);
> > > >        if (ret != 1)
> > > >                ret = -EINVAL;
> > > > 
> > > > probably can fix that. Dunno if debugfs maintainer is okay with this.
> > > > 
> > > > P.S. This needs revisiting all format strings to see if there are no
> > > > additional
> > > > characters, otherwise that needs to be addressed first, if feasible.
> > > 
> > > I was thinking of making such a correction:
> > > 
> > > -       ret = kstrtoull(attr->set_buf, 0, &val);
> > > +       if (attr->set_buf[0] == '-')
> > > +               ret = kstrtoll(attr->set_buf, 0, &val);
> > > +       else
> > > +               ret = kstrtoull(attr->set_buf, 0, &val);
> > > 
> > > and when I tested the change it worked, but then I noticed this commit:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/libfs.c?h=v6.0-rc5&id=488dac0c9237647e9b8f788b6a342595bfa40bda
> > > 
> > > According to this, it previously used simple_strtoll() which supports
> > > negative values, but was changed to use kstrtoull() to deliberately
> > > return '-EINVAL' if it gets a negative value.
> > > 
> > > So I’m not sure debugfs maintainers will be okay with a fix that
> > > basically reverts the commit I mentioned.
> > > Hence, what do you suggest to do with my commit?
> > > Is it ok to leave it as it is today?
> > 
> > Meanwhile asking is not a problem, at least we will know for sure.
> > And yes, leave it as is, but point to the thread where you asking
> > the clarification.
> 
> For the record:
> 
> $ git grep -n -A1 -w DEFINE_DEBUGFS_ATTRIBUTE | grep ');' | sed 's,.*\(".*%.*"\).*,\1,' | sort | uniq -c
>   1 "%08llx\n"
>   5 "0x%016llx\n"
>   5 "0x%02llx\n"
>   5 "0x%04llx\n"
>  13 "0x%08llx\n"
>   1 "0x%4.4llx\n"
>   3 "0x%.4llx\n"
>   4 "0x%llx\n"
>   1 "%1lld\n"
>  40 "%lld\n"
>   2 "%lli\n"
> 129 "%llu\n"
>   1 "%#llx\n"
>   2 "%llx\n"
> 
> means that sscanf() should work and fix the issue. You may even propose a patch
> as a starter for a discussion.

Reading the commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()") I think it should be either reverted or fixed, because
u64 is not an issue for negative numbers. The %lld and %llu in any case are
for 64-bit value, representing it as unsigned simplifies the generic code,
but it doesn't mean we can't keep there signed value if we know that (by
supplying proper format string). We have 43 current users of signed integer
and I'm in doubt this patch doesn't break none of them.

-- 
With Best Regards,
Andy Shevchenko


