Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4563C555
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiK2Qjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiK2Qjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:39:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CEC554EB;
        Tue, 29 Nov 2022 08:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669739983; x=1701275983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9NG01ZwhuIYj2dYkpawIaabd6D6cMXn+yOioyWtWLb8=;
  b=MOmXoa2zdHgIAp4EDN4Rb1xXDU429Eh83cz33Cs4tK7SUQ26zVhdfv1y
   /XT1G6I/hpYiiIP08FzF+GgYAPAunWta1WrfVAC97IEGsDKnD+xKp2b7K
   HVcJUQdzbQG/NJaQhHxSBVWqKUrOZPIY98U6TksmFlGMmTAcuQ/Ede47o
   RlCLP63vL7aa87ow0yhtf++IpJ5bEjrN39PT7/9k42+n6Jupm81DRZ9yf
   4DqysaY6RQ5eRYgvs12D6PiCYGsHLp1lzewKDBG8Qqks7d1XjP8hB3lFQ
   BD6aKSO+dKyxw3w/QKSdtH4gmWccU3SmYdEVj15QX9WbKCreVF3Ua+wW/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="312781857"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="312781857"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972737919"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="972737919"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2022 08:39:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03dw-001mxM-11;
        Tue, 29 Nov 2022 18:39:36 +0200
Date:   Tue, 29 Nov 2022 18:39:35 +0200
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
Subject: Re: [PATCH v4 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y4Y1x8rj7BS8FHMz@smile.fi.intel.com>
References: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
 <20221129064540.3218982-4-gerald.loacker@wolfvision.net>
 <Y4Y1VqvYS0XsWi1r@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Y1VqvYS0XsWi1r@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:37:42PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 29, 2022 at 07:45:40AM +0100, Gerald Loacker wrote:

...

> > +	ret = match_string(tmag5273_angle_names,
> > +			   ARRAY_SIZE(tmag5273_angle_names), str);
> > +	if (ret < 0)
> > +		dev_warn(dev, "unexpected read angle-measurement property: %s\n", str);
> 
> 		dev_warn(dev, "unexpected value in angle-measurement property: %s\n", str);
> 
> ?
> 
> > +	else
> > +		data->angle_measurement = ret;

Actually remembering Rob's statement that Linux should not validate device
tree, this can be written rather as:

	ret = match_string(tmag5273_angle_names,
			   ARRAY_SIZE(tmag5273_angle_names), str);
	if (ret >= 0)
		data->angle_measurement = ret;

-- 
With Best Regards,
Andy Shevchenko


