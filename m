Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F8F66A506
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjAMVT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjAMVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:18:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B684544EA;
        Fri, 13 Jan 2023 13:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673644710; x=1705180710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y94ANSG9Z/MBtqJPgLtw8XoBY12InfxWWGAMoz1ZkOo=;
  b=VRBuLSYcas+BB5DgUB5tgs1rkdPGdlnIeuQE0zhVledF2QN55QxogmsW
   Y0Uloe3mdimdvgSLOEk5XvhM4KmFywlPDO01syZ21es5XPlWXi/mS9tdt
   Obao+DvR5iFx9PsNWRfJhF0xNZeYSbVZxt2PBXc0Mxi004hEl1VqsTmDh
   C8BPHsumfsijkAFNKWjEgtUy6V5N+wR2wG2Ts0p+gmqYJ1w08LSmH1iZb
   4DdzUD7v3KniVsyZioT5iKAQjcO7P2c6wth9hjxk8zULWDHDDOepIsBXx
   L4lkdqVU0o1XA5BqNWD1hcaFhxwco3Odf0HaUocxdKmHWR/3O6r9Su/xp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="386443262"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="386443262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766163817"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766163817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 13:18:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGRRP-008r4U-36;
        Fri, 13 Jan 2023 23:18:23 +0200
Date:   Fri, 13 Jan 2023 23:18:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused of_mm_gpiochip_add()
Message-ID: <Y8HKn4gZkPqpvTAS@smile.fi.intel.com>
References: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
 <20230113202826.GA2868820-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113202826.GA2868820-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:28:26PM -0600, Rob Herring wrote:
> On Thu, Jan 12, 2023 at 04:45:26PM +0200, Andy Shevchenko wrote:
> > of_mm_gpiochip_add() is unused API, remove it for good.

...

> Keep going!
> 
> Looks like of_get_gpio_flags, of_get_gpio, of_gpio_count,
> of_gpio_named_count, and of_get_named_gpio_flags are all unused.

Have you checked Linux Next? Everything, but of_gpio_named_count(),
which moved to be static, is taken care of by Dmitry Torokhov patches.

-- 
With Best Regards,
Andy Shevchenko


