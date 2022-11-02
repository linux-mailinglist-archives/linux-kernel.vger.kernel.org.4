Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2D61619D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiKBLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiKBLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:18:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CEA640E;
        Wed,  2 Nov 2022 04:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667387898; x=1698923898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6jcVDJYb7xr9ywM8Bu2rxJs57m7FJj4radheE8he5k=;
  b=Lag1Jymfr6+yp5xX+o0YKnhHatjrbtzS3dbhpEiAOKifcEpxNqlNhcuh
   +054/O8BVNvKS2e/NhmZoG7AKB2YRNJHB1Bc5HHU2mhWqtIHXJA4buP5o
   BgQ9nIPL0z1axrifDVR41MvEUsjmr80myHPFIw22HSVwnqs1gr7XidHSe
   9AlvbiETfFXUxAi0GRU1Rp9bUmU/6DY+Md7wQqCbuJikNV29k47+yYZJn
   YeErrcL0m8paCL0A1L2X6EANuf5EwImAB3MMuTkeRNRIRJmlRC/LV4qEZ
   7JSNrk3HgycG9FuOALPg5aJGmi56dgX6vAD8HfWkI2a7uiDksBopDJDU5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373604888"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="373604888"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697771846"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="697771846"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2022 04:18:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqBl6-0069Cu-0z;
        Wed, 02 Nov 2022 13:18:12 +0200
Date:   Wed, 2 Nov 2022 13:18:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, senozhatsky@chromium.org,
        wangkefeng.wang@huawei.com, axboe@kernel.dk, kbusch@kernel.org,
        sfr@canb.auug.org.au, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 00/30] Remove strtobool()
Message-ID: <Y2JR9CNEWZFUAfkq@smile.fi.intel.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:05:37PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> 
> Each patch can be applied independently from the other ones.
> The last patch of the serie removes the definition of strtobool().
> 
> All patches have been compile tested, except the ones against
> arm64, s390 and irq-gic.

I got only a cover letter...
Luckily we have a powerful `b4` tool and available archives on lore.kernel.org :-)

> Finally, this gives the opportunity to remove some <linux/kernel.h> from
> a few drivers. This will be addressed later when/if the serie is applied.

-- 
With Best Regards,
Andy Shevchenko


