Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F316F9821
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjEGJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjEGJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:58:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CA559B;
        Sun,  7 May 2023 02:58:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f139de8cefso22868956e87.0;
        Sun, 07 May 2023 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683453534; x=1686045534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iehgW9IhHSajySlEHCrFns6P9bnMxvtYiKkF6FQ5Xso=;
        b=KqBNaIYhcjvv1KtXB1A+3HHlpdgw3APdiiSySFOC+LRTiFuL9uQjdB5jycXafLF2nQ
         o9p5O55+7p91j7ZhYQheNFH/DWAkqCjDEz1tKc+++JFmRCzgy1SzF+JNqMp3iJR9tbFa
         kVDkYmsPZOvWRZSxdUKuai+N1Jtj8GM3/8ZRg8aJ5Vgj4hvE0My5QmPiZSDB/9WfYHwn
         EHuJ0nvmqkjU1KsJbbz5fW0qIA4pl/dGVwYoTDdOMG9WcvMlpwHQeXkHjJ9kNwAuR4Cv
         OVsv/PZr9ICBsb4OYkfsekLpaEOTnqBP/Rfc4lVHouElrZ61BQbQ7PAbeXRRokayBCIx
         BrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683453534; x=1686045534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iehgW9IhHSajySlEHCrFns6P9bnMxvtYiKkF6FQ5Xso=;
        b=L35deLLTpCnXiMTfO8KFXzmCjQPOQZs0Vu8bJ0bof8/s2QYZGyB9J/dP9ehDwdpipe
         7C4z2u4yZl9v69lDlf3bvmCnjAU5tjvFps41x4B2MW1/O7el0H+i1x+DGinQRiK2V56S
         TfNnPmXQW4RBjYz2cDVQEbsiDsizrrOMzdTUHIioS7JIXKPvQ+vMifXDgG+L6S15+OCG
         8l+ZgH4Yx+4AYN5+/sjHPSFzGhWNaTJBASjaVfYrSXpw/j+5XUnuxrutn72VMZWsxx2X
         7k60BDyEb9zYZkMYYQUFUsoU2YT767ntr9VseheLveDeOlPSsh9MuoddEoHjd6OMYlvh
         P1Ew==
X-Gm-Message-State: AC+VfDzkisokheHhEnXIuMKyImW7xtKHjLT1ULJ6KlMjHlpWrcxTnE/g
        IsfxdwgZjyMDIyYwhwd9S7LVeNt74MI=
X-Google-Smtp-Source: ACHHUZ475z0qvBLZpZ//TzM8layYfCa+HIRura1ywON2xShhk2W1w0Kzj+4GRUFfOdnN7BCvsYtkPA==
X-Received: by 2002:a05:6512:281e:b0:4eb:1315:eaea with SMTP id cf30-20020a056512281e00b004eb1315eaeamr4383256lfb.3.1683453533930;
        Sun, 07 May 2023 02:58:53 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id n15-20020ac242cf000000b004f13bd73419sm926856lfl.38.2023.05.07.02.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 02:58:53 -0700 (PDT)
Message-ID: <b8c19793-8650-b997-e868-3efd1e119b9a@gmail.com>
Date:   Sun, 7 May 2023 12:58:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] iio: bu27034: Ensure reset is written
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZFIw/KdApZe1euN8@fedora> <20230506192702.57ebf533@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230506192702.57ebf533@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/23 21:27, Jonathan Cameron wrote:
> On Wed, 3 May 2023 13:01:32 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The reset bit must be always written to the hardware no matter what value
>> is in a cache or register. Ensure this by using regmap_write_bits()
>> instead of the regmap_update_bits(). Furthermore, the RESET bit may be
>> self-clearing, so mark the SYSTEM_CONTROL register volatile to guarantee
>> we do also read the right state - should we ever need to read it.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
> 
> This obviously interacts with the regcache update.
> 
> Fun question is whether a register is volatile if it results in all
> registers (including itself) resetting.  In my view, no it isn't volatile.
> So fixing the regcache stuff as in your other patch is more appropriate.

Hi Jonathan,

I think the key thing here is to ensure writing the reset-bit will 
always be performed no matter what value is found from cache/hardware. I 
guess marking the register as volatile is indeed unnecessary, although I 
don't think it is wrong though, as it underlines we have something 
special in this register. However, using the write_bits() instead of 
update_bits() is in my opinion very much "the right thing" to do :)

Yours¸
	-- Matti

> 
> Jonathan
> 
>>
>> ---
>> Changelog:
>> v1 => v2:
>>    - Fix SoB tag
>>
>>
>> I haven't verified if the reset bit is self-clearin as I did temporarily
>> give away the HW.
>>
>> In worst case the bit is not self clearing - but we don't really
>> get performance penalty even if we set the register volatile because the
>> SYSTEM_CONTROL register only has the part-ID and the reset fields. The
>> part-id is only read once at probe.
>>
>> ---
>>   drivers/iio/light/rohm-bu27034.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
>> index 25c9b79574a5..740ebd86b6e5 100644
>> --- a/drivers/iio/light/rohm-bu27034.c
>> +++ b/drivers/iio/light/rohm-bu27034.c
>> @@ -231,6 +231,9 @@ struct bu27034_result {
>>   
>>   static const struct regmap_range bu27034_volatile_ranges[] = {
>>   	{
>> +		.range_min = BU27034_REG_SYSTEM_CONTROL,
>> +		.range_max = BU27034_REG_SYSTEM_CONTROL,
>> +	}, {
>>   		.range_min = BU27034_REG_MODE_CONTROL4,
>>   		.range_max = BU27034_REG_MODE_CONTROL4,
>>   	}, {
>> @@ -1272,7 +1275,7 @@ static int bu27034_chip_init(struct bu27034_data *data)
>>   	int ret, sel;
>>   
>>   	/* Reset */
>> -	ret = regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
>> +	ret = regmap_write_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
>>   			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
>>   	if (ret)
>>   		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
>>
>> base-commit: 7fcbd72176076c44b47e8f68f0223c02c411f420
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

