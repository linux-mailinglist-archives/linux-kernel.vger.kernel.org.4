Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A1656E51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiL0T1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiL0T0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:26:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C468DEB3;
        Tue, 27 Dec 2022 11:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169201; x=1703705201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bdnmzdLPhGnylPibn6OyUTv4aH136Snh4DgyixVJCbw=;
  b=mkAcUxaBnA9rbpH0Tndy4kjiS5IvPnzGF6i7e+sfEsMAQJcTmD1tU5cA
   Nvi8UWbSrBtIgj47YA/9ABu7LDbVqpWBdkUbJ+tPq5dpZ5i6u4gUOeWUy
   kzdacGyy/tFq+gw7pYqcLTV7gGYtYo3AM/orakiWc57LipFDvBHa5QsOz
   Nh1AZPG6udYcykjYaY0kOsq7e8vryablG5m2oXvapfHN/qsye9g7Y8QUl
   s1jg5TO3VNZvy8LQX1Eb/0EsK/zIocrIA77qz4QEFREiZiE7C5RwXvjC4
   mlUeOqhlbacPo/v5n2HCa1bP8jbRfa1Z/Ulnrk+UTSVSa5MLw8gENvbET
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="385170802"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="385170802"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="827196199"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="827196199"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2022 11:26:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAFae-000CF1-2Z;
        Tue, 27 Dec 2022 21:26:20 +0200
Date:   Tue, 27 Dec 2022 21:26:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Define maximum pad number in the
 group
Message-ID: <Y6tG3KJZeacSVa23@smile.fi.intel.com>
References: <20221219123240.5601-1-andriy.shevchenko@linux.intel.com>
 <Y6B2nIy4hXQLjgvU@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B2nIy4hXQLjgvU@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:08PM +0200, Mika Westerberg wrote:
> On Mon, Dec 19, 2022 at 02:32:40PM +0200, Andy Shevchenko wrote:
> > Instead of using hard coded magic number here and there,
> > define maximum pad number in the group in newly added
> > INTEL_PINCTRL_MAX_GPP_SIZE.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


