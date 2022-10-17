Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808AF600749
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJQHIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJQHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:08:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3EB2E6AC;
        Mon, 17 Oct 2022 00:08:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so22688287ejb.13;
        Mon, 17 Oct 2022 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qs14ysy+q1KUN7l6jyTJj1EYiV5ayfoc/slof2Oqsn4=;
        b=B/akBzlEyd5+dndi5xqfwVl1LcCUr24kFHb4n5BnDXqbaMwuHa8UnNQ0jeQLrksaq3
         qEIWNIfeRzxYoIamdCmbJuT0/mMkYBRU3E04eabmH6M1vm7e5AETPQZSS0z1YVT2m2kC
         qiZ/yPxPF9Xj43tcAtsuA34Me6dKixX28w5x4Nn/JTyK6Le+nLO0AT9apcEIa4kXeLLP
         Y0jW0330g4iWqI2aOpGZ9gahGFLBwVcDWE3NUm3T7LZyRntvRpC+rnTBKpIWBpg33hEV
         VIpWsp4bjgxj1F/dEv3vaN27YxPs7/piL6kWAkxrgNaSc9VZQKWkEAr26qmwvSvczFk2
         1QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qs14ysy+q1KUN7l6jyTJj1EYiV5ayfoc/slof2Oqsn4=;
        b=p65RVL9PIRfYOyfLw1kkEcfHToIVI4iACqxmGFsO1sXBsjcCA8GnNI0ViaG2KWL/ks
         /bUH4Rf++ZBEFonMkvy3LF3I+Uj+dpkR9hw5Ag7GosqciwFhlElf2DN3PsFvXxHnBdRN
         ObS/8CBdmgiY6ENrjFSQ2rUg3jPhg5UqTA14pOgJOK1UNp01P5bVx74ZuIuHrqWS/r1o
         C0Ov+++AR+JzRGScqxVV5rqNoxao9yfPJMkhPJs0/l5U5ynYWCHFKGtXy8oIK+2NVMPT
         SyOscy0jKi3jxk2oxFQryMcTrESED/VO9BHJZXs97eyWa28/k9Xy8ZI7zhot7c0r2ZG0
         utTg==
X-Gm-Message-State: ACrzQf3Jsd5K0PNEeYpOba6+ba1PzB2a0PZzl6pflj33L0fPUV1OkPM7
        j8Wvmk67CfV/xCx7fk+OTug=
X-Google-Smtp-Source: AMsMyM78vTFxn/LWzQXx6XUJ0qt6b1lUfMc6PR3xIXMoAv7SA34odEyscKdRbaq6gFblRxGDdxlX6Q==
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr7585614ejb.438.1665990487991;
        Mon, 17 Oct 2022 00:08:07 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.15.51])
        by smtp.gmail.com with ESMTPSA id lb23-20020a170907785700b0077205dd15basm5645854ejc.66.2022.10.17.00.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:08:07 -0700 (PDT)
Message-ID: <3c4c9d0d-a542-bd54-a8d0-589bb4e6ea49@gmail.com>
Date:   Mon, 17 Oct 2022 10:08:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v9 2/2] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20221006140737.12396-1-cosmin.tanislav@analog.com>
 <20221006140737.12396-3-cosmin.tanislav@analog.com>
 <20221009183122.0de740e0@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20221009183122.0de740e0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/22 20:31, Jonathan Cameron wrote:
> On Thu,  6 Oct 2022 17:07:37 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Hi Cosmin,
> 
> I've cropped down (mostly) to the clock changes.
> A few minor things in there + this looks like it would suffer from the issue
> with IIO_CONST_ATTR() not being handled correctly for buffer attributes.
> 
> Jonathan
> 
> 
> 
>> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
>> +static IIO_CONST_ATTR(hwfifo_watermark_max, __stringify(AD4130_FIFO_SIZE));
> 
> These look like they'd suffer from same problem
> https://lore.kernel.org/all/cover.1664782676.git.mazziesaccount@gmail.com/
> tackles.  Short term fix is don't use IIO_CONST_ATTR for buffer attributes.
> 

