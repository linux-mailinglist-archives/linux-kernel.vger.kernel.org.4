Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BEF72F715
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjFNH5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjFNH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:57:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E336E4;
        Wed, 14 Jun 2023 00:57:08 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3884E6601F25;
        Wed, 14 Jun 2023 08:57:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686729427;
        bh=6ySxmPCc6AxO/C5yZ5OIgfP5VTP41Tr+ut5Qsh5zXeI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=nB/IrrlGZORnLI47DXowLHS3S2oicW/iPPMAItzzwlYN3rOaJWJV170v5KqMJrN95
         zmBrokvx/KtvbJGx4hg6hSf62+MZW/1CaMPxYZ7Jz/Z61wq5v8/SHR6y1K3cua+Yyx
         ijdp40IEnC3eLT5PYS+9LL/AFFkk7MEsubJTqVwQo3Kgb8XIYfkPYBWTUiT8wIMAr4
         MWRVqcykE7RJWg6T+Z/WorV79lzukfT3Gkp7YtjLahmvQCGAkOwafQf1aURYHtff4S
         m0a7lmPUBeNDrOeQbpTtqVgnnSe27n9oIfbjz2AkK5peHPOR15slACaBJCduuEXPkn
         UgsADVM09ceEg==
Message-ID: <1135e329-4d4c-5977-0cc4-932702951b5d@collabora.com>
Date:   Wed, 14 Jun 2023 09:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/7] ASoC: mediatek: mt79xx: add platform driver
Content-Language: en-US
To:     Maso Hunag <maso.huang@mediatek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230612105250.15441-1-maso.huang@mediatek.com>
 <20230612105250.15441-4-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230612105250.15441-4-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/06/23 12:52, Maso Hunag ha scritto:
> From: Maso Huang <maso.huang@mediatek.com>
> 
> Add mt79xx platform driver.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                 |  10 +
>   sound/soc/mediatek/Makefile                |   1 +
>   sound/soc/mediatek/mt79xx/Makefile         |   9 +
>   sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c | 608 +++++++++++++++++++++
>   4 files changed, 628 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt79xx/Makefile
>   create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c
> 

..snip..

> diff --git a/sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c b/sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c
> new file mode 100644
> index 000000000000..69c5f3f3f84b
> --- /dev/null
> +++ b/sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek ALSA SoC AFE platform driver for MT79xx
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Vic Wu <vic.wu@mediatek.com>
> + *         Maso Huang <maso.huang@mediatek.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "mt79xx-afe-common.h"
> +#include "mt79xx-afe-clk.h"
> +#include "mt79xx-reg.h"
> +#include "../common/mtk-afe-platform-driver.h"
> +#include "../common/mtk-afe-fe-dai.h"
> +
> +enum {
> +	MTK_AFE_RATE_8K = 0,
> +	MTK_AFE_RATE_11K = 1,
> +	MTK_AFE_RATE_12K = 2,
> +	MTK_AFE_RATE_16K = 4,
> +	MTK_AFE_RATE_22K = 5,
> +	MTK_AFE_RATE_24K = 6,
> +	MTK_AFE_RATE_32K = 8,
> +	MTK_AFE_RATE_44K = 9,
> +	MTK_AFE_RATE_48K = 10,
> +	MTK_AFE_RATE_88K = 13,
> +	MTK_AFE_RATE_96K = 14,
> +	MTK_AFE_RATE_176K = 17,
> +	MTK_AFE_RATE_192K = 18,
> +};
> +
> +unsigned int mt79xx_afe_rate_transform(struct device *dev,
> +				       unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:
> +		return MTK_AFE_RATE_8K;
> +	case 11025:
> +		return MTK_AFE_RATE_11K;
> +	case 12000:
> +		return MTK_AFE_RATE_12K;
> +	case 16000:
> +		return MTK_AFE_RATE_16K;
> +	case 22050:
> +		return MTK_AFE_RATE_22K;
> +	case 24000:
> +		return MTK_AFE_RATE_24K;
> +	case 32000:
> +		return MTK_AFE_RATE_32K;
> +	case 44100:
> +		return MTK_AFE_RATE_44K;
> +	case 48000:
> +		return MTK_AFE_RATE_48K;
> +	case 88200:
> +		return MTK_AFE_RATE_88K;
> +	case 96000:
> +		return MTK_AFE_RATE_96K;
> +	case 176400:
> +		return MTK_AFE_RATE_176K;
> +	case 192000:
> +		return MTK_AFE_RATE_192K;
> +	default:
> +		dev_warn(dev, "%s(), rate %u invalid, use %d!!!\n",
> +			 __func__, rate, MTK_AFE_RATE_48K);
> +		return MTK_AFE_RATE_48K;
> +	}
> +}
> +
> +static const struct snd_pcm_hardware mt79xx_afe_hardware = {
> +	.info = SNDRV_PCM_INFO_MMAP |
> +		SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_MMAP_VALID,
> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +		   SNDRV_PCM_FMTBIT_S24_LE |
> +		   SNDRV_PCM_FMTBIT_S32_LE,
> +	.period_bytes_min = 256,
> +	.period_bytes_max = 4 * 48 * 1024,
> +	.periods_min = 2,
> +	.periods_max = 256,
> +	.buffer_bytes_max = 8 * 48 * 1024,
> +	.fifo_size = 0,
> +};
> +
> +static int mt79xx_memif_fs(struct snd_pcm_substream *substream,
> +			   unsigned int rate)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_component *component =
> +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);

