Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648D6750C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjGLPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjGLPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:14:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C9A1BD1;
        Wed, 12 Jul 2023 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689174886; x=1720710886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RTQq+qac+Rq23wbU/w7ZDuRAbMV2uQxffliqVP3nt+U=;
  b=iRilH730AMZ1hYMbtiFxxu/8rEUeYt12HtjWBHuVm1KXsH6W6UfLz3Kb
   sIJqaN/5cCLbIBUeRWUk3rd3wtGUC/HH1NqY3hr+W7aXaB9UXSgKZ5JEH
   pjxWC2CjWdOYy40m/lc1lFJUW5Q8suRoNYaZu2CrimKotchnOEMfe49U8
   dm+B1Q/NCICDBGOawG35+btJbLnxobJOuzt0VlGE571xeDkUK5OmtrhId
   FT0pWmRpJAWzqDI9cycDZfJp5O5pgcj5tlDXQIpvA9Y6DH6d9eB3aCcK2
   QVNryKXzZKfbHhUPNpE832Ekzu7aOKfw8LdOnWgWozX1LRfjUcjemqoJY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344516332"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="344516332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791658334"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="791658334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2023 08:14:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJbYA-002A1v-1t;
        Wed, 12 Jul 2023 18:14:42 +0300
Date:   Wed, 12 Jul 2023 18:14:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] doc: TPMI: Add debugfs documentation
Message-ID: <ZK7DYuyo88efUje+@smile.fi.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
 <20230711220949.71881-4-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711220949.71881-4-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:09:49PM -0700, Srinivas Pandruvada wrote:
> Describe fields in the TPMI debugfs folder.

...

> +What:		/sys/kernel/debug/tpmi-<n>/pfs_dump
> +Date:		December 2023

November ?

> +KernelVersion:	6.6

...

> +Date:		December 2023

> +Date:		December 2023

-- 
With Best Regards,
Andy Shevchenko


