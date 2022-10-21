Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB33D607746
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJUMsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJUMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:47:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3372670D8;
        Fri, 21 Oct 2022 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666356453; x=1697892453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ivteo6S8cP7vZ2TsHSLDWsS4j4BL0MsIIJWfwJrhvbc=;
  b=OpCK11HllZAtXLiPDYJwIO9KKXOju+HHpE8vmUzwiggp47tsCYIf/VIY
   LKH9E7xgLUPItXIATGC5EVzqq8TWcM+HEznR1XmO7PfOolii8z24gZub4
   8WUeDwndNQBVQtyQ2ibI8aOOWuR1xy1ce42IPLtpDXF+krKacgJ6bL5Th
   CZX2xbodxoLwkquy/zxBcSYV0q5lpHjreO01V/c8T65dGH6n+HkbNbQl9
   S5bJtUf7sAS+dN/6O+ofwhWRH1sx+dLjvYZrGQET4uLbB/Qd/+ILUkxrY
   Goib+CUxvkTdLpyEY1PPyT2v+cazlUftpCjynUxG2cbE9UqJNgWGYi8eO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="294392927"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="294392927"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 05:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="875665020"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="875665020"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2022 05:46:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olrQQ-00B9vr-0n;
        Fri, 21 Oct 2022 15:46:58 +0300
Date:   Fri, 21 Oct 2022 15:46:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1KUwvGo3Y3RGGW+@smile.fi.intel.com>
References: <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
 <Y1GOTtYIeOFmrmm7@sirena.org.uk>
 <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
 <Y1J3lyrygPvVGUJw@sirena.org.uk>
 <Y1J5wx63bzq4tnik@smile.fi.intel.com>
 <Y1J7iJ967d0I83oZ@sirena.org.uk>
 <Y1J/by2TGbaYgoDq@smile.fi.intel.com>
 <Y1KQhMwAWQ1/k7E8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1KQhMwAWQ1/k7E8@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:28:52PM +0100, Mark Brown wrote:
> On Fri, Oct 21, 2022 at 02:15:59PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 21, 2022 at 11:59:20AM +0100, Mark Brown wrote:
> 
> > > On DT based systems resources can be named by the firmware, I don't know
> > > if that's possible with ACPI but as the name suggests the driver gets
> > > used on PXA systems too.
> 
> > And how is it related to DT if the enumeration happens via platform driver
> > code? As for PXA this is all comes via board files:

...

> > In the current code and after my patch series the priority is that
> > the driver data from the spi-pxa2xx.c is the first. So, if compatible
> > (which is by fact the only "marvell,mmp2-ssp") has named resources
> > that exactly the same as LPSS for MFD, nothing will change the driver
> > behaviour.
> 
> > For the ACPI there is no names for the resources so far.
> 
> It's not so much does this work now as will this clearly work in future
> when someone changes something, and will any changes that are concerning
> be likely to set off alarm bells.  I'm sure it works fine now.

But how? If in the future ones added a board file -- it will be visible
immediately via `git grep` and hence can be fixed.

In case it's a DT enumerated, we are the ones who will see it in the compatible
list in the spi-pxa2xx.c and there the type is a requirement. So, can you point
out what did I miss?

> BTW the new property isn't added to the binding document, though this
> case is a bit iffy given that the intent is apparently that it not be
> added to the document since this is basically working around the issues
> with ACPI not being terribly descriptive, the property is very much not
> idiomatic for DT.  Having it in the binding document might actually end
> up being an issue - from that point of view it'd be good if we had a
> namespace for things that should never appear in DT that didn't look
> like a DT namespace.

Again, if it appears in the DT, there is no way we noticed the behavioral
change due to priorities of the data we try in the driver. Any change
there will be immediately questioned by reviewers, right?

-- 
With Best Regards,
Andy Shevchenko


