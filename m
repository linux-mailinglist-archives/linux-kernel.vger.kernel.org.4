Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30246FB052
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjEHMkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjEHMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:40:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E93989C;
        Mon,  8 May 2023 05:40:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso2993979e87.1;
        Mon, 08 May 2023 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683549607; x=1686141607;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00yoMTErkC+sLR09gilZURKbVPExMwTauOEczXondFk=;
        b=akyjnrlk1q4NOV5ujdelDX98W3QuN8ReoG/ZmJTynvKxMG5+QghXgSHKzSvXkmPVxu
         Ay4DLFMZiGXvPBuqcR9m5odIi1uIt9GocBgQ23Oa1z1SVKGIoiNAEEGr+FKVzFLPn8p+
         +mBIlQo/IisEQ2J7vWMkA/eFH4YPIzbZ+EcHNaimicCpFYCocJfW0bgxqMvnvVyyV2Bk
         rb+agGkK/A7+WBD1pMuycVO5zV5Sge1t/2EKhTbceDzFPdJpVYpa8pN5awx86tgY31vY
         y8Vn3TXmbeY/UcuqUOoIPvQM6nMi/hXEMnsa28ESaKDoc1AE0wZ89+aFb+rUqnpKGekK
         kpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683549607; x=1686141607;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00yoMTErkC+sLR09gilZURKbVPExMwTauOEczXondFk=;
        b=NfRJsWoiiyCL9k4tUngDsBvHJ2+flbvoR90n/GJaglyTyYZOpT63eRaREvrADk/G2l
         UcQceGYFTR1C4ACrmSm3/oRLZ9MRp9hl+bO8GyRxMRqKLn2ueizN+HMZ1WIePlUBpOCJ
         1UZyAJbjhzr6qIOaG8f2m7EKiJ7Sr1IgpUqtHYdGtD2x68u1R4HVSbT3Tzdm369vdAHk
         LZTwNrdyv51lYZqJjwwsW3yrMbPeCOKqZKbhcTHJmtvEWlQ/MLzk5I2bqFnKXm79R6P6
         1orAD6IWulZt6bW2kC+Ub/37yAEW415tYtp0ugsxnzrFU80oogLayTQMaUkVanlQY27x
         MKaw==
X-Gm-Message-State: AC+VfDxKp8mrHIGlSgapslPw8UnNbBIm63djU41GFNhrrNJTZvGe49NP
        i3lz7qsYDkobMN7XIUx/Yms=
X-Google-Smtp-Source: ACHHUZ6Zt2oagdnODgLNoACtfDZduDWF/+OwUGA1KlTnUul5wPFehpiYcHy/k0oubDLJx4Qm+WuwNA==
X-Received: by 2002:a05:6512:4c9:b0:4ed:c61d:c8e8 with SMTP id w9-20020a05651204c900b004edc61dc8e8mr2666536lfq.29.1683549606734;
        Mon, 08 May 2023 05:40:06 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id n18-20020ac242d2000000b004f11e965308sm1271227lfl.20.2023.05.08.05.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 05:40:06 -0700 (PDT)
Message-ID: <6e2c9f59-296c-7382-6490-8e344f3e0210@gmail.com>
Date:   Mon, 8 May 2023 15:40:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
 <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
 <ZFPCUJ81aw/GkJgT@smile.fi.intel.com>
 <c63c5271-3973-3bd4-c683-ab9ab64b67e4@fi.rohmeurope.com>
 <ZFjpqwOo3DxnWahM@smile.fi.intel.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <ZFjpqwOo3DxnWahM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 5/8/23 15:23, Andy Shevchenko wrote:
> On Fri, May 05, 2023 at 04:56:47AM +0000, Vaittinen, Matti wrote:
>> On 5/4/23 17:33, Andy Shevchenko wrote:
>>> On Wed, May 03, 2023 at 12:50:14PM +0300, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +config ROHM_BU27008
>>>> +	tristate "ROHM BU27008 color (RGB+C/IR) sensor"
>>>> +	depends on I2C
>>>> +	select REGMAP_I2C
>>>> +	select IIO_GTS_HELPER
>>>> +	help
>>>> +	  Enable support for the ROHM BU27008 color sensor.
>>>> +	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,
>>>> +	  blue, clear and IR) with four configurable channels. Red and
>>>> +	  green being always available and two out of the rest three
>>>> +	  (blue, clear, IR) can be selected to be simultaneously measured.
>>>> +	  Typical application is adjusting LCD backlight of TVs,
>>>> +	  mobile phones and tablet PCs.
>>>
>>> Module name?
>>
>> We have discussed this several times already.
>>
>> https://lore.kernel.org/all/10c4663b-dd65-a545-786d-10aed6e6e5e9@fi.rohmeurope.com/
>>
>> Module name is completely irrelevant when selecting a kernel configuration.
> 
> This option is also selectable by user.

I don't think the name is selectable. Yes, user selects whether to 
compile driver as a module or in-kernel - but the module name is 
completely irrelevant what comes to this decision.

> ...
> 
>>> Do you need regmap lock? If so, why (since you have mutex)?
>>
>> I believe you know that regmap uses a default lock when no external lock
>> is given. So, I assume you mean that maybe we could set
>> 'disable_locking' for the regmap here.
> 
> Correct.
> 
>> It's nice to be occasionally pushed to think "out of the box". And yes,
>> disabling regmap lock is really out of my "normal box" :)
>>
>> I didn't go through all of the code yet, but I think pretty much all of
>> the sequences which end up to register writes are indeed protected by
>> the mutex. (Well, probe is not but it is expected to only update one bit
>> while rest of the register should stay fixed).
>>
>> It may be we could live without regmap_lock when driver is in it's
>> current state, but I am not convinced the performance improvement is
>> worth the risk. Having regmap unprotected is not common, and it is also
>> not easy to spot when making changes to the driver. In my opinion it is
>> a bit like asking for a nose-bleed unless there is really heavy reasons
>> to drop the lock... In this case, having the regmap_lock (which is
>> pretty much never locked because we have the mutex as you said) is
>> probably not a penalty that matters.
> 
> Basically you try to justify a hidden mine field in case somebody will think
> "oh, we are protected by regmap lock, so why to bother call mutex_lock()" and
> at the end it become a subtle bugs in the code. With disable_locking = true
> I can see that code author _carefully thought through_ the locking schema and
> understands the hardware and the code.

I added the disable_locking = true in v5 - but I am not convinced that 
was a great idea. I am afraid disabling regmap lock is the hidden 
minefield for average users. I didn't grep the kernel for it but I am 
afraid the percentage of regmap users who disable locking is very low. 
Thus, I'd say this is unexpected to many and may lead to bugs although I 
try to watch out for them. Well, time will tell.

> P.S. I'm wondering why your lines of text have a single trailing whitespace
> but the last line.

I guess it must be Thunderbird client then. Well, at least it can send 
out plain-text decently well while working with the exchange servers 
used by ROHM as well as with the gmail. I am not super happy with 
Thunderbird, it tends to eat way more resources I wished it did, but it 
is a working compromise for me. I am interested in hearing if anyone 
knows a way to configure the Thunderbird to drop these extra spaces.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

