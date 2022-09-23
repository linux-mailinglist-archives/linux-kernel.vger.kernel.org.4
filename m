Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991975E7429
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiIWGbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiIWGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:31:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43991288B8;
        Thu, 22 Sep 2022 23:31:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k10so18265574lfm.4;
        Thu, 22 Sep 2022 23:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=cbkvhSGTaqhMw/bo2Jye/uJSqWCAAj5rGiU9y16mw90=;
        b=UL6C4Z+CflzojArJBO4UpboakAJQ63x3LbMFZDyONLqXeeA7+JjjZSyWdptOaq4PtK
         IxoIbsyNlxx8oVXTC0FHr5xRZW/I8Tqsmbb3WL/Na5dclSnJgtDhcrGTmAXH51Zeciid
         9IEF/NhYm0ENysM70SSKrSRTfJSwAkSgLYGGLm2VFm7DZ2wOujKehaerV7vXcAgs9Cqk
         q88hvGRn0MiuPDKc/7qkJLfjZc4dlFBTYYdYI9WdyAjITdVmgH4ZVyTmLRDjcjBdSg3B
         Wzi5gCmy2Wuck5f+dwg/GbBV4Zyh5otwzHFmEvlVZALj+Mk8eDeMADfpWCCGTYKI+sBK
         L+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cbkvhSGTaqhMw/bo2Jye/uJSqWCAAj5rGiU9y16mw90=;
        b=LJ+j3GqlcbkBfLG3j9Pou0al5CHQQC8uYaFRHp4SZtnHTyr8q8H4Z8JAUAZtnuHtOJ
         2Hz4aJQPinHrg+NpPDsWSOhTuUr3G2Kqigc6awx07LW7AGU6AW/BMMDVjQIAXCdqT5XO
         BWR5TTUERMv10nDPZae+VrWoAdz5oTm90lEu+ff943jBNXicBxHjvq2ICvc9WpLtdzKg
         /TMjgTWTX2QJcY31PKDAWlSwsqhTbfoG/LLLhWBx6nQgiknTFgYiwUcFoDGDJvyrhGHQ
         sKZxUDnSsd/cHiZJbyv0iht/lSmsxj4aHkuTj9ae2RkCHFOwLaebUukxYb+KY0CyaigW
         v/fA==
X-Gm-Message-State: ACrzQf19xtveptXiOYy1tPNP3c83Ec4ScNvp/aWkIJE/UoAwMhrl7zXA
        TcGlbpPuJ7NgyRGvs1uArM24R7lHHFA=
X-Google-Smtp-Source: AMsMyM4kbrJ5ynsBwZzcMVzDWBBuid+6MJH2prwn5i4lpiM3hSfPcFW0LBV2wFxFWZHlFJEGebPtIw==
X-Received: by 2002:a05:6512:22d2:b0:498:f68b:6cab with SMTP id g18-20020a05651222d200b00498f68b6cabmr2571473lfu.548.1663914674594;
        Thu, 22 Sep 2022 23:31:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id g5-20020a056512118500b004946bb30469sm1302825lfr.82.2022.09.22.23.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 23:31:13 -0700 (PDT)
Message-ID: <f0ef546a-0ec2-2a52-8f12-8f218960f177@gmail.com>
Date:   Fri, 23 Sep 2022 09:31:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
 <20220922180339.30138141@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
In-Reply-To: <20220922180339.30138141@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 20:03, Jonathan Cameron wrote:
> On Wed, 21 Sep 2022 14:45:35 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
>> ranges (2, 4, 8 and 16g) and probably some other cool fatures.
>>
>> Add support for the basic accelerometer features such as getting the
>> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
>> using the WMI IRQ).
>>
>> Important things to be added include the double-tap, motion
>> detection and wake-up as well as the runtime power management.
>>
>> NOTE: Filling-up the hardware FIFO should be avoided. During my testing
>> I noticed that filling up the hardware FIFO might mess-up the sample
>> count. My sensor ended up in a state where amount of data in FIFO was
>> reported to be 0xff bytes, which equals to 42,5 samples. Specification
>> says the FIFO can hold maximum of 41 samples in HiRes mode. Also, at
>> least once the FIFO was stuck in a state where reading data from
>> hwardware FIFO did not decrease the amount of data reported to be in the
> spell check this.
> 
>> FIFO - eg. FIFO was "stuck". The code has now an error count and 10
>> reads with invalid FIFO data count will cause the fifo contents to be
>> dropped.
> Ouch - that's nasty.

