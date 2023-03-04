Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EC6AAC6A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCDU2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 15:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDU2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:28:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A2DE39C;
        Sat,  4 Mar 2023 12:28:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d36so4718951lfv.8;
        Sat, 04 Mar 2023 12:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677961724;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWwwrnhR3JO5fNzgej0yN8yjWbnmOGnKX0GcMZDlV4M=;
        b=SgimlBFo+bb6QbFDQn0gBVcLrRTuChWzxZZSvRaSx746NLqZilDCVSwrKGmpRreG5J
         XYXP7oVE4SwqwjkuE3qu4iDwWhtkxD7gO5Fe63lSrVEZ6W+okdnY7gaJN0FrvHLRVe37
         E3CScMVQmcVqnMMEP2PHcpA8z2UcZxAjnkhy5PRQ8RFAVEiJRjMYmDEtUwn6esT3Nxig
         mEAbBuOsUK7ZVdnpCZiaFtydKtnE0yeargGJ7wOAefRijt5UEeoi43ngognkiOaDEa/M
         NV0GZ8G9fL/PouzsfZ6H8wg3nj6mk57ZrtwDgGbDKi0FznEiGjMBXEAH7hJxefbXXJ+E
         Ct6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677961724;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWwwrnhR3JO5fNzgej0yN8yjWbnmOGnKX0GcMZDlV4M=;
        b=yXIh2fSCiWtXavvc0jVliKODYY41X+9eJSoSAstRIrYwAhXdll+rM59/WK1xEeSctV
         fZwpAHwnCKG4AQUAXD8LPUOawTy2+lhWQ4tToQvZVVACxWfra6MwjL0LJ0k3nM16TMPp
         nUqDdeVRkdahrPCHQwEKXeItqKDiJ0uEWGKYpziklpuxT1uVU5RqR2c5Sw9cOioNaHdS
         Obc/7TpCEdqnN9FbpTnPlrvY4QXYPWBAe9TOcMrJN8S4X+6KAuhDAYxVa/dWGuMb/LqN
         nGXTPC/C1IcPeZcXxVCpoPiPBUdSZtd6Bud1RAlqgCLf6W0zz6a75Vursl7d5o1cThO1
         lE6Q==
X-Gm-Message-State: AO0yUKU1Mi027nRK3GKMSyUS8EFAlnTkwyDjpRumWe4vi1N/0JIQBC5G
        KEP4VtOW7WlVj3fc5FFGbPQ=
X-Google-Smtp-Source: AK7set/uMAocobdmPM70ejikgWWAk7jzwAcQuJ8ilKPesKaawLZefg03A9atcOM8X4x+aBPkSdKBVA==
X-Received: by 2002:ac2:5922:0:b0:4d6:ef7f:fc53 with SMTP id v2-20020ac25922000000b004d6ef7ffc53mr1406051lfi.34.1677961724343;
        Sat, 04 Mar 2023 12:28:44 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id 15-20020ac2484f000000b004d5a5d90d83sm940058lfy.60.2023.03.04.12.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 12:28:44 -0800 (PST)
Message-ID: <9c62d3f1-7d07-a695-67a0-f4a373e96073@gmail.com>
Date:   Sat, 4 Mar 2023 22:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <ZADCEPc1ZKczhEpE@smile.fi.intel.com>
 <ae769902-4bb5-a970-be1e-05b26f4c770c@gmail.com>
 <20230304190254.2ea052eb@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <20230304190254.2ea052eb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/23 21:02, Jonathan Cameron wrote:

>>> ...
>>>    
>>>> +/*
>>>> + * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
>>>> + * Time impacts to gain: 1x, 2x, 4x, 8x.
>>>> + *
>>>> + * => Max total gain is HWGAIN * gain by integration time (8 * 4096) = 32768
>>>> + *
>>>> + * Using NANO precision for scale we must use scale 64x corresponding gain 1x
>>>> + * to avoid precision loss. (32x would result scale 976 562.5(nanos).
>>>> + */
>>>> +#define BU27034_SCALE_1X	64
>>>> +
>>>> +#define BU27034_GSEL_1X		0x00
>>>> +#define BU27034_GSEL_4X		0x08
>>>> +#define BU27034_GSEL_16X	0x0a
>>>> +#define BU27034_GSEL_32X	0x0b
>>>> +#define BU27034_GSEL_64X	0x0c
>>>> +#define BU27034_GSEL_256X	0x18
>>>> +#define BU27034_GSEL_512X	0x19
>>>> +#define BU27034_GSEL_1024X	0x1a
>>>> +#define BU27034_GSEL_2048X	0x1b
>>>> +#define BU27034_GSEL_4096X	0x1c
>>>
>>> Shouldn't the values be in plain decimal?
>>
>> Why?
> 
> Normally go with datasheet on this as it makes reviewer simpler.
> But datasheet is in binary so meh.
> 
>>
>>> Otherwise I would like to understand bit mapping inside these hex values.
>>
>> I like having register values in hex. It makes it obvious they don't
>> necessarily directly match any 'real world' human-readable values.
> 
> Perhaps a cross reference to the table in the spec is appropriate here?

