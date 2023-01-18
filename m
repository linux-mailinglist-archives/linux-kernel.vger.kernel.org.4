Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1F4671611
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjARITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjARIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:17:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5776D6BE;
        Tue, 17 Jan 2023 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674028022; x=1705564022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QFXAEE/I1e+ZlCichsm9XHIaVDx4dSZnoWCivSwEaY=;
  b=PtHr7507Cc91CPZHgkRPNwLBmP/s/8zGjZyu3XiMRtg+ZPwEa46OR8tv
   QYyKnAnZwtc8EfLh/gop36PJERFsIx+VhTt0ouBZPiZTpNC9UzH52KAgE
   W4eYDTNReQfmzHYhd6pBDZQUANIJtYwBfOoIk42Jy9JAro9aDlFACP2Qs
   WNbfxN0romXGMPRP08pnS2fTKS8fJl2yGh3hi59cCeuwnNhKpjqRyAAoe
   qhTX2V3p4FY7nMrnM+O3AO55hfEQSmce7QaBeFuf/tLGqzWwx+zI2y/4j
   /JJPQr2EinN2B1Ps6Ttsd/Ph72CD5/QsiYzQ40Np/sfL1DhEoIWgMw0tP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="322611688"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="322611688"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 23:46:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="728085837"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="728085837"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2023 23:46:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI39C-00Azu7-2C;
        Wed, 18 Jan 2023 09:46:14 +0200
Date:   Wed, 18 Jan 2023 09:46:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <Y8ejxsqeHL/pBTAY@smile.fi.intel.com>
References: <20230117093944.72271-1-andriy.shevchenko@linux.intel.com>
 <20230117231204.fpvxryjscosg57a6@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117231204.fpvxryjscosg57a6@SoMainline.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:12:04AM +0100, Marijn Suijten wrote:
> On 2023-01-17 11:39:44, Andy Shevchenko wrote:
> > The node name can contain an address part which is not used by
> > the driver. Cut it out before assigning the channel name.
> 
> This explanation doesn't cut it.  It's not that the driver "doesn't use"

Driver doesn't use it still. There is no contradiction, but I agree that
below part is good to have in the commit message.

> the address part, it is that this string is propagated into the
> userspace label, sysfs /filenames/ *and breaking ABI*.

So I will add it into v2 in case the fix works (see below).

...

> > -	const char *name = fwnode_get_name(fwnode), *channel_name;
> > +	const char *name, *channel_name;
> 
> I don't think this'll compile as name is still a pointer to const data,
> while you're assigning (a '\0' char) to it below.

Right, it's always hard for me to compile things for ARM on x86 :-)
Thanks for catching this up!

But does this fix the issue after compilation fix?

-- 
With Best Regards,
Andy Shevchenko


