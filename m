Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2196E941A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjDTMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjDTMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:18:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C2A5B85
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:18:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f1763eea08so6582935e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681993119; x=1684585119;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V6W51aK7dtxbbEU35T6tokn9AAiBsIBkywYQixWbs7k=;
        b=iTtiiG9BKoyTchdjjOZneyQjqTMORk610b8n4BxXsaAVPl7Gre4AdWZ/IZNDNikc0I
         9oVvjGHvZF41a9aQZorUJ56/ayYdp2eb0S2ddGConjzfSKA77/+rl/OihAq2PPmibGz+
         3MJ3YOqGm7W4S33UuqNz+ygwbVE75moawpJPeZtWIZX9xc0ZwDyQ9TAvIVZOwbLDZ73o
         MzsNhmVeCjjzkg5C/2v32Up3CEjAnSjUcAvmv/g2ITv085Zm/Maye9fot1GHMz2rUQGh
         ST4Ruw1sylm07dH9PtQmotS1+fDktwg9bD7iKezrkV+6UH8p/ngg6+ZdTHgtJG66cL00
         ja9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993119; x=1684585119;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6W51aK7dtxbbEU35T6tokn9AAiBsIBkywYQixWbs7k=;
        b=lmDULUKHgASnjiE/voBhqDU6ZUZtFz86jtyAO5k9vs+YCd6bXJr7xVaxdxnxIcZdsE
         r/seMNBQOx3jKpAlPsX48jpOnsx7VtjXsGA3+W/l+Uwo8LyeKOq1L6LFa4tJC/G02Sns
         NfxW3d9Mfv9icj8UW17WVlEusRklN7vzJIhaMkMVBNWFpRPA/XVr83mk3qjE0XRMfXd9
         jsgC665rB375Ec/efDVfufedjRiEUsTx+fkpR7eAO8eNwpio4f9QTe6kIvqi6wNV4gwQ
         4WW6T4hoggdRVXf3jPRmcdEgIssdBgmTYooshyptB2T5wrpMf3dF1axQYQRKUQwsq/wX
         ooug==
X-Gm-Message-State: AAQBX9fzFddzIdWmZy9d9sEWUUfSzWKi2IG9sXSsGs6XiRH/DnzNYR9w
        EwkF7afVrV4du/9wBJP5U1Sbbg==
X-Google-Smtp-Source: AKy350ajYdesVgaKLsZF97mzYar7CBydA7JI6X215xO0mHTy3oZBXgMqc9PddsNj6bpO8qap5q6p8g==
X-Received: by 2002:adf:f58d:0:b0:2f9:61b5:7796 with SMTP id f13-20020adff58d000000b002f961b57796mr1262812wro.29.1681993119207;
        Thu, 20 Apr 2023 05:18:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:455d:d09b:3d7d:bb7d? ([2a01:e0a:982:cbb0:455d:d09b:3d7d:bb7d])
        by smtp.gmail.com with ESMTPSA id c13-20020adfe70d000000b002fbaef32231sm1865638wrm.22.2023.04.20.05.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 05:18:38 -0700 (PDT)
Message-ID: <9037aa40-c441-b610-ed7b-2c9840dff751@linaro.org>
Date:   Thu, 20 Apr 2023 14:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Content-Language: en-US
To:     Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
 <20230419131416.cns3xvkbzjeyrnux@CAB-WSD-L081021>
 <661cea17-a4dd-75d1-6a7e-16efa5aea52b@linaro.org>
 <20230419160405.d7qfir3nv6tlxx2a@CAB-WSD-L081021>
 <427e79ef-156d-027e-9296-6f4e6513a04d@linaro.org>
 <20230419170043.auzfa32weevmrt4e@CAB-WSD-L081021>
 <1c7322c9-8d2d-1cd1-95dc-dd9ec861981f@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <1c7322c9-8d2d-1cd1-95dc-dd9ec861981f@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kelvin,

