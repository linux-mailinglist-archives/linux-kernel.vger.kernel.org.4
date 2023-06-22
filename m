Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C22573A0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjFVMbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFVMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:31:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CAB4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687437106; x=1718973106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VJAOY2tOh8YJLH4ChJtkKP7Ffaf6ITsW6/7BsgVWH2c=;
  b=Rf4fiH6j0HfbAa5sAEO+WDP+qpYYzoVC7tL2kmt2/j6+hzqRaUxJQkWT
   AAqvip60Dnz8TPfdJb2xW+/Zpy0NH9KJQrnXeA0VJq+cKRtRTc/9iM1tL
   u4/hSkPcXedYh+1HrV6rRGCw6WP046br6QMFaLnkAXdL9CyEjeBfq6DIE
   4pwlwFpcf1Dfy/+0uEn9eXx12ASyxc9LQ3muf5AoWYSZzsQ4xuOYobovJ
   JbYapm5bz3lY9uXjO/I69RRKr7enCgYq76zQTmxDbtBKXrdCVw3zMeFwZ
   AOw7zeQE3xZiEI8PvLu+Ll1YaMF/6MJx+ALhbXbzSH7HbX42wxrgLA+q7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340810619"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="340810619"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="1045145887"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="1045145887"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 05:31:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qCJTU-005lRA-0W;
        Thu, 22 Jun 2023 15:31:44 +0300
Date:   Thu, 22 Jun 2023 15:31:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: ipaq-micro: Use %*ph for printing hexdump of
 a small buffer
Message-ID: <ZJQ/L7+hpCLi7grQ@smile.fi.intel.com>
References: <20230612212007.3621-1-andriy.shevchenko@linux.intel.com>
 <20230621171040.GK10378@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621171040.GK10378@google.com>
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

On Wed, Jun 21, 2023 at 06:10:40PM +0100, Lee Jones wrote:
> On Tue, 13 Jun 2023, Andy Shevchenko wrote:
> 
> > The kernel already has a helper to print a hexdump of a small
> > buffer via pointer extension. Use that instead of open coded
> > variant.
> 
> That's not all you're doing is it?
> 
> Nice try.  2 patches please.

I'm not sure it's possible to split to two clean patches that don't overlap
each other like by 70%. Can you elaborate a bit more on your vision on this?

-- 
With Best Regards,
Andy Shevchenko


