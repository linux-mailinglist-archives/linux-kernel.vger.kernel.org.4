Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EB966C2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjAPO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAPOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:55:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE39265BF;
        Mon, 16 Jan 2023 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673880287; x=1705416287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/FcwCcmYR+YBoDpa/d8YDulm759cNORuNKsoMFxGRKg=;
  b=fccPD59rjUDhbt40nC1e3u0QbzjcSutuATBvCasaKpHTyODJy2Mitkmk
   GM7d8Tsgv5qzLtGOg+5BcLkvAa/JPm7KFXKV1hS+DRXb/e2E6VG1HnCuw
   Kkj+WeH7v2W/6AX8tuEJXNxU8uXH0uJNG4NhyrN3PPV+kZ+efLNaLg3Ja
   1ysp/hYSF3I0VPOI8yqcCzE7JJS4kY5oe2Swaepyd1zbdofQnBNu6cgYk
   8qLgPHW0xkmsUA++rCl1TBpvy5hOhaaMhjRmCMygT8skslu67NSFkqtjJ
   48L22XqGsySQ0u9yuPS8M3U7Im+gbpLn4swuU3Pon5cTc8pTjz6UXipdB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410723454"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="410723454"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 06:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659050112"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="659050112"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 16 Jan 2023 06:44:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHQj4-00A7vu-3A;
        Mon, 16 Jan 2023 16:44:42 +0200
Date:   Mon, 16 Jan 2023 16:44:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused of_mm_gpiochip_add()
Message-ID: <Y8Vi2tHh21Ihepe0@smile.fi.intel.com>
References: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYD-MfgCBUdTdNU0+kx+Z6parEmWwQC_3smDYxG73=XGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYD-MfgCBUdTdNU0+kx+Z6parEmWwQC_3smDYxG73=XGw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:17:29PM +0100, Linus Walleij wrote:
> On Thu, Jan 12, 2023 at 4:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > of_mm_gpiochip_add() is unused API, remove it for good.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> A bit late to the party but THANKS for doing this Andy, it's been
> a pain for years to have this cruft around.

You're welcome! But note, that we still have a few more APIs to remove.

> We even have some traction toward eventual <linux/gpio.h> removal
> now thanks to Dmitry's efforts, this is great.

I agree, Dmitry did a nice job on this to be happen eventually!

-- 
With Best Regards,
Andy Shevchenko


