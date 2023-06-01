Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98471EFAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFAQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFAQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:51:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3601B1;
        Thu,  1 Jun 2023 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638270; x=1717174270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sAhDo5ijB5QiHtdByjW35ccQhPA3g20K+nzOIsyvDVE=;
  b=Zp9+3RQhlqcCP/4krIzcZl+67L2FqeuojoZRG2YZOxkF3FCVQ5OUdlJv
   6lo/X26n642ID0Z96Km6sZk/M96L7WWDg2A/6CASDBSViU27JtbH3AwMZ
   TdQU6L/uH7VwQ0qNknzfgX/5V0mQW0/7uIo7Yjob7aGSxBOXZpG3vbkDy
   0s8VLHtrLtIM1sEJw8MQCCXSllpdIeui/bXrNQ9AkKoBlBPb6WMyrfAml
   dDkA2UjzD0Il99jWKEBwsKJmoXeRZGWRzda+V+DetVs/1vnFFcOwwmeG+
   tNdwTLTBuYvIq60anDLt3LpJYD3+v3me9D2DjEHRP4/sjEotUvFXI8ivi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421426638"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421426638"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777283038"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777283038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2023 09:51:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q4lVr-000Soq-38;
        Thu, 01 Jun 2023 19:50:59 +0300
Date:   Thu, 1 Jun 2023 19:50:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/1] leds: simatic-ipc-leds-gpio: add new model BX-21A
Message-ID: <ZHjMcwcCbSyMx5d9@smile.fi.intel.com>
References: <20230531155457.31632-1-henning.schild@siemens.com>
 <20230531155457.31632-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531155457.31632-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 05:54:57PM +0200, Henning Schild wrote:
> This adds support for the Siemens Simatic IPC BX-21A. Its LEDs are
> connected to GPIO pins provided by the Intel Elkhart Lake pinctrl
> driver.

...

> +static struct platform_driver simatic_ipc_led_gpio_elkhartlake_driver = {
> +	.probe = simatic_ipc_leds_gpio_elkhartlake_probe,
> +	.remove = simatic_ipc_leds_gpio_elkhartlake_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,

Just wondering if module name and hence device instance name (which may be
longer) can be so long.

Hint: you can use EHL/ehl for elkhartlake and in same way for the rest if any.

> +	},
> +};

-- 
With Best Regards,
Andy Shevchenko


