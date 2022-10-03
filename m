Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1603C5F2C97
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJCI6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJCI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:58:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A21F5A837;
        Mon,  3 Oct 2022 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664786611; x=1696322611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=POqTCHFhgHZP4PJehVBeukvn0cF46F+fSY63iPQxsWs=;
  b=erzvKXW07gb1W+yOCC2k25dAh3JjXyjzsu1Sw2QtQPXRjJEMxHCaJ2l7
   /590mUdywQFEA2jG0gPkZtHzdAzPbT1D/yMUrAbe+G+lSR6iJ03gAlGd7
   Ec5ImAL8nYqUDBtMQl1Kz9RYc9a4kdEyu8RxculfjAcK0wbvNLVFueGHB
   Soezv7i/DnjTXUTQvR1d0R6kEqw9aUUiO3hVd31i0NRYVEjFBTgM/+0K+
   Qj50WUZA0VJBFhTBCd0s09MoZdsZUEs8L6fVqGTC3u3vAbDD4qdKxYXdw
   NVhRAxv7t2LLO+ZmXDvPGlhe/dBCmtCjnokNTH0jCcxs9XfcTb15WoZYQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="328974358"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="328974358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 01:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="748908010"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="748908010"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2022 01:43:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofH2n-001Pzs-09;
        Mon, 03 Oct 2022 11:43:21 +0300
Date:   Mon, 3 Oct 2022 11:43:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Message-ID: <YzqgqERDTLVkJH67@smile.fi.intel.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:13:53AM +0300, Matti Vaittinen wrote:
> The iio_triggered_buffer_setup_ext() and the
> devm_iio_kfifo_buffer_setup_ext() were changed by
> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> to silently expect that all attributes given in buffer_attrs array are
> device-attributes. This expectation was not forced by the API - and some
> drivers did register attributes created by IIO_CONST_ATTR().
> 
> When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
> the pointer to stored string constant and when the sysfs file is read the
> kernel will access to invalid location.
> 
> Change the function signatures to expect an array of iio_dev_attrs to
> avoid similar errors in the future.

...


Wouldn't be better to split this on per driver basis or is it impossible?

>  drivers/iio/accel/adxl367.c                          | 10 +++++-----
>  drivers/iio/accel/adxl372.c                          | 10 +++++-----
>  drivers/iio/accel/bmc150-accel-core.c                | 12 ++++++------
>  drivers/iio/adc/at91-sama5d2_adc.c                   | 12 ++++++------
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c   |  4 ++--
>  drivers/iio/buffer/industrialio-triggered-buffer.c   |  4 ++--
>  drivers/iio/buffer/kfifo_buf.c                       |  2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  6 +++---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c  |  8 ++++----
>  drivers/iio/industrialio-buffer.c                    | 11 +++++++----
>  include/linux/iio/buffer_impl.h                      |  2 +-
>  include/linux/iio/kfifo_buf.h                        |  3 ++-
>  include/linux/iio/triggered_buffer.h                 |  6 +++---

...

>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_dev_attr *p;

> +	const struct iio_dev_attr *id_attr;

I'm wondering if we may keep this upper, so "longer line goes first" rule would
be satisfied.

>  	struct attribute **attr;
>  	int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
>  	const struct iio_chan_spec *channels;

...

> +		for (i = 0, id_attr = buffer->attrs[i];
> +		     (id_attr = buffer->attrs[i]); i++)

Not sure why we have additional parentheses...

> +			attr[ARRAY_SIZE(iio_buffer_attrs) + i] =
> +				(struct attribute *)&id_attr->dev_attr.attr;

...and explicit casting here. Isn't attr is already of a struct attribute?

-- 
With Best Regards,
Andy Shevchenko


