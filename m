Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034007349C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFSBpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:45:39 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A85FE40;
        Sun, 18 Jun 2023 18:45:33 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8DxyOk7s49kXrAGAA--.13758S3;
        Mon, 19 Jun 2023 09:45:31 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxG8o6s49kkKQfAA--.14537S3;
        Mon, 19 Jun 2023 09:45:30 +0800 (CST)
Message-ID: <325dd825-6fa5-0ebc-4b7e-7acf2d2840e4@loongson.cn>
Date:   Mon, 19 Jun 2023 09:45:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/3] ASoC: Add support for Loongson I2S controller
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        broonie@kernel.org, lgirdwood@gmail.com
Cc:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dan Carpenter <error27@gmail.com>,
        kernel-janitors@vger.kernel.org
References: <20230615122718.3412942-1-mengyingkun@loongson.cn>
 <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
 <6901166d-387f-24de-6ffd-1c8eea724718@oracle.com>
Content-Language: en-US
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <6901166d-387f-24de-6ffd-1c8eea724718@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxG8o6s49kkKQfAA--.14537S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAHDGSO9AIDOQABst
X-Coremail-Antispam: 1Uk129KBj9fXoWDWF15Aw18ury3Gr4xur4xZrc_yoWrCw4xZo
        WUKF1fJr45Xr1UWr1UJr4UJr13JF1UXrnFyryUGr9rJr10k3WUA3yUJrWUtay7JF18Kr1U
        JryUJryFvFy2vr15l-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUO07kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harshit,

Thanks you for pointing this bug.


