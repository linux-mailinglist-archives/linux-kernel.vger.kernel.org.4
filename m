Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0573D9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFZIdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjFZIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:32:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F322E56
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687768375; x=1719304375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5fc0XJqjkH4cWPkyXxUW8B7scuYxwR6iY60Ou1IfUqs=;
  b=DIrqxRlFZftyx73MldcB3i2YE9d5mYvDIlxc0Xe1vUgN8YMfjrIU/Q2M
   3Ob0WHBOSRMWvQHKHmKK3Fi2845arPUD/7eqCHWQO/JyllTipmKCuQVp1
   3U+7LQQe5jdFB1yyqlpiQk2dRuoE6KttyLs8fIi9wkYgqypDi2ZtD/sz7
   VlvBHq93xMB48oK7qxXv98Gz18rhuAfyab/7pXixYFfYPBXEZ/Z5OH0hG
   eTYeY5RUW0dohTnJlIebRDcbKr5v25CWYWEGMJvicdtqcoFT/KRtmBD42
   /NmddvqyW/DK+u3/dvEFAhW9INr6+bMu/BByxxMW59sD9aTDvXVD21JUd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447595548"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447595548"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860605855"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860605855"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2023 01:32:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qDheV-006eY7-21;
        Mon, 26 Jun 2023 11:32:51 +0300
Date:   Mon, 26 Jun 2023 11:32:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Subject: Re: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_372
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <ZJlNMwzlt2MGTvBp@smile.fi.intel.com>
References: <202306250533.CBxzOSEh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306250533.CBxzOSEh-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 05:12:36AM +0800, kernel test robot wrote:
> Hi Alexander,
> 
> FYI, the error/warning still remains.

Alexander, do you have anything to present to fix this? Or is your plan to send
something after v6.5-rc1?

-- 
With Best Regards,
Andy Shevchenko


