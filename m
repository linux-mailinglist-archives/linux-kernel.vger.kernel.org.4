Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028F26F4B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEBUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEBUkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:40:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69910D9;
        Tue,  2 May 2023 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683060030; x=1714596030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orxph8gXqsDtdJQ2KysJOOsFvhyl4wTbC5xnv9jsMTA=;
  b=c8kh/x6LpTyLbATfx/2c8Cj0UPpSqLs92j2+Dj3S+jPOUYOpmW/5irus
   bFaE9cz3w4F+LFPBmM4AnVWUpAOvOuEzE/rO4RQ18iePbXacPERq+ztCI
   NIZ3WDZ4aBG1huFE6R6htLuNPiZODRWUA02r9XG0tOv83Gi1L0luKwzCo
   4yHaGXB7qT6FoLUmPRegAzb6wyL/6OlTUavazl089kxltkSWArvB4wMwu
   3ksmnjyWIa5D9LuUjXfyrkhfk4vkmYKh4UuU4McOhqLQrXr/CnMQkrh9P
   2VqQQQ6LSptbHBu7UQyTAgFtCyqRTCFxdVY2rgxO78FyVRRnOAWCnR/Gl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="337635136"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="337635136"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 13:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="726895262"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="726895262"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 02 May 2023 13:40:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ptwnN-008E0F-0F;
        Tue, 02 May 2023 23:40:21 +0300
Date:   Tue, 2 May 2023 23:40:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <ZFF1NMaR1RYThcSB@smile.fi.intel.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
 <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:08:17AM +0300, Matti Vaittinen wrote:
> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> Add initial support for the ROHM BU27008 color sensor.
>  - raw_read() of RGB and clear channels
>  - triggered buffer w/ DRDY interrtupt

...

> +enum {
> +	BU27008_RED,	/* Always data0 */
> +	BU27008_GREEN,	/* Always data1 */
> +	BU27008_BLUE,	/* data2, configurable (blue / clear) */
> +	BU27008_CLEAR,	/* data2 or data3 */
> +	BU27008_IR,	/* data3 */
> +	BU27008_NUM_CHANS

Why not converting comments to a kernel-doc?

> +};
> +
> +enum {
> +	BU27008_DATA0, /* Always RED */
> +	BU27008_DATA1, /* Always GREEN */
> +	BU27008_DATA2, /* Blue or Clear */
> +	BU27008_DATA3, /* IR or Clear */
> +	BU27008_NUM_HW_CHANS
> +};

Ditto.

...

> +	if (int_time < 0)
> +		int_time = 400000;

Adding 3 0:s to drop them below with a heavy division operation? Well done!
Or did I miss anything?

> +	msleep(int_time / 1000);

USEC_PER_MSEC ?

...

> +	ret = devm_iio_device_register(dev, idev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	return ret;

return 0 will suffice.

-- 
With Best Regards,
Andy Shevchenko


