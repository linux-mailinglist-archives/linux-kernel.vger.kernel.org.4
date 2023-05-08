Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523286F9D79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjEHBl4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 May 2023 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEHBly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:41:54 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5217DBB;
        Sun,  7 May 2023 18:41:49 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3505F24E03C;
        Mon,  8 May 2023 09:41:33 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 8 May
 2023 09:41:33 +0800
Received: from [192.168.125.124] (183.27.98.219) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 8 May
 2023 09:41:32 +0800
Message-ID: <622746ca-8d29-72cf-cc8f-cfe7bc5aea58@starfivetech.com>
Date:   Mon, 8 May 2023 09:41:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/3] ASoC: starfive: Add JH7110 TDM driver
To:     Shengyu Qu <wiagn233@outlook.com>, Mark Brown <broonie@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-3-walker.chen@starfivetech.com>
 <TY3P286MB26118DAB0E0E2BF32C91B19F98739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <TY3P286MB26118DAB0E0E2BF32C91B19F98739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.219]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/6 21:47, Shengyu Qu wrote:
> Hi,
> 
>> Add tdm driver support for the StarFive JH7110 SoC.
>>
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>   MAINTAINERS                     |   6 +
>>   sound/soc/Kconfig               |   1 +
>>   sound/soc/Makefile              |   1 +
>>   sound/soc/starfive/Kconfig      |  15 +
>>   sound/soc/starfive/Makefile     |   2 +
>>   sound/soc/starfive/jh7110_tdm.c | 573 ++++++++++++++++++++++++++++++++
>>   sound/soc/starfive/jh7110_tdm.h | 147 ++++++++
>>   7 files changed, 745 insertions(+)
>>   create mode 100644 sound/soc/starfive/Kconfig
>>   create mode 100644 sound/soc/starfive/Makefile
>>   create mode 100644 sound/soc/starfive/jh7110_tdm.c
>>   create mode 100644 sound/soc/starfive/jh7110_tdm.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5f9c544bc189..add89615d327 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19945,6 +19945,12 @@ F:    Documentation/devicetree/bindings/power/starfive*
>>   F:    drivers/soc/starfive/jh71xx_pmu.c
>>   F:    include/dt-bindings/power/starfive,jh7110-pmu.h
>>   +STARFIVE JH7110 TDM DRIVERS
>> +M:    Walker Chen <walker.chen@starfivetech.com>
>> +S:    Maintained
>> +F:    Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
>> +F:    sound/soc/starfive/jh7110-tdm.*
>> +
>>   STARFIVE SOC DRIVERS
>>   M:    Conor Dooley <conor@kernel.org>
>>   S:    Maintained
>> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
>> index 848fbae26c3b..8d1d9401ecf2 100644
>> --- a/sound/soc/Kconfig
>> +++ b/sound/soc/Kconfig
>> @@ -91,6 +91,7 @@ source "sound/soc/sh/Kconfig"
>>   source "sound/soc/sof/Kconfig"
>>   source "sound/soc/spear/Kconfig"
>>   source "sound/soc/sprd/Kconfig"
>> +source "sound/soc/starfive/Kconfig"
>>   source "sound/soc/sti/Kconfig"
>>   source "sound/soc/stm/Kconfig"
>>   source "sound/soc/sunxi/Kconfig"
>> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
>> index 507eaed1d6a1..65aeb4ef4068 100644
>> --- a/sound/soc/Makefile
>> +++ b/sound/soc/Makefile
>> @@ -59,6 +59,7 @@ obj-$(CONFIG_SND_SOC)    += sh/
>>   obj-$(CONFIG_SND_SOC)    += sof/
>>   obj-$(CONFIG_SND_SOC)    += spear/
>>   obj-$(CONFIG_SND_SOC)    += sprd/
>> +obj-$(CONFIG_SND_SOC)    += starfive/
>>   obj-$(CONFIG_SND_SOC)    += sti/
>>   obj-$(CONFIG_SND_SOC)    += stm/
>>   obj-$(CONFIG_SND_SOC)    += sunxi/
>> diff --git a/sound/soc/starfive/Kconfig b/sound/soc/starfive/Kconfig
>> new file mode 100644
>> index 000000000000..737c956f7b93
>> --- /dev/null
>> +++ b/sound/soc/starfive/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config SND_SOC_STARFIVE
>> +    tristate "Audio support for StarFive SoC"
>> +    depends on COMPILE_TEST || SOC_STARFIVE
>> +    help
>> +      Say Y or M if you want to add support for codecs attached to
>> +      the Starfive SoCs' Audio interfaces. You will also need to
>> +      select the audio interfaces to support below.
>> +
>> +config SND_SOC_JH7110_TDM
>> +    tristate "JH7110 TDM device driver"
>> +    depends on HAVE_CLK && SND_SOC_STARFIVE
>> +    select SND_SOC_GENERIC_DMAENGINE_PCM
>> +    help
>> +      Say Y or M if you want to add support for StarFive TDM driver.
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
>> index 000000000000..33f7cf43e4bd
>> --- /dev/null
>> +++ b/sound/soc/starfive/jh7110_tdm.c
>> @@ -0,0 +1,573 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * jh7110_tdm.c -- StarFive JH7110 TDM driver
>> + *
>> + * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
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
>> +    return readl_relaxed(tdm->tdm_base + reg);
>> +}
>> +
>> +static inline void jh7110_tdm_writel(struct jh7110_tdm_dev *tdm, u16 reg, u32 val)
>> +{
>> +    writel_relaxed(val, tdm->tdm_base + reg);
>> +}
>> +
>> +static void jh7110_tdm_save_context(struct jh7110_tdm_dev *tdm,
>> +                    struct snd_pcm_substream *substream)
>> +{
>> +    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +        tdm->saved_pcmtxcr = jh7110_tdm_readl(tdm, TDM_PCMTXCR);
>> +    else
>> +        tdm->saved_pcmrxcr = jh7110_tdm_readl(tdm, TDM_PCMRXCR);
>> +}
>> +
>> +static void jh7110_tdm_start(struct jh7110_tdm_dev *tdm,
>> +                 struct snd_pcm_substream *substream)
>> +{
>> +    u32 data;
>> +
>> +    data = jh7110_tdm_readl(tdm, TDM_PCMGBCR);
>> +    jh7110_tdm_writel(tdm, TDM_PCMGBCR, data | PCMGBCR_ENABLE);
>> +
>> +    /* restore context */
>> +    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +        jh7110_tdm_writel(tdm, TDM_PCMTXCR, tdm->saved_pcmtxcr | PCMTXCR_TXEN);
>> +    else
>> +        jh7110_tdm_writel(tdm, TDM_PCMRXCR, tdm->saved_pcmrxcr | PCMRXCR_RXEN);
>> +}
>> +
>> +static void jh7110_tdm_stop(struct jh7110_tdm_dev *tdm,
>> +                struct snd_pcm_substream *substream)
>> +{
>> +    unsigned int val;
>> +
>> +    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +        val = jh7110_tdm_readl(tdm, TDM_PCMTXCR);
>> +        val &= ~PCMTXCR_TXEN;
>> +        jh7110_tdm_writel(tdm, TDM_PCMTXCR, val);
>> +    } else {
>> +        val = jh7110_tdm_readl(tdm, TDM_PCMRXCR);
>> +        val &= ~PCMRXCR_RXEN;
>> +        jh7110_tdm_writel(tdm, TDM_PCMRXCR, val);
>> +    }
>> +}
>> +
>> +static int jh7110_tdm_syncdiv(struct jh7110_tdm_dev *tdm)
>> +{
>> +    u32 sl, sscale, syncdiv;
>> +
>> +    if (tdm->rx.sl >= tdm->tx.sl)
>> +        sl = tdm->rx.sl;
>> +    else
>> +        sl = tdm->tx.sl;
>> +
>> +    if (tdm->rx.sscale >= tdm->tx.sscale)
>> +        sscale = tdm->rx.sscale;
>> +    else
>> +        sscale = tdm->tx.sscale;
>> +
>> +    syncdiv = tdm->pcmclk / tdm->samplerate - 1;
>> +
>> +    if ((syncdiv + 1) < (sl * sscale)) {
>> +        dev_err(tdm->dev, "Failed to set syncdiv!\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (tdm->syncm == TDM_SYNCM_LONG &&
>> +        (tdm->rx.sscale <= 1 || tdm->tx.sscale <= 1)) {
>> +        if ((syncdiv + 1) <= sl) {
>> +            dev_err(tdm->dev, "Wrong syncdiv! It must be (syncdiv+1) > max[tx.sl, rx.sl]\n");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    jh7110_tdm_writel(tdm, TDM_PCMDIV, syncdiv);
>> +    return 0;
>> +}
>> +
>> +static int jh7110_tdm_config(struct jh7110_tdm_dev *tdm,
>> +                 struct snd_pcm_substream *substream)
>> +{
>> +    u32 datarx, datatx;
>> +    int ret;
>> +
>> +    ret = jh7110_tdm_syncdiv(tdm);
>> +    if (ret)
>> +        return ret;
>> +
>> +    datarx = (tdm->rx.ifl << IFL_BIT) |
>> +          (tdm->rx.wl << WL_BIT) |
>> +          (tdm->rx.sscale << SSCALE_BIT) |
>> +          (tdm->rx.sl << SL_BIT) |
>> +          (tdm->rx.lrj << LRJ_BIT);
>> +
>> +    datatx = (tdm->tx.ifl << IFL_BIT) |
>> +          (tdm->tx.wl << WL_BIT) |
>> +          (tdm->tx.sscale << SSCALE_BIT) |
>> +          (tdm->tx.sl << SL_BIT) |
>> +          (tdm->tx.lrj << LRJ_BIT);
>> +
>> +    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +        jh7110_tdm_writel(tdm, TDM_PCMTXCR, datatx);
>> +    else
>> +        jh7110_tdm_writel(tdm, TDM_PCMRXCR, datarx);
>> +
>> +    return 0;
>> +}
>> +
>> +static void jh7110_tdm_clk_disable(struct jh7110_tdm_dev *tdm)
>> +{
>> +    int i;
>> +
>> +    for (i = tdm->num_clks - 1; i >= 0; i--)
>> +        clk_disable_unprepare(tdm->clks[i]);
>> +}
>> +
>> +static int jh7110_tdm_clk_enable(struct jh7110_tdm_dev *tdm)
>> +{
>> +    int i, ret;
>> +
>> +    for (i = 0; i < tdm->num_clks; i++) {
>> +        ret = clk_prepare_enable(tdm->clks[i]);
>> +        if (ret) {
>> +            while (i-- > 0)
>> +                clk_disable_unprepare(tdm->clks[i]);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    ret = reset_control_deassert(tdm->resets);
>> +    if (ret) {
>> +        dev_err(tdm->dev, "Failed to deassert tdm resets\n");
>> +        goto dis_tdm_clk;
>> +    }
>> +
>> +    /* select tdm_ext clock as the clock source for tdm */
>> +    ret = clk_set_parent(tdm->clks[5], tdm->clks[4]);
>> +    if (ret) {
>> +        dev_err(tdm->dev, "Can't set clock source for clk_tdm: %d\n", ret);
>> +        goto dis_tdm_clk;
>> +    }
>> +    return 0;
>> +
>> +dis_tdm_clk:
>> +    for (i = tdm->num_clks - 1; i >= 0; i--)
>> +        clk_disable_unprepare(tdm->clks[i]);
>> +
>> +    return ret;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int jh7110_tdm_runtime_suspend(struct device *dev)
>> +{
>> +    struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
>> +
>> +    jh7110_tdm_clk_disable(tdm);
>> +    return 0;
>> +}
>> +
>> +static int jh7110_tdm_runtime_resume(struct device *dev)
>> +{
>> +    struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
>> +
>> +    return jh7110_tdm_clk_enable(tdm);
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int jh7110_tdm_suspend(struct snd_soc_component *component)
>> +{
>> +    /* save context */
>> +    tdm->saved_pcmgbcr = jh7110_tdm_readl(tdm, TDM_PCMGBCR);
>> +    tdm->saved_pcmdiv = jh7110_tdm_readl(tdm, TDM_PCMDIV);
> 
> tdm isn't declared here. Is that same with resume function?

OMG! Maybe I accidentally deleted the declaration of tdm while deleting some debugging statement.
Yes, it is same with resume function.

Best regards,
Walker
