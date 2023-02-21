Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05469E01E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjBUMTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjBUMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:19:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46319265A8;
        Tue, 21 Feb 2023 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676981954; x=1708517954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izryC7F06J5VIJp2EyElOCluBrFFbX9wzea4PSaNy8o=;
  b=gzlkJcBMuCxBXFIXmyUyLpWVA3/W0tpCRHlqLITY0Fw/gVbYY5hMYB38
   bo39665sZ97AkC+ziR86RkFYaoBOnO65GOnqyOPmdeKDORTHzbkxDdRGG
   FT+zkPGLhjFJQDYapTgvMIBfaCENoTtdy3SOZG8csZ9v9Zh25OYfEX/5b
   plfWdu+khs1TLXMe4zInvq1KdFhiylMD0eceBQZz9AQm878ET+4i5MkXF
   8saIhz3Gmn4lR4a1Pr3u8uDQgNE6fxY0Trgr+h6fDIq1tRfOi/dvW78qG
   eJNRX3Ya01ZyW/jxVye7yjDykbI5qsVgidvrrHLMGG3w0M++jxe1tppGL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="397302705"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="397302705"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 04:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="621479547"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="621479547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2023 04:18:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pURba-009wrF-0Y;
        Tue, 21 Feb 2023 14:18:46 +0200
Date:   Tue, 21 Feb 2023 14:18:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/5] regulator: max77541: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y/S2pTZzzHCQzNY3@smile.fi.intel.com>
References: <20230221103926.49597-1-okan.sahin@analog.com>
 <20230221103926.49597-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221103926.49597-3-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:39:10PM +0300, Okan Sahin wrote:
> Regulator driver for both MAX77541 and MAX77540.
> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery
> and 5VDC systems.
> 
> The MAX77540 is a high-efficiency step-down converter
> with two 3A switching phases.

...

> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Analog Devices, Inc.
> + * ADI Regulator driver for the MAX77540 and MAX77541
> + */

Dunno if Mark requires // comments for regulator new code.

...

> +#include <linux/i2c.h>

Is there any user of this?

...

> +static int max77541_regulator_probe(struct platform_device *pdev)
> +{
> +	struct regulator_config config = {};
> +	const struct regulator_desc *desc;
> +	struct device *dev = &pdev->dev;
> +	struct regulator_dev *rdev;
> +	struct max77541 *max77541;

> +	int i;

unsigned ?

> +	max77541 = dev_get_drvdata(dev->parent);

Can be done in definition block (but it's up to you):

	struct regulator_config config = {};
	const struct regulator_desc *desc;
	struct device *dev = &pdev->dev;
	struct max77541 *max77541 = dev_get_drvdata(dev->parent);
	struct regulator_dev *rdev;
	unsigned int i;

> +	config.dev = dev->parent;
> +
> +	switch (max77541->chip->id) {
> +	case MAX77540:
> +		desc = max77540_regulators_desc;
> +		break;
> +	case MAX77541:
> +		desc = max77541_regulators_desc;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < MAX77541_MAX_REGULATORS; i++) {
> +		rdev = devm_regulator_register(dev, &desc[i], &config);
> +		if (IS_ERR(rdev))
> +			return dev_err_probe(dev, PTR_ERR(rdev),
> +					     "Failed to register regulator\n");
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