Indeed it is. As this commit states, this is pretty initial support for 
the accelerometer. I want to enable people to do basic experimenting and 
also use the component to some slow ODR solutions. Besides, having even 
a basic support in-tree enable people to add further improvements :) So, 
I am hoping / expecting to see improvements added also by other people 
using this. I think that after this initial support many people still 
_need_ for example the runtime PM. Maybe we will also end up with some 
nicer solution to the FIFO issues.

Oh, please note that the patch is no longer complete. I've "snipped" 
unrelated pieces when replying to Jonathan. I did also just silently 
ignore the comments which I simply agree with.

>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Hi Matti,
> 
> A somewhat superficial review as I'm short on time, but wanted to get some
> initial comments out to you as I'd started reviewing this yesterday and not
> sure when I'd get back to it.

No problem Jonathan. I appreciate the feedback - and even if the review 
has not been completed the initial feedback will already allow me to 
rework :) I won't go anywhere so you can for sure send me more comments 
during the coming new iterations.

Besides, I appreciate your engagement even more as some maintainers do 
not have the time to look at the RFC patches at all. Getting even 
initial feedback this quickly is much more than I expected! So, thanks!

>> +config IIO_KX022A_SPI
>> +	tristate "Kionix KX022A tri-axis digital accelerometer"
>> +	depends on I2C
>> +	select IIO_KX022A
>> +	select REGMAP_SPI
>> +	help
>> +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
>> +	  accelerometer connected to I2C interface. See IIO_KX022A_I2C if
>> +	  you want to enable support for the KX022A connected via I2C.
> 
> I would not bother with the cross reference to the I2C config element.

I thought it might help avoid some confusion - but can be dropped.


>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
> 
> Other than where required for SPDX use the
> /*
>   * Copyright...
>   */
> syntax.

No problem. Some maintainers prefer having the top of the file comment 
block looking coherent and it also pleases my eye more. Still, can be 
changed to suit the IIO-style.

> 
>> +// Copyright (C) 2022 ROHM Semiconductors
>> +//
>> +// ROHM/KIONIX KX022A accelerometer driver
>> +

>> +static int kx022a_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	struct regmap *regmap;
>> +	struct device *dev = &i2c->dev;
>> +
>> +	if (!i2c->irq) {
> 
> There look to be 2 interrupt lines, so you need to know which
> one this is.  fwnode_irq_get_byname() trying first int1 then
> int2 (as only a single one might be mapped).

Seems like you know the Kionix component(s). Cool! My idea is initially 
to only support a fixed configuration with IRQ connected to the IRQ1 
pin. The support for the second IRQ can be added when needed. I think 
it's better to have at first something working and add features 
iteratively when needed. I do also believe that people who add support 
to IRQ2-pin should also be testing this. I have currently only IRQ1 
connected.

Would a comment explaining this do?

You made me think that this should probably be explained in the 
dt-bindings already. I need to add the irq-names and mention that if the 
irq-names is not populated it is assumed (only) the IRQ1 is used.

>> +static struct i2c_driver kx022a_i2c_driver = {
>> +	.driver = {
>> +			.name  = "kx022a-i2c",
>> +			.of_match_table = kx022a_of_match,
>> +		  },
>> +	.probe_new    = kx022a_i2c_probe,
> 
> I'd avoid tab alignment like this. It breaks far to often
> and doesn't really help readability.

Yep. I already fixed this in my local tree yesterday :) Will carry the 
fix to the v2 :)

