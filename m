Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5327165C02C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbjACMre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbjACMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:47:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64753C0D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672750050; x=1704286050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wv6PqdnYRxTtLwJPfLqSelTVLmVXx8C1Wpf/8vKA3do=;
  b=ibt9ii4ZCo2vj/NJSEO7a1COUDXLhKcezibmat0oDtqKhQx0X8Lwt3m6
   YyfFVYfd8mTmOBPio2jXTDQYeqqwUQ1UKk4dNaqDiqa01XyV8zXOPpBXw
   pyVPCQkr3gP9gWIXMeTkSdq+jIr1jupxiJlVBc6rXrF8jSa46+NvtJAMo
   6BuyX/LoqI3QaZUkAOGdS2GH5GiEK5osSOLwhdYQoti6Sxaumt6Mptx6W
   8To2rVhgN4sU8gDOSFQ4tQBTPn5dxgeywCVw3p5Cugo9W6tHrxtSGGopr
   wjlf+lNbLp5I6p+XIBGVkROGm7Lt31x2Cokxw09tnxqVkJ0rxZROOHcBy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322883437"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="322883437"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 04:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="900170800"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="900170800"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2023 04:46:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pCggZ-003t6w-1l;
        Tue, 03 Jan 2023 14:46:31 +0200
Date:   Tue, 3 Jan 2023 14:46:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cpumask: fix function description kernel-doc notation
Message-ID: <Y7Qjp/Bm6ckmaXbB@smile.fi.intel.com>
References: <20230102211830.2674-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102211830.2674-1-rdunlap@infradead.org>
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

On Mon, Jan 02, 2023 at 01:18:30PM -0800, Randy Dunlap wrote:
> Use kernel-doc notation for the function description to prevent
> a warning:
> 
> lib/cpumask.c:160: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Returns an arbitrary cpu within srcp1 & srcp2.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  lib/cpumask.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/lib/cpumask.c b/lib/cpumask.c
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL(cpumask_local_spread);
>  static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
>  
>  /**
> - * Returns an arbitrary cpu within srcp1 & srcp2.
> + * cpumask_any_and_distribute - Return an arbitrary cpu within srcp1 & srcp2.
>   *
>   * Iterated calls using the same srcp1 and srcp2 will be distributed within
>   * their intersection.

-- 
With Best Regards,
Andy Shevchenko


