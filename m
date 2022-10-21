Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39E5607595
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJULCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiJULCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:02:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC725CD9D;
        Fri, 21 Oct 2022 04:02:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bu25so4503019lfb.3;
        Fri, 21 Oct 2022 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFdV7NP8C6yU75td1dUeGU+HXX+EEy+aRc6V3zFsqbQ=;
        b=TbrKe9Qg0GPwKzMi3kwTM4dL5RNZV1TQ5V11/AQn2rXbqCq4oBbY0SSCJPub7j+C73
         jWdO5tOoH6ji0OOtj4jwOpsmZbhta54THzLL00sHw6F1SP55asX4yHfgsO4gWslOISiA
         U6b2Ome03rzJjYqNZot8UjOHnClqQXxa4O6Vx9dO/e/0l6JrCA8TOyp/GrJEF1XeX+hK
         ChYX9++MUSiyCmk+BaC4YitsXyooNPNaq5BH+ymjseOBUs8MFG91V/hC5S2UB6WbbKUB
         dP4vD7szodW+LiEN4HsiYeEWEIlHVe4mNQUj014q262hTaV53KDdwzbpDCCuh6Ch4mb2
         GrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFdV7NP8C6yU75td1dUeGU+HXX+EEy+aRc6V3zFsqbQ=;
        b=tylJ2ImkStjRM/TjULMQh7zwCftG+mY7kIz5T84trhr2N9PJumilSUk2hBZp/ueo24
         UNtbz5bhxQyp5Ye+J3vk2/MacANh3xMeBACbPt9mQMYYOzBt2Yl8CSy5Qy+4mobFRGz1
         tO7bkpkG2KT29+FgcJ9SZ56zeWwHJdXDZ4ymSg0vmId2s2GQYVm0hg4cYnynAIAFZUqT
         G4i/M+9DhUjBaJel+8oXOPOHIqPtwiCMBwELlqjy8cGk5UfezzW/FVaIW5d52I5ZbOi2
         2pOmZ7DFoyDUN7kI4Qvb0gNvt+BeEgE0SmBCwd5uy8RmUNzJEMnXuVbzWqL0BzuElM/5
         26tw==
X-Gm-Message-State: ACrzQf2t0x9Gt9tUd/tGhAXGJXtZ0c0XZepdd7EMl56raFnsF5K9BsHP
        BbVovuEPd6fZJq88hNWTAFw=
X-Google-Smtp-Source: AMsMyM6raGi5Vpme27/W16RYIuLjDxlRW179PQnGARfzxkMCjNe7hSQg5MdweULaZGPyLHtmHjBZ6A==
X-Received: by 2002:a19:8c5e:0:b0:4a2:2d7b:eef with SMTP id i30-20020a198c5e000000b004a22d7b0eefmr6294463lfj.206.1666350129577;
        Fri, 21 Oct 2022 04:02:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::2? (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id q2-20020a2eb4a2000000b00275aeff36dbsm379738ljm.110.2022.10.21.04.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 04:02:08 -0700 (PDT)
Message-ID: <eb6ce47a-ab87-8a98-7ffe-b8cc50f8a549@gmail.com>
Date:   Fri, 21 Oct 2022 14:02:08 +0300
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
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666263249.git.mazziesaccount@gmail.com>
 <5000bd61650554658d13619c8244f02cedbc182a.1666263249.git.mazziesaccount@gmail.com>
 <Y1FcftQKimmvcOej@smile.fi.intel.com>
 <2cad533d-32d1-5ca1-74e6-e2debcbdad81@gmail.com>
 <Y1J5KiH6IJLmrWH4@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
In-Reply-To: <Y1J5KiH6IJLmrWH4@smile.fi.intel.com>
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

On 10/21/22 13:49, Andy Shevchenko wrote:
> On Fri, Oct 21, 2022 at 10:10:08AM +0300, Matti Vaittinen wrote:
>> On 10/20/22 17:34, Andy Shevchenko wrote:
>>> On Thu, Oct 20, 2022 at 02:37:15PM +0300, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
>>>> +			       sizeof(__le16));
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	*val = le16_to_cpu(data->buffer[0]);
>>>
>>> 'p'-variant of the above would look better
>>>
>>> 	*val = le16_to_cpup(data->buffer);
>>>
>>> since it will be the same as above address without any additional arithmetics.
>>>
>>
>> I guess there is no significant performance difference? To my eye the
>> le16_to_cpu(data->buffer[0]) is much more clear. I see right from the call
>> that we have an array here and use the first member. If there is no obvious
>> technical merit for using le16_to_cpup(data->buffer) over
>> le16_to_cpu(data->buffer[0]), then I do really prefer the latter for
>> clarity.
> 
> Then you probably wanted to have &data->buffer[0] as a parameter to
> regmap_bulk_read()?

Yes! Thanks.

> 
> ...
> 
>>>> +	if (data->trigger_enabled) {
>>>> +		iio_trigger_poll_chained(data->trig);
>>>> +		ret = IRQ_HANDLED;
>>>> +	}
>>>> +
>>>> +	if (data->state & KX022A_STATE_FIFO) {
>>>
>>>> +		ret = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
>>>> +		if (ret > 0)
>>>> +			ret = IRQ_HANDLED;
>>>
>>> I don't like it. Perhaps
>>>
>>> 	bool handled = false;
>>> 	int ret;
>>>
>>> 	...
>>> 		ret = ...
>>> 		if (ret > 0)
>>> 			handled = true;
>>> 	...
>>>
>>> 	return IRQ_RETVAL(handled);
>>
>> I don't see the benefit of adding another variable 'handled'.
>> If I understand correctly, it just introduces one extra 'if' in IRQ thread
>> handling while hiding the return value in IRQ_RETVAL() - macro.
>>
>> I do like seeing the IRQ_NONE being returned by default and IRQ_HANDLED only
>> when "handlers" are successfully executed. Adding extra variable just
>> obfuscates this (from my eyes) while adding also the additional 'if'.
> 
> You assigning semantically different values to the same variable inside the
> function.

Ah, yes! This was really a bug making it way in. I guess you may just 
have saved me from some not-that-funny debugging session... Well spotted!

I still don't like hiding the IRQ_HANDLED / IRQ_NONE. I'll just go for

         if (data->state & KX022A_STATE_FIFO) { 

                 int ok; 

 

                 ok = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, 
true);
                 if (ok > 0) 

                         ret = IRQ_HANDLED; 

         }

for v4. (Which I try to send still today before my memory is flushed by 
the weekend :])

Thanks a lot!

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

