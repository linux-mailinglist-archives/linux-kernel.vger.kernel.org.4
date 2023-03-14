Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57DB6B98D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCNPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCNPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:19:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235F15156
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:19:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x13so16160341edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WRpNQYPj8YUnb7ACu0Ig19uqCjhxtAieKpvbmH1gpQ=;
        b=WO/bAMiS1G9ZfN7Q6edDyk/aRa4CNgthvYuMmh23Q3wxPq6BNC0NQJ+VxXfB7CGvnN
         XQGwbnGacTpGdDT13czlqVLffdyPB5J4ArpRE+lNqbfGxGg+DLEaoXaYkreu+Y3Y7FpV
         iGblHAuboZ80NHV5gSE2mubXjpWui74+boqP8bDc1tqMBZhFnSAyJEK5SMxefMSC/8Ta
         mcEtkfKRZcYLABK2aCrCOkmJxEZif7zqyEc2sjah5iOAaetuFkGR07j3oqt7rmTn0Jyx
         xDkWhSBbRYDIl62li20Bd48mGIBdm5vrJXXCgnNFr4uXIrjTK6L6ghQ4n4prZ4l0JodU
         dcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WRpNQYPj8YUnb7ACu0Ig19uqCjhxtAieKpvbmH1gpQ=;
        b=ThczjaG/DWo4TZ2h59iiapj37IMXgOAYER3KqMt6IG6u47mOJJdkQPok1Tru5NhopO
         KR2bZfBO9EauXiJv7cQvFyiprRxtxl1qquKW1dP5YINO5m0KleNxLkZBKKcFWJu7UOOQ
         09aAhF7GncK0Tg8maaSFIHtGZEusG2o6Ohymt5pzXNLTxs0VgfKOn3+JqBtfv7rYUl9y
         NPofJ18lwZ92/iTWPDQ/fkp1a0baSkiasWrn1OZTWfpZsrN/iTQarOxyp0UoPTHTR+iI
         iM+Cxu5UrTNlxqJhGRW1FUZL4m0YCbODcyjZBKFmjWP/rYVxKxJac58y3UstZ+a6NidI
         chFg==
X-Gm-Message-State: AO0yUKUIiYXzjm0b63fM7J5gndOc7C76+dOwJDnq26GjLecMjWXVYmZK
        IkD37Pj7nFk4bDocQyP3Tmx3zw==
X-Google-Smtp-Source: AK7set9WFmX0z0AGnNuSMHFmGviyUfj6MQ2P63ueoNpOn2QDL0TiZlGuXF5XHv6Xd76dY313a+U/+w==
X-Received: by 2002:a17:906:25c5:b0:8af:5403:992d with SMTP id n5-20020a17090625c500b008af5403992dmr2574839ejb.28.1678807164560;
        Tue, 14 Mar 2023 08:19:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709061e1100b00922547486f9sm1286953ejj.146.2023.03.14.08.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 08:19:24 -0700 (PDT)
Message-ID: <9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org>
Date:   Tue, 14 Mar 2023 16:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
 <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
 <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
 <2d9297e9-dab7-9615-3859-79b3b2980d9a@linaro.org>
 <20230314150107.mwcglcu2jv4ixy3r@CAB-WSD-L081021>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314150107.mwcglcu2jv4ixy3r@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 16:01, Dmitry Rokosov wrote:
> On Tue, Mar 14, 2023 at 03:05:48PM +0100, Krzysztof Kozlowski wrote:
>> On 14/03/2023 12:48, Dmitry Rokosov wrote:
>>> On Tue, Mar 14, 2023 at 12:28:40PM +0100, Krzysztof Kozlowski wrote:
>>>> On 13/03/2023 21:12, Dmitry Rokosov wrote:
>>>
>>> [...]
>>>
>>>>> +#define CLKID_SPIFC		84
>>>>> +#define CLKID_USB_BUS		85
>>>>> +#define CLKID_SD_EMMC		86
>>>>> +#define CLKID_PSRAM		87
>>>>> +#define CLKID_DMC		88
>>>>
>>>> And what is here? Between 88 and 121?
>>>>
>>>
>>> Explained below.
>>>
>>>>> +#define CLKID_GEN_SEL		121
>>>>> +
>>>>> +#endif /* __A1_CLKC_H */
>>>>> diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
>>>>> new file mode 100644
>>>>> index 000000000000..8e97d3fb9d30
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
>>>>> @@ -0,0 +1,20 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>>
>>>> I found in changelog:
>>>> "fix license issue, it's GPL-2.0+ only in the current version"
>>>> and I do not understand.
>>>>
>>>> The license is wrong, so what did you fix?
>>>>
>>>
>>> Sorry don't get you. Why is it wrong?
>>
>> Run checkpatch - it will tell you why wrong. The license is not correct.
>> This is part of binding and should be the same as binding.
>>
> 
> I always run checkpatch before sending the next patch series. Checkpatch
> doesn't highlight this problem:
> 
> --------------
> $ rg SPDX a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
> 32:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> 111:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> 188:+/* SPDX-License-Identifier: GPL-2.0+ */
> 294:+/* SPDX-License-Identifier: GPL-2.0+ */
> 
> $ ./scripts/checkpatch.pl --strict a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
> total: 0 errors, 0 warnings, 0 checks, 259 lines checked

