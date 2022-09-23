Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CCC5E7A92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiIWMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIWMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:21:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACEE13198D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:17:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso3183564wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hGxzyi/pjk7DCJr7hlF/KM96te9l/emnx/wpgO+X2jw=;
        b=IDAYXBBR0FyIiL1wcKctRmtp+moysNxUFBEZ2KtSb3ILYDVgLyX5xreW9ErweMIfYR
         raf/WVBTh5z0NaoQ2MZ9AUrAYHCWjys0pxWPOlUIPqMhTvif9Xkp70eCyprc60dfUl68
         lMkxvIlufX4ljKtHU7J2hIRY+XoZcWKzWkyzXKQvhnnrIk3LYTZnroR8bpPE7mhZHcTC
         NkcULvdjfwHAwqhYG53IdhKcWuTpCjqReywcddKVmo16be7KMRITCBA6t2ZgWbky7s+x
         ylB0dkhjnH2spNTkkEjsPEVRKiQRb4WC5Z8uF7xU8LqgCZvZjfT4GihcEn6TI5FodGwc
         auFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hGxzyi/pjk7DCJr7hlF/KM96te9l/emnx/wpgO+X2jw=;
        b=asOlgLSAZ5BS7KScvX7AIytz0mJkhMjq61XYfSVfTLXTW/7/d5GQLpimZ1TDqHDq10
         ++JVHEOZ+2/Xhay1CGDe+BrsGKVcx4LqkktFpEgXyOWLwRTaHmJ+yAddbheFwyVrhcd2
         gS3n3x+yIGH3EBeH1uRBvMzuJ/IlpAVVCQ+Qe28RoeAxg0RkYUnJeVQNcDvCKPp8vq6K
         zpMF21ULXFBtEm1eswJk0LPDQcrZubmSdzPjCV1kmqce+wlM3IUxTiyqHIq0H11mOE8T
         AY9hew/D4nZ7KQMhxABt6NwYjlk/lG7emciVGEjKVT3+9+MdCByCWTldn68dT/YE5F68
         bszQ==
X-Gm-Message-State: ACrzQf1WzfAUeETy/CuDeua+N8xmmY2NTjRxAxGlfHYS6sZtsKNxtRXD
        ezJStWN6OB3Px++4Ff+GXtiDnA==
X-Google-Smtp-Source: AMsMyM5+jGrSmbeMPKPG8Qhe8WfIplR3L2wXhoBQCJIy77/zBBOob8+TZDSp1FEFMgBohqTkacRFWw==
X-Received: by 2002:a05:600c:211a:b0:3b4:75ee:c63e with SMTP id u26-20020a05600c211a00b003b475eec63emr13100912wml.44.1663935444457;
        Fri, 23 Sep 2022 05:17:24 -0700 (PDT)
Received: from [192.168.1.70] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d60cd000000b0022af6c93340sm7250886wrt.17.2022.09.23.05.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 05:17:23 -0700 (PDT)
Message-ID: <923f5876-d692-7e0e-f351-f0e05869ccd8@baylibre.com>
Date:   Fri, 23 Sep 2022 14:17:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
References: <20220922170402.403683-1-jpanis@baylibre.com>
 <20220922170402.403683-4-jpanis@baylibre.com> <Yy0G9a5S3OzwyEwW@fedora>
 <2f3e5036-caab-f892-a4ad-b852f72db331@baylibre.com> <Yy2aAMv5PRjsJ4s2@fedora>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <Yy2aAMv5PRjsJ4s2@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2022 13:35, William Breathitt Gray wrote:
> On Fri, Sep 23, 2022 at 09:23:26AM +0200, Julien Panis wrote:
>>
>> On 23/09/2022 03:08, William Breathitt Gray wrote:
>>> On Thu, Sep 22, 2022 at 07:04:01PM +0200, Julien Panis wrote:
>>>> ECAP hardware on TI AM62x SoC supports capture feature. It can be used
>>>> to timestamp events (falling/rising edges) detected on input signal.
>>>>
>>>> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>>>>
>>>> In the ECAP hardware, capture pin can also be configured to be in
>>>> PWM mode. Current implementation only supports capture operating mode.
>>>> Hardware also supports timebase sync between multiple instances, but
>>>> this driver supports simple independent capture functionality.
>>>>
>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>> Hello Julien,
>>>
>>> Comments follow inline below.
>>>
>>>> +/**
>>>> + * struct ecap_cnt_dev - device private data structure
>>>> + * @enabled: device state
>>>> + * @clk:     device clock
>>>> + * @regmap:  device register map
>>>> + * @nb_ovf:  number of overflows since capture start
>>>> + * @pm_ctx:  device context for PM operations
>>>> + */
>>>> +struct ecap_cnt_dev {
>>>> +	bool enabled;
>>>> +	struct clk *clk;
>>>> +	struct regmap *regmap;
>>>> +	atomic_t nb_ovf;
>>>> +	struct {
>>>> +		u8 ev_mode;
>>>> +		u32 time_cntr;
>>>> +	} pm_ctx;
>>>> +};
>>> Provide documentation for the ev_mode and time_cntr members. You
>>> probably need a lock as well to protect access to this structure or
>>> you'll end up with race problems.
>> Hi William,
>>
>> How can I end up with race problems ? pm_ctx members are only accessed at
>> suspend (after capture/IRQ are disabled) and resume (before capture/IRQ are
>> re-enabled).
>> Is there any risk I did not identify ?
>>
>> Julien
> I was thinking of the ecap_cnt_dev enabled member. The Counter callbacks
> may execute in concurrent threads, so races can appear when you access
> members of the ecap_cnt_dev structure in these callbacks.
>
> Take for example this section of ecap_cnt_enable_write():
>
>          if (enable == ecap_dev->enabled)
>                  return 0;
>          if (enable)
>                  ecap_cnt_capture_enable(counter);
>          else
>                  ecap_cnt_capture_disable(counter);
>          ecap_dev->enabled = enable
>
> Suppose two threads try to enable the count capture. A race condition is
> present where the two threads could see ecap_dev->enabled as false and
> both proceed to call ecap_cnt_capture_enable(). This results in
> pm_runtime_get_sync() bumping the usage count twice and we're left with
> a mismatch the next time ecap_cnt_capture_disable() is called.
>
> William Breathitt Gray

OK, If I understand well there's the same problem with IO access with 
regmap ?
Julien
