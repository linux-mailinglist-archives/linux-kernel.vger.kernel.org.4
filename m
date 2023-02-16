Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5858E6997F2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBPOxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBPOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:53:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD414BEB5;
        Thu, 16 Feb 2023 06:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676559227; x=1708095227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uh8AYaePY9OgqQRH8+cH3X1BQPImFxjRPykOG3NPOIE=;
  b=mSmwLroEdgi7EXQSvN4IZUdYDVR7wFRcaBk1tEedC72QxoqwG8JZeZTk
   B2I8tJv7yuZhhtfNxq8d0qbcmXT6hmM9J9aIXRhDmim3Gfvog1tEHnBu0
   gsMpy6+pWI36UH8F1tsMkKCzxZuvSlhCt5WWBAE57LF2/9H8rnz9ahEkw
   SbiqMxB8VH2rZJ4T7pxpVOXKZBr8soMYBrpp7XiCU9c9aseZDlNOgMDi7
   4SqgA7lZ8dPsLrVxff2e0I02Ql+tNl8m5/4l5vSc9uI/COAxMYF6/JunG
   nG5D6mCkUA/CExibjUmJZrXkqi9kvHWLznXNnh97+4ZdX+qMRzFCXnLNG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331730098"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331730098"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 06:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="672176123"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="672176123"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2023 06:53:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSfdn-007pLX-2q;
        Thu, 16 Feb 2023 16:53:43 +0200
Date:   Thu, 16 Feb 2023 16:53:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 0/3] Introduce Intel Tangier GPIO driver
Message-ID: <Y+5DdxoQp4vjqaNi@smile.fi.intel.com>
References: <20230216132356.29922-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216132356.29922-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 06:53:53PM +0530, Raag Jadav wrote:
> Multiple Intel platforms started using similar GPIO controllers.
> There was a need to develop a common library driver.
> Intel Tangier implements the common GPIO functionalities for
> Elkhart Lake and Merrifield platforms.

> This patch set introduces:
> 
> 1. Intel Tangier driver that supports the common GPIO functionalities
>    for Elkhart Lake and Merrifield platforms.
> 
> 2. Intel Tangier adaptation for Merrifield GPIO driver.
> 
> 3. GPIO driver for Elkhart Lake PSE GPIO IP.

Thank you!

I will apply this locally and it will be part of Linux Next after v6.3-rc1 is out.

-- 
With Best Regards,
Andy Shevchenko


