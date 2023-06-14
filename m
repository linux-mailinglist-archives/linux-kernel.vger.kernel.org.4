Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753AD72F8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbjFNJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbjFNJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:06:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D27661BE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:06:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8CxNukNg4lk2gwFAA--.8715S3;
        Wed, 14 Jun 2023 17:06:21 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxReQLg4lk3GoaAA--.10231S3;
        Wed, 14 Jun 2023 17:06:19 +0800 (CST)
Message-ID: <818629a3-c934-d0d7-b872-9cf82ab49b98@loongson.cn>
Date:   Wed, 14 Jun 2023 17:05:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ PATCH v2 1/3] ASoC: Add support for Loongson I2S controller
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230612085318.3039485-1-mengyingkun@loongson.cn>
 <8b069919-664d-4329-9168-ec8f26fef647@sirena.org.uk>
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <8b069919-664d-4329-9168-ec8f26fef647@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxReQLg4lk3GoaAA--.10231S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQACDGSIXIITNwABsY
X-Coremail-Antispam: 1Uk129KBj93XoW3AF1kGrWrKr45KryUXF17XFc_yoW7Zr4rpa
        yUua1DKrn5JF4xAw1qqw4kZF15Zw4fAFZ8Cw45J347Ar9xZr1F9343KF4rGFy3Cr9xKw4j
        vr1Fqw4xCFyDGagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc0eHDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/13 02:52, Mark Brown wrote:
> On Mon, Jun 12, 2023 at 04:53:18PM +0800, YingKun Meng wrote:
>
>> Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
>> it is a PCI device with two private DMA controllers, one for playback,
>> the other for capture.
>>
>> The driver supports the use of DTS or ACPI to describe device resources.
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202306060223.9hdivLrx-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202306060320.Sphw0ihy-lkp@intel.com/
> These don't really make sense for a new driver.
>

OK, removed in new version.

>> @@ -0,0 +1,213 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Loongson-2K I2S master mode driver
>> + *
>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>> + */
> Please make the entire comment a C++ one so things look more
> intentional.  You might also want to update the copyright year if there
> was any substantial work on the driver recently.

OK.

>> +		/* Enable master mode */
>> +		regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MASTER,
>> +				   I2S_CTRL_MASTER);
>> +		if (i2s->rev_id == 1) {
>> +			ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>> +						LS_I2S_CTRL, val,
>> +						val & I2S_CTRL_CLK_READY,
>> +						10, 2000);
>> +			if (ret < 0)
>> +				dev_warn(dai->dev, "wait BCLK ready timeout\n");
>> +		}
> Ideally you'd have a set_dai_fmt() operation and support both clock
> provider and consumer mode.

Got it, add .set_fmt callback for DAI ops in new version.

>> +	if (i2s->rev_id == 0) {
>> +	} else if (i2s->rev_id == 1) {
>> +	} else
>> +		dev_err(i2s->dev, "I2S revision invalid\n");
>> +
> This looks like a switch statement.


OK, replaced with a switch statement in new version.

>
>> +static int loongson_i2s_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>> +				       unsigned int freq, int dir)
>> +{
>> +	struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +
>> +	i2s->sysclk = freq;
>> +
>> +	return 0;
>> +}
> Should this be integrated with the clock API rather than just using the
> ASoC specific stuff - where does this sysclk come from?  I do note that
> the PCI driver appears to have a fixed clock...
>
You are right, PCI bus has a fixed clock.

On loongson 7A2000/2K2000 chips, the I2S controller has PCI configuration
address space, IO address space, and memory address space, it works as
a PCI device, but it's not a standard PCI device.

Its clock signal comes from the APB bus or AIX bus, not from PCI bus.
Currently, there is no good support from clock subsystem, the frequency of
the I2S controller's driver clock is a fixed value.

>> +void loongson_i2s_init(struct loongson_i2s *i2s)
>> +{
>> +	if (i2s->rev_id == 1) {
>> +		regmap_write(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_RESET);
>> +		udelay(200);
>> +	}
>> +}
> What's this for?  I'd expect initialising the hardware to be handled
> internally within the driver but this is semi-exported?


On 2K1000LA chip, the i2s controller is a platform device, it's supported
by another driver. My original purpose was to export an API to initializing
hardware.
It's OK to move this to specific I2S driver.

>> diff --git a/sound/soc/loongson/loongson_i2s_pci.c b/sound/soc/loongson/loongson_i2s_pci.c
>> new file mode 100644
>> index 000000000000..f09713b560e9
>> --- /dev/null
>> +++ b/sound/soc/loongson/loongson_i2s_pci.c
>> @@ -0,0 +1,500 @@
> Please split the PCI driver into a separate patch to keep the individual
> reviews smaller.


OK, the driver split into PCI driver and DMA driver in new version.

>> +static int loongson_pcm_trigger(struct snd_soc_component *component,
>> +				struct snd_pcm_substream *substream, int cmd)
>> +{
>> +	switch (cmd) {
>> +	default:
>> +		ret = -EINVAL;
>> +	}
> Missing break; here.


Fixed. Return directly.

>
>> +	/* initialize dma descriptor array */
>> +	mem_addr = runtime->dma_addr;
>> +	order_addr = prtd->dma_desc_arr_phy;
>> +	for (i = 0; i < num_periods; i++) {
>> +		desc = &prtd->dma_desc_arr[i];
> We didn't validate that the number of periods fits in the array.
>

Fixed. Check the number of periods before initializing the descriptor array.

>> +	if (num_periods > 0) {
>> +		desc = &prtd->dma_desc_arr[num_periods - 1];
>> +		desc->order = lower_32_bits(prtd->dma_desc_arr_phy | BIT(0));
>> +		desc->order_hi = upper_32_bits(prtd->dma_desc_arr_phy);
>> +	}
> This is always true, right?


Yes, remove the condition check.

>> +       ret = request_irq(dma_data->irq, loongson_pcm_dma_irq,
>> +                         IRQF_TRIGGER_HIGH, LS_I2S_DRVNAME, substream);
> Does it really make sense to request and free the interrupt when the
> stream is running?  It's generally better to just request the interrupt
> once during probe(), that way we know we've got all the resources we
> need.  If we do need to allocate/free all the time a comment explaining
> why would be good so people don't go trying to fix this.

No, we can request the interrupt just once.

As one DMA controller controls the transmission of audio data in one direction
(playback or capture), it is associated with a substream.
The operation requesting interrupt is placed in .pcm_construct callback of
snd_soc_component_driver in new version.

>> +	ret = pci_request_region(pdev, BAR_NUM, LS_I2S_DRVNAME);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "request regions failed %d\n", ret);
>> +		return ret;
>> +	}
> pcim_iomap_regions()?  At the minute you'll free the region before devm
> frees the regmap which is probably harmless but not ideal.


OK, replaced in new version.

