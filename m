Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA83699097
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBPJ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:58:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38C39BBC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:58:46 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="331676416"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331676416"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 01:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="915604748"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="915604748"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 01:58:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pSb2J-007hle-1Y;
        Thu, 16 Feb 2023 11:58:43 +0200
Date:   Thu, 16 Feb 2023 11:58:43 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop mainaining UUID
Message-ID: <Y+3+Uw1Ya2XPn03z@smile.fi.intel.com>
References: <20230216063110.2152087-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216063110.2152087-1-hch@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 07:31:10AM +0100, Christoph Hellwig wrote:
> The uuid code is very low maintainance now that the major overhaul
> has completed, and doesn't need it's own tree.  All the recent work
> has been done by Andy who'd like to stay on as a reviewer without an
> explicit tree.

Confirmed.
Acked-by: Andy Shevchenko <andy@kernel.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 225c3ce347a217..6a47510d15920f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21818,11 +21818,9 @@ W:	http://en.wikipedia.org/wiki/Util-linux
>  T:	git git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
>  
>  UUID HELPERS
> -M:	Christoph Hellwig <hch@lst.de>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> -T:	git git://git.infradead.org/users/hch/uuid.git
>  F:	include/linux/uuid.h
>  F:	include/uapi/linux/uuid.h
>  F:	lib/test_uuid.c
> -- 
> 2.39.1
> 

-- 
With Best Regards,
Andy Shevchenko


