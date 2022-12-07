Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A163F64634D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLGVdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGVda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:33:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A651134;
        Wed,  7 Dec 2022 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670448809; x=1701984809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTOYsHEh0BI8u8ynI9gQ5E4q2Y9Wvo9VSYUsL+naV94=;
  b=ZXFLiHdvTXxMCGRUTVkk+lSHOEX6gG3AXf1CP2nawQVuVQOQS3xgzW+5
   Md/3UXnUytcwBQ/5qDXsi+4zvUIetOREQJVonnbKLVsLjC7zWPJPKiFng
   de8Cix9+5MFJB/mRmDFZB9BmWAIwVjFQZ+7HWUv7PkVywjhZKMmTkIWwB
   X7bCiNLXBVATKIt3ZPZg1+uG2TtJTq6QpzF2JGz+Cl6QB/XTpcrubw83L
   38ebHjCNmqyX0ja0Bl58KSv6euJn1j5yYx1p+245QKjt4SBc14CUj1NK8
   ZlVe9DL+LQOGoM+Ur8CgD6fnMpaL6w/STtJz5IcH8U66WP7tgaKgepGzI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318858659"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="318858659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:33:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="677514984"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="677514984"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2022 13:33:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p322S-0060B8-0L;
        Wed, 07 Dec 2022 23:33:12 +0200
Date:   Wed, 7 Dec 2022 23:33:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
        pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com
Subject: Re: [RFC 0/3] Add support control UP board CPLD/FPGA pin control
Message-ID: <Y5EGl9qYwBIsqV5s@smile.fi.intel.com>
References: <20221207163359.26564-1-larry.lai@yunjingtech.com>
 <CACRpkdYk=dN8P9X=t0JhRuSVormm5fTeAT1Zwy98Q+F0XFTEpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYk=dN8P9X=t0JhRuSVormm5fTeAT1Zwy98Q+F0XFTEpQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:09:35PM +0100, Linus Walleij wrote:
> On Wed, Dec 7, 2022 at 5:36 PM larry.lai <larry.lai@yunjingtech.com> wrote:
> 
> > The UP board <http://www.upboard.com> is the computer board for
> > Professional Makers and Industrial Applications. We want to upstream
> > the UP board 40-pin GP-bus Kernel driver for giving the users better
> > experience on the software release. (not just download from UP board
> > github)
> >
> > These patches are generated from the Linux kernel mainline tag v6.0.
> 
> Why are these patches tagged RFC now? Weird.

I can easily tell you, this code is no go, too many problematic places.

-- 
With Best Regards,
Andy Shevchenko


