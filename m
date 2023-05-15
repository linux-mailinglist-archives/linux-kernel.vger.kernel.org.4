Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32C702CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbjEOMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbjEOMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:31:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B6CA6;
        Mon, 15 May 2023 05:31:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f26f437b30so5530778e87.1;
        Mon, 15 May 2023 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684153904; x=1686745904;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e88E9z7u+esby0zMYzqEuy5aHnDBMhH2Rhx6uZVB1BU=;
        b=HFNUh8E/ySz5xTckxLXqpf19H/mq9XS+9NBz+jonl+N3WeC3BKInzn9v+umto1C2Si
         g3V9WM7WB4ohFRUV3mLlEwFRaB/5k9/E4tkX7GYvQrqVrrUol5XkL4P0cyuiCbO7J55h
         Bs4wkcEL6VfLZSmRxQ5RvecN+5yAPszD9u6pKaCjas1RUWCEz4xeY6GgFKu/tRA5WuWh
         kuwaUxryQWq/sn/V6rXoemlA2ZHYwSXsh/ZuzDwCkMXpy+t6fEzJbmzA1XQU+mY1Tnx0
         IaSsFG46o41ZUOHTdkvLQkjOMfBzM1E4cl9usXLtX2gNyIK/fNO3xgpxVWbOhbL2tLcR
         /yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684153904; x=1686745904;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e88E9z7u+esby0zMYzqEuy5aHnDBMhH2Rhx6uZVB1BU=;
        b=U7eBGF93UY2vv7/kH6AzuUybtnf6hSyOMCOACDSaMEVY57orb2oU7N6eTHK90xU67V
         FCgWPOiLQgLHsXAE9px3z+mGBxcdy7VLvuTnol2NbCJHako7O5JFVLCykRLHOakcRzrN
         xK7Bv+FUxs0Lv/sPcekEEScez7HyfdQPrPQLZvRmVPg6VjIl7UJpDrKdKTZhp4sE+/tq
         r6p1qOYGCMaiQAqRLlxOjAc9y4+hRyqOayS0N/04+niWv4NRxR0aP9Z5UIqj0Wpkuv0w
         cIe9GfjFS7AMebmlM+CPRgDuvknqdSrQsK7R7s+B4bmXR1O0/RvTLCSXd/fZce3tqUnc
         eDRQ==
X-Gm-Message-State: AC+VfDx681/mEZTCY6dfUUIsYivnnq5WqpknhHFMABrp929fYww5znrw
        ggk6umK67SogxXt74prOgfc=
X-Google-Smtp-Source: ACHHUZ75Dxe3VOngy4VuOMLti1AxsaQd7EkVZ10evYoJgIs/cCTxcS6DHNXQi/PuBp9aVFsNA9eMsQ==
X-Received: by 2002:ac2:4f84:0:b0:4dc:807a:d144 with SMTP id z4-20020ac24f84000000b004dc807ad144mr5288525lfs.39.1684153903501;
        Mon, 15 May 2023 05:31:43 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id r13-20020ac25a4d000000b004f13f4ec267sm2579494lfn.186.2023.05.15.05.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 05:31:43 -0700 (PDT)
Message-ID: <fbc29a8b-abf0-0021-8d07-d57b4b556ec6@gmail.com>
Date:   Mon, 15 May 2023 15:31:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1683105758.git.mazziesaccount@gmail.com>
 <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
 <20230507155434.3d05daa5@jic23-huawei>
 <dca5df2f-b7c0-b5af-f374-7cc5ef854cdb@gmail.com>
 <20230513185236.39bbface@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <20230513185236.39bbface@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/23 20:52, Jonathan Cameron wrote:
