Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403E63C504
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiK2QX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiK2QXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:23:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D726529375;
        Tue, 29 Nov 2022 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669739003; x=1701275003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0li/PXcGzcFbzJdykToMgnKLAEAqNFWlweSdL2o5eI=;
  b=abOATWyoGDI8C2JEJLGs5gijF0HSaAiZP0tos9JyP/OEdrYieyzSQ8tI
   IcHiHketRVb4O3jx89ce9Qd+pBpDwFvsmCFFkY7cPecyOwhwS4JLOrX32
   QmjicsXNPYJbVt1FovsjXAKXidcMxAAaZ7whzK+Z/t2FVV92/i7RayB+1
   ghFXKduFQfmsI3hMKtRM24uW+JNJpODWvIrmMeOdEQZw5pnBtg6xt6pYf
   57zLFe22Km2VnmbbyZ3hTxKiWnBzvBQ/RczvMJkkL6qhX12S2E49F5Lc0
   yKSBvLj/jHPHcdau/CTGsf0r+37vMRb+smxUIU8UUEwomynnj7pX4ONyX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="294849273"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="294849273"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="712427052"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="712427052"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2022 08:23:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03OA-001maK-1x;
        Tue, 29 Nov 2022 18:23:18 +0200
Date:   Tue, 29 Nov 2022 18:23:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ads7846: don't report pressure for ads7845
Message-ID: <Y4Yx9o4z9+nhHfLa@smile.fi.intel.com>
References: <20221129151959.26052-1-l.ellero@asem.it>
 <20221129151959.26052-2-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129151959.26052-2-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:19:57PM +0100, Luca Ellero wrote:
> ADS7845 doesn't support pressure.
> This patch avoids the following error reported by libinput-list-devices:
> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".

Fixes tag?

If you run

	git log --no-merges -- drivers/input/touchscreen/ads7846.c

you can get what prefix should be for these patches.

-- 
With Best Regards,
Andy Shevchenko


