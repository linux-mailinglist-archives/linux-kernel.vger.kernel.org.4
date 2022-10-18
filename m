Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9956029E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJRLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJRLLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:11:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835468768F;
        Tue, 18 Oct 2022 04:11:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o12so13453348lfq.9;
        Tue, 18 Oct 2022 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8tni/kGjlOK1XQXN8hrFzhS2TkTfeJI5GrBJqNimS4=;
        b=U3adCc4TOa+bs1UzQ2+mK/yffvKbwL7MjTI0L4iVAkbxlI2v9RN9MMXp5ts52m79aU
         2JkUS/3rc6UopxWcL8xZU9nEK1IKnYNvEH34nrv8myJnl7v942cq7NGPp101gv9OLXZE
         kLzF30AZOUIeOtuFFCd/Jp+ybmZkoq5v8qmi8VGuEhkd7a38szOIDiMUVRUh/jcNEqXi
         m7T3Mn/ZXhAFQM+u+TcG5xdOWhZqQzQl85sDvJDoqlXBEY2qk9YS51kclGn8JPVbuRGu
         aTr/wh2c2YmO96nRgYNOCEnVMHbjOlCCEGOvJc3tmbbm6F0Z/JGjffHyynCKeqkmQdkQ
         MwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8tni/kGjlOK1XQXN8hrFzhS2TkTfeJI5GrBJqNimS4=;
        b=dQBUAkGEuhJ4zhUuSDwMV9G9mJ2w8axwD3UKEqyfCDoqTc3wBH8TLBewXxfkeQSNvY
         x3dlQkodhiidBlgZSr+ZW+fxx0JId86jwSxT6/l/zRzMV9f5F83OX77y34BMwGHP7bKW
         zy2fZWpaAv2/S6WunwJR4Bju8ZQ40icHN07uvDFj545vtyYG9S9fbnCbU6Ft3BZ3fM3F
         CuctY2O89UYYirQmEU0aJgMBpayCRIIpoQDMcz+BZRNsLIUtM+mcw8Uls3oQUlbogcv8
         TmV0/qTtYYBNIPwzx55Nk59bOXgEfpvlvcg63BKvzgCDULheSvixX2bxsMofLDomEtdG
         ruKg==
X-Gm-Message-State: ACrzQf2pT4B8bRosfS8+xYgig1CYq3/RagNfG1wIYaLW2aHUYnXaRQhm
        Er5THzCogKvePKV39cv08HIgt/WXjsg=
X-Google-Smtp-Source: AMsMyM4YwYjI14nqwWNbm8QXPm+0tMad0TDLe5Vzidp2gYburZTUglifXys/m57b1qZkAoier9C/Qg==
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id x32-20020a056512132000b004888fcce196mr798229lfu.602.1666091460648;
        Tue, 18 Oct 2022 04:11:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id p11-20020ac24ecb000000b0048a9e899693sm1837547lfr.16.2022.10.18.04.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 04:10:59 -0700 (PDT)
Message-ID: <e34d8586-a471-81d6-d09c-f2e0d9884628@gmail.com>
Date:   Tue, 18 Oct 2022 14:10:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
 <b1700ea7-4a7a-263c-595c-0f7a56763c10@gmail.com>
 <20221014144247.00001eb1@huawei.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
In-Reply-To: <20221014144247.00001eb1@huawei.com>
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

