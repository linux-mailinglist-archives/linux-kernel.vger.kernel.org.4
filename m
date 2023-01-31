Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1E682CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjAaMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjAaMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:45:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A8CC11;
        Tue, 31 Jan 2023 04:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675169099; x=1706705099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/RwQqzhoI4pLDu/LgYP8NfjxFwOXtYObH6J5azZ9fcE=;
  b=WCWqomjSPzzN647NwnwJN8aMyAwE37oEnyLnortjwErUFIQ3hEUIj3c2
   EoRK4Y48qpKRVdtnfhriTC9s74Uhf0aJ+HVJU8mMXeBlVsfI1nev0IixR
   45ULTPUvjNus7wdxQzagdReQ/4qBmTTZcc+7ysqS4hv2CXiqvKplDAWJm
   N/lU+Ai36dOc+XvBO/aYE04Aw9XgiQXI3qwAmbCIBMDYd4FgMA3BHYlAt
   12G7jQyTh3PziusBCSly9y/kCVIz2Ts6GT1+MHcXxw060k52JuJdlE+k0
   aBq/wqbDLCEGJm9CWSpYCDzQIaPHDi536PpJf+7wDxapE33h66LzUkA/U
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325525922"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325525922"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="733097607"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="733097607"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2023 04:44:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMq0L-000Fg8-1n;
        Tue, 31 Jan 2023 14:44:53 +0200
Date:   Tue, 31 Jan 2023 14:44:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Harrison <John.C.Harrison@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the
 drm-intel-fixes tree
Message-ID: <Y9kNRVppj5Uxa9ub@smile.fi.intel.com>
References: <20230131130305.019029ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131130305.019029ff@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:03:05PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/gpu/drm/i915/gt/intel_engine_cs.c
> 
> between commit:
> 
>   5bc4b43d5c6c ("drm/i915: Fix up locking around dumping requests lists")
> 
> from the drm-intel-fixes tree and commit:
> 
>   4d70c74659d9 ("i915: Move list_count() to list.h as list_count_nodes() for broader use")
> 
> from the usb tree.
> 
> I fixed it up (the former removed the code changed by the latter)

Hmm... Currently I see that 20230127002842.3169194-4-John.C.Harrison@Intel.com
moves the code to the drivers/gpu/drm/i915/gt/intel_execlists_submission.c.

Is there any new series beside the above mentioned that touches that file and
actually _removes_ that code?

>	and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

-- 
With Best Regards,
Andy Shevchenko


