Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1A632C35
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiKUSlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUSk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:40:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73ACFBAD;
        Mon, 21 Nov 2022 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669056059; x=1700592059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXUA743qnm4rfheWSamHKDdgHFAjXXDgwcJiLXQjFU8=;
  b=lu+jtXc0H3p/EhDkYlLPHdjEEmBMXVqD/GQS6ckMK5Hp67xl5CanvqH1
   LZuuJBCJrwmRCfvobH+y1K1434aLOvs7kIuJXAy9IVVoAKmoB9V3YZ8Sk
   S26WHwE7BF67bIBVqlI5feAGKQmXEQVXFFTNwc/4ROYIS9Umze2Urcli9
   R4WmRDDH+v7omjolD7s77D9m+JyGS3nuIe2BTYj4dskHTxvLIstUTwkNb
   oK7khX3h4x0+vcBGu4lhGBmw/DUYBnvzExKVsAkYohWD5Lfsv7PlNyN4i
   8203PtiSzxCnV7u3/eG12rQfGbDYP+aJLvEcOPhfYFVbIcIkRwC6m4CGJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="296991879"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="296991879"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 10:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="674073888"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="674073888"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2022 10:40:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxBiv-00FQUw-34;
        Mon, 21 Nov 2022 20:40:53 +0200
Date:   Mon, 21 Nov 2022 20:40:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y3vGNVZcSuILCHxW@smile.fi.intel.com>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
 <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
 <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
 <96a632c2-7ac1-7b9d-0cb0-9874ae21a8eb@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a632c2-7ac1-7b9d-0cb0-9874ae21a8eb@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:24:18PM +0100, Gerald Loacker wrote:
> Am 21.11.2022 um 15:04 schrieb Andy Shevchenko:
> > On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:

...

> >> +	if (!device_property_read_string(data->dev, "ti,angle-measurement",
> >> +					 &angle_measurement)) {
> >> +		if (!strcmp(angle_measurement, "off"))
> >> +			data->angle_measurement = TMAG5273_ANGLE_EN_OFF;
> >> +		else if (!strcmp(angle_measurement, "x-y"))
> >> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
> >> +		else if (!strcmp(angle_measurement, "y-z"))
> >> +			data->angle_measurement = TMAG5273_ANGLE_EN_Y_Z;
> >> +		else if (!strcmp(angle_measurement, "x-z"))
> >> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Z;
> >> +		else
> >> +			dev_warn(data->dev,
> >> +				 "failed to read angle-measurement\n");
> > 
> > Can't you use match_string()?
> > 
> 
> Yes, I will use match_string().
> 
> > And you actually can do a bit differently, can you?
> > 
> > 	angle_measurement = "...default...";
> > 	if (device_property_...)
> > 		dev_warn(data->dev, "failed to read angle-measurement\n");
> 
> I think we shouldn't warn here, as angle_measurement isn't a required
> property. Besides that I will do it this way.
> 
> > 	ret = match_string();
> > 	if (ret < 0)
> > 		dev_warn(data->dev, "invalid angle-measurement value\n");
> > 	else
> > 		data->angle_measurement = ret;
> > 
> >> +	}

After looking into DT patch I think you can even use
device_property_match_string(),

...

> >> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u",
> > 
> > There is a difference between %1u and %.1u. And I believe you wanted the
> > latter, but...
> 
> %1u works fine for me. Can you point me to the documentation for %.1u?

man printf(3)

It was a surprise to me that many developers don't know the difference here.
The %NNNNu defines the _minimum_ digits to print, while the %.NNNu defines
the _exact_ amount of digits to print (NNN -- a number).

> >> +			 data->version);

-- 
With Best Regards,
Andy Shevchenko


