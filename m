Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F65F9BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJJJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJJJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:12:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A287140F5;
        Mon, 10 Oct 2022 02:12:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so15660355lfb.13;
        Mon, 10 Oct 2022 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xidr1B7FJdcF9yMQe+HDngWtWObTb6VUMckqjh0Ot00=;
        b=qPyeM51M7pgzmQopAYyrUswB/lbplZSREFZmZcRzCUOAtVMeJpSN1u5BgnPDCBx+x3
         fbvExvF7U9bgbyKalBWLPJW7p60Wz1dfLGUJkJcQfCOQ881hDnG+/sX2gOSjtWaxwKFZ
         /ZvpLKumDN0Rzo9u6ATi0lVzzvPGMUz6i7XnwQQwmv9nplL44yvZnlvhnLk6nxB0LH0o
         n1eqx3kFxFU5PurnZCXPv8qc4k58cuDbFdFezS51PhsjJ99MgGgxqwhmjQCU4GY/Bc5G
         cx3mF1D1PoQen2wUlSywbOqmDUipPXv6SHD5DbrVwyBKQENtIw5n6JKPcAzY6YLjds9D
         uCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xidr1B7FJdcF9yMQe+HDngWtWObTb6VUMckqjh0Ot00=;
        b=1X9jZ23rbWGrDBM+aH4WTCD36w4M2/Xhmfr9YpH1BObSvHlOwcDOlVXMTf+g7GUmLy
         v7VUwzi3g1xMAYU7NxzkYHCuVkkQjSs4Zu/NB2WA5usNbOVuBC/vIhXt0pqwepjpjswj
         qnaaju0/rPOP5i/3ZmH1HJ6oJmzAzYF6YQ+gozP2kMh/cEJp7W/ZzqGS2zWgw34H1QPQ
         FyCN6AoodwKS38yxbmf2G6CCmBgor6bhDQMNCNluDXKDBOHQ+jyXjDPu4ag1tQ9rfvD6
         cvphc6Pgbb/n72vKYKm/Hew8Kz4wB/DGXMVqfDuxaLtRFG/EKBYvKawDTvZq6hF+LWr3
         YYCg==
X-Gm-Message-State: ACrzQf0/OFDCS+fO6KnUUJ7NAOcau/5ubr3PA9b7bK2uVPqrw+RrWFGP
        r72eNDmzPG34acrmEdgjMSs=
X-Google-Smtp-Source: AMsMyM4/MgQqmdJV50EwZmAgZkoQaTi7WPpZwcHaNLni4mL7rXScLf0NRBD9ZY9W1QTnjx92qBnKEg==
X-Received: by 2002:ac2:4550:0:b0:4a2:6e28:5d38 with SMTP id j16-20020ac24550000000b004a26e285d38mr5880712lfm.103.1665393166056;
        Mon, 10 Oct 2022 02:12:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id 25-20020ac25f59000000b00492e570e036sm1341925lfz.54.2022.10.10.02.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:12:45 -0700 (PDT)
Message-ID: <98b59ad5-8c29-be41-4da1-a961db67827c@gmail.com>
Date:   Mon, 10 Oct 2022 12:12:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
In-Reply-To: <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thanks for taking the time and doing the review. Quite a few comments I 
do agree with. I didn't respond to those unless you asked a question :) 
Thanks for the help! OTOH, as usual, I do not fully agree with 
everything - and at some places I would like to get some further 
information :)

