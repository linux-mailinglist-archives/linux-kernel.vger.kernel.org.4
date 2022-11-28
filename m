Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD9D63A970
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiK1N2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiK1N2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:28:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC81B11C25;
        Mon, 28 Nov 2022 05:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669642080; x=1701178080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVHrI4pHYy1NGHezAZoCXCIhn6PYcGb7Y9h61CR31MQ=;
  b=Kcn4rj1FFM2Hj32tND/uFs8XDARrQ89jfwgC2fKy1dEFAwosd/4UvXrA
   0dxBy78YRafCZMCfFyKwHrkCvDa78y5SPNjYqkaWXmpbapRNDN79o5BTF
   b2cj9REs7iA50k4aiQNfeXr2Qr/CWDDD+eqtuiH9NOkR99CXMP9RlzPiC
   hSZ8imIuTqG+BLAlcybR9Lha6dfWvQHCyKsUTUPluIbJ//66SlCZWDI/P
   NTc9l6/jQ0C4qwHUK6BZMU/Z3NAnXOvY44x4s/MqxSpvkR8HQUDxz06pG
   EzMvgNyfJdesfwv71/KGAf/n+kJr3Yc2noDLPG1z2wRsHCgn0nkbIu0BB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="314866215"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="314866215"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="768040124"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="768040124"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2022 05:27:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozeAs-0019SR-1w;
        Mon, 28 Nov 2022 15:27:54 +0200
Date:   Mon, 28 Nov 2022 15:27:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v3 1/3] iio: add struct declarations for iio types
Message-ID: <Y4S3WnYWVnmiVFc+@smile.fi.intel.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
 <Y4CcspD1xkmhmWbh@smile.fi.intel.com>
 <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
 <a55e73f7-4daf-6892-34dc-61c6f6581d8e@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a55e73f7-4daf-6892-34dc-61c6f6581d8e@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 01:18:04PM +0100, Gerald Loacker wrote:
> Am 25.11.2022 um 12:01 schrieb Andy Shevchenko:
> > On Fri, Nov 25, 2022 at 12:45:06PM +0200, Andy Shevchenko wrote:
> >> On Fri, Nov 25, 2022 at 09:35:24AM +0100, Gerald Loacker wrote:

...

> >>> +struct iio_val_int_plus_micro {
> >>> +	int val_int;
> >>> +	int val_micro;
> >>> +};
> > 
> > Thinking more about naming, why not drop val_ completely?
> > 
> > 	int integer;
> > 	int micro;
> > 
> > ?
> 
> Yes, this sounds good to me. I think of adding only
> 
> 	typedef struct {
> 		int integer;
> 		int micro;
> 	} iio_val_int_plus_micro;
> 
> for now, and one can add similar structures when needed, like
> 
> 	typedef struct {
> 		int integer;
> 		int nano;
> 	} iio_val_int_plus_nano;

It's a rule to use _t for typedef:s in the kernel. That's why
I suggested to leave struct definition and only typedef the same structures
(existing) to new names (if needed).

> or

> 	typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;

This is better as explained above.

> If you think it's better to add them all, I can do that, of course.
> 
> >>> +struct iio_val_int_plus_nano {
> >>> +	int val_int;
> >>> +	int val_nano;
> >>> +};
> >>> +
> >>> +struct iio_val_int_plus_micro_db {
> >>> +	int val_int;
> >>
> >> 	int val_int_db; ?
> >>
> >>> +	int val_micro_db;
> >>> +};
> >>
> >> Actually why can't we simply do
> >>
> >> typedef iio_val_int_plus_micro_db iio_val_int_plus_micro;
> >>
> >> ?

-- 
With Best Regards,
Andy Shevchenko