On 20/04/2023 10:43, Kelvin Zhang wrote:
> On 2023/4/20 01:00, Dmitry Rokosov wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Wed, Apr 19, 2023 at 06:25:07PM +0200, Neil Armstrong wrote:
>>> On 19/04/2023 18:04, Dmitry Rokosov wrote:
>>>> On Wed, Apr 19, 2023 at 03:43:12PM +0200, Neil Armstrong wrote:
>>>>> On 19/04/2023 15:14, Dmitry Rokosov wrote:
>>>>>> On Wed, Apr 19, 2023 at 03:38:33PM +0800, =Xianwei Zhao wrote:
>>>>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>>>
>>>>>>> The C series SoCs are designed for smart IP camera
>>>>>>> applications, which does not belong to Meson series.
>>>>>>> So, Add ARCH_AMLIPC for the new series.
>>>>>>>
>>>>>>> There are now multiple amlogic SoC seies supported, so group them under
>>>>>>> their own menu. we can easily add new platforms there in the future.
>>>>>>> Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.
>>>>>>>
>>>>>>> No functional changes introduced.
>>>>>>>
>>>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>>> ---
>>>>>>>     arch/arm64/Kconfig.platforms | 12 ++++++++++++
>>>>>>>     arch/arm64/configs/defconfig |  2 ++
>>>>>>>     2 files changed, 14 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>>>>>> index 89a0b13b058d..bfbc817eef8f 100644
>>>>>>> --- a/arch/arm64/Kconfig.platforms
>>>>>>> +++ b/arch/arm64/Kconfig.platforms
>>>>>>> @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
>>>>>>>          This enables support for MediaTek MT27xx, MT65xx, MT76xx
>>>>>>>          & MT81xx ARMv8 SoCs
>>>>>>> +menuconfig ARCH_AMLOGIC
>>>>>>> +     bool "NXP SoC support"
>>>>>> NXP? Did you mean "Amlogic"?
>>>>>>
>>>>>>> +
>>>>>>> +if ARCH_AMLOGIC
>>>>>>> +
>>>>>>>     config ARCH_MESON
>>>>>>>        bool "Amlogic Platforms"
>>>>>>>        help
>>>>>>>          This enables support for the arm64 based Amlogic SoCs
>>>>>>>          such as the s905, S905X/D, S912, A113X/D or S905X/D2
>>>>>>> +config ARCH_AMLIPC
>>>>>> Do we really need a different ARCH for Amlogic IPC?
>>>>>> I can imagine that it's not the Meson architecture at all.
>>>>>> But maybe a better solution is just to rename ARCH_MESON to ARCH_AMLOGIC?
>>>>> It should be changed treewide, and is it worth it ?
>>>> As far as I understand, the A1 and S4 families are not fully compatible
>>>> with the Meson architecture, and we haven't provided additional ARCH_*
>>>> for them.
>>> The GXBB, GXL/GXM, G12A, G12B & SM1 are also not fully compatible,
>>> but they lie under the "MESON" umbrella which covers SoC since the
>>> Meson6 architecture. It's a facility to include/exclude Amlogic
>>> drivers/DT, nothing else.
> GXBB, GXL/GXM, G12A, G12B , SM1 and S4 belong to media box.
> So, "MESON" represents the media box series.
> Up to now, "MESON" works well for all existing chips except A1 and AXG.
>>> If you compare it to BCM or NXP, it's different situation, the
>>> different ARCH_* actually targets totally different SoCs from
>>> completely different Business Units or from companies acquisitions.
> Firstly, the new C series is totally different from previous MESON series.
>  From the perspective of application, the new C series is designed for smart IP camera applications,
> while MESON series is designed for hybrid OTT/ IP Set Top Box  and high-end media box applications.
>  From the perspective of architecture, the new C series integrates the sensor interface, image signal processing unit, Dewarp, video encoder, neural networking processing unit,
> which MESON series does not and will never have.
> Secondly, there are C1 and C2 besides C3.
> Moreover, more other series are on the way, such as T series.
> If we always stick to "MESON", people will get more and more confused.
> Therefore, I think it is the right time to add ARCH_AMLIPC.

Thanks for sharing such details, we are all happy to see Amlogic's
commitment to upstream of these SoC families.

But as I explained, this ARCH_MESON doesn't define the SoC type
but badly defines the Amlogic SoCs support.

>>> We should have named it ARCH_AMLOGIC since the beginning, but we
>>> can't change history.
> Shouldn't we deserve a chance to make it right?

Yes, so the right thing to do is to move to ARCH_AMLOGIC

>>>> In my opinion, it's a good time to split the Meson architecture into
>>>> proper subsets, or rename it treewide (maybe only config option
>>>> ARCH_MESON => ARCH_AMLOGIC).
>>> MESON is only a codename to differentiate from other SoC vendors
>>> because Amlogic used it as a codename for a long time.
>>> Compare this to Allwinner's "sunxi" or Qualcomm's "msm".
>>>
>>> This config has no functional mean, it's only a config namespace.
>>>
>>> Renaming it would need renaming it in all subsystems Kconfig/Makefiles
>>> and will certainly break builds with custom kernel configs
>>> in various publicly used builds like Armbian, meta-meson, LibreELEC,
>>> Debian, Suse, ...
> Let's get back to ARCH_AMLIPC.
> We just need to add ARCH_AMLIPC in the necessary subsystems Kconfig/Makefile.
> This change will keep the existing MESON related code,  and will neither involve renaming nor break any builds.

The goal of mainline Linux is to build as much as possible and
be modular at runtime, the only supported configuration is arch/arm64/configs/defconfig
and adding a new config to differentiate an Application type
doesn't make sense.

>>> So it's pointless to change, and even add a different one since
>>> it's not a family differentiator since the Kernel is modular
>>> and works around DT to determine which drivers to probe.
> Proper names play an important role in understanding the code, right?

Yes, but stable config names also play an important role for the
users for mainline, and there's a big number of users relying
on the stable naming for all SoCs starting from Meson6.

So if you really want to get rid of the ARCH_MESON, migrating to
ARCH_AMLOGIC is the right thing to do, but it involves doing
a treewide migration and there's no easy way to do this and make
sure the users still manages to build for other Amlogic platforms.

So as the Amlogic ARM/ARM64 SoC support maintainer I must make sure
breakage don't happens, and so far I don't see how achieve that.

Now, you can post a RFC so we can discuss on something.

Neil

>>> Neil
>>>
>> Thank you for the detailed explanation; it makes sense!
>> Actually, I disagree with creating a separate ARCH without first reworking
>> all of its subsets - that's why I started this discussion.
>> Now, I see that you share my perspective and believe that C3
>> should be added to the ARCH_MESON subset, so I have no objections.
>>
>> [...]
>>
>> -- 
>> Thank you,
>> Dmitry
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic

