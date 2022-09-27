Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6905EC295
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiI0MYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiI0MYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:24:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C816B21D;
        Tue, 27 Sep 2022 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281470; x=1695817470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RzS58wpNpgGiE+RZfkfthTAXrOpy+eSWd/O1iWhfu9I=;
  b=eqXzkNlyYL3YJejgTPObIAVZzq5GqB4MuZGcUHN1xHr0gKTj6bTUccNA
   8pK/sBFunYyPKl8E4P2F6PFBdFnC81RJJZQUkpdTNbzQNgSGcvrRmXH2R
   afcxJKtK3klvefOnsAW61pPPMSELRNjSUcPSCsyHyb9DD7kY6KltLdq+3
   cdTg4Lt6AkMMjP0gTugclnNAidFcPNPMAUsl7eM4CebFvHpQLk4Lo84cP
   4125LySTudSMPfiCNO8au6eQIbYGnPPOH7cuLwgkMCH9529mK4mH73FQY
   TCvZ+GnXJ198JJcSsXsTXOmbYdTJCDvKMHMD4G/gOBOJu4Xzzu9joQRQ5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="300022614"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="300022614"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="710541880"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="710541880"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2022 05:24:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1od9dS-008RPU-0V;
        Tue, 27 Sep 2022 15:24:26 +0300
Date:   Tue, 27 Sep 2022 15:24:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <YzLreedzM3/+2gBh@smile.fi.intel.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
 <20220927052217.2784593-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927052217.2784593-4-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:22:16PM -0700, Dmitry Torokhov wrote:
> The driver is using of_device_id and therefore needs to include
> of.h header.

As per patch 2 comment, mod_devicetable.h is needed for that.

> We used to get this definition indirectly via inclusion
> of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
> from unnecessary includes.

-- 
With Best Regards,
Andy Shevchenko