On 10/6/22 21:32, Andy Shevchenko wrote:
> On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:
>> KX022A is a 3-axis accelerometer from ROHM/Kionix. The senosr features
>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
>> ranges (2, 4, 8 and 16g) and probably some other cool features.
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
>> count. My sensor ended up in a state where the amount of data in FIFO was
>> reported to be 0xff bytes, which equals to 42,5 samples. Specification
>> says the FIFO can hold a maximum of 41 samples in HiRes mode. Also, at
>> least once the FIFO was stuck in a state where reading data from
>> hardware FIFO did not decrease the amount of data reported to be in the
>> FIFO - eg. FIFO was "stuck". The code has now an error count and 10
>> reads with invalid FIFO data count will cause the fifo contents to be
>> dropped.
> 
> ...
> 
>> +config IIO_KX022A_SPI
>> +	tristate "Kionix KX022A tri-axis digital accelerometer"
>> +	depends on I2C
>> +	select IIO_KX022A
>> +	select REGMAP_SPI
>> +	help
>> +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
>> +	  accelerometer connected to I2C interface.
> 
> Why it tending to get user to choose Y? It might increase the footprint of
> bootable image and on the embedded platforms it may increase the chances
> to not fit into (flash) ROM.

It may be just my English skills but to me this is really telling that 
"say Y to enable support for this IC". For me it does not mean that "Say 
Y even if you don't have this IC". I am really not seeing the problem 
here, but as I said - maybe it's just my lack of English skills.

Nevertheless, looking at the top of the IIO/accelerometer/KConfg - 
plenty of the accelerometer driver KConfig entries seem to use similar 
pattern. I am nevertheless usually willing to break the pattern if it 
seems like the right thing ;) Can anyone help me to format better 
description?

> Also what will be the module name (see other Kconfig for the pattern)?

Here the pattern is IMHO improved by cutting the useless text. Even the 
cross-reference from SPI to I2C and I2C to SPI driver which was in v1 is 
more useful. Module autoloading for SPI should just work. Adding the 
module name here seems just a silly habit - which I see many people are 
breaking. If module name is to be needed, then it should be checked from 
the Makefile and not trusted that Kconfig text stays up-to-date...

If the module name in config text is generally seen useful (which I 
doubt), then maybe there should be a script that fetches it from the 
Makefile?

>> +config IIO_KX022A_I2C
>> +	tristate "Kionix KX022A tri-axis digital accelerometer"
>> +	depends on I2C
>> +	select IIO_KX022A
>> +	select REGMAP_I2C
>> +	help
>> +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
>> +	  accelerometer connected to I2C interface.
> 
> Ditto.

Ditto.

> 
>> +static int kx022a_spi_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev = &spi->dev;
>> +	struct regmap *regmap;
> 
> Interestingly in the I²C driver you have other style (and I prefer SPI one over
> that). Can you fix I²C driver to follow this style?
> 

I need to respin this anyways, so yes.

>> +	}
> 
> Ditto (blank line).

The blank prior function return? I think I have been told to have blanks 
preceding returns to make returns more obvious - which I kind of understand.

> ...
> 
> 
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
> 
> Can this group be placed after units.h (with blank line in between)?

Why? What's wrong with alphabetical order?

>> + */
>> +#define KXO22A_FIFO_ERR_THRESHOLD 10
>> +#define KX022A_FIFO_LENGTH 41
> 
> Why not to use TAB between definitions and values (also for the rest similar
> cases)?

Because I don't personally see the benefit. I can still do that as I've 
heard many people prefer the aligned values.

> 
>> +#define KX022A_FIFO_MAX_BYTES (KX022A_FIFO_LENGTH *			\
>> +			       KX022A_FIFO_SAMPLES_SIZE_BYTES)
> 
> Slightly better to read:
> 
> #define KX022A_FIFO_MAX_BYTES					\
> 	(KX022A_FIFO_LENGTH * KX022A_FIFO_SAMPLES_SIZE_BYTES)
> 

Really? Well, I can change this but don't personally see any improvement.

> 
>> +const struct regmap_config kx022a_regmap = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.volatile_table = &kx022a_volatile_regs,
>> +	.rd_table = &kx022a_wo_regs,
>> +	.wr_table = &kx022a_ro_regs,
>> +	.rd_noinc_table = &kx022a_nir_regs,
>> +	.precious_table = &kx022a_precious_regs,
>> +	.max_register = KX022A_MAX_REGISTER,
>> +	.cache_type = REGCACHE_RBTREE,
> 
> No max register? Have you tried debugfs output?

