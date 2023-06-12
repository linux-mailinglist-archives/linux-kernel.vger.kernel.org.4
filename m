Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9902272B52B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjFLBpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:45:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28CB9F0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 18:45:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8Cxe+qpeIZk0VUDAA--.7228S3;
        Mon, 12 Jun 2023 09:45:13 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK8qoeIZkT6gUAA--.51150S3;
        Mon, 12 Jun 2023 09:45:12 +0800 (CST)
Message-ID: <525b814e-3ae2-cfe2-f2fd-8560928c45bc@loongson.cn>
Date:   Mon, 12 Jun 2023 09:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] ASoC: Add support for Loongson I2S controller
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        linux-kernel@vger.kernel.org
References: <20230605120934.2306548-1-mengyingkun@loongson.cn>
 <f88a4985-0dc1-4599-8656-2029c0825495@sirena.org.uk>
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <f88a4985-0dc1-4599-8656-2029c0825495@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxK8qoeIZkT6gUAA--.51150S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAADGSFuYEC2QABsO
X-Coremail-Antispam: 1Uk129KBj93XoW7tr18Kr48Jw4UWw1xJF1UArc_yoW8Cr1kpr
        WUuFy3KF12qr4FyF1DtFy8XFy5AFZxtr15Aw4DJr47ZrnI93s5trW8KFWFkF9xCr92yr4j
        vw48X3y0kws0yFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/5 21:17, Mark Brown wrote:
> On Mon, Jun 05, 2023 at 08:09:32PM +0800, YingKun Meng wrote:
>
>> +			regmap_read_poll_timeout_atomic(i2s->regmap,
>> +						LS_I2S_CTRL, val,
>> +						!(val & I2S_CTRL_MCLK_READY),
>> +						10, 2000);
> The driver is waiting for status bits to change in the regmap but...


Break condition reversed. Fixed in new version.

>
>> +		pr_err("buf len not multiply of period len\n");
> Use dev_ functions to log things please.


OK.

>> +static const struct regmap_config loongson_i2s_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.max_register = 0x110,
>> +	.cache_type = REGCACHE_FLAT,
>> +};
> ...there are no volatile registers in the regmap so we will never read
> from the hardware.  I don't understand how this can work?
>

The I2S controller has two private DMA controllers to transfer the audio
data.
Its register set is divided into two parts: I2S control registers and
DMA control registers.

1) The I2S control registers are used to config I2S parameters, accessed
by regmap API. So we don't need to read back.

2) The DMA control registers are used to maintain the status of audio
data transmission.
These registers isn't maintained by regmap. They are accessed using
readx()/writex() APIs.

>> +	i2s->reg_base = pci_iomap(pdev, BAR_NUM, 0);
>> +	if (!i2s->reg_base) {
>> +		dev_err(&pdev->dev, "pci_iomap_error\n");
>> +		ret = -EIO;
>> +		goto err_release;
>> +	}
> pcim_iomap()?


OK.

>> +	dev_set_name(&pdev->dev, "%s", loongson_i2s_dai.name);
> Don't log static information like this, it just adds noise and makes the
> boot slower.


Removed in new version. Its original purpose is to set a fixed value for
platform component name, and match this value in machine driver.

>> +	pci_disable_device(pdev);
> pcim_enable_device() too.


OK.