On 10/14/22 16:42, Jonathan Cameron wrote:
> On Wed, 12 Oct 2022 10:40:38 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 10/10/22 16:20, Vaittinen, Matti wrote:
>>> On 10/10/22 14:58, Andy Shevchenko wrote:
>>>> On Mon, Oct 10, 2022 at 12:12:34PM +0300, Matti Vaittinen wrote:
>>>> ...
>>>>   
>>>>>>> +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
>>>>>>> +			       sizeof(s16));
>>>>   
>>>>>> No endianess awareness (sizeof __le16 / __be16)
>>>>   
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> +
>>>>>>> +	*val = data->buffer[0];
>>>>>>
>>>>>> Ditto (get_unaligned_be16/le16 / le16/be16_to_cpup()).
>>>>>
>>>>> I have probably misunderstood something but I don't see why we should use
>>>>> 'endianess awareness' in drivers? I thought the IIO framework code takes
>>>>> care of the endianes conversions based on scan_type so each individual
>>>>> driver does not need to do that. That however has been just my assumption. I
>>>>> will need to check this. Thanks for pointing it out.
>>>>
>>>> The IIO core uses endianness field only once in iio_show_fixed_type() AFAICS.
>>
>> Following is some hand waving and speculation after my quick code read.
>> So, I may be utterly wrong in which case please do correct me...
>>
>> Anyways, it seems to me that you're correct. The endianness field is
>> only used by the IIO to build the channel information for user-space so
>> that applications reading data can parse it. As far as I understand, the
>> driver does not need to do the conversions for user-space, but the
>> user-space tools should inspect the type information and do the
>> conversion. I think it makes sense as user-space applications may be
>> better equipped to do some maths. It also may be some applications do
>> not want to spend cycles doing the conversion but the conversions can be
>> done later "offline" for the captured raw data. So omitting conversion
>> in the IIO driver kind of makes sense to me.
> 
> That was indeed the original reasonining for buffered data path
> (note the endian marker is for scans only which only apply in buffered
>   / chardev case).

So, in a case where we "push_to_buffers" the data, we can leave the data 
to use the endianess we advertise via endianess info field?

> It's less obvious for the sysfs path as that's inherently slow.
> We could have made this a problem for the IIO core, but we didn't :)

But again, as far as I understood, the user-space is still expected to 
read the sysfs field for "scan_elements/in_accel_<channel>_type"? I 
guess it would be confusing to say "le:s16/16>>0" there while returning 
CPU native endianess values from sysfs files?

>> I haven't thoroughly looked (and I have never used) the in-kernel IIO
>> APIs for getting the data. A quick look at the
>> include/linux/iio/consumer.h allows me to assume the iio_chan_spec can
>> be obtained by the consumer drivers. This should make the endianess
>> information available for the consumer drivers as well. So, again,
>> consumer drivers can parse the raw-format data themself.
> 
> yes consumers should be be endian aware if they are using the
> callback buffer route to get the data.  Now you mention it, we
> may well have cases where that isn't handled correctly.
> There are few enough users of that interface that it might well work
> by coincidence rather than design. oops.
> 
>>
>> I have this far only used the sysfs and iio_generic_buffer on a
>> little-endian machine so I have had no issues with the little-endian
>> data and I have only observed the code. Hence I can not really say if my
>> reasoning is correct - or if it is how IIO has been designed to operate.
>> But based on my quick study I don't see a need for the IIO driver to do
>> endianess conversion to any other format but what is indicated by
>> scan_type. Specifically for KX022A, the data is already 16B LE when read
>> from the sensor. This is also advertised by scan_type so no conversion
>> should be needed (unless, of course, I am mistaken :]).
> 
> Ah. I'd missed that. Data storage should reflect the read back endianness
> and for the read_raw path you need to perform the conversion in driver
> (but not the high perf push to buffers path).

Oh, really? I think it might be confusing to say "le:s16/16>>0" in 
"scan_elements/in_accel_<channel>_type" but return something else from 
the in_accel_<channel>_raw. Especially the "raw" word at the end of the 
file signals the data is in non converted raw format.

I take your word for that if you say this is what the user-space 
expects, it just is not what I did expect. Well, I do very little work 
on the user-space these days ;) Still just to be on safe side - do you 
mean I should convert the data returned from read_raw to the CPU endianess?

> Sure we could probably have handled read_raw in tree as well but we didn't
> and probably too late to sensibly fix that now.  One of many things we'd
> probably do differently if we were starting again.

Well, this is pretty usual story :) Predicting the future is hard. My 
crystal ball ran out of batteries a long ago ;)

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

