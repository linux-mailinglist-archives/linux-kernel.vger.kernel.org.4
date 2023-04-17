Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719BD6E43A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDQJ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDQJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:26:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E41BF0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:25:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w11so25419477pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681723558; x=1684315558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2czyE9WdHDvL4dOLTbMOwqoAekdPTD1iyN/OQRcFav4=;
        b=V1IPYWMHDeKtyzr4EL97xCKLfCGO8rvaOcR1gIabIL2RDv7pAgNrAIhKZuvRE42QKK
         ze+FRd04X/Q9g8mZ1D6B+3p3LLVbUscBLi5pYc+KpB1qIlEYqzJ9oo7Fj1sRa8PrDcML
         +1HYnEkn52F6chYeKQsityAFQAvZWaH99g0k78XfdxuvvgmpQeCwMDCidNCdTbYm+Kqg
         l4RhP3YjUvVh21/AUUwuG8VMP43YauRoaoD1vjP058ITTcX9uK2BIgQhsUDPMYxa9TQI
         PXSXemVsy0HQnlMYPTUFe2aHzH9lc1H8z7ZyIGQTXV3RTpTNzsncKak3AsAhrR61g1sg
         x0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723558; x=1684315558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2czyE9WdHDvL4dOLTbMOwqoAekdPTD1iyN/OQRcFav4=;
        b=NdL3jn5vYejgRFvbLTO6V+JeRupMBxEDPGFQqoA3HjtEnKRgtPxsTdfBikRHVgkzNp
         tgoigeDQ4KOCywC/oDD2jzPXCx9GSDFpfY3FsYjOdJX/QNMzZ0DvW5xbbTW4wiTKPjxh
         fOOxAoAFRrKpm4Y81TC4LN9gtpjsxH69ONewAmAQa8I1tewDViJvxu2NQF5SqcoZGMiy
         OPFjrl27P1dSlrVu5Ulsb048qIKw7AYLIXRF9jXxUOndXU1L5F6acSUFZZ79ioa4dF92
         9K0AXfDgABBAm5g2q9ltCfMoCe7IUzmfpZyYBqsWN6KYz3/ltY6JGYouIamnPivpnn8q
         hLQA==
X-Gm-Message-State: AAQBX9fuZ4UxnmzyfTUGfA582Uq116dyapGuV5dTgCyHxksn84O6T4Qa
        cl0ki7E3SN49EKRc0gqnCWG7SvhkwWGgijx8rcICgw==
X-Google-Smtp-Source: AKy350abjt1oO2o/FTwFOijvNIvyOzmZ8d7LBJTtPdwtVjL+7TT8T+v5j9EQGWutj6pJ4cPKvyHRmw==
X-Received: by 2002:a05:6a20:a028:b0:d9:7a97:a7b9 with SMTP id p40-20020a056a20a02800b000d97a97a7b9mr20348493pzj.6.1681723558220;
        Mon, 17 Apr 2023 02:25:58 -0700 (PDT)
Received: from [10.240.2.163] ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id c9-20020a631c09000000b00514256c05c2sm6678548pgc.7.2023.04.17.02.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 02:25:57 -0700 (PDT)
Message-ID: <3c9bd414-29dd-6e9e-5e6b-8dba27d730bc@tweaklogic.com>
Date:   Mon, 17 Apr 2023 17:25:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
 <20230415183543.6d5e3392@jic23-huawei>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20230415183543.6d5e3392@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Jonathan for the review.
Answering only to the Big questions.
>>
>> Software reset feature is not implemented as it causes I2C bus error,
>> the I2C bus driver throws an ugly error message.
> 
> That's unfortunate and perhaps something we should consider fixing
> at the i2c layer.  Could you point to where it happens?
> 
> We have a lot of drivers where reset causes an error (Ack missing normally
> due to simple state machines in the devices).

Below function which cause the error:
regmap_field_write(data->reg_sw_reset, 1);
regmap_write(data->regmap, APDS9306_MAIN_CTRL, 0x10);
i2c_smbus_write_byte_data(data->client, APDS9306_MAIN_CTRL, 0x10);

Error messages:
[ 3340.426180] stm32f7-i2c 40012000.i2c: <stm32f7_i2c_isr_error>: Bus error accessing addr 0x52
[ 3340.433880] stm32f7-i2c 40012000.i2c: Trying to recover bus

The function which gets called:
https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-stm32f7.c#L1622

There is an errata associated with I2C for STM32MP157C (Section 2.19.2, Pg 35):
https://www.st.com/resource/en/errata_sheet/es0438-stm32mp151x3x7x-device-errata-stmicroelectronics.pdf
It speaks about - "Spurious bus error detection in master mode". But I
don't think it has got anything to do with our case.

I use STM32MP157C-DK2 board as my reference device.
The Reference manual to the STM32MP157C:
https://www.st.com/resource/en/reference_manual/DM00327659.pdf

stm32f7_i2c_isr_error() handler gets called because a control bit is set
ERRIE which enables interrupts from the I2C controller for Buss errors,
Arbitration losses, Overrun/Underrun PEC error, Timeout, etc.

