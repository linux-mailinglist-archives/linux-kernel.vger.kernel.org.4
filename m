Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6166765C4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 11:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjAUKuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 05:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUKuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:50:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C01A4A4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 02:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674298205; x=1705834205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y8jJV61x2piKAKm232GUW884rjKHoAz/W3XpV9LZ6zc=;
  b=TzeQPScuRecKhy/czi62rMvP7dc6YQ846dFSJXZtGSsWwMkdNgnbYhWg
   H1mUK6FbFPcgC5sU8eyLDJfaufYArfrkxVDk7CIpgOwKV8HzwZhwQTWP/
   h91iMb6wFQMEYgyJzvd/fD9MOz5p+0eulNss2PlcXj+OAQwDBxmbxZgfC
   9UhMCzTVfzoQXkKyqGD1f1bNAxkp9J+OQg+9h4TgGNOirAWnl21rDJXhH
   XQxdq075EchHqRpXGdvY9+iswpprFixG8bd0EQOZsCtoAI/CXrDSyed3k
   kfuTJXbfR14c68l6xq4H6p/fH0/+qOChDVCgy7Ydg5yEpXGO3ehVDTeVR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="388135537"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="388135537"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 02:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="654066865"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="654066865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2023 02:50:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJBRi-00Ckg9-0p;
        Sat, 21 Jan 2023 12:50:02 +0200
Date:   Sat, 21 Jan 2023 12:50:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Pantyukhin <apantykhin@gmail.com>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kib/uuid.c: add check for length for uuid_is_valid
Message-ID: <Y8vDWYDoyIiWpg9N@smile.fi.intel.com>
References: <20230120213802.2467-1-apantykhin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120213802.2467-1-apantykhin@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 02:38:02AM +0500, Alexander Pantyukhin wrote:

Thank you for the patch.

> Add check for length strict equality for uuid is valid

UUID

Missing period at the end of sentence.

...

Why do you think it's a problem?

Have you checked all callers if they strictly using this API and not to parse
something like:

	UUID ...other data...\0

?

-- 
With Best Regards,
Andy Shevchenko