>> +
>> +struct kx022a_data;
>> +
>> +struct kx022a_trigger {
> 
> Unusual structure. IIRC we normally just squash this stuff into
> the iio_priv structure and set the trigger devdata to the iio_dev.
> I haven't really thought about the advantages of this way around
> but can see a disadvantage is you get circular pointer loops
> this way.

I'd better admit I didn't invent this myself. I stole big parts of the 
logic from the bmc150-accel-core.c which supports multiple triggers. (By 
the way, I should probably metion that in the commit message). All 
triggers are in an array - so if you only get the trigger pointer to one 
of the triggers in the array, then calculating the start of the 
containing struct becomes non trivial.

This does not apply to this driver now as we only support the data-ready 
trigger so I can change this. OTOH, reading the list of features KX022A 
hardware provides - I wouldn't be surprized to see a new trigger(s) in 
the future. It'd be nice to get support for different modes like for 
example capturing N events that were stored prior certain movement. 
These might be best implemented with triggers. What is your adviece - is 
it worth trying to keep adding new trigger(s) as a low-hanging fruit - 
or is it just better to make the current (limited) implementation as 
simple as possible?

>> +	struct kx022a_data *data;
> 
> Looks like you can get to the data pointer via a container_of()
> so do that instead of carrying a pointer to the containing structure.

True. As long as I have just one trigger... (and yes, we have just one 
right now).

>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.78 1.563 3.125 6.25 12.5 25 50 100 200");
>> +static IIO_CONST_ATTR(scale_available,
>> +		      "598.550415 1197.10083 2394.20166 4788.40332");
>> +
>> +static struct attribute *kx022a_attributes[] = {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	&iio_const_attr_scale_available.dev_attr.attr,
> 
> Use the read_avail() callback instead of doing these as attributes.
> That makes the values available to consumer drivers...

Thanks for the guidance. My first IIO driver => all help much appreciated :)

>> +static const unsigned int kx022a_odrs[] = { 1282051282, 639795266, 320000000,
>> +	 160000000, 80000000, 40000000, 20000000, 10000000, 5000000 };
> 
> where we have lots of zeros useful to use the MEGA etc defines in units.h

One of the best things in upstream collaboration is always learning new 
(to me) things :) I'll check then out. Thanks!

