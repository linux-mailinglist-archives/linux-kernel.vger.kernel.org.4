Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A43646359
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLGVi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:38:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D35062E95;
        Wed,  7 Dec 2022 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670449135; x=1701985135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYbz0QA9WvvbkcDjx9drdCef0FTH6uHyERlQTI9yvA8=;
  b=GGQJEgz5NHKVtU8N3lKiQJ5chWIq+axnvuXpWvmDtkHIRYOzCKrbd1nS
   Y6XawUL6KKDoaezyxKaA2JRGAKpvx6eCGYo6zRgYKq5YC/5vLckHPapUT
   wHTG/N6pTt4VIWiRlSsA5lBXi8sR53+ogN9NjlKXpbuGRWSRtpjN81ed6
   ucNq4zEEfkRXzbiS/Buu04le8R249XKKD+Lf1vIW8nKOd5FwgplEiBp5P
   DAOnI94+NXn++Dh8Q9idvjxIs6KUobYYqG142RhrlU5nxa44Rs6Yw/hIS
   HCypZrMMWUlVxND5dOxINCWgoaQdmWGgKvLlj+ryCbODscha9IubNPnpD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318859603"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="318859603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="640394947"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="640394947"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2022 13:38:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p327u-0060MD-11;
        Wed, 07 Dec 2022 23:38:50 +0200
Date:   Wed, 7 Dec 2022 23:38:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
Subject: Re: [RFC 0/3] Add support control UP board CPLD/FPGA pin control
Message-ID: <Y5EH6nKyMxe90eLo@smile.fi.intel.com>
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
 <Y5EHZX8xHDSjG3FI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5EHZX8xHDSjG3FI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 11:36:37PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 08, 2022 at 12:33:56AM +0800, larry.lai wrote:
> > The UP board <http://www.upboard.com> is the computer board for 
> > Professional Makers and Industrial Applications. We want to upstream 
> > the UP board 40-pin GP-bus Kernel driver for giving the users better 
> > experience on the software release. (not just download from UP board 
> > github)
> > 
> > These patches are generated from the Linux kernel mainline tag v6.0.
> 
> I have just checked the v3 (previous version of this) and I haven't found any
> evidence that I gave my tag or permission to use it. What the heck is going on
> here?!

NAK to this series.

-- 
With Best Regards,
Andy Shevchenko


