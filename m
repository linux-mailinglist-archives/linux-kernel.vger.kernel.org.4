Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF726A8416
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCBOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:23:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D4193FE;
        Thu,  2 Mar 2023 06:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677767000; x=1709303000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1xUvPOheqw1hT95eEnqs5hbaLI/RpHD0dWMUlZ70aOY=;
  b=j8afqEY5GUIpkClBzFDQ9NTT4ZtEE0Dmgs8FGR+I9epNqV/xL+wOz9Se
   mOppjAPOgqGVGqP1B/+sfUw+V2YYb8u17e2BJDFfaZR+fpN0tJccuPXr9
   Qed4xeUQuWpB8vRj/+4HIkWpgqLGiaAAkkNkq5x6vf8O/Ut8VOrEA15v8
   EbxNKQB8qHxIF+KTpm/MpEz9iMn4wV+vaxvG61MTAx0D+qC8Lc11qHLyW
   +k+C3RyTMLsyDmNpaydNGLJ7H1zDjE2t4TobnUVMMiDlSmdYzp1AfmDfR
   HulvUF406gzh7CDgZsWPXG9mCIFJOjY+M3xa+8lUekovXdjPSStOfepm+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="362324884"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="362324884"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:23:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="677230474"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="677230474"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2023 06:23:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXjpz-00ENdZ-0o;
        Thu, 02 Mar 2023 16:23:15 +0200
Date:   Thu, 2 Mar 2023 16:23:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZACxUpzCtlrMehrA@smile.fi.intel.com>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0685d97e-4a28-499e-a9e3-3bafec126832@emailsignatures365.codetwo.com>
 <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 08:49:22AM +0100, Mike Looijmans wrote:
> On 01-03-2023 16:30, Andy Shevchenko wrote:
> > On Tue, Feb 28, 2023 at 07:31:51AM +0100, Mike Looijmans wrote:

...

> > > +	/* Shift result to compensate for bit resolution vs. sample rate */
> > > +	value <<= 16 - ads1100_data_bits(data);
> > > +	*val = sign_extend32(value, 15);
> > Why not simply
> > 
> > 	*val = sign_extend32(value, ads1100_data_bits(data) - 1);
> > 
> > ?
> 
> As discussed with  Jonathan Cameron, the register is right-justified and the
> number of bits depend on the data rate. Rather than having the "scale"
> change when the sample rate changes, we chose to adjust the sample result so
> it's always left-justified.

Hmm... OK, but it adds unneeded code I think.

...

> > > +	for (i = 0; i < 4; i++) {
> > > +		if (BIT(i) == gain) {
> > ffs()/__ffs() (look at the documentation for the difference and use proper one).
> 
> Thought of it, but I'd rather have it return EINVAL for attempting to set
> the analog gain to "7" (0nly 1,2,4,8 allowed).

I'm not sure what you are implying.

You have open coded something that has already to be a function which on some
architectures become a single assembly instruction.

That said, drop your for-loop if-cond and use one of the proposed directly.
Then you may compare the result to what ever you want to be a limit and return
whatever error code you want to.

...

> > > +	for (i = 0; i < size; ++i) {
> > Why pre-increment?
> 
> Spent too much time with other coding guidelines, missed this one... Will
> change.

I don't remember that's in coding guidelines, but it's standard practice in the
Linux kernel project. Yeah, we have a few hundreds of the pre-increments, but
reasons may be quite different for those.

...

> > > +	int millivolts = regulator_get_voltage(data->reg_vdd) / 1000;
> > units.h?
> 
> Should I write:
> 
> regulator_get_voltage(data->reg_vdd) / (MICROS / MILLIS);
> 
> I doubt that improves readability.

Yeah, it should be something like MICROVOLT_PER_MILLIVOLT.
But it's not defined yet.

...

> > > +static int ads1100_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > +	struct ads1100_data *data = iio_priv(indio_dev);
> > > +
> > > +	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
> > > +	regulator_disable(data->reg_vdd);
> > Wrong devm / non-devm ordering.
> 
> Don't understand your remark, can you explain further please?
> 
> devm / non-devm ordering would be related to the "probe" function. As far as
> I can tell, I'm not allocating resources after the devm calls. And the
> "remove" is empty.

Ah, it's my mistake, I misread it as ->remove().

-- 
With Best Regards,
Andy Shevchenko


