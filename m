Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA05B87AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiINL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiINL6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:58:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CBC501A6;
        Wed, 14 Sep 2022 04:58:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4CCC36601D9B;
        Wed, 14 Sep 2022 12:58:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663156716;
        bh=shSymtIAxGsCHrnbATpRaFoRfpKmWQ0G2qmKifjEWQ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OI18wQE+hAXB+BPsNMLhS4Fcg4vEbzpxLY8CRUGvYkZvTJaoBhrl4dXnYv0gE5Pvu
         QNQRUikenrDUMNPBAQzn1IG4je905fA2B4PbGiq/TXXcEdcBZyliFcRmF1ODAExZx9
         /8XIb1AGQYWphZG3+GBUBbSkBI2/qRTY3xwoV3i6qCj/iHq+M68KIMyTXHwLrjo96E
         LCNyrFANVNsZvA8uJJ3IKWJNiYtCmqTjHj87LLe5Cb5FA3OFJE0aaRwzS/l4T6qRJu
         L96oOwx7leewIwSEm1pgcUuxb46OafzKoDwwlyZsHlQZEsvmjLPfgywFriphG8jXyi
         OcgcdTp/hpzKw==
Message-ID: <48cb4f47-754c-9994-2489-7ffabfc1b3b9@collabora.com>
Date:   Wed, 14 Sep 2022 13:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9,1/7] thermal: mediatek: Relocate driver to mediatek
 folder
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-2-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220817080757.352021-2-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/08/22 10:07, bchihi@baylibre.com ha scritto:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add MediaTek proprietary folder to upstream more thermal zone and cooler
> drivers, relocate the original thermal controller driver to it, and rename it
> as "auxadc_thermal.c" to show its purpose more clearly.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Co-developed-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   drivers/thermal/Kconfig                       | 14 ++++--------
>   drivers/thermal/Makefile                      |  2 +-
>   drivers/thermal/mediatek/Kconfig              | 22 +++++++++++++++++++
>   drivers/thermal/mediatek/Makefile             |  1 +
>   .../auxadc_thermal.c}                         |  2 +-
>   5 files changed, 29 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/thermal/mediatek/Kconfig
>   create mode 100644 drivers/thermal/mediatek/Makefile
>   rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae614eb..d35f63daca3b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -412,16 +412,10 @@ config DA9062_THERMAL
>   	  zone.
>   	  Compatible with the DA9062 and DA9061 PMICs.
>   
> -config MTK_THERMAL
> -	tristate "Temperature sensor driver for mediatek SoCs"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	depends on NVMEM || NVMEM=n
> -	depends on RESET_CONTROLLER
> -	default y
> -	help
> -	  Enable this option if you want to have support for thermal management
> -	  controller present in Mediatek SoCs
> +menu "Mediatek thermal drivers"
> +depends on ARCH_MEDIATEK || COMPILE_TEST
> +source "drivers/thermal/mediatek/Kconfig"
> +endmenu
>   
>   config AMLOGIC_THERMAL
>   	tristate "Amlogic Thermal Support"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index def8e1a0399c..f7daeb8056c4 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -55,7 +55,7 @@ obj-y				+= st/
>   obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>   obj-y				+= tegra/
>   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> -obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> +obj-y				+= mediatek/
>   obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>   obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> new file mode 100644
> index 000000000000..8ff32370b591
> --- /dev/null
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -0,0 +1,22 @@
> +config MTK_THERMAL
> +	tristate "MediaTek thermal drivers"
> +	depends on THERMAL_OF
> +	help
> +	  This is the option for MediaTek thermal software solutions.
> +	  Please enable corresponding options to get temperature
> +	  information from thermal sensors or turn on throttle
> +	  mechaisms for thermal mitigation.
> +
> +if MTK_THERMAL
> +
> +config MTK_SOC_THERMAL
> +	tristate "AUXADC temperature sensor driver for MediaTek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM

That's not true. This driver doesn't depend on NVMEM, as in function
mtk_thermal_get_calibration_data(), the calibration params are initialized
with default values and if no "calibration-data" cell was found, it will
return 0 and simply go on with probing... and this is because not all SoCs
need calibration data from eFuses.
If you check carefully, the original entry says "NVMEM || NVMEM=n".

Please drop the NVMEM dependency from this config entirely.

> +	depends on RESET_CONTROLLER

While at it, can you please also drop the dependency for RESET_CONTROLLER?
I know it was present on the original config entry, but that's wrong, as
the driver doesn't strictly require resets, as it uses device_reset_optional().


Regards,
Angelo

