Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF836E94B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDTMjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDTMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:39:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31393659C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:39:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id xd13so6093997ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681994358; x=1684586358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frO9xA4qGK3Raq8henddER4Gj7fo5Lq3c6EyPmzA39U=;
        b=fZuH5/hhYDl86HJZlXgWEAdKy2Wjj+YkTxAJWzXAxlVaW20zc/QIbLhxvG7FguXpji
         j3jQo2H6JIIS3vfjtTD1LQCEFuw1F7fA+RPYkLR8upP1HzWFo69xMN16ojn8VHZvcN7c
         iPMsHojPU6fjNazNFkf5fb8WeSN/FJc1oW20XxS4AmUgdX4cm1gA9vcIm7Lx9RaFk/a7
         jFmDgFM+9MtCJnA8dcLqFdbM2+JrZtq7PrEe+2pEHABehxt/r3XEBpGLpRza769JogAG
         37YlkV6IsSQo7iCplci3XENs4Qk7kmXk4UQYAGI033ehf28WxSN796KDfZxHVRzwmCIA
         z+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681994358; x=1684586358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frO9xA4qGK3Raq8henddER4Gj7fo5Lq3c6EyPmzA39U=;
        b=HBE1+UIWxNgxDIFVDwatQjXCUe3rYxLwcTYtb/Zu6RO678It53hinzAsJMwOW6//EO
         Qi57AzRtnFyqDa5efi7mEFr5yhQNrMhNAbUCqeY79iDzOA47PelOzbpfe6/zngpKCZKL
         +/w6XHikw3DK66n4rXoMKrofVWK6L1kS8IJAh3GYCOfkPgHWHD7Gv1Mn/kcNfl2PsGHY
         SGWTHgl4j1QgxY+yIUGq8TFrOGSuV6kxa/qH6NWyF6iOEDYYnc4S1EhVoemFKh0Q20us
         8rU/t03NGaq7afVQ9DfTbA52ED9oTWj4I9TjwKNH87PdxcfZ5B0sOlLsjdmZ0HiR6TDX
         l56Q==
X-Gm-Message-State: AAQBX9c+/DO/zDWEQlQfFasdM9o5KDUGFOj4wk/0ImE28aUiLmAtcOHh
        +z3aIHuhx+L81OrOLAUh6NUSMA==
X-Google-Smtp-Source: AKy350Z8LjQ8yEXBqV1QNKNQSYXwoxzmB7xhaYEUEDq6AZRkT+w7troCaBLcm+1WAcJyPN8xGEfDeA==
X-Received: by 2002:a17:906:115a:b0:94e:8431:4767 with SMTP id i26-20020a170906115a00b0094e84314767mr1528797eja.38.1681994358651;
        Thu, 20 Apr 2023 05:39:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id fh22-20020a1709073a9600b0094efc389980sm689608ejc.58.2023.04.20.05.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 05:39:18 -0700 (PDT)
Message-ID: <a28766ff-39aa-7e10-394a-6f4db524fff9@linaro.org>
Date:   Thu, 20 Apr 2023 14:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Content-Language: en-US
To:     Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1c7322c9-8d2d-1cd1-95dc-dd9ec861981f@amlogic.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/04/2023 10:43, Kelvin Zhang wrote:
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
>  From the perspective of application, the new C series is designed for 
> smart IP camera applications,
> while MESON series is designed for hybrid OTT/ IP Set Top Box  and 
> high-end media box applications.
>  From the perspective of architecture, the new C series integrates the 
> sensor interface, image signal processing unit, Dewarp, video encoder, 
> neural networking processing unit,
> which MESON series does not and will never have.
> Secondly, there are C1 and C2 besides C3.
> Moreover, more other series are on the way, such as T series.
> If we always stick to "MESON", people will get more and more confused.
> Therefore, I think it is the right time to add ARCH_AMLIPC.

Your DTS uses compatibles from meson, so I would argue that it is still
part of the same architecture.

Anyway, this is just config symbol, so it does not matter. There will be
no confusion and no problem of keeping it ARCH_MESON.


>>> We should have named it ARCH_AMLOGIC since the beginning, but we
>>> can't change history.
> Shouldn't we deserve a chance to make it right?
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
> We just need to add ARCH_AMLIPC in the necessary subsystems 
> Kconfig/Makefile.
> This change will keep the existing MESON related code,  and will neither 
> involve renaming nor break any builds.

It is also not necessary and not justified. We do not have multiple
top-level subarchs for one architecture. We had such talks already and
there was no consensus to change it.

Best regards,
Krzysztof