Can you please explain what you mean by no max register?

> 
>> +struct kx022a_data;
> 
> Why?

Leftover from a removed trigger struct. Thanks.

> 
>> +struct kx022a_data {
>> +	int irq;
>> +	int inc_reg;
>> +	int ien_reg;
> 
>> +	struct regmap *regmap;
> 
> Putting this as a first member might improve code by making pointer arithmetics
> better. Have you checked possibilities with bloat-o-meter?

No. Amount of combinations is just too huge for me to try randomly 
reordering structs and running bloat-o-meter. Can you please explain me 
why you think reordering this would have visible impact and if this is 
something that is universally true or if such an optimization is 
architecture dependent?

> 
>> +	struct iio_trigger *trig;
>> +	bool trigger_enabled;
>> +
>> +	struct device *dev;
>> +	unsigned int g_range;
> 
>> +	struct mutex mutex;
> 
> No warning from checkpatch? Every lock should be commented what it is for.

No. I didn't see a warn from checkpatch with v6.0-rc7. And I am glad I 
didn't. I am not a fan of statements like "always document a lock" or 
"never use a goto" - because blindly following such "rules" tend to lead 
silly corner cases. In lock commenting case it is likely to lead 
copy-pasting comments for locks which are used for trivial protections. 
And I am definitely not a fan of boilerplate.

>> +	unsigned int state;
>> +
>> +	int64_t timestamp, old_timestamp;
>> +	unsigned int odr_ns;
>> +
>> +	struct iio_mount_matrix orientation;
>> +	u8 watermark;
>> +	/* 3 x 16bit accel data + timestamp */
>> +	s16 buffer[8] __aligned(IIO_DMA_MINALIGN);
>> +	struct {
>> +		__le16 channels[3];
>> +		s64 ts __aligned(8);
>> +	} scan;
>> +};
> 
> ...
> 
>> +/*
>> + * The sensor HW can support ODR up to 1600 Hz - which is beyond what most of
>> + * Linux CPUs can handle w/o dropping samples. Also, the low power mode is not
>> + * available for higher sample rates. Thus the driver only supports 200 Hz and
>> + * slower ODRs. Slowest being 0.78 Hz
> 
> Please, check the punctuation.

I admit it. Punctuation rules for English grammar are something I never 
learned. Actually, in the school I was told to just use short sentences 
because correct punctuation in English is not trivial. I understand that 
grammatically correct comments are pleasing to the eye for people who 
really _know_ English. Yet, even the grammatically incorrect comments 
can provide value for someone wondering why some code is as it is. Thus, 
I write the comments the best way I can - even though I am sure there 
are errors at times :)

I actually just tried running the comment through an online English 
checker. (Just picked first search result, I think it was called 
"Reverso" or something like that) Result the checker gave me was "No 
mistakes detected!"

Can you please suggest me a good tool for checking the grammar (or show 
me the errors - but that won't scale).

> 
>> + */
> 
> ...
> 
>> +static const int kx022a_accel_samp_freq_table[][2] = {
>> +	[0] = { 0, 780000 },
>> +	[1] = { 1, 563000 },
>> +	[2] = { 3, 125000 },
>> +	[3] = { 6, 250000 },
>> +	[4] = { 12, 500000 },
>> +	[5] = { 25, 0 },
>> +	[6] = { 50, 0 },
>> +	[7] = { 100, 0 },
>> +	[8] = { 200, 0 }
> 
> What do you need the indices for? They are not defines, so are you expecting to
> shuffle the entries?

No. Not expecting to suffle. I think I borrowed the construct from 
another driver. I am not sure if it had defines for indices though. 
Sounds like you have a problem with this, right? What would you suggest 
here?

>> +};
> 
> ...
> 
>> +static const unsigned int kx022a_odrs[] = { 1282051282, 639795266, 320 * MEGA,
>> +	 160 * MEGA, 80 * MEGA, 40 * MEGA, 20 * MEGA, 10 * MEGA, 5 * MEGA };
> 
> { and }; on the new line. And I would suggest to group by 4 or 8, that makes it
> easier to read / count.
> 
Right. I actually think Jonathan asked me to burn the lines and do 1 
item / line already during the v1 review. Thanks for pointing this out.


