Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3547B72F657
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjFNHa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjFNHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:30:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBD1B2;
        Wed, 14 Jun 2023 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686727823; x=1718263823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HjFJBYBcJYWA5zv1dT/4g5HXReVbrB41cEEH1MD9Xw8=;
  b=UCnoMT5nOJuMfIgV1NieeP4Wx6iC70x4dwTawfLwJy/zKlveMWuisEIL
   ASeq4QXwYpPKoxY74hH6kgIjD8JujdjJWYjdK2HDP8Q3gfGJkEwaos5dX
   brCur92Hnkdj+OvK86siUuOM8+Zw+0MkQATjm93f81CAWdQd126095xOn
   Yqzn4y1d0lOs1C6fyejRCV9q5kg1borVTWv9M0oPI+jREVvH5Fy9Pk6aA
   2G05x+S4AMqQMV3FwPSafDMxN24/h83PoHMvzFGNww194CdDwC/B07eos
   owH2djD4hjNHlza9FiDAHMlHFa9cLn+jskdn1nJhGbxAw9VZbueHecd2j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338177154"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="338177154"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 00:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="689301637"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="689301637"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 00:30:05 -0700
Message-ID: <21237298-fbb3-7fa6-0ea5-15bf3eab61b7@intel.com>
Date:   Wed, 14 Jun 2023 10:30:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH V1 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support
Content-Language: en-US
To:     Chevron Li <chevron_li@126.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, chevron.li@bayhubtech.com
References: <20230607014812.30104-1-chevron_li@126.com>
 <20230607014812.30104-2-chevron_li@126.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230607014812.30104-2-chevron_li@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/06/23 04:48, Chevron Li wrote:
> From: Chevron Li <chevron.li@bayhubtech.com>
> 
> Add Bayhub new chip GG8 support for SD express card.
> This patch depends on patch 1/2.

Patch subject should be different from patch 1

> 
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>

Some comments below.

> ---
> Change in V1:
> 1.Implement the SD express card callback routine.
> 2.Add SD express card support for Bayhub GG8 chip.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 61 +++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 8243a63b3c81..b2d8ddbb4095 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -21,6 +21,7 @@
>   * O2Micro device registers
>   */
>  
> +#define O2_SD_PCIE_SWITCH	0x54
>  #define O2_SD_MISC_REG5		0x64
>  #define O2_SD_LD0_CTRL		0x68
>  #define O2_SD_DEV_CTRL		0x88
> @@ -631,6 +632,63 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_o2_enable_clk(host, clk);
>  }
>  
> +static u8 sdhci_o2_sd_express_clkq_assert(struct sdhci_host *host)
> +{
> +	return sdhci_readb(host, O2_SD_EXP_INT_REG);
> +}
> +
> +static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct sdhci_pci_chip *chip = slot->chip;
> +	u8 scratch8 = 0;
> +	u16 scratch16 = 0;
> +	bool ret = false;

ret should be an int and does not need to be initialized.

> +
> +	/* Disable clock */
> +	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	/* Set VDD2 voltage*/
> +	scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +	scratch8 &= 0x0F;
> +	if ((host->mmc->ios.timing == MMC_TIMING_SD_EXP_1_2V) &&
> +		(host->mmc->caps2 & MMC_CAP2_SD_EXP_1_2V)) {

Unnecessary parentheses

> +		scratch8 |= BIT(4) | BIT(7);
> +	} else

braces {} should be used on all arms of this statement

Have a look at the output of checkpatch.pl --strict

There are "Alignment should match open parenthesis"
messages also

> +		scratch8 |= BIT(4) | BIT(5) | BIT(7);

Please use SDHCI_VDD2_POWER_ON, SDHCI_VDD2_POWER_120, SDHCI_VDD2_POWER_180


> +	sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
> +
> +	/* UnLock WP */
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
> +	scratch8 &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
> +
> +	ret = readx_poll_timeout(sdhci_o2_sd_express_clkq_assert, host,
> +		scratch8, !(scratch8 & BIT(0)), 1, 30000) == 0 ? 0 : 1;

This can use read_poll_timeout() then sdhci_o2_sd_express_clkq_assert()
is not needed.  And the ' == 0 ? 0 : 1' does not seem needed.

> +
> +	if (!ret) {
> +		/* switch to PCIe mode */
> +		scratch16 = sdhci_readw(host, O2_SD_PCIE_SWITCH);
> +		scratch16 |= BIT(8);
> +		sdhci_writew(host, scratch16, O2_SD_PCIE_SWITCH);
> +	} else {
> +		/* keep mode as USHI */

USHI ?

Do you intend to fall back to SD mode here? Because
returning non-zero will cause the initialization to
fail.  To continue to initialize SD mode, it looks
like you need to change host->ios.timing = MMC_TIMING_LEGACY
and return 0

> +		pci_read_config_word(chip->pdev,
> +						O2_SD_PARA_SET_REG1, &scratch16);

Unneeded line break

> +		scratch16 &= ~BIT(11);
> +		pci_write_config_word(chip->pdev,
> +						O2_SD_PARA_SET_REG1, scratch16);

Unneeded line break

> +	}
> +	/* Lock WP */
> +	pci_read_config_byte(chip->pdev,
> +					O2_SD_LOCK_WP, &scratch8);
> +	scratch8 |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
> +
> +	return ret;
> +}
> +
>  static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
> @@ -703,10 +761,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  	case PCI_DEVICE_ID_O2_GG8_9861:
>  	case PCI_DEVICE_ID_O2_GG8_9862:
>  	case PCI_DEVICE_ID_O2_GG8_9863:
> -		host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +		host->mmc->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
>  		host->mmc->caps |= MMC_CAP_HW_RESET;
>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>  		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
> +		host->mmc_host_ops.init_sd_express = sdhci_pci_o2_init_sd_express;
>  		break;
>  	default:
>  		break;

