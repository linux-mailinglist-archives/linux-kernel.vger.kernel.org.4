Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479675B581C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiILKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiILKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:22:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B219008;
        Mon, 12 Sep 2022 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662978129; x=1694514129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4rxBZKYDOZuMKZRytFXmRlZ/iZ+Bdj+rZ4hPsk3ezMs=;
  b=BTH2dlwA/z48aaS/xhdifxrXkw8I9SAKzHhU/XWjngw7oNGCsWgsRpwy
   fUxmvgBSTWN/EhfVyb/0+0E6YSoH3ociFbuTpw09ITZM3djtLXNQVza9B
   EzxAkgqyBMMhN56JitgVeZHb5J/cT/Z88keYCh6xNaSScmPSr4OgHFoeC
   ZLKNrtJqaUKLwk0aUNaXyQjtoBO2MxjfD+Q1mVd5P+dUNW435LF6oBWIC
   oVia3/Nzrp0gUBSt+YGejrTvlErs0F8HBoruP1PxAQHr516I/+L8TgK+N
   vhhYAkcCaJtZyYbtVqqC/rRZGouB3iYDH8kqEwepYWPb3wHdzCo42mcR5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="284851957"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="284851957"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:21:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="649200810"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:21:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oXgZc-001IT9-1W;
        Mon, 12 Sep 2022 13:21:52 +0300
Date:   Mon, 12 Sep 2022 13:21:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <Yx8IQHLBhIilMfEw@smile.fi.intel.com>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <20220603181006.2c5cc6c4@jic23-huawei>
 <20220620204225.34d40a3f@jic23-huawei>
 <YxdM1KUFcdVlnKuO@smile.fi.intel.com>
 <20220911105215.72bd79f3@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911105215.72bd79f3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 10:52:15AM +0100, Jonathan Cameron wrote:
> On Tue, 6 Sep 2022 16:36:20 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jun 20, 2022 at 08:42:25PM +0100, Jonathan Cameron wrote:

...

> > Any news on this one? Maybe I need to resend with the better commit message?
> 
> From glancing back at the thread, looks like you said you were going to send
> a v2 with property.h include.  I think the rest of the thread is concerned
> with a different issue entirely.

Ah, I only read last messages in the thread and didn't realized that I have
some ARs to accomplish. OK, v2 will come soon, thanks!

-- 
With Best Regards,
Andy Shevchenko


