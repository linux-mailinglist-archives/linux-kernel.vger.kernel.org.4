Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8943570F085
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbjEXIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbjEXIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:20:39 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04051A8;
        Wed, 24 May 2023 01:20:25 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1A6BA24DBE9;
        Wed, 24 May 2023 16:20:23 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 24 May
 2023 16:20:22 +0800
Received: from [192.168.125.124] (183.27.98.143) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 24 May
 2023 16:20:22 +0800
Message-ID: <9591b19f-c8f5-7478-08ad-3b781714eea6@starfivetech.com>
Date:   Wed, 24 May 2023 16:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/3] ASoC: starfive: Add JH7110 TDM driver
To:     <Claudiu.Beznea@microchip.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>, <emil.renner.berthing@canonical.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
 <20230511091549.28003-3-walker.chen@starfivetech.com>
 <89c0eb5e-81c7-ea0e-8dd9-9e08ee0c7d1d@microchip.com>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <89c0eb5e-81c7-ea0e-8dd9-9e08ee0c7d1d@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.143]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/5/17 16:35, Claudiu.Beznea@microchip.com wrote:
> On 11.05.2023 12:15, Walker Chen wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> Add tdm driver support for the StarFive JH7110 SoC.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  MAINTAINERS                     |   6 +
>>  sound/soc/Kconfig               |   1 +
>>  sound/soc/Makefile              |   1 +
>>  sound/soc/starfive/Kconfig      |  15 +
>>  sound/soc/starfive/Makefile     |   2 +
>>  sound/soc/starfive/jh7110_tdm.c | 554 ++++++++++++++++++++++++++++++++
>>  sound/soc/starfive/jh7110_tdm.h | 138 ++++++++
>>  7 files changed, 717 insertions(+)
>>  create mode 100644 sound/soc/starfive/Kconfig
>>  create mode 100644 sound/soc/starfive/Makefile
>>  create mode 100644 sound/soc/starfive/jh7110_tdm.c
>>  create mode 100644 sound/soc/starfive/jh7110_tdm.h
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5f9c544bc189..add89615d327 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19945,6 +19945,12 @@ F:     Documentation/devicetree/bindings/power/starfive*
>>  F:     drivers/soc/starfive/jh71xx_pmu.c
>>  F:     include/dt-bindings/power/starfive,jh7110-pmu.h
>> 
>> +STARFIVE JH7110 TDM DRIVERS
>> +M:     Walker Chen <walker.chen@starfivetech.com>
>> +S:     Maintained
>> +F:     Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
>> +F:     sound/soc/starfive/jh7110-tdm.*
>> +
>>  STARFIVE SOC DRIVERS
>>  M:     Conor Dooley <conor@kernel.org>
>>  S:     Maintained
>> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
>> index 848fbae26c3b..8d1d9401ecf2 100644
>> --- a/sound/soc/Kconfig
>> +++ b/sound/soc/Kconfig
>> @@ -91,6 +91,7 @@ source "sound/soc/sh/Kconfig"
>>  source "sound/soc/sof/Kconfig"
>>  source "sound/soc/spear/Kconfig"
>>  source "sound/soc/sprd/Kconfig"
>> +source "sound/soc/starfive/Kconfig"
>>  source "sound/soc/sti/Kconfig"
>>  source "sound/soc/stm/Kconfig"
>>  source "sound/soc/sunxi/Kconfig"
>> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
>> index 507eaed1d6a1..65aeb4ef4068 100644
>> --- a/sound/soc/Makefile
>> +++ b/sound/soc/Makefile
>> @@ -59,6 +59,7 @@ obj-$(CONFIG_SND_SOC) += sh/
>>  obj-$(CONFIG_SND_SOC)  += sof/
>>  obj-$(CONFIG_SND_SOC)  += spear/
>>  obj-$(CONFIG_SND_SOC)  += sprd/
>> +obj-$(CONFIG_SND_SOC)  += starfive/
>>  obj-$(CONFIG_SND_SOC)  += sti/
>>  obj-$(CONFIG_SND_SOC)  += stm/
>>  obj-$(CONFIG_SND_SOC)  += sunxi/
>> diff --git a/sound/soc/starfive/Kconfig b/sound/soc/starfive/Kconfig
>> new file mode 100644
>> index 000000000000..fafb681f8c0a
>> --- /dev/null
>> +++ b/sound/soc/starfive/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config SND_SOC_STARFIVE
>> +       tristate "Audio support for StarFive SoC"
>> +       depends on COMPILE_TEST || ARCH_STARFIVE
>> +       help
>> +         Say Y or M if you want to add support for codecs attached to
>> +         the Starfive SoCs' Audio interfaces. You will also need to
>> +         select the audio interfaces to support below.
>> +
>> +config SND_SOC_JH7110_TDM
>> +       tristate "JH7110 TDM device driver"
>> +       depends on HAVE_CLK && SND_SOC_STARFIVE
>> +       select SND_SOC_GENERIC_DMAENGINE_PCM
>> +       help
>> +         Say Y or M if you want to add support for StarFive TDM driver.
>> diff --git a/sound/soc/starfive/Makefile b/sound/soc/starfive/Makefile
>> new file mode 100644
>> index 000000000000..f7d960211d72
>> --- /dev/null
>> +++ b/sound/soc/starfive/Makefile
>> @@ -0,0 +1,2 @@
>> +# StarFive Platform Support
>> +obj-$(CONFIG_SND_SOC_JH7110_TDM) += jh7110_tdm.o
>> diff --git a/sound/soc/starfive/jh7110_tdm.c b/sound/soc/starfive/jh7110_tdm.c
>> new file mode 100644
>> index 000000000000..1f94cc210140
>> --- /dev/null
>> +++ b/sound/soc/starfive/jh7110_tdm.c
>> @@ -0,0 +1,554 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * jh7110_tdm.c -- StarFive JH7110 TDM driver
>> + *
>> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
>> + *
>> + * Author: Walker Chen <walker.chen@starfivetech.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <sound/initval.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dai.h>
>> +#include "jh7110_tdm.h"
>> +
>> +static inline u32 jh7110_tdm_readl(struct jh7110_tdm_dev *tdm, u16 reg)
>> +{
>> +       return readl_relaxed(tdm->tdm_base + reg);
>> +}
>> +
>> +static inline void jh7110_tdm_writel(struct jh7110_tdm_dev *tdm, u16 reg, u32 val)
>> +{
>> +       writel_relaxed(val, tdm->tdm_base + reg);
>> +}
>> +
>> +static void jh7110_tdm_save_context(struct jh7110_tdm_dev *tdm,
>> +                                   struct snd_pcm_substream *substream)
>> +{
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +               tdm->saved_pcmtxcr = jh7110_tdm_readl(tdm, TDM_PCMTXCR);
>> +       else
>> +               tdm->saved_pcmrxcr = jh7110_tdm_readl(tdm, TDM_PCMRXCR);
>> +}
>> +
>> +static void jh7110_tdm_start(struct jh7110_tdm_dev *tdm,
>> +                            struct snd_pcm_substream *substream)
>> +{
>> +       u32 data;
>> +
>> +       data = jh7110_tdm_readl(tdm, TDM_PCMGBCR);
>> +       jh7110_tdm_writel(tdm, TDM_PCMGBCR, data | PCMGBCR_ENABLE);
>> +
>> +       /* restore context */
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +               jh7110_tdm_writel(tdm, TDM_PCMTXCR, tdm->saved_pcmtxcr | PCMTXCR_TXEN);
>> +       else
>> +               jh7110_tdm_writel(tdm, TDM_PCMRXCR, tdm->saved_pcmrxcr | PCMRXCR_RXEN);
>> +}
>> +
>> +static void jh7110_tdm_stop(struct jh7110_tdm_dev *tdm,
>> +                           struct snd_pcm_substream *substream)
>> +{
>> +       unsigned int val;
>> +
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +               val = jh7110_tdm_readl(tdm, TDM_PCMTXCR);
>> +               val &= ~PCMTXCR_TXEN;
>> +               jh7110_tdm_writel(tdm, TDM_PCMTXCR, val);
>> +       } else {
>> +               val = jh7110_tdm_readl(tdm, TDM_PCMRXCR);
>> +               val &= ~PCMRXCR_RXEN;
>> +               jh7110_tdm_writel(tdm, TDM_PCMRXCR, val);
>> +       }
>> +}
>> +
>> +static int jh7110_tdm_syncdiv(struct jh7110_tdm_dev *tdm)
>> +{
>> +       u32 sl, sscale, syncdiv;
>> +
>> +       if (tdm->rx.sl >= tdm->tx.sl)
>> +               sl = tdm->rx.sl;
>> +       else
>> +               sl = tdm->tx.sl;
>> +
>> +       if (tdm->rx.sscale >= tdm->tx.sscale)
>> +               sscale = tdm->rx.sscale;
>> +       else
>> +               sscale = tdm->tx.sscale;
>> +
>> +       syncdiv = tdm->pcmclk / tdm->samplerate - 1;
>> +
>> +       if ((syncdiv + 1) < (sl * sscale)) {
>> +               dev_err(tdm->dev, "Failed to set syncdiv!\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (tdm->syncm == TDM_SYNCM_LONG &&
>> +           (tdm->rx.sscale <= 1 || tdm->tx.sscale <= 1)) {
> 
> You can add the below condition to the above if to avoid extra indentation.

Hi Claudiu,

Thanks for reviewing the patch.
Yes, the following condition can be place with above statement together.

> 
>> +               if ((syncdiv + 1) <= sl) {
>> +                       dev_err(tdm->dev, "Wrong syncdiv! It must be (syncdiv+1) > max[tx.sl, rx.sl]\n");
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       jh7110_tdm_writel(tdm, TDM_PCMDIV, syncdiv);
>> +       return 0;
>> +}
>> +
>> +static int jh7110_tdm_config(struct jh7110_tdm_dev *tdm,
>> +                            struct snd_pcm_substream *substream)
>> +{
>> +       u32 datarx, datatx;
>> +       int ret;
>> +
>> +       ret = jh7110_tdm_syncdiv(tdm);
>> +       if (ret)
>> +               return ret;
>> +
>> +       datarx = (tdm->rx.ifl << IFL_BIT) |
>> +                 (tdm->rx.wl << WL_BIT) |
>> +                 (tdm->rx.sscale << SSCALE_BIT) |
>> +                 (tdm->rx.sl << SL_BIT) |
>> +                 (tdm->rx.lrj << LRJ_BIT);
>> +
>> +       datatx = (tdm->tx.ifl << IFL_BIT) |
>> +                 (tdm->tx.wl << WL_BIT) |
>> +                 (tdm->tx.sscale << SSCALE_BIT) |
>> +                 (tdm->tx.sl << SL_BIT) |
>> +                 (tdm->tx.lrj << LRJ_BIT);
>> +
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +               jh7110_tdm_writel(tdm, TDM_PCMTXCR, datatx);
>> +       else
>> +               jh7110_tdm_writel(tdm, TDM_PCMRXCR, datarx);
>> +
>> +       return 0;
>> +}
>> +
>> +static void jh7110_tdm_clk_disable(struct jh7110_tdm_dev *tdm)
>> +{
>> +       clk_bulk_disable_unprepare(ARRAY_SIZE(tdm->clks), tdm->clks);
>> +}
>> +
>> +static int jh7110_tdm_clk_enable(struct jh7110_tdm_dev *tdm)
>> +{
>> +       int ret;
>> +
>> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(tdm->clks), tdm->clks);
>> +       if (ret) {
>> +               dev_err(tdm->dev, "Failed to enable tdm clocks\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = reset_control_deassert(tdm->resets);
>> +       if (ret) {
>> +               dev_err(tdm->dev, "Failed to deassert tdm resets\n");
>> +               goto dis_tdm_clk;
>> +       }
>> +
>> +       /* select tdm_ext clock as the clock source for tdm */
>> +       ret = clk_set_parent(tdm->clks[5].clk, tdm->clks[4].clk);
> 
> Maybe not valid for your clocks but, if clocks are not HW implemented for
> this, changing parent at runtime could lead to glitches and thus to
> unexpected behavior. You to check if this could be valid on your hardware.

The TDM works as slave mode, it's bit clock comes from extern source. But defautly the clock of tdm 
always derives from internal clock after each reset. As internal clock derives from PLL2 (1188 MHz),
it cannot be used for audio system with frequency division very well,so it must be switched to extern clock.
There 's no problem doing this.

> 
>> +       if (ret) {
>> +               dev_err(tdm->dev, "Can't set clock source for clk_tdm: %d\n", ret);
>> +               goto dis_tdm_clk;
>> +       }
>> +       return 0;
>> +
>> +dis_tdm_clk:
>> +       clk_bulk_disable_unprepare(ARRAY_SIZE(tdm->clks), tdm->clks);
>> +
>> +       return ret;
>> +}
>> +
>> +static int jh7110_tdm_runtime_suspend(struct device *dev)
>> +{
>> +       struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
>> +
>> +       jh7110_tdm_clk_disable(tdm);
>> +       return 0;
>> +}
>> +
>> +static int jh7110_tdm_runtime_resume(struct device *dev)
>> +{
>> +       struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
>> +
>> +       return jh7110_tdm_clk_enable(tdm);
>> +}
>> +
>> +static int __maybe_unused jh7110_tdm_system_suspend(struct device *dev)
> 
> __maybe_unused could be removed if SYSTEM_SLEEP_PM_OPS() is used in the
> definition of jh7110_tdm_pm_ops.

OK, follow your advise.

> 
> 
>> +{
>> +       struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
>> +
>> +       /* save context */
>> +       tdm->saved_pcmgbcr = jh7110_tdm_readl(tdm, TDM_PCMGBCR);
>> +       tdm->saved_pcmdiv = jh7110_tdm_readl(tdm, TDM_PCMDIV);
>> +
>> +       return pm_runtime_force_suspend(dev);
>> +}
>> +
>> +static int __maybe_unused jh7110_tdm_system_resume(struct device *dev)
> 
> same

Will be changed.

> 
>> +{
>> +       struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
>> +
>> +       /* restore context */
>> +       jh7110_tdm_writel(tdm, TDM_PCMGBCR, tdm->saved_pcmgbcr);
>> +       jh7110_tdm_writel(tdm, TDM_PCMDIV, tdm->saved_pcmdiv);
>> +
>> +       return pm_runtime_force_resume(dev);
>> +}
>> +
>> +static const struct snd_soc_component_driver jh7110_tdm_component = {
>> +       .name = "jh7110-tdm",
>> +};
>> +
>> +static int jh7110_tdm_startup(struct snd_pcm_substream *substream,
>> +                             struct snd_soc_dai *cpu_dai)
>> +{
>> +       struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>> +       struct snd_soc_dai_link *dai_link = rtd->dai_link;
>> +
>> +       dai_link->stop_dma_first = 1;
>> +
>> +       return 0;
>> +}
>> +
>> +static int jh7110_tdm_hw_params(struct snd_pcm_substream *substream,
>> +                               struct snd_pcm_hw_params *params,
>> +                               struct snd_soc_dai *dai)
>> +{
>> +       struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
>> +       int chan_wl, chan_sl, chan_nr;
>> +       unsigned int data_width;
>> +       unsigned int dma_bus_width;
>> +       struct snd_dmaengine_dai_dma_data *dma_data = NULL;
>> +       int ret = 0;
> 
> No need for initialization.

Will be changed.

> 
>> +
>> +       data_width = params_width(params);
>> +
>> +       tdm->samplerate = params_rate(params);
>> +       tdm->pcmclk = params_channels(params) * tdm->samplerate * data_width;
>> +
>> +       switch (params_format(params)) {
>> +       case SNDRV_PCM_FORMAT_S16_LE:
>> +               chan_wl = TDM_16BIT_WORD_LEN;
>> +               chan_sl = TDM_16BIT_SLOT_LEN;
>> +               dma_bus_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +               break;
>> +
>> +       case SNDRV_PCM_FORMAT_S32_LE:
>> +               chan_wl = TDM_32BIT_WORD_LEN;
>> +               chan_sl = TDM_32BIT_SLOT_LEN;
>> +               dma_bus_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +               break;
>> +
>> +       default:
>> +               dev_err(tdm->dev, "tdm: unsupported PCM fmt");
>> +               return -EINVAL;
>> +       }
>> +
>> +       chan_nr = params_channels(params);
>> +       switch (chan_nr) {
>> +       case 1:
>> +       case 2:
>> +       case 4:
>> +       case 6:
>> +       case 8:
>> +               break;
>> +       default:
>> +               dev_err(tdm->dev, "channel not supported\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +               tdm->tx.wl = chan_wl;
>> +               tdm->tx.sl = chan_sl;
>> +               tdm->tx.sscale = chan_nr;
>> +               tdm->play_dma_data.addr_width = dma_bus_width;
>> +               dma_data = &tdm->play_dma_data;
>> +       } else {
>> +               tdm->rx.wl = chan_wl;
>> +               tdm->rx.sl = chan_sl;
>> +               tdm->rx.sscale = chan_nr;
>> +               tdm->capture_dma_data.addr_width = dma_bus_width;
>> +               dma_data = &tdm->capture_dma_data;
>> +       }
>> +
>> +       snd_soc_dai_set_dma_data(dai, substream, dma_data);
>> +
>> +       ret = jh7110_tdm_config(tdm, substream);
>> +       if (ret)
>> +               return ret;
>> +
>> +       jh7110_tdm_save_context(tdm, substream);
>> +       return 0;
>> +}
>> +
>> +static int jh7110_tdm_trigger(struct snd_pcm_substream *substream,
>> +                             int cmd, struct snd_soc_dai *dai)
>> +{
>> +       struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
>> +       int ret = 0;
>> +
>> +       switch (cmd) {
>> +       case SNDRV_PCM_TRIGGER_START:
>> +       case SNDRV_PCM_TRIGGER_RESUME:
>> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +               jh7110_tdm_start(tdm, substream);
>> +               break;
>> +
>> +       case SNDRV_PCM_TRIGGER_STOP:
>> +       case SNDRV_PCM_TRIGGER_SUSPEND:
>> +       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +               jh7110_tdm_stop(tdm, substream);
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               break;
>> +       }
>> +       return ret;
>> +}
>> +
>> +static int jh7110_tdm_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>> +                                 unsigned int fmt)
>> +{
>> +       struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(cpu_dai);
>> +       unsigned int gbcr;
>> +       int ret = 0;
>> +
>> +       /* set master/slave audio interface */
>> +       switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>> +       case SND_SOC_DAIFMT_BP_FP:
>> +               /* cpu is master */
>> +               tdm->ms_mode = TDM_AS_MASTER;
>> +               break;
>> +       case SND_SOC_DAIFMT_BC_FC:
>> +               /* codec is master */
>> +               tdm->ms_mode = TDM_AS_SLAVE;
>> +               break;
>> +       case SND_SOC_DAIFMT_BC_FP:
>> +       case SND_SOC_DAIFMT_BP_FC:
>> +               ret = -EINVAL;
> 
> Probably you should return here to avoid updating register with invalid values.

This is my negligence, it will be changed.

> 
>> +               break;
>> +       default:
>> +               dev_dbg(tdm->dev, "dwc : Invalid clock provider format\n");
>> +               ret = -EINVAL;
> 
> ditto

same

> 
>> +               break;
>> +       }
>> +
>> +       gbcr = (tdm->clkpolity << CLKPOL_BIT) |
>> +               (tdm->elm << ELM_BIT) |
>> +               (tdm->syncm << SYNCM_BIT) |
>> +               (tdm->ms_mode << MS_BIT);
>> +       jh7110_tdm_writel(tdm, TDM_PCMGBCR, gbcr);
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct snd_soc_dai_ops jh7110_tdm_dai_ops = {
>> +       .startup        = jh7110_tdm_startup,
>> +       .hw_params      = jh7110_tdm_hw_params,
>> +       .trigger        = jh7110_tdm_trigger,
>> +       .set_fmt        = jh7110_tdm_set_dai_fmt,
>> +};
>> +
>> +static int jh7110_tdm_dai_probe(struct snd_soc_dai *dai)
>> +{
>> +       struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
>> +
>> +       snd_soc_dai_init_dma_data(dai, &tdm->play_dma_data, &tdm->capture_dma_data);
>> +       snd_soc_dai_set_drvdata(dai, tdm);
>> +       return 0;
>> +}
>> +
>> +#define JH7110_TDM_RATES       SNDRV_PCM_RATE_8000_48000
>> +
>> +#define JH7110_TDM_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE | \
>> +                                SNDRV_PCM_FMTBIT_S32_LE)
>> +
>> +static struct snd_soc_dai_driver jh7110_tdm_dai = {
>> +       .name = "sf_tdm",
>> +       .id = 0,
>> +       .playback = {
>> +               .stream_name    = "Playback",
>> +               .channels_min   = 1,
>> +               .channels_max   = 8,
>> +               .rates          = JH7110_TDM_RATES,
>> +               .formats        = JH7110_TDM_FORMATS,
>> +       },
>> +       .capture = {
>> +               .stream_name    = "Capture",
>> +               .channels_min   = 1,
>> +               .channels_max   = 8,
>> +               .rates          = JH7110_TDM_RATES,
>> +               .formats        = JH7110_TDM_FORMATS,
>> +       },
>> +       .ops = &jh7110_tdm_dai_ops,
>> +       .probe = jh7110_tdm_dai_probe,
>> +       .symmetric_rate = 1,
>> +};
>> +
>> +static const struct snd_pcm_hardware jh7110_pcm_hardware = {
>> +       .info                   = (SNDRV_PCM_INFO_MMAP          |
>> +                                  SNDRV_PCM_INFO_MMAP_VALID    |
>> +                                  SNDRV_PCM_INFO_PAUSE         |
>> +                                  SNDRV_PCM_INFO_RESUME        |
>> +                                  SNDRV_PCM_INFO_INTERLEAVED   |
>> +                                  SNDRV_PCM_INFO_BLOCK_TRANSFER),
>> +       .buffer_bytes_max       = 192512,
>> +       .period_bytes_min       = 4096,
>> +       .period_bytes_max       = 32768,
>> +       .periods_min            = 1,
>> +       .periods_max            = 48,
>> +       .fifo_size              = 16,
>> +};
>> +
>> +static const struct snd_dmaengine_pcm_config jh7110_dmaengine_pcm_config = {
>> +       .pcm_hardware = &jh7110_pcm_hardware,
>> +       .prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
>> +       .prealloc_buffer_size = 192512,
>> +};
>> +
>> +static void jh7110_tdm_init_params(struct jh7110_tdm_dev *tdm)
>> +{
>> +       tdm->clkpolity = TDM_TX_RASING_RX_FALLING;
>> +       tdm->elm = TDM_ELM_LATE;
>> +       tdm->syncm = TDM_SYNCM_SHORT;
>> +
>> +       tdm->rx.ifl = TDM_FIFO_HALF;
>> +       tdm->tx.ifl = TDM_FIFO_HALF;
>> +       tdm->rx.wl = TDM_16BIT_WORD_LEN;
>> +       tdm->tx.wl = TDM_16BIT_WORD_LEN;
>> +       tdm->rx.sscale = 2;
>> +       tdm->tx.sscale = 2;
>> +       tdm->rx.lrj = TDM_LEFT_JUSTIFT;
>> +       tdm->tx.lrj = TDM_LEFT_JUSTIFT;
>> +
>> +       tdm->play_dma_data.addr = JH7110_TDM_FIFO;
>> +       tdm->play_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +       tdm->play_dma_data.fifo_size = JH7110_TDM_FIFO_DEPTH / 2;
>> +       tdm->play_dma_data.maxburst = 16;
>> +
>> +       tdm->capture_dma_data.addr = JH7110_TDM_FIFO;
>> +       tdm->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +       tdm->capture_dma_data.fifo_size = JH7110_TDM_FIFO_DEPTH / 2;
>> +       tdm->capture_dma_data.maxburst = 8;
>> +}
>> +
>> +static int jh7110_tdm_clk_reset_init(struct platform_device *pdev,
>> +                                    struct jh7110_tdm_dev *tdm)
>> +{
>> +       int ret;
>> +
>> +       tdm->clks[0].id = "mclk_inner";
>> +       tdm->clks[1].id = "tdm_ahb";
>> +       tdm->clks[2].id = "tdm_apb";
>> +       tdm->clks[3].id = "tdm_internal";
>> +       tdm->clks[4].id = "tdm_ext";
>> +       tdm->clks[5].id = "tdm";
>> +
>> +       ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(tdm->clks), tdm->clks);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to get tdm clocks\n");
>> +               return ret;
>> +       }
>> +
>> +       tdm->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
>> +       if (IS_ERR(tdm->resets)) {
> 
> of_reset_control_array_get() called by devm_reset_control_array_get()
> called by devm_reset_control_array_get_exclusive() could return
> IS_ERR_OR_NULL() and propagates the NULL also here. Thus you should check
> the return value with IS_ERR_OR_NULL()

It will be changed.

> 
>> +               ret = PTR_ERR(tdm->resets);
>> +               dev_err(&pdev->dev, "Failed to get tdm resets");
>> +               return ret;
>> +       }
>> +
>> +       return jh7110_tdm_clk_enable(tdm);
> 
> AFAICT there is no need to enable clocks in probe. Thus you can remove this
> here and rely on runtime PM when CONFIG_PM is enabled (and for !CONFIG_PM
> see below comment in probe).

Good advise, it will be changed in next submit.

> 
>> +}
>> +
>> +static int jh7110_tdm_probe(struct platform_device *pdev)
>> +{
>> +       struct jh7110_tdm_dev *tdm;
>> +       int ret;
>> +
>> +       tdm = devm_kzalloc(&pdev->dev, sizeof(*tdm), GFP_KERNEL);
>> +       if (!tdm)
>> +               return -ENOMEM;
>> +
>> +       tdm->tdm_base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(tdm->tdm_base))
>> +               return PTR_ERR(tdm->tdm_base);
>> +
>> +       tdm->dev = &pdev->dev;
>> +
>> +       ret = jh7110_tdm_clk_reset_init(pdev, tdm);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to enable audio-tdm clock\n");
>> +               return ret;
>> +       }
>> +
>> +       jh7110_tdm_init_params(tdm);
>> +
>> +       dev_set_drvdata(&pdev->dev, tdm);
>> +       ret = devm_snd_soc_register_component(&pdev->dev, &jh7110_tdm_component,
>> +                                             &jh7110_tdm_dai, 1);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to register dai\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
>> +                                             &jh7110_dmaengine_pcm_config,
>> +                                             SND_DMAENGINE_PCM_FLAG_COMPAT);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Could not register pcm: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       pm_runtime_enable(&pdev->dev);
>> +#ifdef CONFIG_PM
>> +       jh7110_tdm_clk_disable(tdm);
>> +#endif
> 
> Something like this:
> 	if (!pm_runtime_enabled())
> 		jh7110_tdm_runtime_resume();
> 
> 
>> +
>> +       return 0;
>> +}
>> +
>> +static int jh7110_tdm_dev_remove(struct platform_device *pdev)
>> +{
>> +       pm_runtime_disable(&pdev->dev);
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id jh7110_tdm_of_match[] = {
>> +       { .compatible = "starfive,jh7110-tdm", },
>> +       {}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, jh7110_tdm_of_match);
>> +
>> +static const struct dev_pm_ops jh7110_tdm_pm_ops = {
>> +       SET_RUNTIME_PM_OPS(jh7110_tdm_runtime_suspend,
>> +                          jh7110_tdm_runtime_resume, NULL)
> 
> RUNTIME_PM_OPS() otherwise you need __maybe_unsed on functions.
> 
>> +       SET_SYSTEM_SLEEP_PM_OPS(jh7110_tdm_system_suspend,
>> +                               jh7110_tdm_system_resume)
> 
> SYSTEM_SLEEP_PM_OPS() otherwise you need __maybe_unsed on functions.

The above 2 items will be changed.

> 
> 
>> +};
>> +
>> +static struct platform_driver jh7110_tdm_driver = {
>> +       .driver = {
>> +               .name = "jh7110-tdm",
>> +               .of_match_table = jh7110_tdm_of_match,
>> +               .pm = &jh7110_tdm_pm_ops,
> 
> pm_ptr(&jh7110_tdm_pm_ops)
> 
>> +       },
>> +       .probe = jh7110_tdm_probe,
>> +       .remove = jh7110_tdm_dev_remove,
>> +};
>> +module_platform_driver(jh7110_tdm_driver);
>> +
>> +MODULE_DESCRIPTION("StarFive JH7110 TDM ASoC Driver");
>> +MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/sound/soc/starfive/jh7110_tdm.h b/sound/soc/starfive/jh7110_tdm.h
>> new file mode 100644
>> index 000000000000..0b7e6d6543c5
>> --- /dev/null
>> +++ b/sound/soc/starfive/jh7110_tdm.h
> 
> Is the header needed? Can't be all in one place? The header is anyway used
> only in one driver.

Will be fixed.
In a word, you gave a lot of very helpful advice. Thank you so much!

Best regards,
Walker
