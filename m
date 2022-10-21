Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231226070B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJUHKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:10:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AEBF6824;
        Fri, 21 Oct 2022 00:10:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j14so2451701ljh.12;
        Fri, 21 Oct 2022 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+DyRnzX2NJL/tNy1TqvA1u8dEYMW2T23e/Syk4DuRA=;
        b=U4Ol12POOgdO5lIAPaSKDT6b5WeLLMHMRhTck8cmXOyUJdEMLC+5ItAPZowF4M9rWO
         BS7AV5mp+92ZFULfsI+LP8EXM5/mGdHZCs2SjRnzwgbz+gFrlm1ZZiMmMhQM7zWDaDha
         24ist3kMujvdltRs5ps95P0cC7MyYdmi2Zf1X+fwEK8zgADnxRQpd/8REuV6O7sQc6vI
         sHEB2pu0lMJtlGB+G5XEPAXBpbT9Xn6F1HmGg+dZWrjPybkGZGvTsCKAu2SBgByPKwjU
         2fDP25UuOkQ9siuh4oa4SAg7g86Ku9OwgE0QiznFE5YrsWX90IdP9ipeOCV949smgX7w
         zwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+DyRnzX2NJL/tNy1TqvA1u8dEYMW2T23e/Syk4DuRA=;
        b=2lxPVxrdzhwV/UjtDOeZoHip422VacTAVau7VxOvLPDSI0FCeW+BS5QOlf/dsBRv93
         mFeyHsJYySizvCEJNQwqWlruKBg2NP7NeE2KT/9CuDFy48FMcjiMLvp1qRYwhNl/FOae
         pv5GF5Vt9uCpHVN2hi0gvERaO4uuzvRkqVwklqZxc2bc3FaehMDDDF8+MgoWVSzhcQ1F
         +6XvB6oXJF+OJomuxB4IkGOnnfkbDuby6da4pgDD+9dZ4MZEcM+5huL22tOszXdaFF5k
         VyBKEG2eIg7ufcUaz/jweHMoZiV+V6eX0Cs2weyKbhRS8YtcPLJan9gfoMlJeIa+d3CF
         jPCg==
X-Gm-Message-State: ACrzQf2Pcxce5YJ+v89jqfhtEvFBQjY3YbfG/d2XIGwmrvqwQywq8fhm
        dwswIlpyLhhxDYRXxyKwg14=
X-Google-Smtp-Source: AMsMyM5fecE/7tVBOtJL0ll7ohXyQOHQk2BhGfAqhPz0IZTQYSNLhhSv0+wV9q4v01GtZMfSi7wwgQ==
X-Received: by 2002:a2e:8781:0:b0:26d:e758:ce84 with SMTP id n1-20020a2e8781000000b0026de758ce84mr6069368lji.178.1666336209831;
        Fri, 21 Oct 2022 00:10:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::2? (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id t16-20020a056512209000b0048b26d4bb64sm3051993lfr.40.2022.10.21.00.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 00:10:09 -0700 (PDT)
Message-ID: <2cad533d-32d1-5ca1-74e6-e2debcbdad81@gmail.com>
Date:   Fri, 21 Oct 2022 10:10:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666263249.git.mazziesaccount@gmail.com>
 <5000bd61650554658d13619c8244f02cedbc182a.1666263249.git.mazziesaccount@gmail.com>
 <Y1FcftQKimmvcOej@smile.fi.intel.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
In-Reply-To: <Y1FcftQKimmvcOej@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy & All,

Thanks again for the review.

On 10/20/22 17:34, Andy Shevchenko wrote:
> On Thu, Oct 20, 2022 at 02:37:15PM +0300, Matti Vaittinen wrote:
>> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
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
> 
> ...
> 
>> +	if (!i2c->irq) {
>> +		dev_err(dev, "No IRQ configured\n");
>> +		return -EINVAL;
> 
> At least
> 
> 	return dev_err_probe(...);
> 
> for know error codes (or when we know that there won't be EPROBE_DEFER), takes
> less LoCs in the source file.

I think we discussed this already (and disagreed). To me it looks plain 
ugly to have hard-coded return value in dev_err_probe(). That's why I 
prefer the

 >> +		dev_err(dev, "No IRQ configured\n");
 >> +		return -EINVAL;

when -EINVAL is hard-coded. On the other hand, your comment below is 
very valid...

> 
>> +	}
> 
> ...
> 
>> +	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(dev, "Failed to initialize Regmap\n");
>> +		return PTR_ERR(regmap);
>  > Ditto here and anywhere else for the similar cases.

...Yes. This is different from the case above, and I agree the 
dev_err_probe() should be used here. Thanks for pointing it out. I'll 
change this and the one in SPI driver as well.

> 
>> +	}
> 
> ...
> 
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*vals = (const int *)kx022a_accel_samp_freq_table;
>> +		*length = ARRAY_SIZE(kx022a_accel_samp_freq_table) * 2;
>> +		*type = IIO_VAL_INT_PLUS_MICRO;
>> +		return IIO_AVAIL_LIST;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*vals = (const int *)kx022a_scale_table;
>> +		*length = ARRAY_SIZE(kx022a_scale_table) * 2;
>> +		*type = IIO_VAL_INT_PLUS_MICRO;
>> +		return IIO_AVAIL_LIST;
> 
> These  ' * 2' can be replaced with respective ARRAY_SIZE() of nested element

To me this sounds good. I'll see how it would look like.

> 
> ...
> 
>> +static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
>> +{
>> +	int ret;
>> +
>> +	if (on)
>> +		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
>> +				      KX022A_MASK_PC1);
>> +	else
>> +		ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
>> +					KX022A_MASK_PC1);
>> +
>> +	if (ret)
>> +		dev_err(data->dev, "Turn %s fail %d\n", (on) ? "ON" : "OFF",
>> +			ret);
> 
> str_on_off() ?