Fits in one line.

> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
> +
> +	return mt79xx_afe_rate_transform(afe->dev, rate);
> +}
> +
> +static int mt79xx_irq_fs(struct snd_pcm_substream *substream,
> +			 unsigned int rate)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_component *component =
> +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);

Fits in one line.

> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
> +
> +	return mt79xx_afe_rate_transform(afe->dev, rate);
> +}
> +

..snip..

> +
> +static irqreturn_t mt79xx_afe_irq_handler(int irq_id, void *dev)
> +{
> +	struct mtk_base_afe *afe = dev;
> +	struct mtk_base_afe_irq *irq;
> +	unsigned int status;
> +	unsigned int status_mcu;
> +	unsigned int mcu_en;

u32 mcu_en, status, status_mcu;
int i, ret;
irqreturn_t irq_ret = IRQ_HANDLED;

> +	int ret;
> +	int i;
> +	irqreturn_t irq_ret = IRQ_HANDLED;



> +
> +	/* get irq that is sent to MCU */
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);
> +
> +	ret = regmap_read(afe->regmap, AFE_IRQ_MCU_STATUS, &status);
> +	/* only care IRQ which is sent to MCU */
> +	status_mcu = status & mcu_en & AFE_IRQ_STATUS_BITS;
> +
> +	if (ret || status_mcu == 0) {
> +		dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x,
> +			mcu_en 0x%x\n", __func__, ret, status, mcu_en);
> +
> +		irq_ret = IRQ_NONE;
> +		goto err_irq;
> +	}
> +
> +	for (i = 0; i < MT79XX_MEMIF_NUM; i++) {
> +		struct mtk_base_afe_memif *memif = &afe->memif[i];
> +
> +		if (!memif->substream)
> +			continue;
> +
> +		if (memif->irq_usage < 0)
> +			continue;
> +
> +		irq = &afe->irqs[memif->irq_usage];
> +
> +		if (status_mcu & (1 << irq->irq_data->irq_en_shift))
> +			snd_pcm_period_elapsed(memif->substream);
> +	}
> +
> +err_irq:
> +	/* clear irq */
> +	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, status_mcu);
> +
> +	return irq_ret;
> +}
> +
> +static int mt79xx_afe_runtime_suspend(struct device *dev)
> +{
> +	struct mtk_base_afe *afe = dev_get_drvdata(dev);
> +	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
> +
> +	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> +		goto skip_regmap;
> +
> +	/* disable clk*/
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4, 0x3fff, 0x3fff);
> +	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_APLL2_EN_MASK,
> +			   0);
> +	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_26M_EN_MASK,
> +			   0);

Each regmap_update_bits() call fits in one line.