On 2023/6/19 04:14, Harshit Mogalapalli wrote:
>
>
> On 19/06/23 1:41 am, Harshit Mogalapalli wrote:
>> Hi YingKun,
>>
>> On 15/06/23 5:57 pm, YingKun Meng wrote:
>>> From: Yingkun Meng <mengyingkun@loongson.cn>
>>>
>>> Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
>>> it is a PCI device with two private DMA controllers, one for playback,
>>> the other for capture.
>>>
>>> The driver supports the use of DTS or ACPI to describe device 
>>> resources.
>>>
>>> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
>>> ---
>>> changes v3 -> v4
>>>    Add __packed attribute for loongson_dma_desc struct.
>>>
>>> sound/soc/Kconfig                     |   1 +
>>>   sound/soc/Makefile                    |   1 +
>>>   sound/soc/loongson/Kconfig            |  16 ++
>>>   sound/soc/loongson/Makefile           |   4 +
>>>   sound/soc/loongson/loongson_dma.c     | 350 
>>> ++++++++++++++++++++++++++
>>>   sound/soc/loongson/loongson_dma.h     |  16 ++
>>>   sound/soc/loongson/loongson_i2s.c     | 269 ++++++++++++++++++++
>>>   sound/soc/loongson/loongson_i2s.h     |  71 ++++++
>>>   sound/soc/loongson/loongson_i2s_pci.c | 171 +++++++++++++
>>>   9 files changed, 899 insertions(+)
>>>   create mode 100644 sound/soc/loongson/Kconfig
>>>   create mode 100644 sound/soc/loongson/Makefile
>>>   create mode 100644 sound/soc/loongson/loongson_dma.c
>>>   create mode 100644 sound/soc/loongson/loongson_dma.h
>>>   create mode 100644 sound/soc/loongson/loongson_i2s.c
>>>   create mode 100644 sound/soc/loongson/loongson_i2s.h
>>>   create mode 100644 sound/soc/loongson/loongson_i2s_pci.c
>>>
>>> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
>>> index 4b6e5a802880..bfa9622e1ab1 100644
>>> --- a/sound/soc/Kconfig
>>> +++ b/sound/soc/Kconfig
>>> @@ -79,6 +79,7 @@ source "sound/soc/google/Kconfig"
>>>   source "sound/soc/hisilicon/Kconfig"
>>>   source "sound/soc/jz4740/Kconfig"
>>>   source "sound/soc/kirkwood/Kconfig"
>>> +source "sound/soc/loongson/Kconfig"
>>>   source "sound/soc/img/Kconfig"
>>>   source "sound/soc/intel/Kconfig"
>>>   source "sound/soc/mediatek/Kconfig"
>>> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
>>> index 9d9b228e4508..8376fdb217ed 100644
>>> --- a/sound/soc/Makefile
>>> +++ b/sound/soc/Makefile
>>> @@ -46,6 +46,7 @@ obj-$(CONFIG_SND_SOC)    += fsl/
>>>   obj-$(CONFIG_SND_SOC)    += google/
>>>   obj-$(CONFIG_SND_SOC)    += hisilicon/
>>>   obj-$(CONFIG_SND_SOC)    += jz4740/
>>> +obj-$(CONFIG_SND_SOC)    += loongson/
>>>   obj-$(CONFIG_SND_SOC)    += img/
>>>   obj-$(CONFIG_SND_SOC)    += intel/
>>>   obj-$(CONFIG_SND_SOC)    += mediatek/
>>> diff --git a/sound/soc/loongson/Kconfig b/sound/soc/loongson/Kconfig
>>> new file mode 100644
>>> index 000000000000..4478ac91e402
>>> --- /dev/null
>>> +++ b/sound/soc/loongson/Kconfig
>>> @@ -0,0 +1,16 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +menu "SoC Audio for Loongson CPUs"
>>> +    depends on LOONGARCH || COMPILE_TEST
>>> +
>>> +config SND_SOC_LOONGSON_I2S_PCI
>>> +    tristate "Loongson I2S-PCI Device Driver"
>>> +    select REGMAP_MMIO
>>> +    depends on PCI
>>> +    help
>>> +      Say Y or M if you want to add support for I2S driver for
>>> +      Loongson I2S controller.
>>> +
>>> +      The controller is found in loongson bridge chips or SoCs,
>>> +      and work as a PCI device.
>>> +
>>> +endmenu
>>> diff --git a/sound/soc/loongson/Makefile b/sound/soc/loongson/Makefile
>>> new file mode 100644
>>> index 000000000000..099af7989103
>>> --- /dev/null
>>> +++ b/sound/soc/loongson/Makefile
>>> @@ -0,0 +1,4 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +#Platform Support
>>> +snd-soc-loongson-i2s-pci-objs := loongson_i2s_pci.o loongson_i2s.o 
>>> loongson_dma.o
>>> +obj-$(CONFIG_SND_SOC_LOONGSON_I2S_PCI) += snd-soc-loongson-i2s-pci.o
>>> diff --git a/sound/soc/loongson/loongson_dma.c 
>>> b/sound/soc/loongson/loongson_dma.c
>>> new file mode 100644
>>> index 000000000000..65b6719e61c5
>>> --- /dev/null
>>> +++ b/sound/soc/loongson/loongson_dma.c
>>> @@ -0,0 +1,350 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// Loongson ALSA SoC Platform (DMA) driver
>>> +//
>>> +// Copyright (C) 2023 Loongson Technology Corporation Limited
>>> +// Author: Yingkun Meng <mengyingkun@loongson.cn>
>>> +//
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <sound/soc.h>
>>> +#include <sound/pcm.h>
>>> +#include <sound/pcm_params.h>
>>> +#include "loongson_i2s.h"
>>> +
>>> +/* DMA dma_order Register */
>>> +#define DMA_ORDER_STOP          (1 << 4) /* DMA stop */
>>> +#define DMA_ORDER_START         (1 << 3) /* DMA start */
>>> +#define DMA_ORDER_ASK_VALID     (1 << 2) /* DMA ask valid flag */
>>> +#define DMA_ORDER_AXI_UNCO      (1 << 1) /* Uncache access */
>>> +#define DMA_ORDER_ADDR_64       (1 << 0) /* 64bits address support */
>>> +
>>> +#define DMA_ORDER_ASK_MASK      (~0x1fUL) /* Ask addr mask */
>>> +#define DMA_ORDER_CTRL_MASK     (0x0fUL)  /* Control mask  */
>>> +
>>> +/*
>>> + * DMA registers descriptor.
>>> + */
>>> +struct loongson_dma_desc {
>>> +    u32 order;        /* Next descriptor address register */
>>> +    u32 saddr;        /* Source address register */
>>> +    u32 daddr;        /* Device address register */
>>> +    u32 length;        /* Total length register */
>>> +    u32 step_length;    /* Memory stride register */
>>> +    u32 step_times;        /* Repeat time register */
>>> +    u32 cmd;        /* Command register */
>>> +    u32 stats;        /* Status register */
>>> +    u32 order_hi;        /* Next descriptor high address register */
>>> +    u32 saddr_hi;        /* High source address register */
>>> +    u32 res[6];        /* Reserved */
>>> +} __packed;
>>> +
>>> +struct loongson_runtime_data {
>>> +    struct loongson_dma_data *dma_data;
>>> +
>>> +    struct loongson_dma_desc *dma_desc_arr;
>>> +    dma_addr_t dma_desc_arr_phy;
>>> +    int dma_desc_arr_size;
>>> +
>>> +    struct loongson_dma_desc *dma_pos_desc;
>>> +    dma_addr_t dma_pos_desc_phy;
>>> +};
>>> +
>>> +static const struct snd_pcm_hardware ls_pcm_hardware = {
>>> +    .info = SNDRV_PCM_INFO_MMAP |
>>> +        SNDRV_PCM_INFO_INTERLEAVED |
>>> +        SNDRV_PCM_INFO_MMAP_VALID |
>>> +        SNDRV_PCM_INFO_RESUME |
>>> +        SNDRV_PCM_INFO_PAUSE,
>>> +    .formats = (SNDRV_PCM_FMTBIT_S8 |
>>> +        SNDRV_PCM_FMTBIT_S16_LE |
>>> +        SNDRV_PCM_FMTBIT_S20_3LE |
>>> +        SNDRV_PCM_FMTBIT_S24_LE),
>>> +    .period_bytes_min = 128,
>>> +    .period_bytes_max = 128 * 1024,
>>> +    .periods_min = 1,
>>> +    .periods_max = PAGE_SIZE / sizeof(struct loongson_dma_desc),
>>> +    .buffer_bytes_max = 1024 * 1024,
>>> +};
>>> +
>>> +static struct
>>> +loongson_dma_desc *dma_desc_save(struct loongson_runtime_data *prtd)
>>> +{
>>> +    void __iomem *order_reg = prtd->dma_data->order_addr;
>>> +    u64 val;
>>> +
>>> +    val = (u64)prtd->dma_pos_desc_phy & DMA_ORDER_ASK_MASK;
>>> +    val |= (readq(order_reg) & DMA_ORDER_CTRL_MASK);
>>> +    val |= DMA_ORDER_ASK_VALID;
>>> +    writeq(val, order_reg);
>>> +
>>> +    while (readl(order_reg) & DMA_ORDER_ASK_VALID)
>>> +        udelay(2);
>>> +
>>> +    return prtd->dma_pos_desc;
>>> +}
>>> +
>>> +static int loongson_pcm_trigger(struct snd_soc_component *component,
>>> +                struct snd_pcm_substream *substream, int cmd)
>>> +{
>>> +    struct loongson_runtime_data *prtd = 
>>> substream->runtime->private_data;
>>> +    struct device *dev = substream->pcm->card->dev;
>>> +    void __iomem *order_reg = prtd->dma_data->order_addr;
>>> +    u64 val;
>>> +    int ret = 0;
>>> +
>>> +    switch (cmd) {
>>> +    case SNDRV_PCM_TRIGGER_START:
>>> +    case SNDRV_PCM_TRIGGER_RESUME:
>>> +    case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>> +        val = prtd->dma_pos_desc_phy & DMA_ORDER_ASK_MASK;
>>> +        if (dev->coherent_dma_mask == DMA_BIT_MASK(64))
>>> +            val |= DMA_ORDER_ADDR_64;
>>> +        else
>>> +            val &= ~DMA_ORDER_ADDR_64;
>>> +        val |= (readq(order_reg) & DMA_ORDER_CTRL_MASK);
>>> +        val |= DMA_ORDER_START;
>>> +        writeq(val, order_reg);
>>> +
>>> +        while ((readl(order_reg) & DMA_ORDER_START))
>>> +            udelay(2);
>>> +        break;
>>> +    case SNDRV_PCM_TRIGGER_STOP:
>>> +    case SNDRV_PCM_TRIGGER_SUSPEND:
>>> +    case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>> +        dma_desc_save(prtd);
>>> +
>>> +        /* dma stop */
>>> +        val = readq(order_reg) | DMA_ORDER_STOP;
>>> +        writeq(val, order_reg);
>>> +        udelay(1000);
>>> +
>>> +        break;
>>> +    default:
>>> +        dev_err(dev, "Invalid pcm trigger operation\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int loongson_pcm_hw_params(struct snd_soc_component *component,
>>> +                  struct snd_pcm_substream *substream,
>>> +                  struct snd_pcm_hw_params *params)
>>> +{
>>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>>> +    struct device *dev = substream->pcm->card->dev;
>>> +    struct loongson_runtime_data *prtd = runtime->private_data;
>>> +    size_t buf_len = params_buffer_bytes(params);
>>> +    size_t period_len = params_period_bytes(params);
>>> +    dma_addr_t order_addr, mem_addr;
>>> +    struct loongson_dma_desc *desc;
>>> +    u32 num_periods;
>>> +    int i;
>>> +
>>> +    if (buf_len % period_len) {
>>> +        dev_err(dev, "buf len not multiply of period len\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    num_periods = buf_len / period_len;
>>> +    if (!num_periods || num_periods > prtd->dma_desc_arr_size) {
>>> +        dev_err(dev, "dma data too small or too big\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
>>> +    runtime->dma_bytes = buf_len;
>>> +
>>> +    /* initialize dma descriptor array */
>>> +    mem_addr = runtime->dma_addr;
>>> +    order_addr = prtd->dma_desc_arr_phy;
>>> +    for (i = 0; i < num_periods; i++) {
>>> +        desc = &prtd->dma_desc_arr[i];
>>> +
>>> +        /* next descriptor physical address */
>>> +        order_addr += sizeof(*desc);
>>> +        desc->order = lower_32_bits(order_addr | BIT(0));
>>> +        desc->order_hi = upper_32_bits(order_addr);
>>> +
>>> +        desc->saddr = lower_32_bits(mem_addr);
>>> +        desc->saddr_hi = upper_32_bits(mem_addr);
>>> +        desc->daddr = prtd->dma_data->dev_addr;
>>> +
>>> +        desc->cmd = BIT(0);
>>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>> +            desc->cmd |= BIT(12);
>>> +
>>> +        desc->length = period_len >> 2;
>>> +        desc->step_length = 0;
>>> +        desc->step_times = 1;
>>> +
>>> +        mem_addr += period_len;
>>> +    }
>>> +    desc = &prtd->dma_desc_arr[num_periods - 1];
>>> +    desc->order = lower_32_bits(prtd->dma_desc_arr_phy | BIT(0));
>>> +    desc->order_hi = upper_32_bits(prtd->dma_desc_arr_phy);
>>> +
>>> +    /* init position descriptor */
>>> +    *prtd->dma_pos_desc = *prtd->dma_desc_arr;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static snd_pcm_uframes_t
>>> +loongson_pcm_pointer(struct snd_soc_component *component,
>>> +             struct snd_pcm_substream *substream)
>>> +{
>>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>>> +    struct loongson_runtime_data *prtd = runtime->private_data;
>>> +    struct loongson_dma_desc *desc;
>>> +    snd_pcm_uframes_t x;
>>> +    u64 addr;
>>> +
>>> +    desc = dma_desc_save(prtd);
>>> +    addr = ((u64)desc->saddr_hi << 32) | desc->saddr;
>>> +
>>> +    x = bytes_to_frames(runtime, addr - runtime->dma_addr);
>>> +    if (x == runtime->buffer_size)
>>> +        x = 0;
>>> +    return x;
>>> +}
>>> +
>>> +static irqreturn_t loongson_pcm_dma_irq(int irq, void *devid)
>>> +{
>>> +    struct snd_pcm_substream *substream = devid;
>>> +
>>> +    snd_pcm_period_elapsed(substream);
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int loongson_pcm_open(struct snd_soc_component *component,
>>> +                 struct snd_pcm_substream *substream)
>>> +{
>>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +    struct snd_card *card = substream->pcm->card;
>>> +    struct loongson_runtime_data *prtd;
>>> +    struct loongson_dma_data *dma_data;
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * For mysterious reasons (and despite what the manual says)
>>> +     * playback samples are lost if the DMA count is not a multiple
>>> +     * of the DMA burst size.  Let's add a rule to enforce that.
>>> +     */
>>> +    snd_pcm_hw_constraint_step(runtime, 0,
>>> +                   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
>>> +    snd_pcm_hw_constraint_step(runtime, 0,
>>> +                   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 128);
>>> +    snd_pcm_hw_constraint_integer(substream->runtime,
>>> +                      SNDRV_PCM_HW_PARAM_PERIODS);
>>> +    snd_soc_set_runtime_hwparams(substream, &ls_pcm_hardware);
>>> +
>>> +    prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
>>> +    if (!prtd)
>>> +        return -ENOMEM;
>>> +
>>> +    prtd->dma_desc_arr = dma_alloc_coherent(card->dev, PAGE_SIZE,
>>> +                        &prtd->dma_desc_arr_phy,
>>> +                        GFP_KERNEL);
>>> +    if (!prtd->dma_desc_arr) {
>>> +        ret = -ENOMEM;
>>> +        goto desc_err;
>>> +    }
>>> +    prtd->dma_desc_arr_size = PAGE_SIZE / sizeof(*prtd->dma_desc_arr);
>>> +
>>> +    prtd->dma_pos_desc = dma_alloc_coherent(card->dev,
>>> +                        sizeof(*prtd->dma_pos_desc),
>>> +                        &prtd->dma_pos_desc_phy,
>>> +                        GFP_KERNEL);
>>> +    if (!prtd->dma_pos_desc) {
>>> +        ret = -ENOMEM;
>>> +        goto pos_err;
>>> +    }
>>> +
>>> +    dma_data = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), 
>>> substream);
>>> +    prtd->dma_data = dma_data;
>>> +
>>> +    substream->runtime->private_data = prtd;
>>> +
>>> +    return 0;
>>> +pos_err:
>>> +    dma_free_coherent(card->dev, PAGE_SIZE, prtd->dma_desc_arr,
>>> +              prtd->dma_desc_arr_phy);
>>> +desc_err:
>>> +    kfree(prtd);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int loongson_pcm_close(struct snd_soc_component *component,
>>> +                  struct snd_pcm_substream *substream)
>>> +{
>>> +    struct snd_card *card = substream->pcm->card;
>>> +    struct loongson_runtime_data *prtd = 
>>> substream->runtime->private_data;
>>> +
>>> +    dma_free_coherent(card->dev, PAGE_SIZE, prtd->dma_desc_arr,
>>> +              prtd->dma_desc_arr_phy);
>>> +
>>> +    dma_free_coherent(card->dev, sizeof(*prtd->dma_pos_desc),
>>> +              prtd->dma_pos_desc, prtd->dma_pos_desc_phy);
>>> +
>>> +    kfree(prtd);
>>> +    return 0;
>>> +}
>>> +
>>> +static int loongson_pcm_mmap(struct snd_soc_component *component,
>>> +                 struct snd_pcm_substream *substream,
>>> +                 struct vm_area_struct *vma)
>>> +{
>>> +    return remap_pfn_range(vma, vma->vm_start,
>>> +            substream->dma_buffer.addr >> PAGE_SHIFT,
>>> +            vma->vm_end - vma->vm_start, vma->vm_page_prot);
>>> +}
>>> +
>>> +static int loongson_pcm_new(struct snd_soc_component *component,
>>> +                struct snd_soc_pcm_runtime *rtd)
>>> +{
>>> +    struct snd_card *card = rtd->card->snd_card;
>>> +    struct snd_pcm_substream *substream;
>>> +    struct loongson_dma_data *dma_data;
>>> +    unsigned int i;
>>> +    int ret;
>>> +
>>> +    for_each_pcm_streams(i) {
>>> +        substream = rtd->pcm->streams[i].substream;
>>> +        if (!substream)
>>> +            continue;
>>> +
>>> +        dma_data = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0),
>>> +                            substream);
>>> +        ret = devm_request_irq(card->dev, dma_data->irq,
>>> +                       loongson_pcm_dma_irq,
>>> +                       IRQF_TRIGGER_HIGH, LS_I2S_DRVNAME,
>>> +                       substream);
>>> +        if (ret < 0) {
>>> +            dev_err(card->dev, "request irq for DMA failed\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    return snd_pcm_set_fixed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
>>> +                        card->dev,
>>> +                        ls_pcm_hardware.buffer_bytes_max);
>>> +}
>>> +
>>> +const struct snd_soc_component_driver loongson_i2s_component = {
>>> +    .name        = LS_I2S_DRVNAME,
>>> +    .open        = loongson_pcm_open,
>>> +    .close        = loongson_pcm_close,
>>> +    .hw_params    = loongson_pcm_hw_params,
>>> +    .trigger    = loongson_pcm_trigger,
>>> +    .pointer    = loongson_pcm_pointer,
>>> +    .mmap        = loongson_pcm_mmap,
>>> +    .pcm_construct    = loongson_pcm_new,
>>> +};
>>> diff --git a/sound/soc/loongson/loongson_dma.h 
>>> b/sound/soc/loongson/loongson_dma.h
>>> new file mode 100644
>>> index 000000000000..073ee8c0c046
>>> --- /dev/null
>>> +++ b/sound/soc/loongson/loongson_dma.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * ALSA ASoC interface for the Loongson platform
>>> + *
>>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>>> + * Author: Yingkun Meng <mengyingkun@loongson.cn>
>>> + */
>>> +
>>> +#ifndef _LOONGSON_DMA_H
>>> +#define _LOONGSON_DMA_H
>>> +
>>> +#include <sound/soc.h>
>>> +
>>> +extern const struct snd_soc_component_driver loongson_i2s_component;
>>> +
>>> +#endif
>>> diff --git a/sound/soc/loongson/loongson_i2s.c 
>>> b/sound/soc/loongson/loongson_i2s.c
>>> new file mode 100644
>>> index 000000000000..35d34568be79
>>> --- /dev/null
>>> +++ b/sound/soc/loongson/loongson_i2s.c
>>> @@ -0,0 +1,269 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// Common functions for loongson I2S controller driver
>>> +//
>>> +// Copyright (C) 2023 Loongson Technology Corporation Limited.
>>> +// Author: Yingkun Meng <mengyingkun@loongson.cn>
>>> +//
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <sound/soc.h>
>>> +#include <linux/regmap.h>
>>> +#include <sound/pcm_params.h>
>>> +#include "loongson_i2s.h"
>>> +
>>> +#define LOONGSON_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | \
>>> +            SNDRV_PCM_FMTBIT_S16_LE | \
>>> +            SNDRV_PCM_FMTBIT_S20_3LE | \
>>> +            SNDRV_PCM_FMTBIT_S24_LE)
>>> +
>>> +static int loongson_i2s_trigger(struct snd_pcm_substream 
>>> *substream, int cmd,
>>> +                struct snd_soc_dai *dai)
>>> +{
>>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>>> +    int ret = 0;
>>> +
>>> +    switch (cmd) {
>>> +    case SNDRV_PCM_TRIGGER_START:
>>> +    case SNDRV_PCM_TRIGGER_RESUME:
>>> +    case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>>> +                       I2S_CTRL_TX_EN | I2S_CTRL_TX_DMA_EN,
>>> +                       I2S_CTRL_TX_EN | I2S_CTRL_TX_DMA_EN);
>>> +        else
>>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>>> +                       I2S_CTRL_RX_EN | I2S_CTRL_RX_DMA_EN,
>>> +                       I2S_CTRL_RX_EN | I2S_CTRL_RX_DMA_EN);
>>> +        break;
>>> +    case SNDRV_PCM_TRIGGER_STOP:
>>> +    case SNDRV_PCM_TRIGGER_SUSPEND:
>>> +    case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>>> +                    I2S_CTRL_TX_EN | I2S_CTRL_TX_DMA_EN, 0);
>>> +        else
>>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>>> +                    I2S_CTRL_RX_EN | I2S_CTRL_RX_DMA_EN, 0);
>>> +        break;
>>> +    default:
>>> +        ret = -EINVAL;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int loongson_i2s_hw_params(struct snd_pcm_substream *substream,
>>> +                  struct snd_pcm_hw_params *params,
>>> +                  struct snd_soc_dai *dai)
>>> +{
>>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>>> +    u32 clk_rate = i2s->clk_rate;
>>> +    u32 sysclk = i2s->sysclk;
>>> +    u32 bits = params_width(params);
>>> +    u32 chans = params_channels(params);
>>> +    u32 fs = params_rate(params);
>>> +    u32 bclk_ratio, mclk_ratio;
>>> +    u32 mclk_ratio_frac;
>>> +    u32 val = 0;
>>> +
>>> +    switch (i2s->rev_id) {
>>> +    case 0:
>>> +        bclk_ratio = DIV_ROUND_CLOSEST(clk_rate,
>>> +                           (bits * chans * fs * 2)) - 1;
>>> +        mclk_ratio = DIV_ROUND_CLOSEST(clk_rate, (sysclk * 2)) - 1;
>>> +
>>> +        /* According to 2k1000LA user manual, set bits == depth */
>>> +        val |= (bits << 24);
>>> +        val |= (bits << 16);
>>> +        val |= (bclk_ratio << 8);
>>> +        val |= mclk_ratio;
>>> +        regmap_write(i2s->regmap, LS_I2S_CFG, val);
>>> +
>>> +        break;
>>> +    case 1:
>>> +        bclk_ratio = DIV_ROUND_CLOSEST(sysclk,
>>> +                           (bits * chans * fs * 2)) - 1;
>>> +        mclk_ratio = clk_rate / sysclk;
>>> +        mclk_ratio_frac = DIV_ROUND_CLOSEST(((u64)clk_rate << 16),
>>> +                            sysclk) - (mclk_ratio << 16);
>>> +
>>> +        regmap_read(i2s->regmap, LS_I2S_CFG, &val);
>>> +        val |= (bits << 24);
>>> +        val |= (bclk_ratio << 8);
>>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>> +            val |= (bits << 16);
>>> +        else
>>> +            val |= bits;
>>> +        regmap_write(i2s->regmap, LS_I2S_CFG, val);
>>> +
>>> +        val = (mclk_ratio_frac << 16) | mclk_ratio;
>>> +        regmap_write(i2s->regmap, LS_I2S_CFG1, val);
>>> +
>>> +        break;
>>> +    default:
>>> +        dev_err(i2s->dev, "I2S revision invalid\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int loongson_i2s_set_dai_sysclk(struct snd_soc_dai *dai, int 
>>> clk_id,
>>> +                       unsigned int freq, int dir)
>>> +{
>>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>>> +
>>> +    i2s->sysclk = freq;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int loongson_i2s_set_fmt(struct snd_soc_dai *dai, unsigned 
>>> int fmt)
>>> +{
>>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>>> +    u32 val;
>>> +    int ret;
>>> +
>>> +    switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>>> +    case SND_SOC_DAIFMT_I2S:
>>> +        break;
>>> +    case SND_SOC_DAIFMT_RIGHT_J:
>>> +        regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MSB,
>>> +                   I2S_CTRL_MSB);
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +
>>> +    switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>>> +    case SND_SOC_DAIFMT_BC_FC:
>>> +        break;
>>> +    case SND_SOC_DAIFMT_BP_FC:
>>> +        /* Enable master mode */
>>> +        regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MASTER,
>>> +                   I2S_CTRL_MASTER);
>>> +        if (i2s->rev_id == 1) {
>>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>>> +                        LS_I2S_CTRL, val,
>>> +                        val & I2S_CTRL_CLK_READY,
>>> +                        10, 500000);
>>> +            if (ret < 0)
>>> +                dev_warn(dai->dev, "wait BCLK ready timeout\n");
>>> +        }
>>> +        break;
>>> +    case SND_SOC_DAIFMT_BC_FP:
>>> +        /* Enable MCLK */
>>> +        if (i2s->rev_id == 1) {
>>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>>> +                       I2S_CTRL_MCLK_EN,
>>> +                       I2S_CTRL_MCLK_EN);
>>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>>> +                        LS_I2S_CTRL, val,
>>> +                        val & I2S_CTRL_MCLK_READY,
>>> +                        10, 500000);
>>> +            if (ret < 0)
>>> +                dev_warn(dai->dev, "wait MCLK ready timeout\n");
>>> +        }
>>> +        break;
>>> +    case SND_SOC_DAIFMT_BP_FP:
>>> +        /* Enable MCLK */
>>> +        if (i2s->rev_id == 1) {
>>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>>> +                       I2S_CTRL_MCLK_EN,
>>> +                       I2S_CTRL_MCLK_EN);
>>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>>> +                        LS_I2S_CTRL, val,
>>> +                        val & I2S_CTRL_MCLK_READY,
>>> +                        10, 500000);
>>> +            if (ret < 0)
>>> +                dev_warn(dai->dev, "wait MCLK ready timeout\n");
>>> +        }
>>> +
>>> +        /* Enable master mode */
>>> +        regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MASTER,
>>> +                   I2S_CTRL_MASTER);
>>> +        if (i2s->rev_id == 1) {
>>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>>> +                        LS_I2S_CTRL, val,
>>> +                        val & I2S_CTRL_CLK_READY,
>>> +                        10, 500000);
>>> +            if (ret < 0)
>>> +                dev_warn(dai->dev, "wait BCLK ready timeout\n");
>>> +        }
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct snd_soc_dai_ops loongson_i2s_dai_ops = {
>>> +    .trigger    = loongson_i2s_trigger,
>>> +    .hw_params    = loongson_i2s_hw_params,
>>> +    .set_sysclk    = loongson_i2s_set_dai_sysclk,
>>> +    .set_fmt    = loongson_i2s_set_fmt,
>>> +};
>>> +
>>> +static int loongson_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
>>> +{
>>> +    struct loongson_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
>>> +
>>> +    snd_soc_dai_init_dma_data(cpu_dai, &i2s->playback_dma_data,
>>> +                  &i2s->capture_dma_data);
>>> +    snd_soc_dai_set_drvdata(cpu_dai, i2s);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +struct snd_soc_dai_driver loongson_i2s_dai = {
>>> +    .name = "loongson-i2s",
>>> +    .probe = loongson_i2s_dai_probe,
>>> +    .playback = {
>>> +        .stream_name = "CPU-Playback",
>>> +        .channels_min = 1,
>>> +        .channels_max = 2,
>>> +        .rates = SNDRV_PCM_RATE_8000_96000,
>>> +        .formats = LOONGSON_I2S_FORMATS,
>>> +    },
>>> +    .capture = {
>>> +        .stream_name = "CPU-Capture",
>>> +        .channels_min = 1,
>>> +        .channels_max = 2,
>>> +        .rates = SNDRV_PCM_RATE_8000_96000,
>>> +        .formats = LOONGSON_I2S_FORMATS,
>>> +    },
>>> +    .ops = &loongson_i2s_dai_ops,
>>> +    .symmetric_rate = 1,
>>> +};
>>> +
>>> +static int i2s_suspend(struct device *dev)
>>> +{
>>> +    struct loongson_i2s *i2s = dev_get_drvdata(dev);
>>> +
>>> +    regcache_cache_only(i2s->regmap, true);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int i2s_resume(struct device *dev)
>>> +{
>>> +    struct loongson_i2s *i2s = dev_get_drvdata(dev);
>>> +    int ret;
>>> +
>>> +    regcache_cache_only(i2s->regmap, false);
>>> +    regcache_mark_dirty(i2s->regmap);
>>> +    ret = regcache_sync(i2s->regmap);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +const struct dev_pm_ops loongson_i2s_pm = {
>>> +    SET_SYSTEM_SLEEP_PM_OPS(i2s_suspend, i2s_resume)
>>> +};
>>> diff --git a/sound/soc/loongson/loongson_i2s.h 
>>> b/sound/soc/loongson/loongson_i2s.h
>>> new file mode 100644
>>> index 000000000000..52788f6a94ad
>>> --- /dev/null
>>> +++ b/sound/soc/loongson/loongson_i2s.h
>>> @@ -0,0 +1,71 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * ALSA I2S interface for the Loongson platform
>>> + *
>>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>>> + * Author: Yingkun Meng <mengyingkun@loongson.cn>
>>> + */
>>> +
>>> +#ifndef _LOONGSON_I2S_H
>>> +#define _LOONGSON_I2S_H
>>> +
>>> +#include <linux/regmap.h>
>>> +#include <sound/dmaengine_pcm.h>
>>> +
>>> +/* I2S Common Registers */
>>> +#define LS_I2S_VER    0x00 /* I2S Version */
>>> +#define LS_I2S_CFG    0x04 /* I2S Config */
>>> +#define LS_I2S_CTRL    0x08 /* I2S Control */
>>> +#define LS_I2S_RX_DATA    0x0C /* I2S DMA RX Address */
>>> +#define LS_I2S_TX_DATA    0x10 /* I2S DMA TX Address */
>>> +
>>> +/* 2K2000 I2S Specify Registers */
>>> +#define LS_I2S_CFG1    0x14 /* I2S Config1 */
>>> +
>>> +/* 7A2000 I2S Specify Registers */
>>> +#define LS_I2S_TX_ORDER    0x100 /* TX DMA Order */
>>> +#define LS_I2S_RX_ORDER 0x110 /* RX DMA Order */
>>> +
>>> +/* Loongson I2S Control Register */
>>> +#define I2S_CTRL_MCLK_READY    (1 << 16) /* MCLK ready */
>>> +#define I2S_CTRL_MASTER        (1 << 15) /* Master mode */
>>> +#define I2S_CTRL_MSB        (1 << 14) /* MSB bit order */
>>> +#define I2S_CTRL_RX_EN        (1 << 13) /* RX enable */
>>> +#define I2S_CTRL_TX_EN        (1 << 12) /* TX enable */
>>> +#define I2S_CTRL_RX_DMA_EN    (1 << 11) /* DMA RX enable */
>>> +#define I2S_CTRL_CLK_READY    (1 << 8)  /* BCLK ready */
>>> +#define I2S_CTRL_TX_DMA_EN    (1 << 7)  /* DMA TX enable */
>>> +#define I2S_CTRL_RESET        (1 << 4)  /* Controller soft reset */
>>> +#define I2S_CTRL_MCLK_EN    (1 << 3)  /* Enable MCLK */
>>> +#define I2S_CTRL_RX_INT_EN    (1 << 1)  /* RX interrupt enable */
>>> +#define I2S_CTRL_TX_INT_EN    (1 << 0)  /* TX interrupt enable */
>>> +
>>> +#define LS_I2S_DRVNAME        "loongson-i2s"
>>> +
>>> +struct loongson_dma_data {
>>> +    dma_addr_t dev_addr;        /* device physical address for DMA */
>>> +    void __iomem *order_addr;    /* DMA order register */
>>> +    u32 irq;            /* DMA irq */
>>> +};
>>> +
>>> +struct loongson_i2s {
>>> +    struct device *dev;
>>> +    union {
>>> +        struct snd_dmaengine_dai_dma_data playback_dma_data;
>>> +        struct loongson_dma_data tx_dma_data;
>>> +    };
>>> +    union {
>>> +        struct snd_dmaengine_dai_dma_data capture_dma_data;
>>> +        struct loongson_dma_data rx_dma_data;
>>> +    };
>>> +    struct regmap *regmap;
>>> +    void __iomem *reg_base;
>>> +    u32 rev_id;
>>> +    u32 clk_rate;
>>> +    u32 sysclk;
>>> +};
>>> +
>>> +extern const struct dev_pm_ops loongson_i2s_pm;
>>> +extern struct snd_soc_dai_driver loongson_i2s_dai;
>>> +
>>> +#endif
>>> diff --git a/sound/soc/loongson/loongson_i2s_pci.c 
>>> b/sound/soc/loongson/loongson_i2s_pci.c
>>> new file mode 100644
>>> index 000000000000..6dcfb17d3276
>>> --- /dev/null
>>> +++ b/sound/soc/loongson/loongson_i2s_pci.c
>>> @@ -0,0 +1,171 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// loongson_i2s_pci.c -- Loongson I2S controller driver
>>> +//
>>> +// Copyright (C) 2023 Loongson Technology Corporation Limited
>>> +// Author: Yingkun Meng <mengyingkun@loongson.cn>
>>> +//
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/pci.h>
>>> +#include <sound/soc.h>
>>> +#include "loongson_i2s.h"
>>> +#include "loongson_dma.h"
>>> +
>>> +static bool loongson_i2s_wr_reg(struct device *dev, unsigned int reg)
>>> +{
>>> +    switch (reg) {
>>> +    case LS_I2S_CFG:
>>> +    case LS_I2S_CTRL:
>>> +    case LS_I2S_RX_DATA:
>>> +    case LS_I2S_TX_DATA:
>>> +    case LS_I2S_CFG1:
>>> +        return true;
>>> +    default:
>>> +        return false;
>>> +    };
>>> +}
>>> +
>>> +static bool loongson_i2s_rd_reg(struct device *dev, unsigned int reg)
>>> +{
>>> +    switch (reg) {
>>> +    case LS_I2S_VER:
>>> +    case LS_I2S_CFG:
>>> +    case LS_I2S_CTRL:
>>> +    case LS_I2S_RX_DATA:
>>> +    case LS_I2S_TX_DATA:
>>> +    case LS_I2S_CFG1:
>>> +        return true;
>>> +    default:
>>> +        return false;
>>> +    };
>>> +}
>>> +
>>> +static bool loongson_i2s_volatile_reg(struct device *dev, unsigned 
>>> int reg)
>>> +{
>>> +    switch (reg) {
>>> +    case LS_I2S_CFG:
>>> +    case LS_I2S_CTRL:
>>> +    case LS_I2S_RX_DATA:
>>> +    case LS_I2S_TX_DATA:
>>> +    case LS_I2S_CFG1:
>>> +        return true;
>>> +    default:
>>> +        return false;
>>> +    };
>>> +}
>>> +
>>> +static const struct regmap_config loongson_i2s_regmap_config = {
>>> +    .reg_bits = 32,
>>> +    .reg_stride = 4,
>>> +    .val_bits = 32,
>>> +    .max_register = LS_I2S_CFG1,
>>> +    .writeable_reg = loongson_i2s_wr_reg,
>>> +    .readable_reg = loongson_i2s_rd_reg,
>>> +    .volatile_reg = loongson_i2s_volatile_reg,
>>> +    .cache_type = REGCACHE_FLAT,
>>> +};
>>> +
>>> +static int loongson_i2s_pci_probe(struct pci_dev *pdev,
>>> +                  const struct pci_device_id *pid)
>>> +{
>>> +    const struct fwnode_handle *fwnode = pdev->dev.fwnode;
>>> +    struct loongson_dma_data *tx_data, *rx_data;
>>> +    struct loongson_i2s *i2s;
>>> +    int ret;
>>> +
>>> +    if (pcim_enable_device(pdev)) {
>>> +        dev_err(&pdev->dev, "pci_enable_device failed\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
>>> +    if (!i2s)
>>> +        return -ENOMEM;
>>> +
>>> +    i2s->rev_id = pdev->revision;
>>> +    i2s->dev = &pdev->dev;
>>> +    pci_set_drvdata(pdev, i2s);
>>> +
>>> +    ret = pcim_iomap_regions(pdev, 1 << 0, dev_name(&pdev->dev));
>>> +    if (ret < 0) {
>>> +        dev_err(&pdev->dev, "iomap_regions failed\n");
>>> +        return ret;
>>> +    }
>>> +    i2s->reg_base = pcim_iomap_table(pdev)[0];
>>> +    i2s->regmap = devm_regmap_init_mmio(&pdev->dev, i2s->reg_base,
>>> +                        &loongson_i2s_regmap_config);
>>> +    if (IS_ERR(i2s->regmap)) {
>>> +        dev_err(&pdev->dev, "regmap_init_mmio failed\n");
>>> +        return PTR_ERR(i2s->regmap);
>>> +    }
>>> +
>>> +    tx_data = &i2s->tx_dma_data;
>>> +    rx_data = &i2s->rx_dma_data;
>>> +
>>> +    tx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_TX_DATA;
>>> +    tx_data->order_addr = i2s->reg_base + LS_I2S_TX_ORDER;
>>> +
>>> +    rx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_RX_DATA;
>>> +    rx_data->order_addr = i2s->reg_base + LS_I2S_RX_ORDER;
>>> +
>>> +    tx_data->irq = fwnode_irq_get_byname(fwnode, "tx");
>>
>> Smatch detects that tx_data->irq and rx_data->irq are of type 
>> u32(unsigned) so they can never be negative.
>>
>>> +    if (tx_data->irq < 0) {
>>              ^^^^^^^^ This can never be true.
>>
>> Should irq be of type 'int' instead?
>>
>>> +        dev_err(&pdev->dev, "dma tx irq invalid\n");
>>> +        return tx_data->irq;
>>> +    }
>>> +
>>> +    rx_data->irq = fwnode_irq_get_byname(fwnode, "rx");
>>> +    if (rx_data->irq < 0) {
>>              ^^^ Same problem here.
>>
>> Should irq
>
> Should 'irq' be of type int instead?
>
> As fwnode_irq_get_byname() returns a integer.
>
Yes, you are right. I will add a patch to fix the type of 'irq' to int.

Thanks,
Yingkun


> Thanks,
> Harshit
>
>>> +        dev_err(&pdev->dev, "dma rx irq invalid\n");
>>> +        return rx_data->irq;
>>> +    }
>>> +
>>> +    device_property_read_u32(&pdev->dev, "clock-frequency", 
>>> &i2s->clk_rate);
>>> +    if (!i2s->clk_rate) {
>>> +        dev_err(&pdev->dev, "clock-frequency property invalid\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>> +
>>> +    if (i2s->rev_id == 1) {
>>> +        regmap_write(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_RESET);
>>> +        udelay(200);
>>> +    }
>>> +
>>> +    ret = devm_snd_soc_register_component(&pdev->dev,
>>> +                          &loongson_i2s_component,
>>> +                          &loongson_i2s_dai, 1);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "register DAI failed %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct pci_device_id loongson_i2s_ids[] = {
>>> +    { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a27) },
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(pci, loongson_i2s_ids);
>>> +
>>> +static struct pci_driver loongson_i2s_driver = {
>>> +    .name = "loongson-i2s-pci",
>>> +    .id_table = loongson_i2s_ids,
>>> +    .probe = loongson_i2s_pci_probe,
>>> +    .driver = {
>>> +        .owner = THIS_MODULE,
>>> +        .pm = pm_sleep_ptr(&loongson_i2s_pm),
>>> +    },
>>> +};
>>> +module_pci_driver(loongson_i2s_driver);
>>> +
>>> +MODULE_DESCRIPTION("Loongson I2S Master Mode ASoC Driver");
>>> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
>>> +MODULE_LICENSE("GPL");
>>
>> Thanks,
>> Harshit

