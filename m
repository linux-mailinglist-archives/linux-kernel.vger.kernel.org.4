Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A7615040
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKARNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKARM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:12:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239F91DA59;
        Tue,  1 Nov 2022 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322776; x=1698858776;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=uLxasX73yNq8uwZ5AARUffTEEStbLjYfR7QyiSXf6dI=;
  b=H7dWDcr7faTqwxIjvKOsNN74BCGTwIfkzEsMqIWQWx3C/gqnD14CKjic
   0isKPNddsRhgPc/pvaZCGkMQ3iUtBtZ+6PxNV1+D50f1M/BXKek0tb06v
   xKDKNjq81hhbzATIOKwVnAjpCfegcIDp66q9cy4jFlx1w+dPRrVtxb1E9
   vEX+n1Hm/C1yNzRfKlGYhJSK7R+OBOvwjqKdk0HcXiLwPmfjvw+kYEk5v
   xmrp0lmnJZ4Qc0/h/13wyPf6/QKRuvdFSd9QkT/n6XgLcl1FG5wxu9eYh
   cTkI/WJczwGZ+f0ZCytXbz5vhQLy5LflFNcmTMhCFo04Ktu7y3kneYoIM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309189952"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="309189952"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723228661"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="723228661"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:52 -0700
Message-ID: <a154ee25-e1e7-8709-abad-8064edc3c43f@intel.com>
Date:   Tue, 1 Nov 2022 19:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 09/26] mmc: sdhci: add UHS-II module
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-10-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-10-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> This patch adds sdhci-uhs2.c as a module for UHS-II support.
> This is a skelton for further development in this patch series.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/Makefile     |  1 +
>  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4e4ceb32c4b4..c4ae7c6d9c04 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
>  obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
> +obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
>  				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> new file mode 100644
> index 000000000000..f29d3a4ed43c
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
> + *  Interface driver
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + *  Copyright (C) 2020 Genesys Logic, Inc.
> + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *  Copyright (C) 2020 Linaro Limited
> + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + */
> +
> +#include <linux/module.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-uhs2.h"
> +
> +#define DRIVER_NAME "sdhci_uhs2"
> +#define DBG(f, x...) \
> +	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Driver init/exit                                                          *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +
> +static int __init sdhci_uhs2_mod_init(void)
> +{
> +	return 0;
> +}
> +module_init(sdhci_uhs2_mod_init);
> +
> +static void __exit sdhci_uhs2_exit(void)

It would be better to match the form of the init name
e.g. sdhci_uhs2_mod_exit

> +{
> +}
> +module_exit(sdhci_uhs2_exit);
> +
> +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> +MODULE_DESCRIPTION("MMC UHS-II Support");
> +MODULE_LICENSE("GPL v2");

