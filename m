Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD662C362
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiKPQFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiKPQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:05:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629C2E9DC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668614705; x=1700150705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n9AN618bUNj13xisUH6R3r0HHk9xx57S07U0cpH9LJQ=;
  b=lZ9IHFT0J1YAw8eAnjtWtSCLVBgEh3hD8cfCUgJb00gfvOunPNQLua2i
   pLYR3juSB8U0j7TKv2g5J9upBkvrXi1Dfp5G7myvySOYlPuCN9Yw/JZ5S
   aNethwFzvNNyEkT1lRGtmCOdu1w0JT30KpdgNjj84ywZclKVPUWCNhHTb
   Zx/Y6OSmt8iMr68aC2PoiwfKuJiozj0K/gGntqQzNJmB89i4kaBqs1DJG
   I6jqGai+YICJNQhqXpy1hBzGH/jhJDzGarL2XTXb7/aroOG7ChBGtDFTi
   MeVmG2TARna4x/ktIEvRur2vAA/FFIIe+F4dvqjqs/yxiVHgmBkEJ23TO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292973464"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292973464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590238725"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="590238725"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2022 08:04:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovKty-00DD59-0o;
        Wed, 16 Nov 2022 18:04:38 +0200
Date:   Wed, 16 Nov 2022 18:04:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
 <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
 <Y3T/qJalJ9H224Mu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3T/qJalJ9H224Mu@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:20:08PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 16, 2022 at 03:29:31PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 16, 2022 at 12:42:16PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Nov 16, 2022 at 11:22:54AM +0200, Andy Shevchenko wrote:

...

> > > > - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > > + * @uuid:		Reserved (used to be UUID of the VM)
> > > 
> > > If it's reserved, then don't you need to check for 0?
> > 
> > Reserved in a way that it may content something we just don't care about.
> 
> "reserved" in the kernel ioctls mean "must be 0 and we will test for it,
> otherwise this is an empty/useless field that can never be touched again
> in the future.
> 
> Please spell it out in detail as to if you can ever use this later on,
> and what the kernel will do (if anything) if it is set.
> 
> And if "the kernel ignores it" then that means these bytes are now
> "empty space never to be used again", right?

Right, I will fix this in v5.

...

> > > > +	__u8	uuid[16];
> > > 
> > > You just changed the type here, so what is that going to break in
> > > userspace that depended on this being of a structure type and now it's
> > > an array?
> > 
> > It's the same. The previous was hidden behind additional type level.
> 
> Same size, yes.  Same C structure definition, no.

It doesn't matter, see below.

> > > And no other kernel changes needed?  Shouldn't you warn if this field is
> > > set?
> > 
> > No, as pointed out in the commit message kernel never ever used this.
> 
> That does not mean that userspace tools never did, right?  You are
> changing the structure definition, what tool just broke?

The only tool has been amended like a year ago, so the answer is none.
The commit message has links to the commits in question that made that
amendment.

Maybe I should remove Fixes tags? In such case we will very much know
that no old tools will be run on the new kernel.

-- 
With Best Regards,
Andy Shevchenko


