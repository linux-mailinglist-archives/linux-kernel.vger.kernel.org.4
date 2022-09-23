Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3A5E7AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIWMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIWMcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:32:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D6491DBA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:32:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n10so20172422wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A1LMoIfsTe6u029K1CPYtu/kaJlbv/4M38rW9dvy7HY=;
        b=NHbiC/QqL7pTKM1IF3LOs4Z+fbWIgHLyuBeQPgKYqB3bQcp3/q+IMjkSXBKbsozqdY
         Z1VVzcJmeZI50GAA6nBWhJAeWN3AUOJ3OSJRXzlEg9y1ns19t8CEnDtOEwfOfIh+FVij
         y5oM/8RCBoA4Hc8QBxhmiaYdFmC4H8YwS2+k8Y9XHr10wGKPKcErWowZQewsqtmK4IBY
         DY4Pm59H7a+eLTGmmgz7wLqg908E5AVhHjonsJaaFBa5UDqNZdhHNEKBfK+ewZoxf5pF
         iaX+uFjMtQzzqdxGPhcrIL0vreo1uGL2xxjzkT+BkywU5mrZxZGyyVHx6d74Cd81Yh2H
         6sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A1LMoIfsTe6u029K1CPYtu/kaJlbv/4M38rW9dvy7HY=;
        b=1YVWHq3NX/9yMA9duYJPqdb2sRKFgPD3eVvDxRr1vYDPJcwrliUYKiFnX8VNOB+RgD
         YW4SFzuAb1TYgukUDFjb4DV1DgDtu3wL1TlWjlC71sRS0wnGUsVxilS5bJG8bSR2YGub
         5NDIXbNB0dtcjUv8Rgs8N9ptmYJWOipfqT6g473+cXOUTMQsJR49I8ZXo4vwq1aNqeKI
         hybzI1ZrpM/vnn8Ani93A9jqBonV/GH3M9dpIjp6QGjLER12KkQuKVv29NykAgCxxp5P
         7+zDR1B8duN+CkTW2Xg3FQV4e/sA/3eIPVsDtZSVjVSGHNAW02CIRKOcDts8uvJiOMlL
         cGOA==
X-Gm-Message-State: ACrzQf2jM+/tA0J12w8y/7Wh6RnQJArEjGU6ELoh6U/9gPA8wgGtYqqY
        pHXiKVu1UQGq5+y3wB9l+JplfcHWqoLPXA==
X-Google-Smtp-Source: AMsMyM6E8vC9t2uADbYYSK/mHlDsXZdsxKkElFLeNjosFG11bZI0H0Nq92OMKhLygh41xfh1Y4GJgw==
X-Received: by 2002:a05:6000:1acf:b0:22b:ed0:71b1 with SMTP id i15-20020a0560001acf00b0022b0ed071b1mr5410058wry.51.1663936348653;
        Fri, 23 Sep 2022 05:32:28 -0700 (PDT)
Received: from [192.168.1.70] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003b491f99a25sm2673286wmq.22.2022.09.23.05.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 05:32:28 -0700 (PDT)
Message-ID: <8a60b6a0-9289-0d89-c543-02386a721bca@baylibre.com>
Date:   Fri, 23 Sep 2022 14:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
References: <20220922170402.403683-1-jpanis@baylibre.com>
 <20220922170402.403683-4-jpanis@baylibre.com> <Yy0G9a5S3OzwyEwW@fedora>
 <2f3e5036-caab-f892-a4ad-b852f72db331@baylibre.com> <Yy2aAMv5PRjsJ4s2@fedora>
 <923f5876-d692-7e0e-f351-f0e05869ccd8@baylibre.com>
In-Reply-To: <923f5876-d692-7e0e-f351-f0e05869ccd8@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2022 14:17, Julien Panis wrote:
>
>
> On 23/09/2022 13:35, William Breathitt Gray wrote:
>> On Fri, Sep 23, 2022 at 09:23:26AM +0200, Julien Panis wrote:
>>>
>>> On 23/09/2022 03:08, William Breathitt Gray wrote:
>>>> On Thu, Sep 22, 2022 at 07:04:01PM +0200, Julien Panis wrote:
>>>>> ECAP hardware on TI AM62x SoC supports capture feature. It can be 
>>>>> used
>>>>> to timestamp events (falling/rising edges) detected on input signal.
>>>>>
>>>>> This commit adds capture driver support for ECAP hardware on AM62x 
>>>>> SoC.
>>>>>
>>>>> In the ECAP hardware, capture pin can also be configured to be in
>>>>> PWM mode. Current implementation only supports capture operating 
>>>>> mode.
>>>>> Hardware also supports timebase sync between multiple instances, but
>>>>> this driver supports simple independent capture functionality.
>>>>>
>>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>> Hello Julien,
>>>>
>>>> Comments follow inline below.
>>>>
>>>>> +/**
>>>>> + * struct ecap_cnt_dev - device private data structure
>>>>> + * @enabled: device state
>>>>> + * @clk:     device clock
>>>>> + * @regmap:  device register map
>>>>> + * @nb_ovf:  number of overflows since capture start
>>>>> + * @pm_ctx:  device context for PM operations
>>>>> + */
>>>>> +struct ecap_cnt_dev {
>>>>> +    bool enabled;
>>>>> +    struct clk *clk;
>>>>> +    struct regmap *regmap;
>>>>> +    atomic_t nb_ovf;
>>>>> +    struct {
>>>>> +        u8 ev_mode;
>>>>> +        u32 time_cntr;
>>>>> +    } pm_ctx;
>>>>> +};
>>>> Provide documentation for the ev_mode and time_cntr members. You
>>>> probably need a lock as well to protect access to this structure or
>>>> you'll end up with race problems.
>>> Hi William,
>>>
>>> How can I end up with race problems ? pm_ctx members are only 
>>> accessed at
>>> suspend (after capture/IRQ are disabled) and resume (before 
>>> capture/IRQ are
>>> re-enabled).
>>> Is there any risk I did not identify ?
>>>
>>> Julien
>> I was thinking of the ecap_cnt_dev enabled member. The Counter callbacks
>> may execute in concurrent threads, so races can appear when you access
>> members of the ecap_cnt_dev structure in these callbacks.
>>
>> Take for example this section of ecap_cnt_enable_write():
>>
>>          if (enable == ecap_dev->enabled)
>>                  return 0;
>>          if (enable)
>>                  ecap_cnt_capture_enable(counter);
>>          else
>>                  ecap_cnt_capture_disable(counter);
>>          ecap_dev->enabled = enable
>>
>> Suppose two threads try to enable the count capture. A race condition is
>> present where the two threads could see ecap_dev->enabled as false and
>> both proceed to call ecap_cnt_capture_enable(). This results in
>> pm_runtime_get_sync() bumping the usage count twice and we're left with
>> a mismatch the next time ecap_cnt_capture_disable() is called.
>>
>> William Breathitt Gray
>
> OK, If I understand well there's the same problem with IO access with 
> regmap ?
> Julien

[ERRATUM] It seems that some spinlock is already used by regmap API.
So, only the 'enabled' member needs a lock.
