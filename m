Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86870F4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjEXLHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjEXLHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:07:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40217195;
        Wed, 24 May 2023 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684926434; x=1716462434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwI8xxMEjunWpxl7fD4Qdm430ndHRu9GRBnfhcyQF7o=;
  b=fOsP82439wQlE8vLPIMzXe1hf4+A3OCXQUX409Nf5OkZnlQkdtbNqpsr
   Sxn890TOchKEBaA5u9kgDk7G6ZGz81MoSaCkc4eNjpF9nA98OeGHFl0kw
   CadqXN3qOusHdLeeQQZtcNd9QrxfCtoe8uhhkstFzNf17L+iT/8txnnW+
   FCHUDDYlvhfWnaJ9iyl7Zugbjwmdwe+hWT8v2tmZeD4g4gdRoFY8pgrWr
   b9HEJ9GcSKyjPTq+8o4Hq9292/Dox5UTNSfsEH1wN5l2MjRN8ntk43AjV
   GfYu/y/LZeiZSCDK/pv0TBpT1vgDJgQmGcoPtU2JYJrgjduxryEWoxt7+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="353555542"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="353555542"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="774201652"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="774201652"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2023 04:06:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q1mKW-000GEH-01;
        Wed, 24 May 2023 14:06:56 +0300
Date:   Wed, 24 May 2023 14:06:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxim Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v1 1/4] iio: adc: Add Allwinner D1/T113s/R329 SoCs
 GPADC
Message-ID: <ZG3vzxWicUgndMqv@smile.fi.intel.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
 <20230524082744.3215427-2-bigunclemax@gmail.com>
 <20230524110105.4928906c@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524110105.4928906c@donnerap.cambridge.arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:01:05AM +0100, Andre Przywara wrote:
> On Wed, 24 May 2023 11:27:30 +0300
> Maxim Kiselev <bigunclemax@gmail.com> wrote:

...

> > +static const struct regmap_config sun20i_gpadc_regmap_config = {
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +	.fast_io = true,
> > +};
> 
> Is there any particular reason you chose a regmap to model this here?
> Isn't that just straight-forward MMIO, which we could just drive using
> readl()/writel()?

Even though regmap adds a few nice features that might be used.
For example, locking. But I dunno if this driver actually uses it
OR uses it correctly.

...

> > +	config = of_device_get_match_data(&pdev->dev);

Please, avoid using OF-centric APIs in the new IIO drivers.

	config = device_get_match_data(&pdev->dev);

should suffice.

> > +	if (!config)
> > +		return -ENODEV;

...

> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return dev_err_probe(&pdev->dev, irq, "failed to get irq\n");

We should not repeat the message that printed by platform core.

...

> > +	ret = devm_request_irq(&pdev->dev, irq, sun20i_gpadc_irq_handler,
> > +			       0, dev_name(&pdev->dev), info);

You can simplify your life with

	struct device *dev = &pdev->dev;

at the definition block of the function.

> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed requesting irq %d\n", irq);

...

> > +		.data = &sun20i_d1_gpadc_channels[1]

Also, leave comma here.

...

> > +		.data = &sun50i_r329_gpadc_channels[2]

Same as above.

-- 
With Best Regards,
Andy Shevchenko