> +
> +	/* make sure all irq status are cleared, twice intended */
> +	regmap_update_bits(afe->regmap, AFE_IRQ_MCU_CLR, 0xffff, 0xffff);
> +
> +skip_regmap:
> +	return mt79xx_afe_disable_clock(afe);
> +}
> +
> +static int mt79xx_afe_runtime_resume(struct device *dev)
> +{
> +	struct mtk_base_afe *afe = dev_get_drvdata(dev);
> +	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
> +	int ret;
> +
> +	ret = mt79xx_afe_enable_clock(afe);
> +	if (ret)
> +		return ret;
> +
> +	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> +		goto skip_regmap;

Just return 0 here instead of jumping.

> +
> +	/* enable clk*/
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4, 0x3fff, 0);
> +	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_APLL2_EN_MASK,
> +			   AUD_APLL2_EN);
> +	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_26M_EN_MASK,
> +			   AUD_26M_EN);
> +
> +skip_regmap:
> +	return 0;
> +}
> +
> +static int mt79xx_afe_component_probe(struct snd_soc_component *component)
> +{
> +	return mtk_afe_add_sub_dai_control(component);
> +}
> +
> +static const struct snd_soc_component_driver mt79xx_afe_component = {
> +	.name = AFE_PCM_NAME,
> +	.probe = mt79xx_afe_component_probe,
> +	.pointer	= mtk_afe_pcm_pointer,
> +	.pcm_construct	= mtk_afe_pcm_new,
> +};
> +
> +static int mt79xx_dai_memif_register(struct mtk_base_afe *afe)
> +{
> +	struct mtk_base_afe_dai *dai;
> +
> +	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
> +	if (!dai)
> +		return -ENOMEM;
> +
> +	list_add(&dai->list, &afe->sub_dais);
> +
> +	dai->dai_drivers = mt79xx_memif_dai_driver;
> +	dai->num_dai_drivers = ARRAY_SIZE(mt79xx_memif_dai_driver);
> +
> +	dai->dapm_widgets = mt79xx_memif_widgets;
> +	dai->num_dapm_widgets = ARRAY_SIZE(mt79xx_memif_widgets);
> +	dai->dapm_routes = mt79xx_memif_routes;
> +	dai->num_dapm_routes = ARRAY_SIZE(mt79xx_memif_routes);
> +
> +	return 0;
> +}
> +
> +typedef int (*dai_register_cb)(struct mtk_base_afe *);
> +static const dai_register_cb dai_register_cbs[] = {
> +	mt79xx_dai_etdm_register,
> +	mt79xx_dai_memif_register,
> +};
> +
> +static int mt79xx_afe_pcm_dev_probe(struct platform_device *pdev)
> +{
> +	struct mtk_base_afe *afe;
> +	struct mt79xx_afe_private *afe_priv;
> +	struct device *dev;
> +	int i, irq_id, ret;
> +
> +	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
> +	if (!afe)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, afe);
> +
> +	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
> +					  GFP_KERNEL);
> +	if (!afe->platform_priv)
> +		return -ENOMEM;
> +
> +	afe_priv = afe->platform_priv;
> +	afe->dev = &pdev->dev;
> +	dev = afe->dev;
> +
> +	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(afe->base_addr))
> +		return PTR_ERR(afe->base_addr);
> +
> +	/* initial audio related clock */
> +	ret = mt79xx_init_clock(afe);
> +	if (ret) {
> +		dev_err(dev, "init clock error\n");
> +		return ret;

return dev_err_probe(dev, ret, "Cannot initialize clocks\n");

> +	}
> +
> +	pm_runtime_enable(dev);

ret = devm_pm_runtime_enable(dev);
if (ret)
	return ret;

