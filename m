Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6C746CF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGDJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGDJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:13:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD739B1;
        Tue,  4 Jul 2023 02:13:25 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64A046606F97;
        Tue,  4 Jul 2023 10:13:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688462004;
        bh=+UQ3wJ7CsnBFYk8FxVMfEoCs8C7XLAIRsUVYc1Mm22w=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=E/AxA8JE41PCtF5GjxclcVxesQ4YexgIMo4X6onAErZ8smkNVVqEbLRUdzinos12M
         g/rkKhPWvRoHRA9n5WApg3bBQS7SToRtw2C4o6ZXrk6S6Z32/s9QrvOSwuR4tzvS6J
         mz1EPIrlIw3HbGzqL7cAZvYqE7/CiZY586WJE16pvjzfcZM0H+cG3rXYuXaYVX5tUj
         yO5xm6bs4QCDW/PmAkM088FI6XLKFX1izK5Vveguzq7X/iPqZpgwF+LLR1VLpSmsoc
         jPUYDHoy6SX9ttmfIr4gQqFV92tOZbj6sQvI+q4sNr3jrv7so6qXR9j0UYbINBEUU3
         J2lwDPpI9K4RA==
Message-ID: <d5c0ea7a-e38b-b078-4664-dd451d4e3396@collabora.com>
Date:   Tue, 4 Jul 2023 11:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/7] ASoC: mediatek: mt7986: add platform driver
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230626023501.11120-1-maso.huang@mediatek.com>
 <20230626023501.11120-5-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230626023501.11120-5-maso.huang@mediatek.com>
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

Il 26/06/23 04:34, Maso Huang ha scritto:
> Add mt7986 platform driver.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                 |  10 +
>   sound/soc/mediatek/Makefile                |   1 +
>   sound/soc/mediatek/mt7986/Makefile         |   9 +
>   sound/soc/mediatek/mt7986/mt7986-afe-pcm.c | 598 +++++++++++++++++++++
>   4 files changed, 618 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt7986/Makefile
>   create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
> 

..snip..

> diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
> new file mode 100644
> index 000000000000..9eef21762e93
> --- /dev/null
> +++ b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek ALSA SoC AFE platform driver for MT7986
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
> +#include "mt7986-afe-common.h"
> +#include "mt7986-afe-clk.h"
> +#include "mt7986-reg.h"
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
> +unsigned int mt7986_afe_rate_transform(struct device *dev,
> +				       unsigned int rate)

Fits in one line.

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

s/use/using/g

> +			 __func__, rate, MTK_AFE_RATE_48K);
> +		return MTK_AFE_RATE_48K;
> +	}
> +}
> +

..snip..

> +
> +static bool mt7986_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/* these auto-gen reg has read-only bit, so put it as volatile */
> +	/* volatile reg cannot be cached, so cannot be set when power off */

Fix the comment format please; for multi-line comments, you want:

	/*
	 * Those auto-gen regs are read-only, so put it a volatile because
	 * volatile registers cannot be cached, which means that they cannot
	 * be set when power is off
	 */


> +	switch (reg) {
> +	case AFE_DL0_CUR_MSB:
> +	case AFE_DL0_CUR:
> +	case AFE_DL0_RCH_MON:
> +	case AFE_DL0_LCH_MON:
> +	case AFE_VUL0_CUR_MSB:
> +	case AFE_VUL0_CUR:
> +	case AFE_IRQ_MCU_STATUS:
> +	case AFE_MEMIF_RD_MON:
> +	case AFE_MEMIF_WR_MON:
> +		return true;
> +	default:
> +		return false;
> +	};
> +}
> +

..snip..

> +
> +static int mt7986_afe_pcm_dev_probe(struct platform_device *pdev)
> +{
> +	struct mtk_base_afe *afe;
> +	struct mt7986_afe_private *afe_priv;
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
> +	ret = mt7986_init_clock(afe);

As said in the review for patch [2/7], function mt7986_init_clock() must be moved
in this file instead.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot initialize clocks\n");
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* enable clock for regcache get default value from hw */
> +	afe_priv->pm_runtime_bypass_reg_ctl = true;
> +	pm_runtime_get_sync(&pdev->dev);
> +
> +	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
> +		      &mt7986_afe_regmap_config);

	pm_runtime_put_sync(&pdev->dev);
	if (IS_ERR(afe->regmap))
		return PTR_ERR(afe->regmap);

	afe_prov->pm_runtime_bypass_reg_ctl = false;

that's better :-)

> +	if (IS_ERR(afe->regmap)) {
> +		ret = PTR_ERR(afe->regmap);
> +		goto err_pm_disable;
> +	}
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	afe_priv->pm_runtime_bypass_reg_ctl = false;
> +
> +	/* init memif */
> +	afe->memif_size = MT7986_MEMIF_NUM;
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
> +	afe->irqs_size = MT7986_IRQ_NUM;
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
> +	if (irq_id < 0) {
> +		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
> +		ret = irq_id;
> +		goto err_pm_disable;

You can just return... and please use dev_err_probe().

> +	}
> +	ret = devm_request_irq(dev, irq_id, mt7986_afe_irq_handler,
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
> +			dev_err(afe->dev, "dai register i %d fail, ret %d\n",
> +				 i, ret);
> +			goto err_pm_disable;
> +		}
> +	}
> +
> +	/* init dai_driver and component_driver */
> +	ret = mtk_afe_combine_sub_dai(afe);
> +	if (ret) {
> +		dev_err(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
> +			 ret);
> +		goto err_pm_disable;
> +	}
> +
> +	afe->mtk_afe_hardware = &mt7986_afe_hardware;
> +	afe->memif_fs = mt7986_memif_fs;
> +	afe->irq_fs = mt7986_irq_fs;
> +
> +	afe->runtime_resume = mt7986_afe_runtime_resume;
> +	afe->runtime_suspend = mt7986_afe_runtime_suspend;
> +
> +	/* register component */
> +	ret = devm_snd_soc_register_component(&pdev->dev,
> +					      &mt7986_afe_component,
> +					      NULL, 0);
> +	if (ret) {
> +		dev_warn(dev, "err_platform\n");

That shall not be a dev_warn, but a dev_err() instead, but then, being this
a probe function and not needing that jump, it's dev_err_probe().

> +		goto err_pm_disable;
> +	}
> +
> +	ret = devm_snd_soc_register_component(afe->dev,
> +					      &mt7986_afe_pcm_dai_component,
> +					      afe->dai_drivers,
> +					      afe->num_dai_drivers);
> +	if (ret) {
> +		dev_warn(dev, "err_dai_component\n");

Same here.

> +		goto err_pm_disable;
> +	}
> +
> +	return ret;
> +
> +err_pm_disable:

You don't need this label because you're now using devm_pm_runtime_enable() and,
following my advice from some lines up, pm_runtime_put_sync() is called at the
right time already.

This means that you can simplify this function a lot with directly returning the
error in error paths (including instances of dev_err_probe() ).

> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	return ret;
> +}
> +
> +static void mt7986_afe_pcm_dev_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		mt7986_afe_runtime_suspend(&pdev->dev);
> +}
> +
> +static const struct of_device_id mt7986_afe_pcm_dt_match[] = {
> +	{ .compatible = "mediatek,mt7986-afe", },

You don't need the comma here               ^^
so this is just

	{ .compatible = "mediatek,mt7986-afe" },

Everything else looks fine.

Regards,
Angelo
