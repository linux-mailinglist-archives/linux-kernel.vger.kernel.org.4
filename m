Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27533625A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiKKMSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKKMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:18:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A52627F8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668169131; x=1699705131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZiC4fta80ysVMMnIbwgRUgPvfNl+TY9HCilhsXb6NWM=;
  b=Q5AGJwyB/FAPbLq7f75zQW4qkNlWupmDIq0n0stvpXZztHzYCF5lJW/J
   nYYbXYpetWVvt+K6YajTvzcdWHRugAip5tgnQY/a7n90oTRXgU22UgiYr
   guECHNaAxeRvMFPL0YObSYZlX5NgzrHxXbr0RPY1k1RTDP6ANKa6rWINq
   zEtdnm3Nesz0RzDXdzREZ8x5dIzluNvXc9I2gHK6AZnEtfswclXimRf7H
   8lOFPz/CKuASZAOhfc65VJ9NfpbEvrEg954kUxxVxYSZ/6wDDUR5uFBC2
   5BcVQ1no890RXOj7zYm7F9ht8fXU9LZe9VFG10/FTUTFMI9LWTPbcOR2q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294945715"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="294945715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 04:18:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668796041"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668796041"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 04:18:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otSzg-00Agx2-0i;
        Fri, 11 Nov 2022 14:18:48 +0200
Date:   Fri, 11 Nov 2022 14:18:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: Fix a typo ("identify map")
Message-ID: <Y249p7v0OSB1s8Xs@smile.fi.intel.com>
References: <20221101161207.969265-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101161207.969265-1-j.neuschaefer@gmx.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:12:07PM +0100, Jonathan Neuschäfer wrote:
> A map in which each element is mapped to itself is called an "identity
> map".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  lib/bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 1c81413c51f86..b0f234bc1ce84 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -988,7 +988,7 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
>   * to @dst.
>   *
>   * The positions of unset bits in @old are mapped to themselves
> - * (the identify map).
> + * (the identity map).
>   *
>   * Apply the above specified mapping to @src, placing the result in
>   * @dst, clearing any bits previously set in @dst.
> @@ -1037,7 +1037,7 @@ EXPORT_SYMBOL(bitmap_remap);
>   * the position of the m-th set bit in @new, where m == n % w.
>   *
>   * The positions of unset bits in @old are mapped to themselves
> - * (the identify map).
> + * (the identity map).
>   *
>   * Apply the above specified mapping to bit position @oldbit, returning
>   * the new bit position.
> --
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