I think adding a reference to the table in the data-sheet is good. 
Although - I gave some feedback about the data-sheet inside the company. 
It may be we will eventually see another version of it...

> whilst there are some patterns they aren't terribly consistent so probably
> best to just point at the table in the spec.
> 
> 
>>>> +		if (helper64 < 0xFFFFFFFFFFFFFLLU) {
>>>
>>> Perhaps this needs a definition.
>>
>> I like seeing the value here. It makes this less obfuscating. Comment
>> makes the purpose obvious so adding a define would not really give any
>> extra advantage.
> 
> It's not immediately obvious why it is that many f's.  Perhaps change
> to refer to number of bits (which is what matters really I think)
> and then use GENMASK() to fill this in?  I think it's 52 bits?

I am personally not used to the GENMASK(). I am always wondering whether 
the parameters were start + end bits, or star bit + number of set bits 
or ... It's somehow easier for me to understand the hex values - 
(especially when they are composed of all fff's or 1, 3, 7 or 2, 4, 8 ... ).

Well, I understand that is not universally true though so GENMASK() can 
for sure be simpler for most others - and it does not hide the value as 
define would do. So yes, GENMASK() could make sense here.

>>>> +			helper64 *= gain0;
>>>> +			do_div(helper64, ch0);
>>>> +		} else {
>>>> +			do_div(helper64, ch0);
>>>> +			helper64 *= gain0;
>>>> +		}
> 
>>>
>>> ...> >> +	if (!res[0])
>>>
>>> Positive conditional?
>>
>> No. Again, we check for the very specific case where res has all bits
>> zeroed. Inverse condition is counter intuitive.
>>
>>>    
>>>> +		ch0 = 1;
>>>> +	else
>>>> +		ch0 = le16_to_cpu(res[0]);
>>>> +
>>>> +	if (!res[1])
>>>> +		ch1 = 1;
>>>
>>> Ditto.
>>>    
>>>> +	else
>>>> +		ch1 = le16_to_cpu(res[1]);
>>>
>>> But why not to read and convert first and then check.
>>
>> Because conversion is not needed if channel data is zero.
> 
> Conversion is trivial. I agree with Andy here that the logic would look
> a bit simpler as (taking it a little further)
> 
> 	ch0 = max(1, le16_to_cpu(res[0]));

It's strange how differently we read the code. For me:

if (!val)
	ch = 1;
else
	ch =  le16_to_cpu(val);

tells what is happening at a glance whereas the:
ch0 = max(1, le16_to_cpu(res[0]));

really requires some focusing to see what is going on. For me it is both 
less clear and less efficient :(

But alas, if this is what is preferred by both of you, then I guess 
that's what it will look like.

>>>
>>>> +	switch (mask) {
>>>> +	case IIO_CHAN_INFO_INT_TIME:
>>>> +		return iio_gts_avail_times(&data->gts, vals, type, length);
>>>> +	case IIO_CHAN_INFO_SCALE:
>>>> +		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return -EINVAL;
>>>
>>> You may do it from default case.
>>>    
>>
>> I think we have discussed this one in the past too. I like having return
>> at the end of a non void function.
> 
> Given all the earlier returns and the fact that the compiler will shout at
> you if it you can get here and it is missing, I'd also suggest just putting
> it in the switch statement.

Ok. IIO is your territory. If the roles were switched I would definitely 
ask for having the returns at the end of the function - and at the end 
of the function only (when possible w/o lot of extra complication).

So perhaps I just have to accept that you want to have it your way with 
IIO :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

