Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D586FB093
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjEHMsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHMsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:48:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7081F32359;
        Mon,  8 May 2023 05:48:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f22908a082so1985052e87.1;
        Mon, 08 May 2023 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683550116; x=1686142116;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Uf76kzQL3e3Ng3HXTMG+effyKJxcrXo57uEe4Q7lJI=;
        b=SNiMnJnIrFE0wqbn88SmWG89iGu8lQntyHP9DL4JrtLZdLb177LdTyTTLbQsBpwdfF
         9nwReW+pH5qrpboEMI/qC0cbOKXqGj+406UNJFog5Khcb6AJFXueqBZJSJqo2fjuDBjn
         o/NKAXS5Na82gpxdlPkKnvghX55UQrUK3ddkdhCyt+uvVLtpM+oDnKAzsXcm8Q+BSy6M
         07h1h2kYFqwtJchsrl6IdeGYRoN+44A3kFRNdHXdhoN18y5Mgozo16pZEdQTC6Wfw1xg
         Q7R0disZtgq+tb/o5KB3/Nw5cinTUeHXB+JEpv1w9+z0P656n/PDoLo5M3c8T9sLYnTR
         VxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683550116; x=1686142116;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Uf76kzQL3e3Ng3HXTMG+effyKJxcrXo57uEe4Q7lJI=;
        b=cTap30576S5GbusJ0d7mqmde7AegdEF5WlWwttfHpxkRYt0B5579b9ovSrS2qnwkaw
         K33CUeSuwmsvU/5GXIrcPolwQsj0AiQLFtsryLVnWJt4MppMYyMreEWlunuKJksz8FhT
         jgL/dRXVlbdNmJkV0nqOH4n61oVo8gOMHMCUsTcNbdr2H+hwKu9QyIPLDC/cIIyawBGY
         DApK8H9kFYpp0lYGKRBCrvmhKL8fvyzpLlxmbaP+HLAL19McDQqGnfSrahq+s3T7fjkv
         aQ1DHMq4Ag41sgkpDjYvL2Os4IItTp+kb0SGvI5B/ffQu4CuNQaQbxq+JSIIamyco+Mx
         n05Q==
X-Gm-Message-State: AC+VfDy7mzIRxmDXqvj1Gqwd6lUnbAfwGg78iiC059ny5qk7WuQuoKyn
        EO5y4cFglxia/8f9060yHAjiW9w3inM=
X-Google-Smtp-Source: ACHHUZ4MtOahkVAhUN2+80cHR2i76UP93IjgzkSKAQ3qmgnDxRT+uE9owVBML6KYIZEXkD+2l+VJYQ==
X-Received: by 2002:a19:ae1a:0:b0:4f2:4d0a:7bdf with SMTP id f26-20020a19ae1a000000b004f24d0a7bdfmr970645lfc.52.1683550115547;
        Mon, 08 May 2023 05:48:35 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id q12-20020ac24a6c000000b004efeea0dcfesm1302128lfp.44.2023.05.08.05.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 05:48:35 -0700 (PDT)
Message-ID: <5b32c9dc-f14b-f4dc-d3e2-08bd4f4e6465@gmail.com>
Date:   Mon, 8 May 2023 15:48:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
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
 <20230507152443.754f2fab@jic23-huawei> <ZFjt33rdupWOAsc8@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <ZFjt33rdupWOAsc8@smile.fi.intel.com>
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

On 5/8/23 15:41, Andy Shevchenko wrote:
> On Sun, May 07, 2023 at 03:24:43PM +0100, Jonathan Cameron wrote:
>> On Wed, 3 May 2023 05:11:53 +0000
>> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
>>> On 5/2/23 23:40, Andy Shevchenko wrote:
>>>> On Wed, Apr 26, 2023 at 11:08:17AM +0300, Matti Vaittinen wrote:
> 
> ...
> 
>>>>> +enum {
>>>>> +	BU27008_RED,	/* Always data0 */
>>>>> +	BU27008_GREEN,	/* Always data1 */
>>>>> +	BU27008_BLUE,	/* data2, configurable (blue / clear) */
>>>>> +	BU27008_CLEAR,	/* data2 or data3 */
>>>>> +	BU27008_IR,	/* data3 */
>>>>> +	BU27008_NUM_CHANS
>>>>
>>>> Why not converting comments to a kernel-doc?
>>>>    
>>>>> +};
>>>>> +
>>>>> +enum {
>>>>> +	BU27008_DATA0, /* Always RED */
>>>>> +	BU27008_DATA1, /* Always GREEN */
>>>>> +	BU27008_DATA2, /* Blue or Clear */
>>>>> +	BU27008_DATA3, /* IR or Clear */
>>>>> +	BU27008_NUM_HW_CHANS
>>>>> +};
>>>>
>>>> Ditto.
>>>
>>> I see no value having entities which are not intended to be used outside
>>> this file documented in any "global" documentation. One who is ever
>>> going to use these or wonder what these are - will most likely be
>>> watching this file. My personal view is that the generated docs should
>>> be kept lean. In my opinion the problem of the day is the time we spend
>>> looking for a needle hidden in a haystack. In my opinion adding this to
>>> kernel-doc just adds hay :)
>>
>>>
>>> I still can do this if no-one else objects. I almost never look at the
>>> generated docs myself. Usually I just look the docs from code files -
>>> and kernel-doc format is not any worse for me to read. Still, I can
>>> imagine including this type of stuff to generic doc just bloats them and
>>> my not serve well those who use them.
>>
>>
>> Unless someone specifically adds this doc to the main docs build, the
>> kernel-doc won't end up in the docs anyway. It just provides a nice
>> bit of consistent formatting. Even if they do add this for some reason,
>> there are controls on internal vs external (exported stuff) being added
>> to the docs.
> 
> I can run it manually and see in a nice form instead of browsing file for that,
> so there is still a usefulness in my opinion. Esp. taking into account that
> comments are already there. It's just different and helpful form of
> representation. No?

My main objection was a _misunderstanding_ that the kernel-doc formatted 
comments would automatically end up in generated docs. As I wrote, I 
rarely (never) generate the docs. I use the docs from sources, hence it 
is not easy for me to see this value. Nevertheless, I also wrote

 >>> and kernel-doc format is not any worse for me to read.

Hence, I did format these comments as kernel-doc in v5. The only slight 
disadvantage (from my perspective) in using the kernel-doc is increased 
amount of lines with pretty much no additional information. I can live 
with that though.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

