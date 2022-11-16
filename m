Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB1F62C4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiKPQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiKPQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:37:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA65D69D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668616274; x=1700152274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pp2ejVg97Ir6mcl2h7T/qT/KmmJmIIspCaDwIEaxt1g=;
  b=Cii6FchJwyaf0tyI9cbuLoeZot9TX5zTMMk2veXdvDVBrBUPHWcF/Wp9
   QDs01u1M4anRIIxWiRW8fnW9gOXZ+n+sIYPKW1XGU+mIhaZm2wNQ8rbe5
   PNfw5rdr0PZPLt8YXfysQISCvJ7EIXwizr4ILhCWVPaLKLYEdrFwRZx/H
   uvtUN0yxdE/E4PLVgL9jB61xlwHX2A/pFMRFZxtU5jLclpqkfxUjjy4ay
   qbU4Vgph6xoEeEXqzvcU+VSpHg3Q0pvvyMKZaZlewCoJZIv2wCY12FhuH
   2pArXB/oae30BYJ+LeKlt+ZHFtkG1RC2cPVkCBKgLcvymtkHYJ4vq66lV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="398877484"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="398877484"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="633683947"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="633683947"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2022 08:31:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovLJf-00DDmn-0L;
        Wed, 16 Nov 2022 18:31:11 +0200
Date:   Wed, 16 Nov 2022 18:31:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3UQTnQB/lz9o3/e@smile.fi.intel.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
 <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
 <Y3T/qJalJ9H224Mu@kroah.com>
 <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
 <Y3UM1PSJnr8xQ966@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3UM1PSJnr8xQ966@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:16:20PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 16, 2022 at 06:04:37PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 16, 2022 at 04:20:08PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Nov 16, 2022 at 03:29:31PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 16, 2022 at 12:42:16PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Wed, Nov 16, 2022 at 11:22:54AM +0200, Andy Shevchenko wrote:
> > 
> > ...
> > 
> > > > > > - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > > > > + * @uuid:		Reserved (used to be UUID of the VM)
> > > > > 
> > > > > If it's reserved, then don't you need to check for 0?
> > > > 
> > > > Reserved in a way that it may content something we just don't care about.
> > > 
> > > "reserved" in the kernel ioctls mean "must be 0 and we will test for it,
> > > otherwise this is an empty/useless field that can never be touched again
> > > in the future.
> > > 
> > > Please spell it out in detail as to if you can ever use this later on,
> > > and what the kernel will do (if anything) if it is set.
> > > 
> > > And if "the kernel ignores it" then that means these bytes are now
> > > "empty space never to be used again", right?
> > 
> > Right, I will fix this in v5.
> > 
> > ...
> > 
> > > > > > +	__u8	uuid[16];
> > > > > 
> > > > > You just changed the type here, so what is that going to break in
> > > > > userspace that depended on this being of a structure type and now it's
> > > > > an array?
> > > > 
> > > > It's the same. The previous was hidden behind additional type level.
> > > 
> > > Same size, yes.  Same C structure definition, no.
> > 
> > It doesn't matter, see below.
> > 
> > > > > And no other kernel changes needed?  Shouldn't you warn if this field is
> > > > > set?
> > > > 
> > > > No, as pointed out in the commit message kernel never ever used this.
> > > 
> > > That does not mean that userspace tools never did, right?  You are
> > > changing the structure definition, what tool just broke?
> > 
> > The only tool has been amended like a year ago, so the answer is none.
> > The commit message has links to the commits in question that made that
> > amendment.
> > 
> > Maybe I should remove Fixes tags? In such case we will very much know
> > that no old tools will be run on the new kernel.
> 
> Please remove "fixes" as this doesn't "fix" anything.

Done in v5.

Thank you for the thorough review!

-- 
With Best Regards,
Andy Shevchenko