> On Mon, 8 May 2023 09:32:28 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 5/7/23 17:54, Jonathan Cameron wrote:
>>> On Wed, 3 May 2023 12:50:14 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
>>>> and IR) with four configurable channels. Red and green being always
>>>> available and two out of the rest three (blue, clear, IR) can be
>>>> selected to be simultaneously measured. Typical application is adjusting
>>>> LCD backlight of TVs, mobile phones and tablet PCs.
>>>>
>>>> Add initial support for the ROHM BU27008 color sensor.
>>>>    - raw_read() of RGB and clear channels
>>>>    - triggered buffer w/ DRDY interrtupt
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>   
>>> Mostly stuff that you asked about in response to earlier version but
>>> which I hadn't replied to until today.
>>>
>>> Upshot, don't need the manual irq handling in here.
>>>
>>> Whilst you aren't setting IRQF_ONESHOT for the pollfunc side of the trigger
>>> (the downstream IRQ / IRQ thread) the IIO utility functions are.
>>
>> I tried doing:
>>
>> static int bu27008_setup_trigger(struct bu27008_data *data, struct
>> iio_dev *idev)
>> {
>> 	struct iio_trigger *itrig;
>> 	char *name;
>> 	int ret;
>>
>> 	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
>> 					      &iio_pollfunc_store_time,
>> 					      bu27008_trigger_handler,
>> 					      &bu27008_buffer_ops);
>> 	if (ret)
>> 		return dev_err_probe(data->dev, ret,
>> 			     "iio_triggered_buffer_setup_ext FAIL\n");
>>
>> 	itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d",
>> 				       idev->name, iio_device_id(idev));
>> 	if (!itrig)
>> 		return -ENOMEM;
>>
>> 	data->trig = itrig;
>>
>> 	itrig->ops = &bu27008_trigger_ops;
>> 	iio_trigger_set_drvdata(itrig, data);
>>
>> 	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bu27008",
>> 			      dev_name(data->dev));
>>
>> 	ret = devm_request_irq(data->dev, data->irq,
>> 				/* No IRQ disabling */
>> 			       &iio_trigger_generic_data_rdy_poll,
>> 			       0, name, itrig);
>> 	if (ret)
>> 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
>>
>> 	ret = devm_iio_trigger_register(data->dev, itrig);
>> 	if (ret)
>> 		return dev_err_probe(data->dev, ret,
>> 				     "Trigger registration failed\n");
>>
>> 	/* set default trigger */
>> 	idev->trig = iio_trigger_get(itrig);
>>
>> 	return 0;
>> }
>>
>> It seems to me we get IRQ storm out of it, bu27008_trigger_handler never
>> being called. My assumption is that as soon as the IRQ handling code
>> exits the iio_trigger_generic_data_rdy_poll, it re-enables the IRQ - and
>> because we have level active IRQ and because the
>> bu27008_trigger_handler() has not yet had a chance to read the VALID bit
>> which restores the IRQ-line - we will immediately enter back to the IRQ
>> handling.
> 
> Ah. I'd miss understood what was going on here. I thought we were talking
> race conditions only - not a level interrupt. Sorry for confusion / being
> half asleep. If it has an Ack like this I'd argue this is really an edge
> interrupt but that would require a guaranteed drop in the signal.

Yes. A failure to detect the edge (and skip acking) would leave the IRQ 
no longer working. I think we have both seen some examples of that in 
the past ;)

> I am assuming the sensor merrily carries on grabbing data, whether or
> not anyone reads it

This is also my understanding.

> and so if we treated this as an edge interrupt then
> the clear to set cycle could be very short (and hence not detected).
> If it instead doesn't read new data until previous has been read, then things
> are much simpler.

I think this is not how BU27008 works.

I think we could probably go on with edge IRQs and cook-up some "re-read 
the VALID-bit again after the IRQ is for sure enabled to ensure the IRQ 
does not go unasserted" - mechanism, which would work on 99.99% of the 
cases. Problem is that some device always handles the 10000th 
measurement ;) To tell the truth, I never really thought of that.

> Hmm. How to make this work cleanly assuming it's case 1. It might be that your
> current approach is the best though it would be nice to do something in the
> IIO code (with risk of breaking everyone  :()

I didn't check if this would be doable.

   I don't think we can though
> as we have no way from the trigger implementation side to know if we might
> get threaded interrupt handling or not on the downstream side.
> 
> We have reference counting to reenable a trigger that actually has a hardware
> mask at the device end when all consumers are done - that should be used for
> the reenable, not do it in the pollfunc handler.  As it's a level interrupt
> you avoid need to do a bonus read in there I think (sometimes that's necessary
> because of an edge trigger and a slow read back on a possible unrelated device).
> 
> The subtle difference between IRQF_ONESHOT and irq_disable is one uses
> the irq_mask / unmask callbacks on the irq chip and the other is using
> the enable / disable ones.  That may make no practical difference - I'm not
> entirely sure.  A quick glance at some drivers suggests masking is usually
> lighter weight as less state is rewrite on reenable.
> 
> So in short, move the irq_enable() into the iio_trig->reenable() callback.
> 

This should be what I did at v5 :) Thanks for the help!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