>> +
>> +static int kx022a_turn_off_lock(struct kx022a_data *data)
>> +{
>> +	int ret;
> 
> As below, I'm not convinced this wrapper is worthwhile
> 
>> +
>> +	mutex_lock(&data->mutex);
>> +	ret = __kx022a_turn_off_unlocked(data);
>> +	if (ret)
>> +		mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static int kx022a_turn_on_unlock(struct kx022a_data *data)
>> +{
>> +	int ret;
>> +
> This is not used enough that I can see a strong reason for the
> wrapper.  Just put the two calls inline and rename the unlocked case.
> 

I kind of see the value of the wrappers as it documents the purpose of 
locking. It's kind of a wake-up that we really want to keep the access 
locked during sensor 'shut-down'. I don't know how other sensors work 
but for me the Kionix sensors requiring the sensor to be "turned off" 
for the duration of pretty much _any_ configurations was a surprize... 
Again, I think this will be required for _all_ new configuration code we 
add in the driver.

>> +	ret = __kx022a_turn_on_unlocked(data);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +	/*
>> +	 * We should not allow changing scale or frequency when FIFO is running
>> +	 * as it will mess the timestamp/scale for samples existing in the
>> +	 * buffer. If this turns out to be an issue we can later change logic
>> +	 * to internally flush the fifo before reconfiguring so the samples in
>> +	 * fifo keep matching the freq/scale settings. (Such setup could cause
>> +	 * issues if users trust the watermark to be reached within known
>> +	 * time-limit).
>> +	 */
>> +	mutex_lock(&data->mutex);
>> +	if (iio_buffer_enabled(idev)) {
> 
> As below - do this with iio_device_claim_direct_mode() before taking the mutex.
> It's the standard way to avoid the races and prevent access when buffers are enabled
> (if they are - you can't claim direct mode).

Thanks! I'll see the iio_device_claim_direct_mode() - again, appreciate 
your advices!

>> +
>> +static int kx022a_fifo_report_data(struct kx022a_data *data, void *buffer,
>> +				   int samples)
>> +{
> 
> I would just put this code inline at the single call site.

Eg, meld this in the fifo flushing function? Ok.

> 
>> +	int ret, fifo_bytes;
>> +
>> +	fifo_bytes = samples * KX022A_FIFO_SAMPLES_SIZE_BYTES;
>> +	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
>> +			       buffer, fifo_bytes);
>> +	if (ret)
>> +		dev_err(data->dev, "FIFO read failed %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int kx022a_get_axis(struct kx022a_data *data,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val)
>> +{
>> +	u16 raw_val;
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(data->regmap, chan->address, &raw_val,
>> +			       sizeof(raw_val));
> 
> Bulk reads for SPI still require dma safe buffers. Long story but
> The short version is today regmap happens to always use bounce buffers
> for SPI (or it did last time I looked at it). However there is no
> guarantee on that in future.  As such you need to use a buffer
> that is  __aligned(IIO_DMA_MINALIGN);
> Easiest option is to put one at the end of the iio_priv() structure.
> 

Thanks. That's a bummer. I would prefer buffer from the stack which 
would be a simple way of avoiding races. OTOH, the access is serialized 
so there should be no problem with your suggestion of using buffer from 
iio_priv. I'll fix this.

>> +	if (ret)
>> +		return ret;
>> +	*val = raw_val;
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int kx022a_read_raw(struct iio_dev *idev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val, int *val2, long mask)
>> +{
>> +	struct kx022a_data *data = iio_priv(idev);
>> +	unsigned int regval;
>> +	int ret = -EINVAL;
>> +
>> +	mutex_lock(&data->mutex);
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		if (iio_buffer_enabled(idev)) {
> 
> Claim direct mode as standard way to avoid racing in read_raw.
> Note you should be very careful on locking order as well.
> Claim direct mode first then take any other locks.
> 

Thanks again.

>> +	if (fifo_bytes > KX022A_FIFO_MAX_BYTES) {
>> +		/*
>> +		 * I've observed a strange behaviour where FIFO may get stuck if
>> +		 * samples are not read out fast enough. By 'stuck' I mean
>> +		 * situation where amount of data adverticed by the STATUS_1
>> +		 * reg is 255 - which equals to 42,5 (sic!) samples and by
>> +		 * my experimenting there are situations where reading the
>> +		 * FIFO buffer does not decrease the data count but the same
>> +		 * fifo sample level (255 bytes of data) is reported
>> +		 */
>> +		err_ctr++;
>> +		dev_warn(data->dev, "Bad amount of data %u\n", fifo_bytes);
>> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
>> +	} else if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES) {
>> +		err_ctr++;
>> +		dev_err(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
>> +	} else {
>> +		err_ctr = 0;
>> +	}
>> +
>> +	if (err_ctr > KXO22A_FIFO_ERR_THRESHOLD) {
>> +		__kx022a_turn_off_unlocked(data);
>> +		kx022a_drop_fifo_contents(data);
>> +		__kx022a_turn_on_unlocked(data);
>> +
>> +		err_ctr = 0;
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
>> +	if (!count)
>> +		return 0;
>> +
>> +	/*
>> +	 * If we are being called from IRQ handler we know the stored timestamp
>> +	 * is fairly accurate for the last stored sample. Otherwise, if we are
>> +	 * called as a result of a read operation from userspace and hence
>> +	 * before the watermark interrupt was triggered, take a timestamp
>> +	 * now. We can fall anywhere in between two samples so the error in this
>> +	 * case is at most one sample period.
>> +	 */
>> +	if (!irq) {
>> +		data->old_timestamp = data->timestamp;
>> +		data->timestamp = iio_get_time_ns(idev);
>> +	}
>> +
>> +	/*
>> +	 * Approximate timestamps for each of the sample based on the sampling
>> +	 * frequency, timestamp for last sample and number of samples.
>> +	 *
>> +	 * We'd better not use the current bandwidth settings to compute the
>> +	 * sample period. The real sample rate varies with the device and
>> +	 * small variation adds when we store a large number of samples.
>> +	 *
>> +	 * To avoid this issue we compute the actual sample period ourselves
>> +	 * based on the timestamp delta between the last two flush operations.
>> +	 */
>> +	if (data->old_timestamp) {
>> +		sample_period = (data->timestamp - data->old_timestamp);
>> +		do_div(sample_period, count);
>> +	} else {
>> +		sample_period = data->odr_ns;
>> +	}
>> +	tstamp = data->timestamp - (count - 1) * sample_period;
>> +
>> +	if (samples && count > samples) {
>> +		/*
>> +		 * Here we leave some old samples to the buffer. We need to
>> +		 * adjust the timestamp to match the first sample in the buffer
>> +		 * or we will miscalculate the sample_period at next round.
>> +		 */ >> +		data->timestamp -= (count - samples) * sample_period;
>> +		count = samples;

Just a note not directly related to this driver. I borrowed (stoled) the 
timestamp logic from the bmc150-accel-core.c. The bmc150-core did not 
have this timestamp adjustment which I think is necessary in case the 
fifo is not read empty. Someone familiar with the bmc150-accel-core.c 
might want to check this.

>> +	}
>> +
>> +	ret = kx022a_fifo_report_data(data, buffer, count);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		int bit;
>> +		u16 *samples = &buffer[i * 3];
>> +
>> +		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
>> +			memcpy(&data->scan.channels[bit], &samples[bit],
>> +			       sizeof(data->scan.channels[0]));
>> +
>> +		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
>> +
>> +		tstamp += sample_period;
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static int kx022a_prepare_irq_pin(struct kx022a_data *data)
>> +{
>> +	/* Enable IRQ1 pin. Set polarity to active low */
> 
> Must either handle both pins or at least know if it is irq2 and
> treat that as no irq for now.

I don't want to try supporting both pins for now. It makes this somewhat 
more complex - especially if we want to support using two IRQs. That 
will require some thorough thinking which I don't have time to do right 
now :(

I can add the irq-names to the bindings and add check to the probe so 
that if the irq2 is used we error out with nice 'not supported' message.

> 
>> +	int mask = KX022A_MASK_IEN1 | KX022A_MASK_IPOL1 |
>> +		   KX022A_MASK_ITYP;
>> +	int val = KX022A_MASK_IEN1 | KX022A_IPOL_LOW |
>> +		  KX022A_ITYP_LEVEL;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(data->regmap, KX022A_REG_INC1, mask, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mask = KX022A_MASK_INS2_DRDY | KX122_MASK_INS2_WMI;
>> +
>> +	return regmap_set_bits(data->regmap, KX022A_REG_INC4, mask);
>> +}
>> +
>> +static int kx022a_fifo_disable(struct kx022a_data *data)
>> +{
>> +	int ret = 0;
>> +
>> +	/* PC1 to 0 */
> ?  No idea what that means...

Sorry about confusing print. The sensor state control bit is named as 
PC1 in the data-sheet and almost every single register table refers to 
the "PC1 bit" because pretty much nothing can be configured when sensor 
is running. I still agree this comment is terrible for anyone not 
reading the data-sheet. Thanks for pointing it out - I'll either drop it 
or make it more obvious...

> 
>> +	ret = kx022a_turn_off_lock(data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_INC4,
>> +				KX022A_MASK_WMI1);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	/* disable buffer */
>> +	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
>> +				KX022A_MASK_BUF_EN);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	data->state &= (~KX022A_STATE_FIFO);
>> +
>> +	kx022a_drop_fifo_contents(data);
>> +
>> +	return kx022a_turn_on_unlock(data);
>> +
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +

>> +static int kx022a_fifo_enable(struct kx022a_data *data)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = kx022a_turn_off_lock(data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Write WMI to HW */
> 
> Where WMI is?

Stored in the iio_priv. data->watermark. The kx022a_set_watermark() only 
updates the value in iio_priv() and we take it in use only when the 
buffer is enabled.


>> +
>> +static int kx022a_buffer_postenable(struct iio_dev *idev)
>> +{
>> +	struct kx022a_data *data = iio_priv(idev);
>> +
>> +	/*
>> +	 * If we use triggers, then the IRQs should be handled by trigger
>> +	 * enable and buffer is not used but we just add results to buffer
>> +	 * when data-ready triggers.
> 
> That comment needs rewriting given you have two buffers and I think they
> are very different things..

True. Sometimes it just requires someone else to read your comments to 
really see the obfuscations like this one. Thanks for pointing it out.

>> +
>> +/* Get timestamps and wake the thread if we need to read data */
>> +static irqreturn_t kx022a_irq_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct kx022a_data *data = iio_priv(idev);
>> +	bool ack = false;
>> +
>> +	data->old_timestamp = data->timestamp;
>> +	data->timestamp = iio_get_time_ns(idev);
>> +
>> +	if (data->trigger.enabled) {
>> +		iio_trigger_poll(data->trigger.indio_trig);
>> +		ack = true;
>> +	}
>> +
>> +	if (data->state & KX022A_STATE_FIFO)
>> +		return IRQ_WAKE_THREAD;
>> +
>> +	if (ack) {
>> +		/*
>> +		 * The IRQ is not acked until data is read. We need to disable
>> +		 * the IRQ in order to schedule the trigger thread. Enabling
>> +		 * is done in reenable.
> 
> I'm a little confused at what is going on here, but a common solution to situations
> like this is to handling to use iio_trigger_poll_chained() from the thread and
> a IRQF_ONESHOT irq.  Thus the interrupt will remain masked until the trigger
> consumers are all done.

Oh, right. This is again probably because of my lack of experience with 
IIO. I did just use the iio_trigger_poll() from the handler - which in 
turn ends up to separate thread for handling. Eg, handing was not done 
in the context of the irq thread => IRQF_ONESHOT did not keep irq 
disabled for the duration of the thread scheduled by the 
iio_trigger_poll(). Thus I disabled the IRQ so that the thread scheduled 
by iio_trigger_poll() was able to run and read the sample.

I will revise this with the iio_trigger_poll_chained() - hopefully I can 
make this nicer with it! Thanks

> 
>> +		 *
>> +		 * It would be possible to set the IRQ to 50uS pulse. If we are
>> +		 * losing data due to the disabled IRQ we can evaluate the
>> +		 * option of using edge triggered IRQs with the pulse mode.
>> +		 */
>> +		disable_irq_nosync(irq);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	return IRQ_NONE;
>> +}
>> +
>> +/* Read the data from the fifo and fill IIO buffers */
>> +static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct kx022a_data *data = iio_priv(idev);
>> +	bool ack = false;
>> +	int ret;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	if (data->state & KX022A_STATE_FIFO) {
>> +		ret = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
>> +		if (ret > 0)
>> +			ack = true;
>> +	}
>> +	/*
>> +	 * WMI and data-ready IRQs are acked when results are read. If we add
>> +	 * TILT/WAKE or other IRQs - then we may need to implement the acking
>> +	 * (which is racy).
> 
> I'm not even going to ask for more info at this stage but that sound worrying.

Yep, you didn't ask but I can still babble a bit :) It's just about the 
fact that this (and many other) Kionix sensors clear all IRQs when a 
single bit of a single register is written. This naturally is racy 
because there will always be a time-window for new IRQs to trigger 
between reading the active IRQs and writing the ack. So with this acking 
mechanism we do potentially lose IRQs.

It might be there were separate ack registers for both of the IRQ pins - 
meaning we might be able to use separate pins for separate (ackable) 
IRQs - and be able to support two IRQs without an acking race. This 
however would require some logic for which pin to use for which IRQ - 
and potentially this selection could be HW dependant. Currently I am not 
supporting anything but watermark and data-ready, both of which get 
cleaned when data is read. It's still worth mentioning that care must be 
taken if ackable IRQs are to be added...

> 
>> +	 */
>> +	if (ack)
>> +		ret = IRQ_HANDLED;
>> +	else
>> +		ret = IRQ_NONE;
>> +
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static void kx022a_trig_reen(struct iio_trigger *trig)
>> +{
>> +	struct kx022a_trigger *t = iio_trigger_get_drvdata(trig);
> 
> Mentioned above, but I really don't like the pointer loops between
> the trigger and main _data structure.
> 

Yep. This is also something that remained from supporting an array of 
triggers.

>> +	struct kx022a_data *data = t->data;
>> +
>> +	enable_irq(data->irq);
>> +}
>> +
>> +static const struct iio_trigger_ops kx022a_trigger_ops = {
>> +	.set_trigger_state = kx022a_trigger_set_state,
>> +	.reenable = kx022a_trig_reen,
>> +};
>> +
>> +static int kx022a_chip_init(struct kx022a_data *data)
>> +{
>> +	int ret, dummy;
>> +
>> +	/*
>> +	 * Disable IRQs because if the IRQs are left on (for example by
>> +	 * a shutdown which did not deactivate the accelerometer) we do
>> +	 * most probably end up flooding the system with unhandled IRQs
>> +	 * and get the line disabled from SOC side.
>> +	 */
>> +	ret = regmap_write(data->regmap, KX022A_REG_INC4, 0);
> 
> Unusual to do this rather than a reset.  Quick look suggests there is
> a suitable software reset (CNTL2)

Same thing was just told me by a colleague of mine yesterday. Reset 
simplifies this quite a bit. (I just wonder if we can trust the reset 
always initializes the IC to same defaults or if there may be OTP 
differencies. I am new to these sensors).

>> +	if (ret) {
>> +		dev_err(data->dev, "Failed to init IRQ states\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = kx022a_set_drdy_irq(data, false);
>> +	if (ret) {
>> +		dev_err(data->dev, "Failed to init DRDY\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Clear any pending IRQs */
>> +	ret = regmap_read(data->regmap, KX022A_REG_INT_REL, &dummy);
>> +	if (ret) {
>> +		dev_err(data->dev, "Failed to ACK IRQs\n");
>> +		return ret;
>> +	}
>> +	/* set data res 16bit */
>> +	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
>> +			      KX022A_MASK_BRES);
> 
> Can we have a _BRES_16 to make this self documenting?

Yes we can :)


>> +
>> +	ret = iio_triggered_buffer_setup_ext(idev,
> 
> devm_

Ouch. Yes.

> 
>> +					     &iio_pollfunc_store_time,
>> +					     kx022a_trigger_handler,
>> +					     IIO_BUFFER_DIRECTION_IN,
>> +					     &kx022a_buffer_ops,
>> +					     kx022a_fifo_attributes);
>> +
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "iio_triggered_buffer_setup_ext FAIL %d\n",
>> +				     ret);
>> +
>> +	indio_trig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d", idev->name,
>> +					    iio_device_id(idev));
>> +	if (!indio_trig)
>> +		return -ENOMEM;
>> +
>> +	data->trigger.indio_trig = indio_trig;
>> +
>> +	indio_trig->ops = &kx022a_trigger_ops;
>> +	data->trigger.data = data;
>> +	iio_trigger_set_drvdata(indio_trig, &data->trigger);
>> +
>> +	ret = iio_trigger_register(indio_trig);
> 
> Don't mix devm and non devm allocation / registration.

Ouch2. I know and should have seen this. Thanks for pointing it out.

> 
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Trigger registration failed\n");
>> +
>> +	ret = devm_iio_device_register(data->dev, idev);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +				     "Unable to register iio device\n");
>> +
>> +	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
>> +					&kx022a_irq_thread_handler,
>> +					IRQF_ONESHOT, "kx022", idev);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(kx022a_probe_internal);

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
