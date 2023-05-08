Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230396F9F74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEHGMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEHGMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:12:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD25B80;
        Sun,  7 May 2023 23:12:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec8149907aso4717336e87.1;
        Sun, 07 May 2023 23:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683526354; x=1686118354;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR9wS4JVqHhq+RVInaHQuI3PMYYssEi2RiZh0s8pvaQ=;
        b=kUOse9tzBT+jpV2BYxnD+muPTUvi8AQ5Zgo610SN1RqO5mRhigwiuyj+jNGtdO9nPY
         +ZZbkrgc2siRsezTYe0ozDJ/u9x1S7DKFxsRynB1j3BpQLGNmj7+T5mRBlGyVCJdAadg
         7/PYXetCZEG9BJP1hBDwEuBr7I0vB9wL0XtB3Gt2kFNC7mCha2aWasbXyDobRbx15m95
         9A5rl/6rz3LF+ZFKTZFKdmrN5kUlBJ8LNl9odCZZm+tFi8GAQmNpV0v89mI8J8xSs7tR
         qBEIWG8C3naBqC3rLkvB9ebEiBg+nw6ZL23ULryGUF5v7pXn5van49JLdFwmUUOqFt6L
         i9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683526354; x=1686118354;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR9wS4JVqHhq+RVInaHQuI3PMYYssEi2RiZh0s8pvaQ=;
        b=lf7gbSXk73YkHXmPzh8ZDHYhpFXluaHJpIf92aHDrgQVmr6gpaRNoBH/35FjNTy2Ex
         mR+/1HizqM880GFnQOFO4Rs9QXQXz8qmnK6pKa70hOIBaP+81u4UA9n17Ah1GKt13WvB
         ikQ0vBMaYI3NiQrQimR1P3OSMGnDGuATw42mbpySZvUcBV+BQpJrC1vy1W1M/D9enjQJ
         BlYTFS89O46bIElh2jpMmLEDMGRcW79iPUY+hdE4n+3hIzjEkEXRnXURWLeiXYfCRlC5
         Z+iGEnjyFy1iVIYFwNWaU6G1ZPnuAsq2y+rhSf3Mb7I52siWafdJa+uUJjNJ2DX0Dehz
         Jsow==
X-Gm-Message-State: AC+VfDz3jTWrmEjIKrKePshAg9w9zGkmxaJGL9ayY0FyJEo9d8B8vxDQ
        1cBSbqCoU4QuCfwd0mdboecnMGTbKpQ=
X-Google-Smtp-Source: ACHHUZ66qeNXz87cT29wCIJEtYqPPWMds4NloaeYwjiQbEUM4RNRc20anieugwjLBr8fTVZ/RFvEIg==
X-Received: by 2002:ac2:5a45:0:b0:4dd:af74:fe1a with SMTP id r5-20020ac25a45000000b004ddaf74fe1amr2117958lfn.48.1683526353818;
        Sun, 07 May 2023 23:12:33 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v14-20020a056512096e00b004f1430ee142sm1185193lft.17.2023.05.07.23.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:12:33 -0700 (PDT)
Message-ID: <b967f131-68d3-01ea-5304-cd2caf8d9c15@gmail.com>
Date:   Mon, 8 May 2023 09:12:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com> <ZEeAGN3TBcao3CNA@carbian>
 <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com> <ZFgN4MGXpfbcaXTG@carbian>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
