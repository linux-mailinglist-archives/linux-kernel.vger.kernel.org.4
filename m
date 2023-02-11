Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41486930BF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBKL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBKL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:56:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC418A81;
        Sat, 11 Feb 2023 03:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676116547; x=1707652547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=95wQjL+Zc8jViWbxfkoTEwvp3PeuR6v8ELcSbnJPmnQ=;
  b=HFtbvswWwDMdNR/JtZH28FlPUYxnUwXhOO1pL9JqI4e5n/aIrPGi+obE
   y5moRHRhObbMUwfYPKWCZu0TMRkz/gls5Zh+8elGTb+LMujWUmXwfBbiJ
   IrJC734tYZXNKIS3DuR4xZ2tdvrf+l+Z2PaVB14gFB0w6+e5Mw8rK76ZH
   nxRXLg81iPih57rajSEevX3MY4pOQnf0Cg7c890kHBzInvJDR+qd490Cm
   PNJU66vseLxVZYR/vrcAEQ6KzYerZJc7wGWqF8fEXSuguPGTTirh3zDAi
   q60flafmzfGF9cSOzuSmjv7ekrctl4OW9eJzYrhv0GaSPtQpL0WkLWiTB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328300434"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="328300434"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 03:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="811103125"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="811103125"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2023 03:55:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pQoTc-005TIG-1R;
        Sat, 11 Feb 2023 13:55:32 +0200
Date:   Sat, 11 Feb 2023 13:55:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Message-ID: <Y+eCNEHcmo4qapcI@smile.fi.intel.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:39:41AM -0500, Asmaa Mnebhi wrote:
> This patch adds support to the BlueField-3 SoC pin controller.

Please read Submitting Patches on how to create better commit message.

> It allows muxing individual GPIOs to switch from the default
> hardware mode to software controlled mode.

...

> +config PINCTRL_MLXBF
> +	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
> +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)

This is wrong.
Please make sure you cover more testing.
Also, do you really need an ACPI dependency?

> +	select PINMUX
> +	select GPIOLIB
> +	select GPIOLIB_IRQCHIP
> +	select GPIO_MLXBF3
> +	help
> +	  This selects the pinctrl driver for BlueField-3 SoCs.

Same comment as per previous patch.

> +// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
> +
> +/*
> + * Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>

Same comments as per previous patch.

> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>

Based on the above, I stop here and wait for next version where comments given
anywhere are applied to all appropriate places.

...

> +	BUILD_BUG_ON(ARRAY_SIZE(mlxbf_pinctrl_single_group_names) !=
> +		     ARRAY_SIZE(mlxbf_pinctrl_single_group_pins));

static_assert().

-- 
With Best Regards,
Andy Shevchenko


