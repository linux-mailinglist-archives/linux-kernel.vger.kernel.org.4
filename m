Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B54646356
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLGVgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGVgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:36:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FEF56D6A;
        Wed,  7 Dec 2022 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670449002; x=1701985002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/bj0VQ9SBPGLPWc23e3YR0eCmU+eAQBjDCamHwyiVs=;
  b=X107pRE6BuMSR3wHVNA0rYtc+c9SDGBDrzUagCCvx/Zh+5DixbuhIy67
   waLMeVXuUjyWD9apbEMsuvKpB1K0lOxXRR49GyA07msBx6iXGD0l4NM6J
   DliQ5h0JZR6maNDzJZrAOvHcyDnvYJj1eBf+5PLVBM9DczDCKZ8FEcfFN
   H9GDHAshWeQprSnQ5Aa0HdCr5Qsqhxf1INTu+zqJa9K4KzJgyIMjbduAq
   lOxcn5qrO/mkUzJ/ITqBINlK3bxOucAn+ATaLsXbLuxLsAwy7SKY1oxMF
   R3MsSb9adfeXXOXrnvVebyZVul2dWHHYkw7LqydHyvmeTkadQWvCnRJ8T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296701679"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="296701679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:36:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="735543725"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="735543725"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2022 13:36:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p325l-0060Gn-2z;
        Wed, 07 Dec 2022 23:36:37 +0200
Date:   Wed, 7 Dec 2022 23:36:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
Subject: Re: [RFC 0/3] Add support control UP board CPLD/FPGA pin control
Message-ID: <Y5EHZX8xHDSjG3FI@smile.fi.intel.com>
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207163359.26564-1-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:33:56AM +0800, larry.lai wrote:
> The UP board <http://www.upboard.com> is the computer board for 
> Professional Makers and Industrial Applications. We want to upstream 
> the UP board 40-pin GP-bus Kernel driver for giving the users better 
> experience on the software release. (not just download from UP board 
> github)
> 
> These patches are generated from the Linux kernel mainline tag v6.0.

I have just checked the v3 (previous version of this) and I haven't found any
evidence that I gave my tag or permission to use it. What the heck is going on
here?!

-- 
With Best Regards,
Andy Shevchenko


