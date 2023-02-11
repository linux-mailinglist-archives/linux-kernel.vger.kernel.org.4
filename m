Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D717A6930C7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBKL7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjBKL65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:58:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246332CC6A;
        Sat, 11 Feb 2023 03:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676116724; x=1707652724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mYvgNqBMI7hpwT5WQYb0Rjjv8qQe3QJxhkvxZA4ioDg=;
  b=m6tRPr98lZWxH7oZcXawN8B7N0BISZFYiWrghjPQx03z0bhYTMICiZ6q
   kijxVbV7tCbeGnNqcpTc5XntoadQS7m9ohDSs+oaxiwj83t78MwVNfrG0
   cT8CS4aX5ylZDALE7SMYMMMZWSrL9Mz1I8aBfi0HjmRE2gXzXjo3dfcHU
   FbkzcvBau4n0eXejDSlvTP4Zq7bf3zpFj0cVuex3EwUD+oqQA+Yie7ctP
   xhhoRTsJa48C6IIQmA//lCwKKIdzwOB3Uw5sh/4aOoTTTihBzxesUUole
   z9Ov87lFlmhw36Q5coRJlfSg6LcHsc44l6mKzPpvAdsxnViaErRzgcWid
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329234833"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="329234833"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 03:58:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="670298931"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="670298931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2023 03:58:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pQoWf-005TLE-13;
        Sat, 11 Feb 2023 13:58:41 +0200
Date:   Sat, 11 Feb 2023 13:58:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Message-ID: <Y+eC8JFE63lRaEgT@smile.fi.intel.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676042188.git.asmaa@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:39:39AM -0500, Asmaa Mnebhi wrote:
> This series of patches creates a pin controller driver and GPIO
> driver for NVIDIA BlueField-3 SoC.
> The first patch creates a GPIO driver for handling interrupts and
> allowing the change of direction and value of a GPIO if needed.
> The second patch creates a pin controller driver for allowing a
> select number of GPIO pins to be manipulated from userspace or
> the kernel.
> 
> The BlueField-3 SoC gpio-mlxbf3.c driver handles different hardware registers
> and logic that from gpio-mlxbf.c and gpio-mlxbf2.c.
> For that reason, we have separate drivers for each generation.

It seems you neglected to include maintainers and reviewers of the previous
version(s) of your series. Don't do this. Please, respect people who invested
their time in your code.

Hint: I have a "smart" script [1] which helps to collect proper people (except
reviewers that you need to add manually via --cc command line parameter) and
mailing lists. Fell free to re-use, modify, send feedback.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


