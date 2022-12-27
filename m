Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EBA656E50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiL0T1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiL0T0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:26:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C31ADF07;
        Tue, 27 Dec 2022 11:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169134; x=1703705134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GRlybx5QetKZLWO0J26CHXFZW2T1H9jRr22RGPVZIl8=;
  b=awXhCb5Mwhk48pm5vomNh1PPRhwnYqDpxEVdarPxjm3LP9sX1wGEFJre
   wAUlxrnPqquHrIRWMD3LG+MEQ7/M+gI767/hbbUelMwXoryRZFGuF0k0a
   RpnrlFhY+c0mRz/cBUA0ZxS57AxXwcE1P31HSrA/F8aXPrJjhatpbzWG0
   M+TJ5G0ORP5X+Twy13+C6TQJvCJNbimxc4ToZGQDQNAoxyBWg6BND31hB
   97tHT3G0rUbdSf3rCT9IC5omXSPLlrR+kxO2Im7wEsDOQxItrfzwDHp3p
   aUAPlcOpiHbhs4ostuV3EkaNxht74f6sS+YuoZL9p2AbuiOrG7l0ki7B8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="383049061"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="383049061"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="685490588"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="685490588"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2022 11:25:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAFZq-000CDp-0u;
        Tue, 27 Dec 2022 21:25:30 +0200
Date:   Tue, 27 Dec 2022 21:25:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Use same order of bit fields for
 PADCFG2
Message-ID: <Y6tGqkzASXXrOSYa@smile.fi.intel.com>
References: <20221219123229.5564-1-andriy.shevchenko@linux.intel.com>
 <Y6B2e17sDuUxUgpY@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B2e17sDuUxUgpY@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