> ...
> 
>> +		int n = ARRAY_SIZE(kx022a_accel_samp_freq_table);
> 
> You may drop {} in each case and have n defined once for all cases.

Could you please explain how? We use different table depending on the case.

> 
>> +
>> +		while (n-- > 0)
> 
> while (n--) ? Or why the 0 is ignored?

What do you mean by 0 being ignored? I am sorry but I do have 
difficulties following some of your comments.

> 
>> +			if (val == kx022a_accel_samp_freq_table[n][0] &&
>> +			    kx022a_accel_samp_freq_table[n][1] == val2)
>> +				break;
> 
>> +		if (n < 0) {
> 
> How is it even possible with your conditional?

Eh? Why it would not be possible? I don't see any problem with the code. 
Could you explain me what you mean?

> 
>> +			ret = -EINVAL;
>> +			goto unlock_out;
>> +		}
> 
> ...
> 
>> +static int kx022a_get_axis(struct kx022a_data *data,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
>> +			       sizeof(s16));
> 
> No endianess awareness (sizeof __le16 / __be16)  >
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = data->buffer[0];
> 
> Ditto (get_unaligned_be16/le16 / le16/be16_to_cpup()).


I have probably misunderstood something but I don't see why we should 
use 'endianess awareness' in drivers? I thought the IIO framework code 
takes care of the endianes conversions based on scan_type so each 
individual driver does not need to do that. That however has been just 
my assumption. I will need to check this. Thanks for pointing it out.

> 
>> +	return IIO_VAL_INT;
>> +}
> 
>  > ...
> 
>> +	if (val > KX022A_FIFO_LENGTH)
>> +		val = KX022A_FIFO_LENGTH;
> 
> max() from minmax.h?

Definitely not. We could use min() to squeeze one line but for my 
personal preference the open-coded limit check is clearer. Can switch to 
min() if this is a subsystem standard though.

> ...
> 
>> +	/*
>> +	 * We must clear the old time-stamp to avoid computing the timestamps
>> +	 * based on samples acquired when buffer was last enabled
> 
> Period!

Is the use of exclamation mark is really justified? It makes your 
suggestion feel slightly rude.

> 
>> +	 */
> 
> ...
> 
>> +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0xff);
> 
> GENMASK() ?

I don't really see a need for GENMASK here. It does not matter what is 
written to this register.

> ...
> 
>> +static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
>> +{
>> +	if (en)
>> +		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
>> +				       KX022A_MASK_DRDY);
> 
> I would put redundant 'else' here to have them on the same column, but
> it's pity we don't have regmap_assign_bits() API (or whatever name you
> can come up with) to hide this kind of code.

Eh, you mean you would put else here even though we return from the if? 
And then put another return in else, and no return outside the if/else?

I definitely don't like the idea.

We could probably use regmap_update_bits and ternary but in my opinion 
that would be just much less obvious. I do like the use of set/clear 
bits which also makes the meaning / "polarity" of bits really clear.

> 
>> +	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
>> +				 KX022A_MASK_DRDY);
>> +}
> 
> ...
> 
>> +	if (!g_kx022a_use_buffer) {
>> +		dev_err(data->dev, "Neither trigger set nor hw-fifo enabled\n");
> 
>> +
> 
> No need in blank line in such cases.
> 
>> +		return -EINVAL;
>> +	}
> 
> Maybe you want to place it here instead?
> 
Yes.

>> +	return kx022a_fifo_enable(data);
> 
> ...
> 
>> +	/*
>> +	 * I've seen I2C read failures if we poll too fast after the sensor
>> +	 * reset. Slight delay gives I2C block the time to recover.
>> +	 */
>> +	msleep(1);
> 
> msleep(1) is not doing what you think it is. I recommend to use usleep_range()
> here.

