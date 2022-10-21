Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19444607561
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJUKuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJUKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:49:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73FCBDE;
        Fri, 21 Oct 2022 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666349361; x=1697885361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0a33PigWSTiQkXsbRap1wdMtX5M30vWOtN5yDWKwAk=;
  b=a5P3ItN1PE4ZxpTrwEnRlk4OKdTZiiNfH/3JYqmqsdzIDgL58H9F6iHn
   JhqTqTjndFgEJhHJhAAM+EbP9x1J70ClKUdsS2nE8jScRMzaQjVdYLG0g
   ZuIXRhbmT+I01cbBEnAN21T7lV8O+AggLcnpAExrMfxUc1BCN9Qj++ecc
   /RnxvGOzC29H2wsOczg9EQ/xcD5GiyR2ef9btyPyWf8w4YgFo+bJZ+uHj
   oh9vFoIm6GBKPzofUPtoRLv8M9p0V3deyvHR/Os2d4rJPoT32L8R5+BEk
   UV8RrlXCeep47fWGCfygL7KCvW6qLIGgMVCmIaBbPc/XNhBy1k2gewY5p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="308070032"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="308070032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 03:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="632863745"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="632863745"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Oct 2022 03:49:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olpaV-00B6rD-0Q;
        Fri, 21 Oct 2022 13:49:15 +0300
Date:   Fri, 21 Oct 2022 13:49:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Y1J5KiH6IJLmrWH4@smile.fi.intel.com>
References: <cover.1666263249.git.mazziesaccount@gmail.com>
 <5000bd61650554658d13619c8244f02cedbc182a.1666263249.git.mazziesaccount@gmail.com>
 <Y1FcftQKimmvcOej@smile.fi.intel.com>
 <2cad533d-32d1-5ca1-74e6-e2debcbdad81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cad533d-32d1-5ca1-74e6-e2debcbdad81@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:10:08AM +0300, Matti Vaittinen wrote:
> On 10/20/22 17:34, Andy Shevchenko wrote:
> > On Thu, Oct 20, 2022 at 02:37:15PM +0300, Matti Vaittinen wrote:

...

> > > +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
> > > +			       sizeof(__le16));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*val = le16_to_cpu(data->buffer[0]);
> > 
> > 'p'-variant of the above would look better
> > 
> > 	*val = le16_to_cpup(data->buffer);
> > 
> > since it will be the same as above address without any additional arithmetics.
> > 
> 
> I guess there is no significant performance difference? To my eye the
> le16_to_cpu(data->buffer[0]) is much more clear. I see right from the call
> that we have an array here and use the first member. If there is no obvious
> technical merit for using le16_to_cpup(data->buffer) over
> le16_to_cpu(data->buffer[0]), then I do really prefer the latter for
> clarity.

Then you probably wanted to have &data->buffer[0] as a parameter to
regmap_bulk_read()?

...

> > > +	if (data->trigger_enabled) {
> > > +		iio_trigger_poll_chained(data->trig);
> > > +		ret = IRQ_HANDLED;
> > > +	}
> > > +
> > > +	if (data->state & KX022A_STATE_FIFO) {
> > 
> > > +		ret = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
> > > +		if (ret > 0)
> > > +			ret = IRQ_HANDLED;
> > 
> > I don't like it. Perhaps
> > 
> > 	bool handled = false;
> > 	int ret;
> > 
> > 	...
> > 		ret = ...
> > 		if (ret > 0)
> > 			handled = true;
> > 	...
> > 
> > 	return IRQ_RETVAL(handled);
> 
> I don't see the benefit of adding another variable 'handled'.
> If I understand correctly, it just introduces one extra 'if' in IRQ thread
> handling while hiding the return value in IRQ_RETVAL() - macro.
> 
> I do like seeing the IRQ_NONE being returned by default and IRQ_HANDLED only
> when "handlers" are successfully executed. Adding extra variable just
> obfuscates this (from my eyes) while adding also the additional 'if'.

You assigning semantically different values to the same variable inside the
function.

-- 
With Best Regards,
Andy Shevchenko


