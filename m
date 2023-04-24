Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84F6EC9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjDXKPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDXKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:15:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D51FEE;
        Mon, 24 Apr 2023 03:15:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso4239542e87.2;
        Mon, 24 Apr 2023 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682331298; x=1684923298;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0i4djhW7uRWyOaO75H1RwqPYON3KNQa40MH2EXIkVw=;
        b=kZNzgw8M9nXmoJyegWGOA3a3yYSLwM6My1cis4+rXT45lfzI3Q1GmdXPjd9v/omS3+
         /p3pNRGnDG/2wruy5xIN6K02mWVAYMqC9q1GdDT9+w+QB4XTCC+inf0Ln4tXklBZsOKa
         Ociis6NQGKyb/aN+oi5pVLh3Sq7qT9rZVd59fVxOBBgeePrVvl7PrZHkpS9eN4PG/oGC
         bZlVdgXkpdgGdwz8FKXneWVHTuQ5oZtc73OJSnDRdqaB0hLD67Bz6xeUPaXn1s1vWM/P
         uM5KWgZ4e91I41buTJZX44fz4oWgA1HErFnhAOFUtlN1rC282Q/L+e2InnxMy98dK6Mb
         AOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682331298; x=1684923298;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0i4djhW7uRWyOaO75H1RwqPYON3KNQa40MH2EXIkVw=;
        b=kepslHzMJBMaUYEvMTC6E0qzaloN47B5Nt5/Ze26I0LxLPM5B+cUs66exE8u5Ed+hZ
         MBejQBJrSrrS+FD/DXujl4Sq1vLrFqz/lherB7ZiQP0m14FbExUwABCZoFsQVk7Ivtp/
         whdaosyn4RwLiGMF9bEtzrKf9GH1uoj2A+e8zhqR8uo8bbSuWJkV5Cq6ukRw4HjV/O6a
         0R7Oele26Z63qDBRO3TTWfuN38wQI2NgzNfgVxT0eUZIQNaKzugpkYL5DSo7jZl9AU/d
         eRLzeJfvoVgjb2KWlSyfgCmdAJ1nghmGAeqWAujkoRxZQOMp+mg6Q9r0m44kes2o0iOl
         wwHQ==
X-Gm-Message-State: AAQBX9cg7wW9CDMP39tGfohbwD9kBx/1Gi+tl7XV2HfR3lykVBLjm0Ti
        NrnrLj3JUFaNA8pA/kk5EAJUo7v7fnU=
X-Google-Smtp-Source: AKy350bCEiOPihkghrWjkMWCJL2EZtzpe8DNWysClfcx0bqfQsq0dbilgnOyLx6R5TuSaI1JM4pQog==
X-Received: by 2002:ac2:4d16:0:b0:4ed:5c73:79cb with SMTP id r22-20020ac24d16000000b004ed5c7379cbmr3200060lfi.21.1682331298121;
        Mon, 24 Apr 2023 03:14:58 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id r1-20020a19ac41000000b004d3d43c7569sm1625636lfc.3.2023.04.24.03.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 03:14:57 -0700 (PDT)
Message-ID: <e47b367f-717b-387e-2d6a-40c998795440@gmail.com>
Date:   Mon, 24 Apr 2023 13:14:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1682067567.git.mazziesaccount@gmail.com>
 <28ace0e26267df5618fbd23625425292391ad7f0.1682067567.git.mazziesaccount@gmail.com>
 <20230423135706.008206da@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v1 2/3] iio: light: ROHM BU27008 color sensor
In-Reply-To: <20230423135706.008206da@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/23 15:57, Jonathan Cameron wrote:
> On Fri, 21 Apr 2023 12:39:36 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
>> and IR) with four configurable channels. Red and green being always
>> available and two out of the rest three (blue, clear, IR) can be
>> selected to be simultaneously measured. Typical application is adjusting
>> LCD backlight of TVs, mobile phones and tablet PCs.
>>
>> Add initial support for the ROHM BU27008 color sensor.
>>   - raw_read() of RGB and clear channels
>>   - triggered buffer w/ DRDY interrtupt
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> +
>> +static int bu27008_meas_set(struct bu27008_data *data, bool enable)
>> +{
>> +	if (enable)
>> +		return regmap_set_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
>> +				       BU27008_MASK_MEAS_EN);
>> +
>> +	return regmap_clear_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
>> +				 BU27008_MASK_MEAS_EN);
> 
> Might be cleaner with regmap_update_bits()
> 
>> +}

Hm. I need to disagree on this although I think it depends on what one 
is used to :)

For me adding a variable for value to be used is slightly more complex 
than just using clear or set function depending on the enable/disable. I 
remember thinking the same as you and preferring the update_bits also on 
enable/disable cases - until I wrote my first power-supply driver and 
Sebasian Reichel told me to not do:

int val;

if (foo)
	val = mask;
else
	val = 0;

return regmap_update_bits(regmap, reg, mask, val);

but use set/clear bits. This allows killing the 'int val;'. I remember I 
had to sleep over night on it but I later started seeing the set/clear 
bits as a simpler thing.

Sure we could also do

if (foo)
	return regmap_update_bits(map, reg, mask, mask);
else
	return regmap_update_bits(map, reg, mask, 0);

- but here we just replace:

regmap_set_bits(map, reg, mask) with
regmap_update_bits(map, reg, mask, mask)

and

regmap_clear_bits(map, reg, mask)
regmap_update_bits(map, reg, mask, 0)

with longer but functionally same variants - which kind of says "I think 
the "regmap_set_bits() and regmap_clear_bits()" are useless ;)

After saying this - I can use the regmap_update_bits() if you insist, 
but in my (not always so) humble opinion this does not improve the function.


>> +
>> +static int bu27008_set_drdy_irq(struct bu27008_data *data, bool state)
>> +{
>> +	if (state)
>> +		return regmap_set_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
>> +					BU27008_MASK_INT_EN);
>> +	return regmap_clear_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
>> +				 BU27008_MASK_INT_EN);
> regmap_update_bits() maybe with the mask and value supplied.

Same weak objection here as was with the bu27008_meas_set(). Eg, can 
change if required but please reconsider :)

>> +}
>> +
> 
>> +static irqreturn_t bu27008_irq_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct bu27008_data *data = iio_priv(idev);
>> +
>> +	data->old_timestamp = data->timestamp;
> 
> What is old_timestamp for?  Without out setting that, this
> is the same as iio_pollfunc_store_time() with the timestamp
> stored in a slightly difference place and always waking the thread
> (which probably doesn't matter)

Thanks. I just re-used the logic from a driver which had some other 
options but the data-ready IRQ as well. As we don't have any such in 
bu27008, I think we can drop the custom stuff as you suggest and clean 
up this for quite a bit :) Thanks!


>> +
>> +static irqreturn_t bu27008_irq_thread_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct bu27008_data *data = iio_priv(idev);
>> +	irqreturn_t ret = IRQ_NONE;
>> +
>> +	mutex_lock(&data->mutex);
>> +	if (data->trigger_enabled) {
>> +		iio_trigger_poll_nested(data->trig);
> 
> Add a comment here on why it makes sense to hold the mutex whilst
> calling this.

After revising this - I don't think it makes. Nor do I think we need the 
trigger_enable flag so we don't propably need the mutex in buffer enable 
either as all raw-write configs are claiming the direct mode.

I'll cook the v2 soon(ish). Thanks!

Yours,
	--Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

