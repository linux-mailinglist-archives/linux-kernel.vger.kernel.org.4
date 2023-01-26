Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D202567CBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjAZNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjAZNGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:06:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E05B96;
        Thu, 26 Jan 2023 05:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674738406; x=1706274406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kykFXhubpymwzzf6wp/HVD1TT25MTI+pMnPfzf7Ns7M=;
  b=QKdBx5mxqBQ5iBzRiGY57p/6nMbHxNOXzomSD0NBXTFd59YVV+uIj/eI
   1eEbhG/Pe0VwxmnJXW3eIcePEZ5C/S/C6wea332I8I+nn/KsIgcDBP3uo
   yvI/YmZtfyU/UsSbr6Io3g8VK67VZtGIBuvhd6RNQrIk3zNJu9rOdCIrE
   2U54lSZTeYs7leLJocEeFRrzU0GMk/OZlHV5KYBRhNbSqBHODzWdlzf0k
   7mcU8QudM49EQwEyu4hJyM+PWW0yBieLeW8fcp27frtHiWvduxPOaIyKr
   dkss731qFf1LlQgJq+7kBvKjbE2A6xbw4bZ9r+WsDI5QBfOAgieHrcoJ3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="389143297"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="389143297"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="771129604"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="771129604"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2023 05:06:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL1xX-00FOp3-0j;
        Thu, 26 Jan 2023 15:06:31 +0200
Date:   Thu, 26 Jan 2023 15:06:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Input: ads7846 - fix support for ADS7845
Message-ID: <Y9J61vTJQI8CzwQB@smile.fi.intel.com>
References: <20230126105227.47648-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126105227.47648-1-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:52:24AM +0100, Luca Ellero wrote:
> ADS7845 support is buggy in this driver.
> These patches fix various issues to get it work properly.

Entire series now looks good to me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

> Changes for v2:
>  - add missing period in patch 0001 message
>  - elaborate comment in patch 0002
>  
> Changes for v3:
>  - send from the same email address of "Signed-off"
> 
> Changes for v4:
>  - fix tag
>  - fix comment in patch 0002
> 
> Changes for v5:
>  - add Fixes: tag
>  - fix comment in patch 0001
> 
> Luca Ellero (3):
>   Input: ads7846 - don't report pressure for ads7845
>   Input: ads7846 - always set last command to PWRDOWN
>   Input: ads7846 - don't check penirq immediately for 7845
> 
>  drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


