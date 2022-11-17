Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033862E15E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiKQQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiKQQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:18:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265F73BB1;
        Thu, 17 Nov 2022 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668701892; x=1700237892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uRwGw5VIjGJYpIriu0SlA1b3di7m84GdxzpfQl8VPps=;
  b=Bwv39NjgiaPwMhd9GN1sW3ozbJxzcdOpEGxRohF65ejXZ5EZzULv8O/J
   EKfwyaHvegBdivsmsZv8cdJQiZxz2t+yQO+RO7PwbnLVaBClrTQK6sKGg
   2H9ED0pfvdlsvO3KgjMz5aAV/xmiFERpJM6q3cAOIqOyv3BihKnmucJtg
   Jay0ZBsJw/rgQ4qFpcmTWY+FfEOVe/2pXcy+nwDrSSKsCJqhA90n+CLGy
   /oWCH60/wFs0J7OovkIH7pH6o6W7+yq2O/aRkWgDKi5RIZYJKqoAXWUjF
   6Lt3eUT/EMsPjz80ss7G3CcL6vvgGyb+cXE2Oxg13wbCDWHGaOIhx8X0y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="377160623"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="377160623"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="968929062"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968929062"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2022 08:17:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovhaH-00Ddo6-1f;
        Thu, 17 Nov 2022 18:17:49 +0200
Date:   Thu, 17 Nov 2022 18:17:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 3/3] clk: fractional-divider: Regroup inclusions
Message-ID: <Y3ZerQIW7fzOrRdt@smile.fi.intel.com>
References: <20221117155105.1486-1-andriy.shevchenko@linux.intel.com>
 <20221117155105.1486-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117155105.1486-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:51:05PM +0200, Andy Shevchenko wrote:
> For the better maintenance regroup inclusions as follows:
> - split CCF related headers in its own group
> - order groups from generic to particular
> - sort each group alphabetically

...

>  #include <linux/clk-provider.h>

Forgot removing this one.

Anyway, I will wait for comments and then will send a v2.


-- 
With Best Regards,
Andy Shevchenko


