Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4B6F24F4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjD2N4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjD2N4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:56:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203E1BC2;
        Sat, 29 Apr 2023 06:56:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4efe8991bafso1218314e87.0;
        Sat, 29 Apr 2023 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682776600; x=1685368600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wD2Tv7VWgOu34ooZ9hAAE411z3zX6PYGvJ3ivxoCyk0=;
        b=A0Bk4V0f2efpYuP8tu8Oq4MufoTU1x0gdYa3/2HTZDWdQ2OYONCba0VQRyJD4QjK4u
         QsrN3gDEfwtE//Xktnjl4jkFpI+BlsUtUxdTmkAedPE8Lr36Pm5cCO+gX0a5qWwGnl12
         7ddQcRrO//BrFPFhD+ufWdNWUU/WqJg1eRbib/pe8Op2cEsiNBtEtqw+3S0NWM4ZwA9O
         t/c0RbpG1eGbIEuGw57VuQkp+Q1COSlsILeqtyF7XU+Z0+3eGOrvPhUOrRDv0t57K84Q
         RUJoeg6uBtsq53uKY+aA2Wwp+4dqfRX1OEmmzKukytffkxuEzvzWwpOzOIbxJ2umcODF
         CHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682776600; x=1685368600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD2Tv7VWgOu34ooZ9hAAE411z3zX6PYGvJ3ivxoCyk0=;
        b=j9u5vtWwAOHnaTBmf+Qd9YJBmFPv7t6+doqUDXrOIaIA4qhchODngincgQRiTCeFbp
         1ptAEOoDWqkfzgHWn4vTf1T7zWevRcHwPzzc+srOQ7xQ3q9BujGQFAJX1PNhOVfB6x1F
         Bi8mQQ5wKjmIxNSHo9BkGiR5JpwrOwsSy3/1BfKB94cQqDKJ+GeJZQCZwhdOvtVPSwm2
         RQWYgnEOPQP1yxoWWYcnvDa5b4+pUxh5O70iw4+nBCw6IXdivDR2hsIf8xxhqbDdpDI6
         xBdTe651r+pv8Jl9jg1HpCQKR/loz3iGBlCspKV2pqcG1A5xPQoXFQONw4V6H8DGMuAx
         tVAg==
X-Gm-Message-State: AC+VfDx/08i4geLAXO8SGJzThT5JxGMToHDKy1pn4CjuXiehQ6vM0VqT
        1fMud8OI+JpZw/2To4Di/3HZQ2s7HRM=
X-Google-Smtp-Source: ACHHUZ7Rz35mlEkMtOo0EttdUY+zJqMTsAIqMSLgew9WDiBWNdp8AcntJM7IyPVCTdOn97D8EETWMw==
X-Received: by 2002:ac2:4895:0:b0:4ec:9f24:3e5f with SMTP id x21-20020ac24895000000b004ec9f243e5fmr2474852lfc.0.1682776599998;
        Sat, 29 Apr 2023 06:56:39 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id q6-20020a19a406000000b004edb8fac1cesm3800590lfc.215.2023.04.29.06.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 06:56:39 -0700 (PDT)
Message-ID: <64728e90-48a7-43d0-b3d3-bfceb94884d7@gmail.com>
Date:   Sat, 29 Apr 2023 16:56:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com> <ZEeAGN3TBcao3CNA@carbian>
 <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com> <ZE0Unz0lxMWY4pRf@carbian>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZE0Unz0lxMWY4pRf@carbian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/23 15:59, Mehdi Djait wrote:
> Hi Matti,
> 
> On Tue, Apr 25, 2023 at 11:12:11AM +0300, Matti Vaittinen wrote:
>> On 4/25/23 10:24, Mehdi Djait wrote:
>>> Hi Matti,
>>>
>>> On Tue, Apr 25, 2023 at 09:50:11AM +0300, Matti Vaittinen wrote:
>>>> On 4/25/23 01:22, Mehdi Djait wrote:
>>>>> Add the chip_info structure to the driver's private data to hold all
>>>>> the device specific infos.
>>>>> Refactor the kx022a driver implementation to make it more generic and
>>>>> extensible.
>>>>>
>>>>> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
>>>>> ---
>>>>> v3:
>>>>> - added the change of the buffer's allocation in the __kx022a_fifo_flush
>>>>>      to this patch
>>>>> - added the chip_info to the struct kx022a_data
>>>>>
>>>>> v2:
>>>>> - mentioned the introduction of the i2c_device_id table in the commit
>>>>> - get i2c_/spi_get_device_id only when device get match fails
>>>>> - removed the generic KX_define
>>>>> - removed the kx022a_device_type enum
>>>>> - added comments for the chip_info struct elements
>>>>> - fixed errors pointed out by the kernel test robot
>>>>>
>>>>>     drivers/iio/accel/kionix-kx022a-i2c.c |  15 +++-
>>>>>     drivers/iio/accel/kionix-kx022a-spi.c |  15 +++-
>>>>>     drivers/iio/accel/kionix-kx022a.c     | 114 +++++++++++++++++---------
>>>>>     drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++-
>>>>>     4 files changed, 147 insertions(+), 51 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
>>>>> index 8f23631a1fd3..ce299d0446f7 100644
>>>>> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
>>>>> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
>>>>> @@ -15,6 +15,7 @@
>>>>
>>>> ...
>>>>
>>>>
>>>>>     static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>>>>> @@ -600,13 +600,17 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>>>>>     {
>>>>>     	struct kx022a_data *data = iio_priv(idev);
>>>>>     	struct device *dev = regmap_get_device(data->regmap);
>>>>> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
>>>>> +	__le16 *buffer;
>>>>>     	uint64_t sample_period;
>>>>>     	int count, fifo_bytes;
>>>>>     	bool renable = false;
>>>>>     	int64_t tstamp;
>>>>>     	int ret, i;
>>>>> +	buffer = kmalloc(data->chip_info->fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
>>>>> +	if (!buffer)
>>>>> +		return -ENOMEM;
>>>>
>>>> Do you think we could get rid of allocating and freeing the buffer for each
>>>> flush? I feel it is a bit wasteful, and with high sampling frequencies this
>>>> function can be called quite often. Do you think there would be a way to
>>>> either use stack (always reserve big enough buffer no matter which chip we
>>>> have - or is the buffer too big to be safely taken from the stack?), or a
>>>> buffer stored in private data and allocated at probe or buffer enable?
>>>
>>> I tried using the same allocation as before but a device like the KX127
>>> has a fifo_length of 342 (compared to 86 for kx132, and 43 for kx022a).
>>> Allocating this much using the stack will result in a Warning.
>>>
>>
>> Right. Maybe you could then have the buffer in private-data and allocate it
>> in buffer pre-enable? Do you think that would work?
> 
> Do you mean add a new function kx022a_buffer_preenable to iio_buffer_setup_ops ?

Sorry. I thought the kx022a already implemented the pre-enable callback 
but it was the postenable. I was mistaken.

> Would adding the allocation to kx022a_fifo_enable and the free to
> kx022a_fifo_disable be a good option also ?
Yes. I think that should work!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

