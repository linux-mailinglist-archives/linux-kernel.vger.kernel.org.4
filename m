Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE88638FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKYSaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKYSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:30:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE75317C6;
        Fri, 25 Nov 2022 10:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669401028; x=1700937028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vmsGSwgyApl2cViKoF+PAPFSLOHMzKelVf+2z7aKa88=;
  b=HzNfQqxJ2XGj8jONn1yYiChFtRFHE/RHUf8AHRxlySUSkh0dLfKI9x/G
   ZIoQBRUfV5UswGGvgHnr3+7c5WT8tncLwRL3K5wO6iMqefChcf/K0MJfT
   7oizD6c3aDG04mWjE8rjmju/hXfedD7+loNdKijQAeJYCnUPKCruilBOt
   3wtD4B7SscrFtatXGQBnYzn4NG8LJnn30yzCEFtW/poHZ4Fs6s+n1OiQc
   ssD2peETNHTcIAnQSnN9DxYM/Nq0kacBB1SPGsxFy622nwoyqv+maMVw2
   TvqfDinuQKWCQUB7jMRwp3z3BWPt300seCLv9/AroLjAJQs0R2130DfeU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="312160858"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="312160858"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 10:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="767433069"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="767433069"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2022 10:30:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oydSx-00HM26-2q;
        Fri, 25 Nov 2022 20:30:23 +0200
Date:   Fri, 25 Nov 2022 20:30:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v1 1/1] gpiolib: Unify access to the device properties
Message-ID: <Y4EJv2gCR8nj3hHj@smile.fi.intel.com>
References: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:17:28PM +0200, Andy Shevchenko wrote:
> Some of the functions are using struct fwnode_handle, some struct device
> pointer. In the GPIO library the firmware node of the GPIO device is the
> same as GPIO node of the GPIO chip. Due to this fact we may use former
> to access properties everywhere in the code.

Bart, can this be applied?

-- 
With Best Regards,
Andy Shevchenko


