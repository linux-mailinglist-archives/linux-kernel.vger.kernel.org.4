Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBB5E8052
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiIWRE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIWREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:04:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17814AD7A;
        Fri, 23 Sep 2022 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663952642; x=1695488642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PTqQK6dYlkjIw/931CWXKps3JJ2u8fVVhXqBGqzRZKA=;
  b=aq8FOnQEUA2FLFHjMpgirg0U5RsvXBYb4YJufK6ZsBfYr9u8OetGUWnd
   Yj9cHxYiu7ntY0aC5FXN3bA4479z0dRdUlbI2690efOqQEm3zN4+9EouQ
   rStqKSoB1P/y2LLoesD0jTumJxug8/LmbclkeyF7DJCmYNwFRaETYpSlx
   oSivNfS/IV/Ob6UC3n6lSQxlYl1wEDFDp3H8OM4dbps9o7PeBQygZs1Lf
   N338CnxlM1m0pqtVTNH/+dmSjlsrQWg1cC7WpFrTuisHoiIy3Pzs1GzUb
   25IVKFjPS7LwLoeeYGRIzcIFBZy9QRucoZvWrjFPVCKxOFQXMguVuXAm+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="362450367"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="362450367"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="620275074"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2022 10:03:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obm5U-006a2K-0A;
        Fri, 23 Sep 2022 20:03:40 +0300
Date:   Fri, 23 Sep 2022 20:03:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/9] pwm: lpss: Clean up and convert to a pure library
Message-ID: <Yy3m63T6P00SM5mp@smile.fi.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 04:56:49PM +0300, Andy Shevchenko wrote:
> First of all, a set of cleanups and code deduplications (for better
> maintenance) to the PWM LPSS driver.
> 
> Second, we may (re-)use the core part as a library in the future in
> the devices that combine the same PWM IP in their address space. So
> convert the core file to be a pure library which doesn't require any
> special resource handling or alike.

What happened to the PWM subsystem maintenance again?
For weeks there is no reaction from the maintainer(s)... :-(
If there is a lag of maintaining, perhaps we should mark it
as Orphaned?

-- 
With Best Regards,
Andy Shevchenko


