Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D699615035
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKARMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKARM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:12:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218413E30;
        Tue,  1 Nov 2022 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322749; x=1698858749;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=2Y14e2BplnomsSCVfJl1KHV2xlBohmP4+8zY0JeOYy8=;
  b=PPoOuJhZ1wQe3kgYuzsrLDwC25dzTpisD+CZs1YgCZOXYQRNDiWEjDJe
   8GLwtWtfVasr5+2hBv+JRfL9UWm5ZNuEcx+NiJNWaF+U16Li8B16sz3GX
   8yYgN/sTf/5xpxqhgb9LePMt8Hg7nBV8yzElvYEcnYoky5a0VWb7DUDlD
   +UVC0hHEsbe4KDvq44ehxuFt0U25afYnsNmwlWdknVd0Rv1o5KdBUhvn1
   nv6s4Ot/JAY5uDMc/fFD1lOPmD1KGOW2ppBV88SlHHlBgcq8GrcT98dl9
   ueRjgeiA4ypiB2J03Jlk27YVxBcBhQFn2cN29el3X2OshEQZnP+UBgEJk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="307914432"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="307914432"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723228511"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="723228511"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:25 -0700
Message-ID: <b807fa2e-78e4-cb32-cd2b-3a4d90eced08@intel.com>
Date:   Tue, 1 Nov 2022 19:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 07/26] mmc: sdhci: add a kernel configuration for
 enabling UHS-II support
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-8-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-8-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> in the following commits to indicate UHS-II specific code in sdhci
> controllers.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Please merge this patch with:
	[PATCH V5 09/26] mmc: sdhci: add UHS-II module

> ---
>  drivers/mmc/host/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f324daadaf70..7e53cca97934 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>  
>  	  This is the case for the Nintendo Wii SDHCI.
>  
> +config MMC_SDHCI_UHS2
> +	tristate "UHS2 support on SDHCI controller"
> +	depends on MMC_SDHCI
> +	help
> +	  This option is selected by SDHCI controller drivers that want to
> +	  support UHS2-capable devices.
> +
> +	  If you have a controller with this feature, say Y or M here.
> +
>  config MMC_SDHCI_PCI
>  	tristate "SDHCI support on PCI bus"
>  	depends on MMC_SDHCI && PCI

