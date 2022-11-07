Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC361F0EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiKGKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiKGKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:38:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A77F59;
        Mon,  7 Nov 2022 02:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667817530; x=1699353530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D68k+70AbtJNumRWp6LgrGl/TGfcgO3I3DFP2CNfipI=;
  b=BDVm/e0yIHVH5VOnTealylWAAKkQrJAQbB/jq/y0ocd55jaOBtVjq+wM
   +xeFxej4G2RIeYuq1q9WPc85LYvodjjfVBBSOekut7Dx6XsX1PfK+Jr0G
   G43n5g4G6bPxi55lrMveogc088hvyGtYL0AnHA6pX2xRLG3Rm4SXqS9em
   DHWk8ubtsVrRJJu5FXn4btpT7LzDYCUt7pHph6Ro3esd0HleO8f7RAmND
   09gjVa0NODN2HX/ybwIOEQa1JjL4u3TJSt49eLY+TMQT2Cg6Gz/y2uCu6
   vKWawDMgaRt22FDikLyWCtRrBwwdjXuiru1bjtgCv8UAsDpzlsFIC0wrO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="309090680"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="309090680"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 02:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="704824002"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="704824002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2022 02:38:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1orzWh-008ax9-3A;
        Mon, 07 Nov 2022 12:38:47 +0200
Date:   Mon, 7 Nov 2022 12:38:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: 104-dio-48e: Migrate to regmap API
Message-ID: <Y2jgN1YiHVDxzBFE@smile.fi.intel.com>
References: <cover.1667472555.git.william.gray@linaro.org>
 <523cfe2bfbf804e64e8c9f6ed38339e850e6d9d9.1667472555.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523cfe2bfbf804e64e8c9f6ed38339e850e6d9d9.1667472555.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 07:20:47AM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.

I'm wondering if gpio-regmap can be used for these...

-- 
With Best Regards,
Andy Shevchenko