Never heard of that before. Seems we have all kinds of gadgets in kernel 
:) I deeply dislike how ternary looks like so I will gladly hide it in 
str_on_off() - thanks!

>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		n = ARRAY_SIZE(kx022a_accel_samp_freq_table);
>> +
>> +		while (n--)
>> +			if (val == kx022a_accel_samp_freq_table[n][0] &&
>> +			    kx022a_accel_samp_freq_table[n][1] == val2)
> 
> Why not to use the same kind of l and r arguments in == lines?
> In current form it's a bit harder to see what the catch here.

As to why I didn't - because for me the order does not matter regarding 
how hard it is to catch the meaning here. However, there is no problem 
changing this because the order does not matter for me :)
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
>> +			       sizeof(__le16));
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = le16_to_cpu(data->buffer[0]);
> 
> 'p'-variant of the above would look better
> 
> 	*val = le16_to_cpup(data->buffer);
> 
> since it will be the same as above address without any additional arithmetics.
> 

I guess there is no significant performance difference? To my eye the 
le16_to_cpu(data->buffer[0]) is much more clear. I see right from the 
call that we have an array here and use the first member. If there is no 
obvious technical merit for using le16_to_cpup(data->buffer) over 
le16_to_cpu(data->buffer[0]), then I do really prefer the latter for 
clarity.

>> +	return IIO_VAL_INT;
>> +}
> 
> 
> ...
> 
>> +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
> 
> Would simple '0' suffice? 

Technically, yes. I however prefer having the register values in hex - 
unless they directly map to some meaningful physical world entity that 
is easier to understand when in decimal. (For example, a register which 
content would directly represent millivolts or divider or any such 
meaningful physical entity).

> ...
> 
>> +	for (i = 0; i < count; i++) {
>> +		int bit;
>> +		u16 *samples = &buffer[i * 3];
> 
> I would put it as
> 
> 		u16 *samples = &buffer[i * 3];
> 		int bit;

Well, you know my opinion but Ok ;)

Now I also noticed that the name of the block scoped variable 'samples' 
collides with the function scoped variable of same name. I'll rename the 
block scoped 'samples' just to avoid confusion.

> 
>> +		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
>> +			memcpy(&data->scan.channels[bit], &samples[bit],
>> +			       sizeof(data->scan.channels[0]));
> 
> Why not use bit instead of 0 for the sake of consistency?

Because, again, using 0 is clearer to me. It leaves zero room for 
wondering :)

> 
> Also might be good to have a temporary for channels:
> 
> 		... *chs = data->scan.channels;

I think we have discussed this too previously somewhere. I do dislike 
hiding things in temporary variables. I like seeing that we are really 
using the driver private data and not some stack variable and only use 
temporary variables when they significantly reduce the line count.

