Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC901668F37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjAMH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbjAMHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:25:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2523B7E3;
        Thu, 12 Jan 2023 23:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673594413; x=1705130413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y3dF78OQd21knEiz3Yhh/QY/Dl2oydckoMmUh4NifSQ=;
  b=lN3g1z0swha2u/3w7jUVIV0eN7JroEzz4rWMEkUnm/vOSdfY/CuFRmnM
   tL1wmpldvMq3W7520/tEYmhL9ZNowRwYTy1LD2XROEyXZxHB+qSpsz6+L
   xXh8vLSRfi/xSGHLL1H0/nkkg9VSZjcwPsv6Q/VX/NYZSetqrZxfcGZcd
   3dvXuctUIOSqxjD34c+G7A7+rgTpPd1jm5rHzKjunmW5xkecJ4ZFIdZO7
   YG8EjUKoGGDSOBQ5BDUZCSGaxia1COpunPO9vVne2hoIABFADkFVt/7Bc
   YtLnYKeht50DwUllXzg0X9Tfkdv4+daSw5f7U3vD5c53QdxXE2oeUjszI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351170039"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="351170039"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 23:20:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690412760"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="690412760"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 23:20:10 -0800
Message-ID: <47bdc4e2-a2d6-12b4-f826-63874c9c0cbb@intel.com>
Date:   Fri, 13 Jan 2023 09:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 2/5] drivers: mmc: sdhci-cadence: enable
 MMC_SDHCI_IO_ACCESSORS
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, jannadurai@marvell.com,
        cchavva@marvell.com
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-3-pmalgujar@marvell.com>
 <35ea0a7a-3d63-26b7-4dc3-69f6ca41909a@intel.com>
 <20230112141230.GB6335@Dell2s-9>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230112141230.GB6335@Dell2s-9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/23 16:12, Piyush Malgujar wrote:
> Hi Adrian, 
> 
> Thank you for the review comments.
> 
> On Wed, Jan 11, 2023 at 10:23:43AM +0200, Adrian Hunter wrote:
>> On 19/12/22 16:24, Piyush Malgujar wrote:
>>> From: Jayanthi Annadurai <jannadurai@marvell.com>
>>>
>>> Add support for CONFIG_MMC_SDHCI_IO_ACCESSORS for controller
>>> specific register read and write APIs.
>>>
>>> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
>>> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
>>> ---
>>>  drivers/mmc/host/Kconfig         | 12 ++++++
>>>  drivers/mmc/host/sdhci-cadence.c | 63 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 75 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 5e19a961c34d7b5664ab2fd43cfba82dc90913ac..b5b2ae0bb4625bdb9d17acdbb1887c9caa3a1f32 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -262,6 +262,18 @@ config MMC_SDHCI_CADENCE
>>>  
>>>  	  If unsure, say N.
>>>  
>>> +config MMC_SDHCI_CN10K
>>> +	tristate "SDHCI Cadence support for Marvell CN10K platforms"
>>> +	select MMC_SDHCI_CADENCE
>>> +	select MMC_SDHCI_IO_ACCESSORS
>>
>> Probably better to just add MMC_SDHCI_IO_ACCESSORS to 
>> config MMC_SDHCI_CADENCE and drop MMC_SDHCI_CN10K
>>
> 
> This reason behind this was to not force SDHCI_IO_ACCESSORS upon cadence users as some may not
> require it owing to how cadence ip is integrated to soc.

In practice, it makes no difference to performance and adds a
negligible amount of code, so it is not worth the extra complexity
to make it conditional.

> 
>>> +	help
>>> +	  This selects the SDHCI cadence driver and IO Accessors
>>> +	  for Marvell CN10K platforms
>>> +
>>> +	  If you have Marvell CN10K platform, say Y or M here.
>>> +
>>> +	  If unsure, say N.
>>> +
>>>  config MMC_SDHCI_CNS3XXX
>>>  	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
>>>  	depends on ARCH_CNS3XXX || COMPILE_TEST
>>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>>> index 5332d19e489be936d6814feba4f0fc046f5e130e..6bf703f15bc5be7e3be4cb1144b78ec3585ec540 100644
>>> --- a/drivers/mmc/host/sdhci-cadence.c
>>> +++ b/drivers/mmc/host/sdhci-cadence.c
>>> @@ -449,6 +449,61 @@ static u32 read_dqs_cmd_delay, clk_wrdqs_delay, clk_wr_delay, read_dqs_delay;
>>>  
>>>  static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host, unsigned int timing);
>>>  
>>> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>> +static u32 sdhci_cdns_sd6_readl(struct sdhci_host *host, int reg)
>>> +{
>>> +	return readl(host->ioaddr + reg);
>>> +}
>>> +
>>> +static void sdhci_cdns_sd6_writel(struct sdhci_host *host, u32 val, int reg)
>>> +{
>>> +	writel(val, host->ioaddr + reg);
>>> +}
>>> +
>>> +static u16 sdhci_cdns_sd6_readw(struct sdhci_host *host, int reg)
>>> +{
>>> +	u32 val, regoff;
>>> +
>>> +	regoff = reg & ~3;
>>> +
>>> +	val = readl(host->ioaddr + regoff);
>>> +	if ((reg & 0x3) == 0)
>>> +		return (val & 0xFFFF);
>>> +	else
>>> +		return ((val >> 16) & 0xFFFF);
>>> +}
>>> +
>>> +static void sdhci_cdns_sd6_writew(struct sdhci_host *host, u16 val, int reg)
>>> +{
>>> +	writew(val, host->ioaddr + reg);
>>> +}
>>> +
>>> +static u8 sdhci_cdns_sd6_readb(struct sdhci_host *host, int reg)
>>> +{
>>> +	u32 val, regoff;
>>> +
>>> +	regoff = reg & ~3;
>>> +
>>> +	val = readl(host->ioaddr + regoff);
>>> +	switch (reg & 3) {
>>> +	case 0:
>>> +		return (val & 0xFF);
>>> +	case 1:
>>> +		return ((val >> 8) & 0xFF);
>>> +	case 2:
>>> +		return ((val >> 16) & 0xFF);
>>> +	case 3:
>>> +		return ((val >> 24) & 0xFF);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static void sdhci_cdns_sd6_writeb(struct sdhci_host *host, u8 val, int reg)
>>> +{
>>> +	writeb(val, host->ioaddr + reg);
>>> +}
>>> +#endif
>>> +
>>>  static int sdhci_cdns_sd6_phy_lock_dll(struct sdhci_cdns_sd6_phy *phy)
>>>  {
>>>  	u32 delay_element = phy->d.delay_element_org;
>>> @@ -1576,6 +1631,14 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>>>  };
>>>  
>>>  static const struct sdhci_ops sdhci_cdns_sd6_ops = {
>>> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>> +	.read_l = sdhci_cdns_sd6_readl,
>>> +	.write_l = sdhci_cdns_sd6_writel,
>>> +	.read_w = sdhci_cdns_sd6_readw,
>>> +	.write_w = sdhci_cdns_sd6_writew,
>>> +	.read_b = sdhci_cdns_sd6_readb,
>>> +	.write_b = sdhci_cdns_sd6_writeb,
>>> +#endif
>>>  	.get_max_clock = sdhci_cdns_get_max_clock,
>>>  	.set_clock = sdhci_cdns_sd6_set_clock,
>>>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>>
> 
> Rest of the comments will be taken care in v2.
> 
> Thanks,
> Piyush

