Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D16AC0EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCFN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCFN3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:29:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AAE23671;
        Mon,  6 Mar 2023 05:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678109384; x=1709645384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWELgJ6UKYulLa0yVyGSUh1o9vmjbEAcGp3BvCpR7/0=;
  b=Ny6Bdmhyf+d/e8qS/LLEUEaaP9YCwje2Vn9J9bihSRqJPy1TH0+/TYIb
   ZDQqMccGUINYeC9XZScfzLytp/baib9pFIGOFBP1bPCHa4in9X3QLPhv2
   hMREARdufyrHtXFynlFFsb2chSgnBTaWWvTiYt9Pu7yjxacvfbZxhE7tN
   6Kd+ker27OyjxxOEpU9QD6v+YzEXUqMglXwsQwerjcen2wvliIBtzJFlm
   f62qt7Awsc4gayySv96/3TwxVNfEyovcCSFmEA9gQAJpsB8Y2C0oO6KiL
   nqMXhy6i+KH4b8E2Bd/sjqO/yp2G2qoRrXXW8JLs4NuKqCcq5y5ce7jjf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400372283"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="400372283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 05:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="799994608"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="799994608"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 06 Mar 2023 05:29:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZAuH-00GRQZ-2v;
        Mon, 06 Mar 2023 15:29:37 +0200
Date:   Mon, 6 Mar 2023 15:29:37 +0200
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
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZAXqwaKA3Uh6TH2q@smile.fi.intel.com>
References: <20230306131312.7170-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0270109b-145d-4024-b8ff-05d54be2ad97@emailsignatures365.codetwo.com>
 <20230306131312.7170-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306131312.7170-2-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:13:12PM +0100, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.

...

> +	/* Value is always 16-bit 2's complement */
> +	value = be16_to_cpu(buffer);

+ Blank line?

> +	/* Shift result to compensate for bit resolution vs. sample rate */
> +	value <<= 16 - ads1100_data_bits(data);

+ Blank line?

> +	*val = sign_extend32(value, 15);

...

> +	microvolts = regulator_get_voltage(data->reg_vdd);
> +	/*
> +	 * val2 is in 'micro' units, n = val2 / 1000000
> +	 * result must be millivolts, d = microvolts / 1000
> +	 * the full-scale value is d/n, corresponds to 2^15,
> +	 * hence the gain = (d / n) >> 15, factoring out the 1000 and moving the
> +	 * bitshift so everything fits in 32-bits yields this formula.
> +	 */
> +	gain = ((microvolts + BIT(14)) >> 15) * 1000 / val2;

Perhaps adding MICROVOLT_PER_MILLIVOLT (to units.h) and use it here?

Besides that it's seems like

	microvolts = regulator_get_voltage(data->reg_vdd);
	gain = DIV_ROUNDUP_CLOSEST(microvolts, BIT(15)) *
	       MICROVOLT_PER_MILLIVOLT / val2;

> +	if (gain <= 0 || gain > 8)
> +		return -EINVAL;

As I commented out in the previous discussion (please, give a chance to the
reviewers to answer before issuing a new version of the series) this better
to be

	if (gain < BIT(0) || gain > BIT(3))

which will show the nature of power of two implicitly.

> +	regval = ffs(gain) - 1;
> +	ads1100_set_config_bits(data, ADS1100_PGA_MASK, regval);

Can be unified in one line.

> +	return 0;
> +}

...

> +			return ads1100_set_config_bits(
> +					data, ADS1100_DR_MASK,
> +					FIELD_PREP(ADS1100_DR_MASK, i));

Wrong indentation.
Please, check all your code for this kind of issues.

-- 
With Best Regards,
Andy Shevchenko


