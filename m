Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296815FC159
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJLHkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLHkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:40:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6595AFD;
        Wed, 12 Oct 2022 00:40:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r22so18342788ljn.10;
        Wed, 12 Oct 2022 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+IYmi8tEOzQZXwBg2WQPAuUHlGeEUS5FrkTkjk+8r4=;
        b=FOPJ9nrj9y5QZ8FojeBTK5zlj/pB+V9L1nBdMphMqh/X69LUfrnDyKffKpTkvzRrya
         WzDqax1bXpZ2azImvJwrIYIvQYnBcWOIsYWkTsRjbun2XkRQuJkqKgJRUew5W5EPh2W6
         d3U4QXHAZQBoL9JQhWBgCHu+MSeBqd4UPq8MBUN+/zdxEVD8yv4nhjJmoALtj75UaI3t
         S5kN5E2o5yj8bdKj2HyKPnIMigQuYenZFsCdd3D65xq4s6LtPn2Lcp+OwoaL6FIR9FAR
         Frs6oVs3IVlxKQR6VRPXwHvnzHfP3vtfqA9LFpFloSSnw9mC/Sd3Tic5EYrTEXxnBttE
         uetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+IYmi8tEOzQZXwBg2WQPAuUHlGeEUS5FrkTkjk+8r4=;
        b=wpVnqnKr41o7y9lVFeh0zt4xdI3JO+9aF1pPkpPnPGFQzkguvNCC4uJRQr1sBbALIu
         D5K/pTeUImfcsQM78nBfCxXKhOr0dzwu0J5wrd0bi52H2JxxbB7voAcCotBu1/lvS2zM
         Oey48ViV9hfxsZiHOubZnhtR9MROrGXA1OZDhZuCehaPmpuVUDgzEWUmLMPXkPwMHiJL
         FBDBIGFrqv1slib3q5EAsLBqP5F6wzSRbW/tdz2favQrhHPJ3OKah3GGHzuUxbHfu4+2
         1dCKYvjRns1J8B2Qh+5msTZmh7HA1Vz0ljKieD/9pX+0qtQPHiebQp0OZRKTh1NukZfR
         Y1Hg==
X-Gm-Message-State: ACrzQf35r6d8GcMVBJSSDH7FO2BeAw3aCI/oap3oQR2Rlzn3JNLdWMxE
        +Ah/nNnMtvgKv2gR7wssKLg=
X-Google-Smtp-Source: AMsMyM7Bx7O5hrdirsTUZ5eU0BSzcJT7QqqMLDiJPPkhbIOX9ZLjuOyM2YM/6mObCPUwrE759uFqXw==
X-Received: by 2002:a2e:a54d:0:b0:26c:64ae:236a with SMTP id e13-20020a2ea54d000000b0026c64ae236amr10808580ljn.207.1665560440059;
        Wed, 12 Oct 2022 00:40:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id dt11-20020a0565122a8b00b00497c3fdf995sm2183545lfb.152.2022.10.12.00.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 00:40:39 -0700 (PDT)
Message-ID: <b1700ea7-4a7a-263c-595c-0f7a56763c10@gmail.com>
Date:   Wed, 12 Oct 2022 10:40:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
 <98b59ad5-8c29-be41-4da1-a961db67827c@gmail.com>
 <Y0QIzf2cAH9ehSeO@smile.fi.intel.com>
 <19a6db0f-40a8-dacf-4583-cdb9d74e1243@fi.rohmeurope.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
In-Reply-To: <19a6db0f-40a8-dacf-4583-cdb9d74e1243@fi.rohmeurope.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 16:20, Vaittinen, Matti wrote:
> On 10/10/22 14:58, Andy Shevchenko wrote:
>> On Mon, Oct 10, 2022 at 12:12:34PM +0300, Matti Vaittinen wrote:
>> ...
>>
>>>>> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
>>>>> +			       sizeof(s16));
>>
>>>> No endianess awareness (sizeof __le16 / __be16)
>>
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	*val = data->buffer[0];
>>>>
>>>> Ditto (get_unaligned_be16/le16 / le16/be16_to_cpup()).
>>>
>>> I have probably misunderstood something but I don't see why we should use
>>> 'endianess awareness' in drivers? I thought the IIO framework code takes
>>> care of the endianes conversions based on scan_type so each individual
>>> driver does not need to do that. That however has been just my assumption. I
>>> will need to check this. Thanks for pointing it out.
>>
>> The IIO core uses endianness field only once in iio_show_fixed_type() AFAICS.

Following is some hand waving and speculation after my quick code read. 
So, I may be utterly wrong in which case please do correct me...

Anyways, it seems to me that you're correct. The endianness field is 
only used by the IIO to build the channel information for user-space so 
that applications reading data can parse it. As far as I understand, the 
driver does not need to do the conversions for user-space, but the 
user-space tools should inspect the type information and do the 
conversion. I think it makes sense as user-space applications may be 
better equipped to do some maths. It also may be some applications do 
not want to spend cycles doing the conversion but the conversions can be 
done later "offline" for the captured raw data. So omitting conversion 
in the IIO driver kind of makes sense to me.

I haven't thoroughly looked (and I have never used) the in-kernel IIO 
APIs for getting the data. A quick look at the 
include/linux/iio/consumer.h allows me to assume the iio_chan_spec can 
be obtained by the consumer drivers. This should make the endianess 
information available for the consumer drivers as well. So, again, 
consumer drivers can parse the raw-format data themself.

I have this far only used the sysfs and iio_generic_buffer on a 
little-endian machine so I have had no issues with the little-endian 
data and I have only observed the code. Hence I can not really say if my 
reasoning is correct - or if it is how IIO has been designed to operate. 
But based on my quick study I don't see a need for the IIO driver to do 
endianess conversion to any other format but what is indicated by 
scan_type. Specifically for KX022A, the data is already 16B LE when read 
from the sensor. This is also advertised by scan_type so no conversion 
should be needed (unless, of course, I am mistaken :]).

>> And it does nothing with it. Maybe Jonathan can shed a light what is it for
>> (I mean the field)?
>>

I agree. It'd be great to listen to someone who actually knows what he 
is talking about and is not just guessing as I am ^_^;

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