Hmm, my bad, that's something to fix/improve in checkpatch.

> 
> a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch has no obvious style problems and is ready for submission.
> --------------
> 
> I've got your point, will fix in the next version.
> 
>>> I've changed all new source files to GPL-2.0+ except yaml, because yaml
>>> dt bindings schemas require the following license:
>>>
>>>     # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>
>>> I've pointed it in the changelog.
>>
>> The only thing I found was:
>> "fix license issue, it's GPL-2.0+ only in the current version"
>>
>> so what exactly you pointed out in changelog? What was to fix? What was
>> fixed? Correct license into incorrect? But why?
>>
> 
> By 'license issue' I meant your comment for the previous version at:
> https://lore.kernel.org/all/6a950a51-fe90-9163-b73d-0a396d7187ee@linaro.org/
> 
> I thought you mentioned the problem is in two license usage in the one
> line (GPL + MIT), I've fixed it to GPL2 only, and mentioned it in the
> changelog.

The comment was for a reason why the license here is different than in
the binding. Should be the same. Binding had license:
GPL-2.0-only OR BSD-2-Clause

> 
> I didn't know about the special requirement for a dt-bindings license, I've
> just checked other clock dt-bindings and found that license is different
> in the many places:
> 
> $ grep -r "SPDX" include/dt-bindings/clock | grep -v -e "GPL-2.0.*BSD-2-Clause" | wc -l
> 291
> 
> And Tegra Car 124 as an example for different license between yaml
> schema and binding header:
> $ grep "SPDX" include/dt-bindings/clock/tegra124-car.h
> /* SPDX-License-Identifier: GPL-2.0 */
> $ grep "SPDX" Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
> # SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

checkpatch has the correct license. Many files were licensed differently
*on purpose* so I asked about purpose here.

> 
> Anyway, it's not a problem to fix the license to the same value between
> header and yaml schema, I'll fix it in the next version.
> But based on the above experiments, other clock bindings should be fixed

Your binding has a correct license. What should be fixed?

> as well, checkpatch behavior should be extended for dt bindings headers
> licence checking.

Yes.

> 
>>>
>>>>> +/*
>>>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>>>> + * Author: Jian Hu <jian.hu@amlogic.com>
>>>>> + *
>>>>> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
>>>>> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>>>>> + */
>>>>> +
>>>>> +#ifndef __A1_PLL_CLKC_H
>>>>> +#define __A1_PLL_CLKC_H
>>>>> +
>>>>> +#define CLKID_FIXED_PLL		1
>>>>> +#define CLKID_FCLK_DIV2		6
>>>>> +#define CLKID_FCLK_DIV3		7
>>>>> +#define CLKID_FCLK_DIV5		8
>>>>> +#define CLKID_FCLK_DIV7		9
>>>>> +#define CLKID_HIFI_PLL		10
>>>>
>>>>
>>>> Probably I asked about this... why indices are not continuous? You know
>>>> that consumers are allowed to use number 2 and it will be your ABI, even
>>>> though you did not write it in the binding? That's a tricky and
>>>> confusing pattern for no real gains.
>>>
>>> Actually, indices are continuou but splitted into two parts: public and
>>> private. The public part is located in the dt bindings and can be included
>>> from device tree sources. The private part is in the drivers/clk/meson
>>> folder, and only clk drivers can use it.
>>> I know, there is some trick when the user just inserts a digit value and
>>> doesn't use constants.
>>
>> This is not a trick. This is how DTS works. You have only indices/numbers.
>>
>>> But I'm starting from the assumption that such
>>> dts changes will not be approved by maintainers. In other words, the user
>>> *must* apply defined ABI constants from dt bindings; it's a strong
>>> restriction.
>>
>> But it is not correct assumption. Defines are very important, but they
>> are just helpers. Otherwise without defines you could not use any clock?
>> We pretty often use IDs - for DTS to allow merging via different trees,
>> for DT binding examples to not rely on headers.
>>
>> Your driver implements the ABI and the driver exposes for example clock
>> ID=2, even if it is not in the header.
>>
>> These IDs are unfortunately undocumented ABI and you if you change them,
>> users are allowed to complain.
>>
>> Solution: don't do this. Have all exposed clock IDs and clocks in sync
>> (and continuous).
> 
> I see. But I don't understand how I can restrict access to private
> clock objects. I don't want to open ability to change system clocks
> parents, for example. Or it's under device tree developer responsibility?
> I would appreciate any assistance in determining the best path.

There are many ways - depend on your driver. For example like this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/samsung/clk-exynos5420.c#n975

The first argument is the clock ID (or ignore).

BTW, quite likely the problem is generic to all Meson clock drivers.

Best regards,
Krzysztof

