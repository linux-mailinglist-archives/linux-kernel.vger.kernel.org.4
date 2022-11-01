Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC44961510E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKARrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKARrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:47:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EA1D643;
        Tue,  1 Nov 2022 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667324869; x=1698860869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TYf5YYIzFj+h7ElHv3ioNLA0mS+1SXo5oCNtaYVIquA=;
  b=N+5O+DumIbOame0OI571r3Y2i4czPcQ4fSvgdL9h58eXO5ZiBhRFdYWx
   tbH/wgAoDhX1ofBhmqyTfYJbKHrE2CK/kMp11PsbsoU4bfnhmMXHwD3ZA
   /JLJBTvnKFv3Ct7t5E3sXSVn3MfqpP8eqSE95Wr9Ah+cDrCKwy7fhs2op
   EPQaLqRiiBd3HZQ/wynIbLHH5u+SfVK1sypDEJfjYtsPXTYbJuyyFPEiV
   lSFQpfO2wqzqXNpjb5yAyXbe/eksdPO4UHVN9GGv/4RLpwVVRgqhBsuaI
   CF+lPG652PLs+6g4zOIldwnGv5lGqtcGRRNEBU9lw3onOCgOBtU7hUCVS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="306818990"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="306818990"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="963206366"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="963206366"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2022 10:47:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1opvMY-005hWx-1m;
        Tue, 01 Nov 2022 19:47:46 +0200
Date:   Tue, 1 Nov 2022 19:47:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/3] pwm: core: Drop unneeded casting in pwm_seq_show()
Message-ID: <Y2Fbwg99BWJ54q/w@smile.fi.intel.com>
References: <20221101174255.54452-1-andriy.shevchenko@linux.intel.com>
 <20221101174255.54452-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101174255.54452-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 07:42:54PM +0200, Andy Shevchenko wrote:
> The casting form void * to char * is not needed and done implicitly.

This patch is wrong and it seems I have tried something like this in the past.
The rest in the series is okay.

-- 
With Best Regards,
Andy Shevchenko