However, in this particular case I can scope the temporary variable in 
this smallish block of code - which makes it pretty easy to spot we are 
using the data->scan.channel underneath (as the chs is assigned just a 
row above). And it helps us avoid line split so ... Ok.

> 
> 
> 		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
> 			memcpy(&chs[bit], &samples[bit], sizeof(chs[bit]));
> 
>> +		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
>> +
>> +		tstamp += sample_period;
>> +	}
> 
> ...
> 
>> +	ret = regmap_clear_bits(data->regmap, data->ien_reg,
>> +				KX022A_MASK_WMI);
> 
> I don't see why it's not on a single line. Even if you are a conservative
> adept of 80.

Good catch. Thanks.

> ...
> 
>> +	int ret = IRQ_NONE;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	if (data->trigger_enabled) {
>> +		iio_trigger_poll_chained(data->trig);
>> +		ret = IRQ_HANDLED;
>> +	}
>> +
>> +	if (data->state & KX022A_STATE_FIFO) {
> 
>> +		ret = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
>> +		if (ret > 0)
>> +			ret = IRQ_HANDLED;
> 
> I don't like it. Perhaps
> 
> 	bool handled = false;
> 	int ret;
> 
> 	...
> 		ret = ...
> 		if (ret > 0)
> 			handled = true;
> 	...
> 
> 	return IRQ_RETVAL(handled);

I don't see the benefit of adding another variable 'handled'.
If I understand correctly, it just introduces one extra 'if' in IRQ 
thread handling while hiding the return value in IRQ_RETVAL() - macro.

I do like seeing the IRQ_NONE being returned by default and IRQ_HANDLED 
only when "handlers" are successfully executed. Adding extra variable 
just obfuscates this (from my eyes) while adding also the additional 'if'.

> 
>> +	}
>> +
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
> 
> ...
> 
>> +	if (!dev)
>> +		return -ENODEV;
> 
> Do you really need this check?

Good question. In principle I do like checking the parameters of 
exported calls. OTOH, this export is now done using the driver namespace 
so yes, I think we can drop the check.

> 
> ...
> 
>> +	fw = dev_fwnode(dev);
>> +	if (!fw)
>> +		return -ENODEV;
> 
> You may combine these two in one.
> 
> 	struct fwnode_handle *fwnode;
> 
> 
> 	fwnode = dev ? dev_fwnode(dev) : NULL;
> 	if (!fwnode)
> 		return -ENODEV;

I just drop the check for !dev. But even if I didn't, I wouldn't use 
ternary here - to me it is _much_ harder to read compared to two 
separate ifs while giving no obvious benefits.

> And please, call it fwnode.

Ok. I personally like fw more - probably because I'm used to that - but 
I guess the 'fwnode' is used in number of other places. Thanks.

> ...
> 
>> +	irq = fwnode_irq_get_byname(fw, "INT1");
>> +	if (irq > 0) {
>> +		data->inc_reg = KX022A_REG_INC1;
>> +		data->ien_reg = KX022A_REG_INC4;
>> +
>> +		if (fwnode_irq_get_byname(dev_fwnode(dev), "INT2") > 0)
> 
> Why not use fwnode again

I think I've beeen distracted while writing this part :) I guess I have 
added the temporary variable 'fw' just for the purpose of being able to 
call the dev_fwnode() just once. So, Thanks!

> 
> ...
> 
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "iio_triggered_buffer_setup_ext FAIL %d\n",
>> +				     ret);
> 
> Drop dup ret at the end, dev_err_probe() has been adding it to each message.

Thanks!

> 
> ...
> 
>> +	/*
>> +	 * No need to check for NULL. request_threadedI_irq() defaults to
>> +	 * dev_name() should the alloc fail.
>> +	 */
>> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
>> +			      dev_name(data->dev));
> 
> It's not clear why do you need a suffix here.
> 

Because for example just "spi0,0" is much less informative compared to 
"spi0.0-kx022a". As an user I like seeing the device generating the IRQ. 
I don't wan't to dig out details like which bus/chipselect my device is 
connected to - especially if I have only one accelerometer connected. 
The dev_name() is used just to make this unique for cases where we could 
have multiple similar devices connected to the system (as you suggested 
in previous review).


Once again, thanks for the review! I appreciate your help/suggestions.

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

