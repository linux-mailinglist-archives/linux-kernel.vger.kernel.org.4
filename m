Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB46C4453
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCVHrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCVHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:47:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53485CEC6;
        Wed, 22 Mar 2023 00:47:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j11so22182647lfg.13;
        Wed, 22 Mar 2023 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679471235;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLwiXV0YvNZidRXiXPDEnRcwjCSjOPPj5ONkRpg/wEc=;
        b=NEWXnpRR+1BolHyfJ8sOhdJxfXho2qSoXZbLTK27DwV3CjyZcab3HfV5EOQkJ0GxXL
         bm8wJHZBaH77hYOSbtVbaMNsSWTa6xJ31w9cSd4le884cfTWazFA4wmpEky770Vo3bPk
         f65L6U9SvJkXfVzTzHta04WItGQH9oqiV/4kipwjTXBlzDFO0oDwxqbUhb6WJPaw/tHr
         /baltL/uZDMy9lzFh28oEPp/4NxT1/UVk+yHNRbZjYv4kqNVoYIfMMim7kqoayaguHTY
         mtLNxbn/qOV32GU1eRTgkWps38DK4N4E8IDHt2/S3hlv2FxnirKpS0aBM2eLy09ruFdg
         1rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679471235;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLwiXV0YvNZidRXiXPDEnRcwjCSjOPPj5ONkRpg/wEc=;
        b=bdLSJNtXBhRORztHG69sxN2dF55YRIsf2dHbHDRA79RdPWgiLg5XpIq0MKrrKNkMfn
         F3qETNZHw/jXEb301mvqG6FQ51nHphHPm0+T+lGyqd6QVnj3BLSEPGPct+K1qa3SLHxg
         QRTAx+HKJtLNhGC7BwnGMjdMIhPP698EwIUagyucDlAfbkDuqJUOKXVzRME1obPIKyay
         hbP0s4RL7C3xxUESfnonDYg8pJc76F3zIN1DGeNIF39FBuHTkVuzzTFCrOprcl9Pms4X
         RAKc9Bi7qLUtFwz0bt6pffJ7hFgMOlLstDpANn7QMYYO0hLijmhqzNKTq0UHLcEr2NLW
         Q4pA==
X-Gm-Message-State: AO0yUKWuePOWwBzLmhSbkk4pKPrwCGy4aNiTsLkQLO57XHhbRo9MEYVI
        HzDvNQUhYNNf5qs3JaLG6es=
X-Google-Smtp-Source: AK7set9wBL34CGb5qY/hOqASsWJzQ2tUTZ9GjEKhgE6p2t0mx4rNwjBfH2PJ9y8luZwk9uWeH858MA==
X-Received: by 2002:ac2:5fef:0:b0:4e8:c81b:1a11 with SMTP id s15-20020ac25fef000000b004e8c81b1a11mr1717487lfg.49.1679471234533;
        Wed, 22 Mar 2023 00:47:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u1-20020ac248a1000000b004db51387ad6sm2498244lfg.129.2023.03.22.00.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:47:13 -0700 (PDT)
Message-ID: <c652e56e-213a-e86e-8730-eb97403a4589@gmail.com>
Date:   Wed, 22 Mar 2023 09:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <00babd12-0ab7-de2a-857b-a58a0948b85c@gmail.com> <ZBmuRqjDH9rTtiVy@carbian>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
In-Reply-To: <ZBmuRqjDH9rTtiVy@carbian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 15:16, Mehdi Djait wrote:
> Hi Matti,
> 
> On Sun, Mar 19, 2023 at 09:43:19AM +0200, Matti Vaittinen wrote:
>> Hi Mehdi,
>>
>> Things have been piling up for me during last two weeks... I will do proper
>> review during next week.
>>
>> On 3/17/23 01:48, Mehdi Djait wrote:
>>> KX132 accelerometer is a sensor which:
>>> 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
>>> 	- can be connected to I2C or SPI
>>> 	- has internal HW FIFO buffer
>>> 	- supports various ODRs (output data rates)
>>>
>>> The KX132 accelerometer is very similair to the KX022A.
>>> One key difference is number of bits to report the number of data bytes that
>>> have been stored in the sample buffer: 8 bits for KX022A vs 10 bits for KX132.
>>
>> The KX022A has 16bits of data in HiRes mode. This is the default for kx022a
>> driver.
> 
> I am talking here about "Buffer Sample Level number of bits":

Ah. My bad. I misunderstood. Mentioning the number of bits made me to 
instantly think of the format of measured data not the size of the FIFO 
and how many bits are needed to represent the full FIFO.

  kx022a uses
> 8 bits: just BUF_STATUS_1 to report the status of the buffer. kx132 uses
> BUF_STATUS_1 and the Bit0, Bit1 of BUF_STATUS_2.
> 
> That's the reason for adding the kx022a_get_fifo_bytes function.
> 
>>
>>> A complete list of differences is listed in [1]
>>>
>>>
>>> [1] https://kionixfs.azureedge.net/en/document/AN112-Transitioning-to-KX132-1211-Accelerometer.pdf1
>>
>> This document is somewhat misleading. It does not contain KX022A but the
>> older KX022. Kionix has the somewhat confusing habit of having very similar
>> names for models with - occasionally significant - differences. (My own
>> opinion).
> 
> Yes, I am aware that it does not contain KX022A, but from my
> understanding of your code, the document can be used to highlight the
> difference I mentioned

I don't remember all the differences between the KX022 and KX022A - but 
I believe at least the supported G-ranges were different. I think there 
probably were also some other things.

>> Finally, AFAIK the key "thing" in KX132 is the "ADP" (Advanced Data Path)
>> feature which allows filtering the data "in sensor". Unfortunately, I am not
>> really familiar with this feature. Do you think this is something that might
>> get configured only once at start-up depending on the purpose of the board?
>> If yes, this might be something that will end-up having properties in
>> device-tree. If yes, then it might be a good idea to have own binding doc
>> for KX132. Currently it seems Ok to have them in the same binding doc
>> though.
>>
> 
> Correct me if I am wrong: the Devicetree is a description of the
> hardware

Yes.

> and the transitioning document states:
> 
> "From a hardware perspective, all these sensors
> have an identical pad/pin layouts and identical pin functionality"

Sometimes (fixed) hardware _configuration_ can be visible in 
device-tree. Eg, device-tree can be used to tell: "On this board this 
configurable piece of hardware shall look like this". My understanding 
of ADP is very limited, but I thought it may be used to adjust the 
hardware by for example adding some filters.

As I said, I however don't know if the ADP will be used with 'static 
configurations' which could be seen as hardware properties. Hence I 
asked if you had insight to this.

> I was thinking about adding an advanced_data_path boolean to the chip_info
> struct and providing different driver callbacks depending on the value.

I can't really comment on this much as I lack of knowledge. I have 
understood the ADP can be configured to do very different type of 
filtering(?) I wonder how the boolean flag suits these needs but I guess 
we can go into those details when ADP support is being implemented. 
Right now I am happy if you say you have analyzed the ADP to the point 
you don't expect many kx132 specific dt-bindings to be needed. And. even 
if this analysis was wrong, we can later separate the kx132 bindings to 
own doc if that is needed. So, I am happy with the bindings being in 
same file now.

> Something like in the bmc150-accel-core: iio_info for bmc150_accel_info
> and iio_info for bmc150_accel_info_fifo

I will see those later, thanks.

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

