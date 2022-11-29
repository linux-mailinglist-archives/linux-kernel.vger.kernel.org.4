Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D8063C51B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiK2Q0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiK2Q0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:26:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCA4C248;
        Tue, 29 Nov 2022 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669739209; x=1701275209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYhqNJHcQMXDB1gY7dCCFi+jTB8wR2/AxYj3YQ88tC8=;
  b=gmDeKXSyGcOI6xKHyRGy5/BMZ0q/7LbOiocRM6UaXcabAvjpuPx10d4Y
   e18HJFGQVx459ZWaEt88Eb2e4d6xmBvBF7RUg7xoyJs3n79yh1qFTdHAH
   7KCwO4Mz6c6q7RU+4NC8YM2PlVzGwE0mb1x6afvfynazQICTM/RVNGC1W
   4uKrpIQQh20cdbypa+6qS4AteVbEYFTcO2GDHVymzgQ2SgGIoifl1DGUT
   vG+yrtPMy61gtDOW+PHoWsWZ6YIkmBC/w2CDK51T0xpyPCv60clWbXjr7
   F3TugHbkgFJYJ/nqk0apb/SGj61j3Fxe8nm3KW4JnV+EXVvouraiIz1v7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315185503"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="315185503"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:26:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="786095527"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="786095527"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2022 08:26:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03R3-001meQ-0j;
        Tue, 29 Nov 2022 18:26:17 +0200
Date:   Tue, 29 Nov 2022 18:26:16 +0200
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
Subject: Re: [PATCH v4 1/3] iio: add struct declaration for iio types
Message-ID: <Y4YyqPUQJQmp3WqO@smile.fi.intel.com>
References: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
 <20221129064540.3218982-2-gerald.loacker@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129064540.3218982-2-gerald.loacker@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 07:45:38AM +0100, Gerald Loacker wrote:
> Add struct for iio type arrays such as IIO_AVAIL_LIST which can be used
> instead of int arrays.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> ---
> Changes in v4:
>  - Add only struct for IIO_VAL_INT_PLUS_MICRO iio type.
> 
>  include/linux/iio/iio.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index f0ec8a5e5a7a..e5101bef50c5 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -381,6 +381,11 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
>  
>  #define INDIO_MAX_RAW_ELEMENTS		4
>  
> +struct iio_val_int_plus_micro {
> +	int integer;
> +	int micro;
> +};
> +
>  struct iio_trigger; /* forward declaration */
>  
>  /**
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