In-Reply-To: <ZFgN4MGXpfbcaXTG@carbian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/23 23:45, Mehdi Djait wrote:
> Hello Matti,
> 
> On Tue, Apr 25, 2023 at 11:12:11AM +0300, Matti Vaittinen wrote:
>>>>> +const struct kx022a_chip_info kx022a_chip_info = {
>>>>> +	.name		  = "kx022-accel",
>>>>> +	.regmap_config	  = &kx022a_regmap_config,
>>>>> +	.channels	  = kx022a_channels,
>>>>> +	.num_channels	  = ARRAY_SIZE(kx022a_channels),
>>>>> +	.fifo_length	  = KX022A_FIFO_LENGTH,
>>>>> +	.who		  = KX022A_REG_WHO,
>>>>> +	.id		  = KX022A_ID,
>>>>> +	.cntl		  = KX022A_REG_CNTL,
>>>>> +	.cntl2		  = KX022A_REG_CNTL2,
>>>>> +	.odcntl		  = KX022A_REG_ODCNTL,
>>>>> +	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
>>>>> +	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
>>>>> +	.buf_clear	  = KX022A_REG_BUF_CLEAR,
>>>>> +	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
>>>>> +	.buf_read	  = KX022A_REG_BUF_READ,
>>>>> +	.inc1		  = KX022A_REG_INC1,
>>>>> +	.inc4		  = KX022A_REG_INC4,
>>>>> +	.inc5		  = KX022A_REG_INC5,
>>>>> +	.inc6		  = KX022A_REG_INC6,
>>>>> +	.xout_l		  = KX022A_REG_XOUT_L,
>>>>> +};
>>>>> +EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
>>>>
>>>> Do you think the fields (or at least some of them) in this struct could be
>>>> named based on the (main) functionality being used, not based on the
>>>> register name? Something like "watermark_reg", "buf_en_reg", "reset_reg",
>>>> "output_rate_reg", "int1_pinconf_reg", "int1_src_reg", "int2_pinconf_reg",
>>>> "int1_src_reg" ...
>>>>
>>>> I would not be at all surprized to see for example some IRQ control to be
>>>> shifted from INC<X> to INC<Y> or cntl<X> / buf_cntl<X> stuff to be moved to
>>>> cntl<Y> or to buf_cntl<Y> for next sensor we want to support. Especially
>>>> when new cool feature is added to next sensor, resulting also adding a new
>>>> cntl<Z> or buf_cntl<Z> or INC<Z>.
>>>>
>>>> I, however, believe the _functionality_ will be there (in some register) -
>>>> at least for the ICs for which we can re-use this driver. Hence, it might be
>>>> nice - and if you can think of better names for these fields - to rename
>>>> them based on the _functionality_ we use.
>>>>
>>>> Another benefit would be added clarity to the code. Writing a value to
>>>> "buf_en_reg", "watermark_reg" or to "int1_src_reg" is much clearer (to me)
>>>> than writing a value to "buf_cntl1", "buf_cntl2" or "INC4". Especially if
>>>> you don't have a datasheet at your hands.
>>>>
>>>> I am not "demanding" this (at least not for now :]) because it seems these
>>>> two Kionix sensors have been pretty consistent what comes to maintaining the
>>>> same functionality in the registers with same naming - but I believe this is
>>>> something that may in any case be lurking around the corner.
>>>
>>> I agree, this seems to be the better solution. I will look into this.
>>>
>>
>> Thanks for going the extra mile :)
> 
> I am reconsidering the renaming of the fields
> 
> 1. inc{1,4,5,6} get assigned once to data->{ien_reg,inc_reg} in the probe
> function and then never used again
> 
> 2. buf_cntl2 is used for enabling the buffer and changing the resolution
> to 16bits, so which name is better than buf_cntl ?
> 
> 3. cntl seems the most appropriate name, again different functions and the same
> reg

I think that for the clarity and re-usability we would have fields for 
functions. We could for example have separate fields for buffer enable 
and resolution even though it means assigning the same register to both. 
This, however, is somewhat wasteful (memory vise).

Problem with buf_cntl1 and buf_cntl2 is that the 'cntl' is too broad to 
really tell what the control is. Also, what is the difference of 
buf_cntl1 and buf_cntl2?

> 4. who, id, xout_l, odcntl, buf_{clear, status, read} are quite straightforward

I agree. These look pretty clear to me, although 'status' is also 
somewhat ambiguous. (Is it sample level? Is it some corruption 
detection? Can the buffer be 'busy'?).

> Anyway this is my opinion, what do you think ?

I can currently live with both of these approaches. We may need to 
review this if/when adding support to other sensor(s) though. I will 
leave the decision to you - just make the code best you can ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