> +
> +	/* enable clock for regcache get default value from hw */
> +	afe_priv->pm_runtime_bypass_reg_ctl = true;
> +	pm_runtime_get_sync(&pdev->dev);
> +
> +	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
> +		      &mt79xx_afe_regmap_config);
> +	if (IS_ERR(afe->regmap)) {
> +		ret = PTR_ERR(afe->regmap);
> +		goto err_pm_disable;
> +	}
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	afe_priv->pm_runtime_bypass_reg_ctl = false;
> +
> +	/* init memif */
> +	afe->memif_size = MT79XX_MEMIF_NUM;
> +	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
> +				  GFP_KERNEL);
> +	if (!afe->memif)
> +		goto err_pm_disable;
> +
> +	for (i = 0; i < afe->memif_size; i++) {
> +		afe->memif[i].data = &memif_data[i];
> +		afe->memif[i].irq_usage = -1;
> +	}
> +
> +	mutex_init(&afe->irq_alloc_lock);
> +
> +	/* irq initialize */
> +	afe->irqs_size = MT79XX_IRQ_NUM;
> +	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
> +				 GFP_KERNEL);
> +	if (!afe->irqs)
> +		goto err_pm_disable;
> +
> +	for (i = 0; i < afe->irqs_size; i++)
> +		afe->irqs[i].irq_data = &irq_data[i];
> +
> +	/* request irq */
> +	irq_id = platform_get_irq(pdev, 0);
> +	if (!irq_id) {
> +		dev_err(dev, "%pOFn no irq found\n", dev->of_node);

You're not setting any `ret` value to return an error: this will return 0!!!


> +		goto err_pm_disable;
> +	}
> +	ret = devm_request_irq(dev, irq_id, mt79xx_afe_irq_handler,
> +			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
> +	if (ret) {
> +		dev_err(dev, "could not request_irq for asys-isr\n");
> +		goto err_pm_disable;
> +	}
> +
> +	/* init sub_dais */
> +	INIT_LIST_HEAD(&afe->sub_dais);
> +
> +	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
> +		ret = dai_register_cbs[i](afe);
> +		if (ret) {
> +			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
> +				 i, ret);

Please change this dev_warn() to dev_err().

> +			goto err_pm_disable;
> +		}
> +	}
> +
> +	/* init dai_driver and component_driver */
> +	ret = mtk_afe_combine_sub_dai(afe);
> +	if (ret) {
> +		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
> +			 ret);

dev_err()

> +		goto err_pm_disable;
> +	}
> +
> +	afe->mtk_afe_hardware = &mt79xx_afe_hardware;
> +	afe->memif_fs = mt79xx_memif_fs;
> +	afe->irq_fs = mt79xx_irq_fs;
> +
> +	afe->runtime_resume = mt79xx_afe_runtime_resume;
> +	afe->runtime_suspend = mt79xx_afe_runtime_suspend;
> +
> +	/* register component */
> +	ret = devm_snd_soc_register_component(&pdev->dev,
> +					      &mt79xx_afe_component,
> +					      NULL, 0);
> +	if (ret) {
> +		dev_warn(dev, "err_platform\n");
> +		goto err_pm_disable;
> +	}
> +
> +	ret = devm_snd_soc_register_component(afe->dev,
> +					      &mt79xx_afe_pcm_dai_component,
> +					      afe->dai_drivers,
> +					      afe->num_dai_drivers);
> +	if (ret) {
> +		dev_warn(dev, "err_dai_component\n");
> +		goto err_pm_disable;
> +	}
> +
> +	return ret;
> +
> +err_pm_disable:
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	return ret;
> +}
> +
> +static int mt79xx_afe_pcm_dev_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		mt79xx_afe_runtime_suspend(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt79xx_afe_pcm_dt_match[] = {
> +	{ .compatible = "mediatek,mt79xx-afe", },
> +	{},

Last entry is always { /* sentinel */ }

> +};
> +MODULE_DEVICE_TABLE(of, mt79xx_afe_pcm_dt_match);
> +
> +static const struct dev_pm_ops mt79xx_afe_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mt79xx_afe_runtime_suspend,
> +			   mt79xx_afe_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver mt79xx_afe_pcm_driver = {
> +	.driver = {
> +		   .name = "mt79xx-audio",
> +		   .of_match_table = mt79xx_afe_pcm_dt_match,
> +		   .pm = &mt79xx_afe_pm_ops,
> +	},
> +	.probe = mt79xx_afe_pcm_dev_probe,
> +	.remove = mt79xx_afe_pcm_dev_remove,
> +};
> +

Remove this extra blank line.

> +module_platform_driver(mt79xx_afe_pcm_driver);
> +
> +MODULE_DESCRIPTION("Mediatek SoC AFE platform driver for ALSA MT79xx");
> +MODULE_AUTHOR("Vic Wu <vic.wu@mediatek.com>");
> +MODULE_LICENSE("GPL");

Thanks,
Angelo

