Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950855EF2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiI2Jxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiI2Jxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:53:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B312C6BD;
        Thu, 29 Sep 2022 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664445222; x=1695981222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vGkLjivaiR7LAJ5xwQ9O6hiKM41mqmslS4frekkTONo=;
  b=cAnEEIg+RUf1jHhU8S3zofEnj/4dHIP0D/etm8znxVu5qFZ0akDJxUQw
   4Ax441h/MfytRugFNIFv2f7XKSObZ3OcqPJWAo2Kf3yVoFZCjYH9BnnGp
   MVtLX06DKceeFycYzvWg2qh3YxA3wNPzKybWPB72sXmjtipq2BJThzC7x
   v43fTt1zThLG5sl0bGbMVySvVMfmx7KSMRr2jIsZ4v6IDj3mbC5cwK+cS
   gAcHEdxrR1hnckla5QtdOtjocGVX3EkcVkcIklDBFdAj0RKjvSYOBmbaS
   eTGmLR4UfWssPEpLmIZ/xnwo18H89D+W6YO2IxbKc6Z7vi2STe93k5ggj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363692961"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="363692961"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="655490428"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="655490428"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2022 02:53:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odqEZ-009KuU-2K;
        Thu, 29 Sep 2022 12:53:35 +0300
Date:   Thu, 29 Sep 2022 12:53:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell: Minor style fixes
Message-ID: <YzVrH8DYUQm+kvXD@smile.fi.intel.com>
References: <20220928220952.2772-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928220952.2772-1-W_Armin@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:09:52AM +0200, Armin Wolf wrote:
> Fix some style issues found during review to improve
> code maintainability, no functional changes.
> 
> Tested on a Dell Inspiron 3505.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 6ccce90f475d..699feae3c435 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -1,13 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell notebooks.
> + * Linux driver for WMI sensor information on Dell notebooks.
>   *
>   * Copyright (C) 2022 Armin Wolf <W_Armin@gmx.de>
>   */
> 
>  #define pr_format(fmt) KBUILD_MODNAME ": " fmt
> 
> -#include <acpi/battery.h>
>  #include <linux/acpi.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> @@ -21,6 +20,8 @@
>  #include <linux/sysfs.h>
>  #include <linux/wmi.h>
> 
> +#include <acpi/battery.h>
> +
>  #define DRIVER_NAME	"dell-wmi-ddv"
> 
>  #define DELL_DDV_SUPPORTED_INTERFACE 2
> @@ -52,7 +53,8 @@ enum dell_ddv_method {
> 
>  struct dell_wmi_ddv_data {
>  	struct acpi_battery_hook hook;
> -	struct device_attribute temp_attr, eppid_attr;
> +	struct device_attribute temp_attr;
> +	struct device_attribute eppid_attr;
>  	struct wmi_device *wdev;
>  };
> 
> @@ -153,8 +155,9 @@ static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_meth
> 
>  static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
>  {
> -	const char *uid_str = acpi_device_uid(acpi_dev);
> +	const char *uid_str;
> 
> +	uid_str = acpi_device_uid(acpi_dev);
>  	if (!uid_str)
>  		return -ENODEV;
> 
> --
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