I think msleep(1) is sleeping 1ms or (likely) quite a bit more. It also 
allows other things to be scheduled meanwhile and does not do any (in 
this case) unnecessary real-time (like) constrains. Could you please 
educate me as to which part I got wrong? And no, I don't really care if 
the probe is resumed only after 1, 10, 20 or 40ms assuming the CPU has 
other things to do. (I don't think forcing this to be continued within 
hard time limit would be beneficial)

> 
> ...
> 
>> +int kx022a_probe_internal(struct device *dev)
>> +{
>> +	static const char * const regulator_names[] = {"io-vdd", "vdd"};
>> +	struct iio_trigger *indio_trig;
>> +	struct kx022a_data *data;
>> +	struct regmap *regmap;
>> +	unsigned int chip_id;
>> +	struct iio_dev *idev;
>> +	int ret, irq;
> 
>> +	if (WARN_ON(!dev))
> 
> Huh?! This can be easily transformed to panic followed by oops. Why is it
> necessary to do so?

Because the call to this probe is only issued from I2C / SPI wrappers 
which are part of the same driver. I think missing a dev here means 
error in this driver - and it should be caught immediately. I don't 
think this should ever happen unless one developing this driver makes an 
error.

Well, if there are doubts I can remove this though.

> 
>> +		return -ENODEV;

>> +	if (chip_id != KX022A_ID) {
>> +		dev_err(dev, "unsupported device 0x%x\n", chip_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
>> +	if (irq > 0) {
>> +		data->inc_reg = KX022A_REG_INC1;
>> +		data->ien_reg = KX022A_REG_INC4;
>> +	} else {
>> +		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
>> +		if (irq < 0)
>> +			return dev_err_probe(dev, irq, "No suitable IRQ\n");
> 
> Missed check for 0.

Why check for 0? fwnode_irq_get_byname() doc states:
  * Return:
  * Linux IRQ number on success, or negative errno otherwise.

I don't see 0 indicating a failure?

> 
> To me it feels inconsistency to use dev_err_probe() in the cases when
> it _might_ be a deferred probe and not use it in the cases we it won't
> be a deferred probe.
> 

I think we discussed this already. To me it feels better to have 
inconsistency for hard-coded return values than use dev_err_probe. At 
times using the "consistency" as a rationale for things feels like 
excusing the infamous "when you're used to use a hammer as solution, all 
problems start looking like nails" approach...

> 
>> +module_param(g_kx022a_use_buffer, bool, 0);
>> +MODULE_PARM_DESC(g_kx022a_use_buffer,
>> +		 "Buffer samples. Use at own risk. Fifo must not overflow");
> 
> Why?! We usually do not allow module parameters in the new code.

There are still quite a few parameters that have been added during 
previous cycle. And many of those are to allow behaviour which is 
undesirable in many cases for those who can benefit from it.

3dbec44d9c94 ("KVM: VMX: Reject kvm_intel if an inconsistent VMCS config 
is detected")

can serve as a random example.

As explained by the comment:
/*
  * Filling up the HW-FIFO can cause nasty problems. Thus we do not
  * enable the fifo unless it is explicitly requested by a module param.
  * If you are _sure_ your system can serve the interrupts in time you
  * can enable the HW fifo. I do not recommend it for sample frequencies
  * higher than 2 Hz - and even in that case I would set the watermark
  * somewhere near 20 samples (HI-RES) to have magnitude of 10 sec
  * safety-margin.
  */

this is also the use-case here.

And yes, using the FIFO regardless of the problems can be beneficial so 
just dropping the support completely would be counter-productive. I 
agree with Jonathan that disabling the FIFO by default does probably 
help avoiding bug reports - but allowing enabling the FIFO with own risk 
is just giving a hand to those who need it. Thus I'd really like to see 
the support upstream. We all know that code which is sitting in some 
downstream git is not likely to help people - and it is the reason why I 
do upstream code in first place.

Yours
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

