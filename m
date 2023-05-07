Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE376F9986
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjEGPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjEGPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:49:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9369444B7;
        Sun,  7 May 2023 08:49:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac8ee9cf7aso20869501fa.2;
        Sun, 07 May 2023 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683474550; x=1686066550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXVmMTlzGpsqwxVNqIgVPdFj3pbPWyuy+sB1it/GnoM=;
        b=f9lJpX2arNLau6lrCSNLSgUcb/dKOh/FKQUW8blzJBTu5MnOzOt3TFDwqjqKL+xP7R
         vQ06yP/zvy/cjxbtQKYQ236AAAdO7O6WfB1seEBSNn5lmiHLIsu9UIkl/iFFp/0yzuDd
         pc5g3712gdGD1AUwmXUFK4NR9u0qt3l+xR+hukEodFLoI73v+Ocw8+VIu8CfqqSeZqEB
         Vclh5jS55crFtnbDeXd2AIOvp8lC5tNfe5XMNsyXDzj5Jrftn7/zletbQvZz1QPj1YYJ
         x0+3JMySJ4dzaZf8os5pcVtFfGlVfhMRIiS2suh0bBGpRknlpt5tRmuVlr+qkttnQPA6
         zyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474550; x=1686066550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXVmMTlzGpsqwxVNqIgVPdFj3pbPWyuy+sB1it/GnoM=;
        b=gNAeJjYhcqMQwqK+a8P4yavi2BU1Y9OTJ3NSHpLHcq4zhByQ2b0p5y6RmC63VjBXCM
         2+t5dwfN2uoBfe/joQLjQI3m2k/Zh+qNWX/fGvAZhk+2pfxdlj3IccWNQ7gRfkuREm0J
         SBgEmtO5fB4e+vLBjET62w0b4qQ5k4A0ZcaXjvpANQtymuWvAFJg4NqQUWyyRXsoyE/w
         EjaM3+JDT55bjdGo1w+zJepbE40yGvdY7ijHA+cVQBjlJfI1Dv22EUstxIXNewI8eiuu
         IGCAH+xMnoVCxa0aIqP4uX++Te5r0gAaX6p+Qwk3JfAhV1dO2NIM5LyUDOO2ukXgbjBc
         yiVA==
X-Gm-Message-State: AC+VfDz+1g/WLG2b2Wo1phfQ6mkgxklCd45UV9pKJJNJhzTaTbWZxSKG
        ef0tYhgrqLUh7FmZegZ0qZU=
X-Google-Smtp-Source: ACHHUZ6Jm4w6vQZ+oNrNLJOiZriMuE7yGRQggT7eTwiriv3/sTn/k90vt5Thejo2Cg+t6vP2mZHqQQ==
X-Received: by 2002:a2e:938c:0:b0:2a7:6fee:2503 with SMTP id g12-20020a2e938c000000b002a76fee2503mr2093662ljh.14.1683474550519;
        Sun, 07 May 2023 08:49:10 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e9588000000b002a77583b718sm847073ljh.12.2023.05.07.08.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 08:49:10 -0700 (PDT)
Message-ID: <84a732f4-0890-307d-2b08-d7d545f1fc42@gmail.com>
Date:   Sun, 7 May 2023 18:49:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
 <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
 <ZFF1NMaR1RYThcSB@smile.fi.intel.com>
 <307cc8ce-6178-7a86-2c90-eaf0ac8c122d@fi.rohmeurope.com>
 <20230507152443.754f2fab@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230507152443.754f2fab@jic23-huawei>
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

On 5/7/23 17:24, Jonathan Cameron wrote:
> On Wed, 3 May 2023 05:11:53 +0000
> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> 
>> Hi Andy
>>
>> Thanks for the review.
>>
>> On 5/2/23 23:40, Andy Shevchenko wrote:
>>> On Wed, Apr 26, 2023 at 11:08:17AM +0300, Matti Vaittinen wrote:
>>>> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
>>>> and IR) with four configurable channels. Red and green being always
>>>> available and two out of the rest three (blue, clear, IR) can be
>>>> selected to be simultaneously measured. Typical application is adjusting
>>>> LCD backlight of TVs, mobile phones and tablet PCs.
>>>>
>>>> Add initial support for the ROHM BU27008 color sensor.
>>>>    - raw_read() of RGB and clear channels
>>>>    - triggered buffer w/ DRDY interrtupt
>>>
>>> ...
>>>    
>>>> +enum {
>>>> +	BU27008_RED,	/* Always data0 */
>>>> +	BU27008_GREEN,	/* Always data1 */
>>>> +	BU27008_BLUE,	/* data2, configurable (blue / clear) */
>>>> +	BU27008_CLEAR,	/* data2 or data3 */
>>>> +	BU27008_IR,	/* data3 */
>>>> +	BU27008_NUM_CHANS
>>>
>>> Why not converting comments to a kernel-doc?
>>>    
>>>> +};
>>>> +
>>>> +enum {
>>>> +	BU27008_DATA0, /* Always RED */
>>>> +	BU27008_DATA1, /* Always GREEN */
>>>> +	BU27008_DATA2, /* Blue or Clear */
>>>> +	BU27008_DATA3, /* IR or Clear */
>>>> +	BU27008_NUM_HW_CHANS
>>>> +};
>>>
>>> Ditto.
>>
>> I see no value having entities which are not intended to be used outside
>> this file documented in any "global" documentation. One who is ever
>> going to use these or wonder what these are - will most likely be
>> watching this file. My personal view is that the generated docs should
>> be kept lean. In my opinion the problem of the day is the time we spend
>> looking for a needle hidden in a haystack. In my opinion adding this to
>> kernel-doc just adds hay :)
> 
>>
>> I still can do this if no-one else objects. I almost never look at the
>> generated docs myself. Usually I just look the docs from code files -
>> and kernel-doc format is not any worse for me to read. Still, I can
>> imagine including this type of stuff to generic doc just bloats them and
>> my not serve well those who use them.
> 
> 
> Unless someone specifically adds this doc to the main docs build, the
> kernel-doc won't end up in the docs anyway.

Ah! This makes sense. Thanks for correcting me!

> It just provides a nice
> bit of consistent formatting. Even if they do add this for some reason,
> there are controls on internal vs external (exported stuff) being added
> to the docs.

I'll use kernel-doc for this then.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

