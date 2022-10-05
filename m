Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2D5F5441
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJEMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJEMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:15:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD495491D6;
        Wed,  5 Oct 2022 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664972149; x=1696508149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I/0/uca7PMc1JB5EXowgPj8CdkujWBJBOjIoOK0lALU=;
  b=jwt49dlHesGnub2c+Ds5OvLQDRnB37QbswMpmkptptJ26pcrJClPWHm1
   E9bBOuGJEXkMH/X+GW3u/kXzc2KB5TbbaNE4rCKWLvJq3TRL/PAfDGjin
   nvblShxYUnnWn5RjmxZQE23+bTsr92Hz8xmr8KyDJ+rOBVqvLh+g75Rlk
   jvb3/5ABtBi+qHjYr6Pp161BjOkLQjGqyR6S+Gzdg5wele+R80mtrRzEF
   pu7J/JAkPYBtqwcIB6K903uJtmBYCOx928oqwVSPidxkexjO1waQ7Z+ip
   d1B8mOYPYi3ZqnqbyvWmT10zJbCw45W4agOKA6SjlEfuNUGl75ajC+KSh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304126065"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304126065"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 05:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="799468529"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="799468529"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 05 Oct 2022 05:15:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1og3JP-002eDW-0J;
        Wed, 05 Oct 2022 15:15:43 +0300
Date:   Wed, 5 Oct 2022 15:15:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com
Subject: Re: [PATCH v13 5/5] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
Message-ID: <Yz11bkxz9lK4wOHE@smile.fi.intel.com>
References: <cover.1664991040.git.chiaen_wu@richtek.com>
 <1bcd19dbd09650ddac7b96b0fe2932698be2731e.1664991040.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bcd19dbd09650ddac7b96b0fe2932698be2731e.1664991040.git.chiaen_wu@richtek.com>
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

On Wed, Oct 05, 2022 at 07:43:58PM +0800, ChiaEn Wu wrote:
> From: Alice Chen <alice_chen@richtek.com>
> 
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
> LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
> 
> Add support for the MT6370 Flash LED driver. Flash LED in MT6370
> has 2 channels and support torch/strobe mode.

...

> +config LEDS_MT6370_FLASH
> +	tristate "Flash LED Support for MediaTek MT6370 PMIC"

> +	depends on LEDS_CLASS && OF

Why do you have OF dependency?

> +	depends on LEDS_CLASS_FLASH || !LEDS_CLASS_FLASH
> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> +	depends on MFD_MT6370
> +	help
> +	  Support 2 channels and torch/strobe mode.
> +	  Say Y here to enable support for
> +	  MT6370_FLASH_LED device.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called "leds-mt6370-flash".

-- 
With Best Regards,
Andy Shevchenko


