Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE4C638814
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiKYLAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKYLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:00:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5584A598;
        Fri, 25 Nov 2022 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669374021; x=1700910021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Cwy7VwRspGF4g5e1D17JmsOF1WSa4YjVu+exHA+BZw=;
  b=hKbo05ojxXtCdjEe7QJOBIxlIY8mbbqBYbT3ejZUcWTrOxivCf/Gm8iQ
   qZHLnOicPNo24wu/38EvWEzJeQmWopwNDy7a0yrx9FdurZOsSdlh4zYI4
   Ada2RWUwKvzUKytB7yDWF9Lq1jaOJYqcsuE7fTjVppcTdONZCgWuESvZl
   3BKTLt2KlCLCl3BanZYiZUzdyLKhsLmVduVBsJdGZoE3ysku9760alEgw
   H+8QuCzE+Au1t+yP0uHWJkyExljYnUfSkfNyQVyMerwE+eNeOyIbvMMO1
   B00hDbImYs+QfvjFOSAddxu5G77HjS+UmaBgfA9s819IoyCziIq+df89C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="294163560"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="294163560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 03:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="593189418"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="593189418"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2022 03:00:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyWRK-00HCJv-2S;
        Fri, 25 Nov 2022 13:00:14 +0200
Date:   Fri, 25 Nov 2022 13:00:14 +0200
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
Subject: Re: [PATCH v3 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y4CgPhhk0t7BM5JY@smile.fi.intel.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-4-gerald.loacker@wolfvision.net>
 <Y4Cf9MvNRcfy+7jf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Cf9MvNRcfy+7jf@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 12:59:01PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 25, 2022 at 09:35:26AM +0100, Gerald Loacker wrote:

...

> > +static int tmag5273_write_scale(struct tmag5273_data *data, int scale_micro)
> > +{
> 
> What about
> 
> 	u32 mask;

After looking again, I guess it should be

	u32 value;

> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(tmag5273_scale[0]); i++) {
> > +		if (tmag5273_scale[data->version][i].val_micro == scale_micro)
> > +			break;
> > +	}
> > +	if (i == ARRAY_SIZE(tmag5273_scale[0]))
> > +		return -EINVAL;
> > +	data->scale_index = i;
> 
> 	if (data->scale_index == MAGN_RANGE_LOW)
> 		mask = 0;
> 	else
> 		mask = TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK;
> 
> > +	return regmap_update_bits(data->map,
> > +		TMAG5273_SENSOR_CONFIG_2,
> > +		TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK,
> 
> 		mask);
> 
> > +		data->scale_index == MAGN_RANGE_LOW ? 0 :
> > +			TMAG5273_Z_RANGE_MASK |
> > +			TMAG5273_X_Y_RANGE_MASK);
> 
> ?
> 
> > +}

-- 
With Best Regards,
Andy Shevchenko