I am not sure about other chips.
A possible way to mitigate these kind of issues would be to pass a flag
from upper layers to the i2c bus driver (I2C_SMBUS_REPORT_ERR_OFF or
something on those lines). The drivers can then implement in
struct i2c_algorithm in smbus_xfer() function where they can check for
the flag and disable error checking.

I don't have in depth knowledge on this subject so excuse my lack
of understanding.

> 
>>
>> Could not locate the Lux calculations from datasheet, only exporting
>> raw values.
> 
> Ah. That's annoying as userspace is generally not able to do much with
> the raw values.  Any other known code supporting this device that you
> can raid for info?
> 
> If not, then this ist he best we can do.
> 
This device is similar to LTRF216A.
If I use the calculation in ltrf216a then I would have to verify them
with Lux meter and controlled light source or ltrf216a.
This will be bit difficult for me at this moment.

>>
>> Reading of the Status register clears the Data Ready and the Interrupt
>> Status flags. It makes it tricky to read oneshot values together with
>> interrupts enabled as the IRQ handler clears the status on receipt
>> of an interrupt signal.
>>   
>> Not checking the status in IRQ handler will make the interrupt line
>> unsharable and it does not reset the interrupt line if the Interrupt
>> status flag is not cleared.
> 
> Definitely need to check it but I'm not sure I follow why you can't
> use it for both purposes with a slightly complex interrupt handler design.
> Maybe the code makes it clear what the issue is here.
Answers are in below comment.

>> +
>> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>> +{
>> +	struct device *dev = &data->client->dev;
>> +	int ret, delay, status, int_en;
>> +	int retries = 4;
>> +	u8 buff[3];
>> +
>> +	ret = apds9306_runtime_power(data, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Whichever is greater - integration time period or
>> +	 * sampling period.
>> +	 */
>> +	delay = max(apds9306_intg_time[data->intg_time_idx][1],
>> +			apds9306_repeat_rate_period[data->repeat_rate_idx]);
>> +
>> +	/*
>> +	 * If interrupts are enabled then Status resistor cannot be
>> +	 * relied upon as all the status bits are cleared by the
>> +	 * interrupt handler in case of an event.
> 
> Ah.  I was assuming sane hardware (always an error :) that would issue
> an interrupt on the data being ready.  I think we can make this work
> but it is ugly.  Add some flags to the state structure. Then whenever
> you read this register, set whether the two status flags are set of not.
> Thus in the interrupt handler you can tell if this got there first and
> here you can tell if the interrupt handler got their first.
If I have a flag in the state structure for this, then a timestamp would
also be required or may be just a timestamp.

> 
> One messy corner.  A status read resets the interrupt line, potentially before
> we saw the interrupt. Oh goody - normally this silliness only happens as
> a result of complex interrupt migration or errata. However it is understood
> what to do about it.
> 
> If you see the interrupt status flag here, you have no way of knowing
> if the interrupt line was high for long enough that the interrupt controller
> saw it.  As such your only option is to assume it didn't and inject an extra
> one.  Given a passing of the threshold could in theory have been noisy enough
> to trigger two actual interrupts very close together userspace should be fine
> with the extra event - we probably just wasted some cycles doing something twice.
> 
> The annoying bit will be testing as these races will be somewhat rare.

As per my understanding the Status register has - "Observer effect"

The Status register has got 3 bits - Power On Status, ALS Interrupt
and ALS Data.
A single read of the register clears all three bits.

In case of an interrupt event, the interrupt line is held low (Active) by the
device till the Status register is read. As this is an edge triggered interrupt,
we stop receiving interrupts till we read the status register.
This is why it is good to acknowledge the interrupt by reading the Status register
in the ISR.

Reading the Status register in the ISR inadvertently clears the "ALS Data" bit
as well.

What you are asking is to have a read flag in the static struct and a timestamp
flag may be. In the isr, we check the flag and if the timestamp is within one
integration period, if yes, we don't read the Status register any more from the
isr.
And in this function we read the Status register and update the read flag and
the timestamp with current time.

Not sure if my understanding is correct but I will try the above.

> 
>> +	 */
>> +	ret = regmap_field_read(data->regfield_int_en, &int_en);
>> +	if (ret) {
>> +		dev_err(dev, "read interrupt status failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (!int_en) {
>> +		while (retries--) {
>> +			ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS,
>> +					&status);
>> +			if (ret) {
>> +				dev_err(dev, "read status failed: %d\n", ret);
>> +				return ret;
>> +			}
>> +			if (status & APDS9306_ALS_DATA_STAT_MASK)
>> +				break;
>> +			/*
>> +			 * In case of continuous one-shot read from userspace,
>> +			 * new data is available after sampling period.
>> +			 * Delays are in the range of 25ms to 2secs.
>> +			 */
>> +			fsleep(delay);
>> +		}
>> +	} else
>> +		fsleep(delay);
>> +
>> +	if (!retries)
>> +		return -EBUSY;
>> +
>> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
>> +	if (ret) {
>> +		dev_err(&data->client->dev, "read data failed\n");
>> +		return ret;
>> +	}
>> +
>> +	*val = get_unaligned_le24(&buff[0]);
>> +
>> +	ret = apds9306_runtime_power(data, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ret;
>> +}
>> +

Regards,
Subhajit Ghosh
