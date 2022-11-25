Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE346387C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKYKpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKYKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:45:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD622284;
        Fri, 25 Nov 2022 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669373114; x=1700909114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LqB7yfOJKehuHE5h/4Sq5Y8vk2FeivJgj9pQckLc+V8=;
  b=DYuegUBYtdJqUycSrj4CvWgqPuwpPuvkH0YmY13dzwYrV13VH6EfHsfG
   x7PSU7Aj/rTv8eoPh5ZxC5ZPnfwx9LlgUdbRtXnlHLeREE0K+RegNRbeS
   eVaatoSBVI41nIvYVYNsjDY7C9irDQALkdPJRL1saTPVLSIJx7l3bx5QO
   k/yywEvomxrteDV7lGlGuAod7i+4QpZVV6Q4+/0nUA3y+4deNa4YXoyAG
   /8ZkKnrrMnNfpcXQS04ER/3PXGpK533D8pViOeQy2Uf/vS0uvB3MR7OPg
   VQ/9xz7MDiLs3IYP7Iqgso9EXOXkbPhutvIZdIRGOAH2vvZyinCXM2Uj2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="313157736"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="313157736"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 02:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="817105952"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="817105952"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2022 02:45:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyWCg-00HC0K-1C;
        Fri, 25 Nov 2022 12:45:06 +0200
Date:   Fri, 25 Nov 2022 12:45:06 +0200
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
Message-ID: <Y4CcspD1xkmhmWbh@smile.fi.intel.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 09:35:24AM +0100, Gerald Loacker wrote:
> Add structs for iio type arrays such as IIO_AVAIL_LIST which can be used
> instead of int arrays.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

And thank you for doing this!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(one comment below)

> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> ---
>  include/linux/iio/iio.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index f0ec8a5e5a7a..eaf6727445a6 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -383,6 +383,21 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
>  
>  struct iio_trigger; /* forward declaration */
>  
> +struct iio_val_int_plus_micro {
> +	int val_int;
> +	int val_micro;
> +};
> +
> +struct iio_val_int_plus_nano {
> +	int val_int;
> +	int val_nano;
> +};
> +
> +struct iio_val_int_plus_micro_db {
> +	int val_int;

	int val_int_db; ?

> +	int val_micro_db;
> +};

Actually why can't we simply do

typedef iio_val_int_plus_micro_db iio_val_int_plus_micro;

?

>  /**
>   * struct iio_info - constant information about device
>   * @event_attrs:	event control attributes
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


