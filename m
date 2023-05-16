Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35070527E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjEPPoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjEPPn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:43:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B01989
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684251836; x=1715787836;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FTnmhbzvHNs6LvKEIpBUOQXPObXKmLKsrl6rnqnEWkY=;
  b=PAOgYjiz2nacTq8MTHVV8ShzkSzS967nASbvgKKHKp57tu5KOA3QuTm6
   j5ed09hbwv0ocT0obTrZbiq8j95jHZeA8pmqk63LvPz57OpiKGRR1U313
   SLEQCjnE+mXi5hzAzcINiidshMqirUCuq1ouxjrXPHvQpCyBMBTDIpDFp
   n1N4T1aLCSau5zaNnov19MJF9Ui3ppo0CGe6zKxxgKf2m2WbZnkCTXHR5
   9nOq+c1wvq6hZNut3ELXoJt3/syKseihKOrQpvqZ3fA+7+UaTt1Qp+FM3
   xTwR4IJypFA7j93nloRBW8pAl3IN9/VdmG+Fv7v7ZcJ5z9KAeeh3W1q2E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379694343"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379694343"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="701391902"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="701391902"
Received: from aboonloe-mobl.amr.corp.intel.com (HELO [10.212.186.99]) ([10.212.186.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:43:42 -0700
Message-ID: <b8ad1f03-686a-7f2f-baea-b63b12c19df9@linux.intel.com>
Date:   Tue, 16 May 2023 09:40:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 3/9] ASoC: amd: ps: add soundwire dma driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        --to=broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
 <20230516103543.2515097-4-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230516103543.2515097-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/23 05:35, Vijendar Mukunda wrote:
> Soundwire DMA platform driver binds to the platform device created by
> ACP PCI device. Soundwire DMA driver registers ALSA DMA component
> with ASoC framework.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h      |  5 +++
>  sound/soc/amd/ps/ps-sdw-dma.c | 71 +++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index faf7be4d77c2..f86c60cd1565 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -111,6 +111,11 @@ struct pdm_dev_data {
>  	struct snd_pcm_substream *capture_stream;
>  };
>  
> +struct sdw_dma_dev_data {
> +	void __iomem *acp_base;
> +	struct mutex *acp_lock; /* used to protect acp common register access */
> +};
> +
>  /**
>   * struct acp63_dev_data - acp pci driver context
>   * @acp63_base: acp mmio base
> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
> new file mode 100644
> index 000000000000..0d0889842413
> --- /dev/null
> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AMD ALSA SoC Pink Sardine Soundwire DMA Driver
> + *
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +#include "acp63.h"
> +
> +#define DRV_NAME "amd_ps_sdw_dma"
> +
> +static const struct snd_soc_component_driver acp63_sdw_component = {
> +	.name		= DRV_NAME,
> +};
> +
> +static int acp63_sdw_platform_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct sdw_dma_dev_data *sdw_data;
> +	int status;
> +
> +	if (!pdev->dev.platform_data) {
> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
> +		return -ENODEV;
> +	}
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +		return -ENODEV;
> +	}
> +
> +	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
> +	if (!sdw_data)
> +		return -ENOMEM;
> +
> +	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!sdw_data->acp_base)
> +		return -ENOMEM;
> +
> +	sdw_data->acp_lock = pdev->dev.platform_data;
> +	dev_set_drvdata(&pdev->dev, sdw_data);
> +	status = devm_snd_soc_register_component(&pdev->dev,
> +						 &acp63_sdw_component,
> +						 NULL, 0);
> +	if (status) {
> +		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
> +		return -ENODEV;

return status;

> +	}
> +	return 0;
> +}
> +
> +static struct platform_driver acp63_sdw_dma_driver = {
> +	.probe = acp63_sdw_platform_probe,
> +	.driver = {
> +		.name = "amd_ps_sdw_dma",
> +	},
> +};
> +
> +module_platform_driver(acp63_sdw_dma_driver);
> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_DESCRIPTION("AMD ACP6.3 PS SDW DMA Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRV_NAME);
