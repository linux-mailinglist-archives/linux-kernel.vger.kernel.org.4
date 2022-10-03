Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09E85F2CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJCJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJCJG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:06:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD71A81F;
        Mon,  3 Oct 2022 02:03:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 25so5349738lft.9;
        Mon, 03 Oct 2022 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WFcFQjxqJEFnrJQ8qbV31qWM6RmdFnAwK/71OYcFvf4=;
        b=mHh+n+cnmkVaK/GqIBEktKSE/ejYIxJzhEz3Hdnn70fU4MszIDQ7RrKkj3kW8jA5lx
         KjzN7D0n/CbQ/3UzYmrkMG40js1lIRwdLjtMDeBc4YuPleQvNzHPZiKHzl5aoX9BMbqW
         V61N3N+ldQF/xCIoliHLel5uFcJTgToJ/Hyhwj6HjFfY1QNj1ZlQodwZEuXusdwIf8xl
         /CtpXnzEcjiiUGIjKZg5sHveuyT1lfMxaTrBAtRXb4Yt45xCgemTuSjHUwR5s+p2qDo2
         8Xq9AJYxreSi2HqDTIEyRQGas/dF4usEIE4wTjYJUxOdcyrvS+0W2SK0inMPNDX//hN6
         Dusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WFcFQjxqJEFnrJQ8qbV31qWM6RmdFnAwK/71OYcFvf4=;
        b=29iJc4+/0f5pKlpjDFW46czmHAw4Xv+KvFg+v9SB93OOG7WO9ErVe2etTFDOdmi8mz
         pB7tlWRV7QD4cOHr6rFH03fqZRbNYOGZC3rmtahiTl9VJcyBvOoXvSSFwBpbFNlOKF6X
         9C/nByjhfQC5yZxp715U+h59zMu02fr8jk5+2Moah+YYl3Rnt2C8NVDc6QhwNharTswq
         c/VQDDb2DSLuFgpTDGR3/qg8smvypSarbgcBJMJb/I93+G4Rmk0ALDz1Zq4f2jtputZd
         yaHVDloo/d1nx7jgK6+xaTeLAerrQyeDdHBngVL9o5yQzFWu4Q8cDHdRsSAyM4Bdnudu
         2NcA==
X-Gm-Message-State: ACrzQf1DsoeB9e2YBHzMUozT9EYAYjiHkChRtdrEbIHb98V3zruHaB0i
        BTMOHpCPq+WguJqq+SghZ4E=
X-Google-Smtp-Source: AMsMyM4+xsbj6WOlcC757YkmshHzz3QVQ2wuPWpm/cGhsx1CE1yDfBL82V6qgJTEqcdswNVfolfbHg==
X-Received: by 2002:a05:6512:3f9a:b0:4a0:2af3:4523 with SMTP id x26-20020a0565123f9a00b004a02af34523mr6773412lfa.184.1664787778721;
        Mon, 03 Oct 2022 02:02:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id k22-20020ac24f16000000b00499f700430fsm1372487lfr.224.2022.10.03.02.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:02:58 -0700 (PDT)
Message-ID: <7ae09809-4f3c-9872-5a87-0a05e73d39b4@gmail.com>
Date:   Mon, 3 Oct 2022 12:02:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
 <YzqgqERDTLVkJH67@smile.fi.intel.com>
 <b36ee317-abfe-9f55-70b5-bbf3138f50c0@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b36ee317-abfe-9f55-70b5-bbf3138f50c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 11:58, Matti Vaittinen wrote:
> Hi Andy,
> 
> Thanks for taking the time to review :) Much appreciated.
> 
> On 10/3/22 11:43, Andy Shevchenko wrote:
>> On Mon, Oct 03, 2022 at 11:13:53AM +0300, Matti Vaittinen wrote:
>>> The iio_triggered_buffer_setup_ext() and the
>>> devm_iio_kfifo_buffer_setup_ext() were changed by
>>> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into 
>>> iio_dev_attr")
>>> to silently expect that all attributes given in buffer_attrs array are
>>> device-attributes. This expectation was not forced by the API - and some
>>> drivers did register attributes created by IIO_CONST_ATTR().
>>>
>>> When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
>>> the pointer to stored string constant and when the sysfs file is read 
>>> the
>>> kernel will access to invalid location.
>>>
>>> Change the function signatures to expect an array of iio_dev_attrs to
>>> avoid similar errors in the future.
>>
>> ...
>> 
>>> +            attr[ARRAY_SIZE(iio_buffer_attrs) + i] =
>>> +                (struct attribute *)&id_attr->dev_attr.attr;
>>
>> ...and explicit casting here. Isn't attr is already of a struct 
>> attribute?
> 
> I am glad you asked :)
> This is one of the "things" I was not really happy about. Here we hide 
> the fact that our array is full of pointers to _const_ data. If we don't 
> cast the compiler points this out. Old code did the same thing but it 
> did this by just doing a memcpy for the pointers - which I personally 
> consider even worse as it gets really easy to miss this. The cast at 
> least hints there is something slightly "fishy" going on.
> 
> My "gut feeling" about the correct fix is we should check if some 
> attributes in the array (stored to the struct here) actually need to be 
> modified later (which I doubt). If I was keen on betting I'd bet we 
> could switch the struct definition to also contain pointers to const 
> attributes. I am afraid this would mean quite a few more changes to the 
> function signatures (changing struct attribute * to const struct 
> attribute *) here and there - and possibly also require some changes to 
> drivers. Thus I didn't even look at that option in the scope of this 
> fix. It should probably be a separate refactoring series. But yes - this 
> cast should catch attention as it did.
> 

Actually, now that you pointed it out - do you think this would warrant 
a FIXME comment?

> Yours,
>      -- Matti Vaittinen
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

