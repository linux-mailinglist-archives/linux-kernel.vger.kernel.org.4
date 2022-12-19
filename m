Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2161650D80
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiLSOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiLSOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:39:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8211F198;
        Mon, 19 Dec 2022 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460761; x=1702996761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCQHZpM+/1vfi9uBTeBhQeKwjkgu8kWOQVhgRmihmwI=;
  b=K7iPVR/mEb8h6+Nx7884p6McjtbURt5YetbILTOOnMn9ha5Y+YeWV3GL
   VlsQ1paY+ZqPxZIBCEXN7O9Y62Kpx3rH0N4pHRTz8IlTm8ohwG44Soh8v
   w7P+Lmjc3sskXal3Jsc0yNXackc0SWkg1NX8zG0zX8/eSwJQzg+5em8pS
   G8Vgus3yRNzfKDbp9C4eV4s0xCliANKs45F8K0PBz9xfrfJBAVmlL2I7K
   ukyQUo1cBb0ksWGObblb1puOOz2V7MXFMjk1nPKLVIjYaGDV3lPyJ91fN
   46mqvsK2r+eW9LZKux6/YQeOAVCTZSSuBcf71t/2gSctIKgSspmDQJw63
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299038498"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299038498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="757642469"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="757642469"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 19 Dec 2022 06:39:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7HIP-00CKKM-0r;
        Mon, 19 Dec 2022 16:39:13 +0200
Date:   Mon, 19 Dec 2022 16:39:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Use same order of bit fields for
 PADCFG2
Message-ID: <Y6B3kaPG3G3s4BKX@smile.fi.intel.com>
References: <20221219123229.5564-1-andriy.shevchenko@linux.intel.com>
 <Y6B2e17sDuUxUgpY@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B2e17sDuUxUgpY@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:34:35PM +0200, Mika Westerberg wrote:
> On Mon, Dec 19, 2022 at 02:32:29PM +0200, Andy Shevchenko wrote:
> > PADCFG0 and PADCFG1 are ordered from MSB to LSB, do the same
> > for PADCFG2 bit fields.
> 
> Perhaps:
> 
> No functional changes.

Sure.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


