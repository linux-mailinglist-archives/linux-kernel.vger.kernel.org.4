Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2142969E1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjBUNvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBUNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:51:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174D28D2B;
        Tue, 21 Feb 2023 05:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676987468; x=1708523468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KS5B5YypziseZpu2NX+1cRUwnfO8HNyoE9eh8q4E50Q=;
  b=mH4jkyT9QpuTfCVyfT/J0w0ukpdw6Uc3X6oeCfSJhyZRp0QV68I2xhBo
   Yf9mR5dOF5XDaHBR+eM7r4/ZpJC7fEIzZ+1t7XhomL/3OXObHBvNr8gIL
   uvvZbZRRi5tNr75WEYYxhKAbPGJCw/fzftue70Lt06yQ2a2F6XOkFeO/+
   vxT7w1F2p0GEdrNUif2E2ufwolCGnl85RYWH4Y7jF3hpt6+ueS5VBneIv
   dyYc1fPKuFZALYzQ7WzZU0SnJvBbPyKz6xOvrJlZ8Wc34kVlZEfBg7YTy
   dLW4SkQOeDXUZUpr8xuuYFFDHhSlhcsM3G8Sqx8T3e03HaB6b8u7mD3Ja
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331300203"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="331300203"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 05:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="740413736"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="740413736"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2023 05:51:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUT2u-009yR9-0X;
        Tue, 21 Feb 2023 15:51:04 +0200
Date:   Tue, 21 Feb 2023 15:51:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple
 drivers
Message-ID: <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
 <20230221122414.24874-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221122414.24874-3-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:24:13PM +0100, Henning Schild wrote:
> In order to clearly describe the dependencies between the gpio

GPIO

> controller drivers and the users the driver is split up into two and one

one --> a

> common header.

...

> + * Authors:

(everywhere where it is a single author, 's' is redundant)

...

> +#ifndef __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
> +#define __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO

> +#endif /* __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO */

This header doesn't look right.

Have you run `make W=1 ...` against your patches?
Even if it doesn't show defined but unused errors
the idea is that this should be a C-file, called,
let's say, ...-core.c.

-- 
With Best Regards,
Andy Shevchenko


