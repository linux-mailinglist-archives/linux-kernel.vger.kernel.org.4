Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7AC72FEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbjFNMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbjFNMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:33:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7B19A5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686745968; x=1718281968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sz4UOxkq4egOIJA2kTG5DU/XOmSO0LxH9oPG0R48y0=;
  b=SW6Iwa88ua1+FPUkHLTSy8gT9yEHRpdwJJAE3DRzeSXi1xQTyq9nfwuY
   2p2Om/csB5hzcG77zk19RUjyOeTL+F7pYZuJIIXvl869oCL//BBL1GmYu
   VNU04eH87LB/hgfTBtKvErmfdIneaxxtWgS5gPLU94kIl/zk5fO0BCIaL
   vjOrk6jKo5x0SY53ApkLVY/bkmdT7FsyBsdHp/YAid9EmSoqhAwcN14QW
   XJarA+eG2gL9Kw4FeQTOKwp+QPzG1eaTmWZvva/321mR/O0o8omuXwWPD
   BtoXG5DXAsU6eTgnYsSuuIApIs9lPtRUd/4ZQ97MxPZkEbtEH/Li8JYL1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="422200213"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="422200213"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="706199257"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="706199257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2023 05:32:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9Pfr-003hPv-0d;
        Wed, 14 Jun 2023 15:32:31 +0300
Date:   Wed, 14 Jun 2023 15:32:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     hexingwei001@208suo.com
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib/test_printf.c: space required after that ','
Message-ID: <ZImzXhc7ZRbSvz7/@smile.fi.intel.com>
References: <20230614082523.63191-1-panzhiai@cdjrlc.com>
 <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:30:55PM +0800, hexingwei001@208suo.com wrote:
> Add missing spaces to clear checkpatch errors:
> 
> lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).

Doesn't make any difference to the code, so let do this (unneeded) churn
to calm checkpatch down.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Xingwei He <hexingwei001@208suo.com>
> ---
>  lib/test_printf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 7677ebccf3c3..9d17c564fdf6 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -559,7 +559,7 @@ static void __init
>  bitmap(void)
>  {
>      DECLARE_BITMAP(bits, 20);
> -    const int primes[] = {2,3,5,7,11,13,17,19};
> +    const int primes[] = {2, 3, 5, 7, 11, 13, 17, 19};
>      int i;
> 
>      bitmap_zero(bits, 20);

-- 
With Best Regards,
Andy Shevchenko