Right, this only works downstream.

Should I switch to IIO_STATIC_CONST_DEVICE_ATTR?

> 
>> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
>> +static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);
>> +
>> +static const struct attribute *ad4130_fifo_attributes[] = {
>> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
>> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
>> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
>> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
>> +	NULL
>> +};
> 
> 
>> +static void ad4130_clk_disable_unprepare(void *clk)
>> +{
>> +	clk_disable_unprepare(clk);
>> +}
>> +
>> +static int ad4130_set_mclk_sel(struct ad4130_state *st,
>> +			       enum ad4130_mclk_sel mclk_sel)
>> +{
>> +	return regmap_update_bits(st->regmap, AD4130_ADC_CONTROL_REG,
>> +				 AD4130_ADC_CONTROL_MCLK_SEL_MASK,
>> +				 FIELD_PREP(AD4130_ADC_CONTROL_MCLK_SEL_MASK,
>> +					    mclk_sel));
>> +}
>> +
>> +static unsigned long ad4130_int_clk_recalc_rate(struct clk_hw *hw,
>> +						unsigned long parent_rate)
>> +{
>> +	return AD4130_MCLK_FREQ_76_8KHZ;
>> +}
>> +
>> +static int ad4130_int_clk_is_enabled(struct clk_hw *hw)
>> +{
>> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
>> +
>> +	return st->mclk_sel == AD4130_MCLK_76_8KHZ_OUT;
>> +}
>> +
>> +static int ad4130_int_clk_prepare(struct clk_hw *hw)
>> +{
>> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
>> +	int ret;
>> +
>> +	ret = ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ_OUT);
>> +	if (ret)
>> +		return ret;
>> +
>> +	st->mclk_sel = AD4130_MCLK_76_8KHZ_OUT;
>> +
>> +	return 0;
>> +}
>> +
>> +static void ad4130_int_clk_unprepare(struct clk_hw *hw)
>> +{
>> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
>> +	int ret;
>> +
>> +	ret = ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ);
>> +	if (ret)
>> +		return;
>> +
>> +	st->mclk_sel = AD4130_MCLK_76_8KHZ;
>> +}
>> +
>> +static const struct clk_ops ad4130_int_clk_ops = {
>> +	.recalc_rate = ad4130_int_clk_recalc_rate,
>> +	.is_enabled = ad4130_int_clk_is_enabled,
>> +	.prepare = ad4130_int_clk_prepare,
>> +	.unprepare = ad4130_int_clk_unprepare,
>> +};
>> +
>> +static int ad4130_setup_int_clk(struct ad4130_state *st)
>> +{
>> +	struct device *dev = &st->spi->dev;
>> +	struct device_node *of_node = dev->of_node;
> 
> Hmm. There goes our careful use of generic firmware properties.
> I guess there still isn't much we can do about that for clks
> so at least it's contained to this one function.
> 
> Also is this code safe to of_node == NULL?
> 

No, I guess it is not. I'll fix it.
Should I just
if (!of_node) return 0;
?

>> +	struct clk_init_data init;
>> +	const char *clk_name;
>> +	struct clk *clk;
>> +
>> +	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
>> +	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
>> +		return 0;
>> +
>> +	clk_name = of_node->name;
>> +	of_property_read_string(of_node, "clock-output-names", &clk_name);
> 
> Probably want to check success of that read before using it.
> I'd also expect that these to be optional + doesn't he dt binding need
> updating to add this stuff?
> 

It does need updating, sorry.
of_node->name is the default clk_name, if clock-output-names is present
then the of_property_read_string() result will be used instead. If not,
there's no trouble, and we don't care about the return value since we
have the default clk_name assigned just above.
I can also switch to device_property_read_string() here to minimize the
damage from using OF.

> 
>> +
>> +	init.name = clk_name;
>> +	init.ops = &ad4130_int_clk_ops;
>> +
>> +	st->int_clk_hw.init = &init;
>> +	clk = devm_clk_register(dev, &st->int_clk_hw);
>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +
>> +	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
>> +}
>> +
