Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C96458B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLGLRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLGLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:17:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A396DC1E;
        Wed,  7 Dec 2022 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670411829; x=1701947829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H0Vzsz2jhaO+JMBnaxA31lSJWlWykGUD2EfsJINbXAg=;
  b=FkFd6ZpL8AGXwxy1ubYQ3ZOo0oygDZRMO7q2X+wVysci5v1TbHbgoIvI
   nySPWg8M/u9SRyZz7dy8+5+KsXIIwrNrpxiufjEpsFDPW8lM9vzrZKmEX
   kPzJl4k+r4ygD9a0QNIuwdFWO0xVD1VyzlS+Pn1t/RAN7oWl9V0av5bNR
   BQQGAReTLJqfEu8w4VRAzNwoiq0NsjzRkGrMsWEPZHBf79+76bgJ8Wt11
   Uh2aSRUfNQ+gzS1+u5BCQJXmqZc0OuMuEBNLToCIZxssjDcVSQL+RW6oP
   notaYUJExxWd6tKgQWugC5psvF9nTdfWbrGN4ettGnvcrV7dtGCnimDtc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316881114"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="316881114"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="679102665"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="679102665"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2022 03:16:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2sPu-005jlA-26;
        Wed, 07 Dec 2022 13:16:46 +0200
Date:   Wed, 7 Dec 2022 13:16:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     outreachy@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: drivers: regulator: Add MAX77541 Regulator
 Support
Message-ID: <Y5B2HrS1MlERLppj@smile.fi.intel.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
 <20221207090906.5896-4-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207090906.5896-4-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 12:08:42PM +0300, Okan Sahin wrote:
> This patch adds regulator driver for both MAX77541 and MAX77540.

Read Submitting Patches documentation on how to create better commit message.

> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery and 5VDC systems.
> 
> The MAX77540 is a high-efficiency step-down converter
> with two 3A switching phases.

...

> +/*
> + * Copyright (c) 2022 Analog Devices, Inc.
> + * ADI Regulator driver for the MAX77540 and MAX77541

> + *

Redundant blank line.

> + */

...

> +static const unsigned int max77541_buck_volt_range_sel[] = {
> +	0x00, 0x00, 0x40, 0x40, 0x80, 0x80

You can leave trailing comma.

> +};

...

> +static const struct regulator_desc max77540_regulators_desc[] = {
> +	MAX77540_BUCK(1, max77541_buck_ops),
> +	MAX77540_BUCK(2, max77541_buck_ops)

Ditto.

> +};
> +
> +static const struct regulator_desc max77541_regulators_desc[] = {
> +	MAX77541_BUCK(1, max77541_buck_ops),
> +	MAX77541_BUCK(2, max77541_buck_ops)

Ditto.

> +};

...

> +struct max77541_regulator_dev {
> +	struct device *dev;

Isn't it the same as...

> +	struct max77541_dev *max77541;

...max77541->dev ?

> +};

...

> +static int max77541_regulator_probe(struct platform_device *pdev)
> +{

	truct device *dev = &pdev->dev;

will save you a bit of code below.

> +	struct max77541_dev *max77541 = dev_get_drvdata(pdev->dev.parent);


...


> +				return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
> +							"Failed to register regulator\n");

Wrong indentation.

...

> +				return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
> +						"Failed to register regulator\n");

Ditto.

...

> +

Redundant blank line.

> +module_platform_driver(max77541_regulator_driver);

-- 
With Best Regards,
Andy Shevchenko


