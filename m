Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D16627969
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiKNJsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiKNJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:48:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B03DBB;
        Mon, 14 Nov 2022 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668419304; x=1699955304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tw0S/mrhgXEwhusCWL7HJKtSrqKRfg78N9jta7g7Sfg=;
  b=miK59sJZoxFA4kVpIqgJNOLfMQTJNyJyaz5RTCgWU8z0UHGHgFLyX2Rl
   SCRI43FooQ9Nw1AUaod3OBSvfU/HjArFYMlLSu7Mt2LaTt4kiaJNt5CpQ
   ny51lDfG4V9eqMy6VPwVX+gbNsXdM5x/LmIahqx24E1OVN7toumij9935
   p0orKKg1OV++3YzG6jzjU4yp+ptH9NKjEBfXtBx7Paj+osX7rU08kaE4p
   AclCw4OghNwHUcW/n0rI83rFFauZY3qcmppvCky0fXcW0KsdNfl67FNDv
   swpClCpf3GV1bNqFFZcGW2YbJVH9SxtZ8Y7mUpLb7bd6QGcSh3MbhXFS8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="311932188"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="311932188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="883475174"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="883475174"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2022 01:48:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouW4h-00C6V5-2B;
        Mon, 14 Nov 2022 11:48:19 +0200
Date:   Mon, 14 Nov 2022 11:48:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] staging: media: tegra-video: Replace custom
 implementation of device_match_fwnode()
Message-ID: <Y3IO4zVqex78+rTn@smile.fi.intel.com>
References: <20220927173011.72571-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173011.72571-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:30:11PM +0300, Andy Shevchenko wrote:
> Replace custom implementation of the device_match_fwnode().

Sakari, here you are in Cc list and I never have any response on this patch.

Maybe something wrong with emails somewhere?

-- 
With Best Regards,
Andy Shevchenko


