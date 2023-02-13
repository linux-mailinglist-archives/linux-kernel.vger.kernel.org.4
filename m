Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2F6943DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBMLHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBMLH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:07:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32559CE;
        Mon, 13 Feb 2023 03:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676286447; x=1707822447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E9boDOqBdzkxDX7RI0mQIJN5QkmJXjG9fld5F1+j04U=;
  b=VKtKrTXVgDbpT152tmSQIRv0NVmAMsaGhEgIS/7X9BFOJDQ16Y6O20MT
   jDZp342TfzT6E7RHrA00Fg2OoaOt6FzRdN6Hs9MELdUttdjAf2ZkLR3HX
   Ady/FDre0EHat0/0LmZkzqtzJbEEPjw8uYeBBsuXN7feTUJ5psdp3esNS
   wyXUagvw7sIV/qqpfjoPqNsqns1fR0NnmdvpicRWnA+QlIHNkZiUBZdSK
   RClzAQXs9HBkivr6v/CisuE3j2hFR3aWZzmLkNc7pPiJ3h8ExaOlXOsM6
   8S/C1JeKxHU2vYp7CuzASIg+/6buPUBY+oblHM1k/BWWDZu6I8K30ynzu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="311227971"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="311227971"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 03:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="670784612"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="670784612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2023 03:07:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pRWg8-006IcH-1z;
        Mon, 13 Feb 2023 13:07:24 +0200
Date:   Mon, 13 Feb 2023 13:07:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the pinctrl-intel-fixes tree
Message-ID: <Y+oZ7O9d8r8SIM0A@smile.fi.intel.com>
References: <20230213080620.62f7eeb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213080620.62f7eeb6@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 08:06:20AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   a13bbd841bf8 ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
> 
> This is commit
> 
>   a8520be3ffef ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
> 
> in Linus' tree.

I believe this due to it's in my tree and not tagged. That's why it appeared in
the upper trees with different SHA. I'll drop mine.

-- 
With Best Regards,
Andy Shevchenko


