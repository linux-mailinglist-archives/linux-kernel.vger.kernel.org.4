Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7A6BACE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjCOKA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCOKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F077673AFE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:59:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92025B81DB8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7DEC4339B;
        Wed, 15 Mar 2023 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874361;
        bh=Zt8Fn9RBg9zUIlT1Qoxfcb78d/GvRsgfwThplyX0Sl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3rP+schZnaTP0z6SlDq1AMfSjQOPFtrXWyCDEPa8n1gsgedEbDcoPwyeLby9jKOL
         vVZvl0NeHtLFL6yudfeR07WuK+f78qodhBF1wJK9IwEg7PLfLvl49mZCeD8j2KuNg+
         1c4wrvvGJC0BfImQZAqZ2ItB/tG7Oj4goZMD60L7llGlFIF24wQFDFnsOJ8Mw4SI21
         rQX03h0b3Lcrn8rezHT2kxImgyngXmAmBR0Xgsh9iNNk7m3dGnmbw1Vn+FBB3IxCtc
         ulvypGvOQOtXqdYQUFmH0ox48zNNjfa5rLp5c6A3pQTgd9N1nRIMQIS61OXeIphfwq
         ZeEPa+zLUWX9A==
Date:   Wed, 15 Mar 2023 15:29:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 4/8] soundwire: amd: enable build for AMD SoundWire
 manager driver
Message-ID: <ZBGW9ThXgcT0tIui@matsya>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-5-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307133135.545952-5-Vijendar.Mukunda@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-23, 19:01, Vijendar Mukunda wrote:
> Enable build for SoundWire manager driver for AMD platforms.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Link: https://lore.kernel.org/lkml/20230220100418.76754-5-Vijendar.Mukunda@amd.com
> ---
>  drivers/soundwire/Kconfig  | 10 ++++++++++
>  drivers/soundwire/Makefile |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index 2b7795233282..983afe3570b2 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -46,4 +46,14 @@ config SOUNDWIRE_QCOM
>  config SOUNDWIRE_GENERIC_ALLOCATION
>  	tristate
>  
> +config SOUNDWIRE_AMD
> +	tristate "AMD SoundWire Manager driver"

Alphabetically sorted please

> +	select SOUNDWIRE_GENERIC_ALLOCATION
> +	depends on ACPI && SND_SOC
> +	help
> +	  SoundWire AMD Manager driver.
> +	  If you have an AMD platform which has a SoundWire Manager then
> +	  enable this config option to get the SoundWire support for that
> +	  device.
> +
>  endif
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index ca97414ada70..5956229d3eb3 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -26,3 +26,7 @@ obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
>  #Qualcomm driver
>  soundwire-qcom-y :=	qcom.o
>  obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
> +
> +#AMD driver
> +soundwire-amd-y :=	amd_manager.o
> +obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o

here as well

> -- 
> 2.34.1

-- 
~Vinod
