Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7356ED138
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjDXPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjDXPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:22:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5B86BF;
        Mon, 24 Apr 2023 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682349738; x=1713885738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qcfml2mDJ01bBf69Gj3gLLlNibuMy0QAooiEzfCDtEA=;
  b=fUwHShACM3/yxnHfxT/5HifGQuosKHcAwCo6YwlAPABjdw05WaxDi5w+
   XHn3eUlhnKWRkwQoudDt23qB2q9kqFZm5x0Ea/WsLBG7MS+xQA8h1yvsb
   zsEDN+4WIU2JdhfO5xlKp0psHgSyyfk6+lBOnsxxKD9FTUNeZhWZXb/ZY
   Rlo+vnBImmzhb3KNNJnJ3Oq8Bd6OtKTD1K54BkCEhnLhpdFLQQ/F/xgeQ
   ffFVy7i2OhzzQMJs8hmvm4cNG4fEBAK5/Q+OS3kIsAPEr6JpXCyOQX+WO
   ByNDChwhxw8F3xY4F6xvHwxLSqoXgX406gYdJEOhsbaPih1302eSIhhDO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="348389273"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="348389273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="939365080"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="939365080"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2023 08:22:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pqy15-004ZO9-1L;
        Mon, 24 Apr 2023 18:22:11 +0300
Date:   Mon, 24 Apr 2023 18:22:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <ZEaeoxdWTknLz7lQ@smile.fi.intel.com>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
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

On Mon, Apr 24, 2023 at 04:10:09PM +0300, Matti Vaittinen wrote:
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

This...

> +#include <linux/bits.h>

...is guaranteed to be included by this.

> +#include <linux/bitops.h>

...

> +static const struct of_device_id bu27008_of_match[] = {
> +	{ .compatible = "rohm,bu27008", },

Inner comma is not necessary to have.

> +	{ }
> +};


-- 
With Best Regards,
Andy Shevchenko


