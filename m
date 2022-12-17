Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E600364F945
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLQOXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLQOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:23:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE20614D16
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:23:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so7580513lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7GKQb3+L4Pk6YPHkpx+N3XR70m8LhkH5VdXkJBb8HM=;
        b=l3zUMMylLYscZgrd3uGYnNAviEF5RmJ/vOMiKyfBCuHjqso6Lexgmxu+Zww6tWqhIm
         AtLCsjKLwC1Q6S6lGTsriuaEF54P7Sp2smj72CEHrBw1IfUKtxZWPuJlynW2XTsl/Qb/
         WRNFSbYcTnHCYlcoiC3qiCmzsGwSmeUMnFVq71vHM2Lzw10xUYHyJTo225vv0G0WCkFd
         Wa18RG3VRjcxFXAA+4S5yM5aLgXnXA0l8UDPLBcanSQT/SgzBP8WNy3vmBjo+4eEHUoJ
         kaiYMAVQAY2OdBa1i3eq7nGShc4Uku9yS+9VSAd6jx5J3/IUQcJ9zk8T1KhF1Mi3U6ZJ
         RQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7GKQb3+L4Pk6YPHkpx+N3XR70m8LhkH5VdXkJBb8HM=;
        b=7iVnDV8dbIg0w4qH0xi1szADU7cHi4IKBvcmsvBIAamFzaoaIVbmHm2hsYyKwtNNfc
         JSqCKQwP10Z8KCd+lOqA7nbKIR5owg6D813u6JkSpjmt4AM2I7k0GYTaZ6jMlR2/zDYL
         dCioeN3z5xnXelJQAl7+eQ0iAkR9Rwb/cL7PySocItvKzSH4zu6TN1LqkFn/Y1WHD0Cx
         eCQTwqJL0tOrAVj4aFMjuqR/hCF6Qg7NqbEHb+0tRoa88mjoUX/6svCpKsmS7NiJQYYc
         63xB/M+bwZnx8TLHk742rbGjLBTnII6eqagbmUGFSW4ejncPa7wnu5cVn/tes9EWp8iW
         lBWw==
X-Gm-Message-State: ANoB5pnT6sFw927QHpUuSxY+aB3GGBy/CjXweqzFck8xyxccV3OH5nqd
        kgTQ3+R5zT8kuZFwGRpEykkybQ==
X-Google-Smtp-Source: AA0mqf64o7muDYa18mOkrzyFwBX3O94Y9WDbwZXYNtcpuGdqZrnxhYJePiH8NiGRov/9PB/Ra/CEsg==
X-Received: by 2002:a05:6512:2087:b0:4b5:7817:419d with SMTP id t7-20020a056512208700b004b57817419dmr9690622lfr.41.1671287019093;
        Sat, 17 Dec 2022 06:23:39 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id v21-20020ac258f5000000b004b5872a7003sm526315lfo.98.2022.12.17.06.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:23:38 -0800 (PST)
Message-ID: <07f2a180-8a93-6c54-6d97-208ac8426fa6@linaro.org>
Date:   Sat, 17 Dec 2022 15:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-4-they@mint.lgbt>
 <afcb9378-f331-df8c-ced5-1c10999f5fb8@linaro.org>
 <d0157452-307b-37a5-890a-b479a880ab95@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d0157452-307b-37a5-890a-b479a880ab95@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.12.2022 21:27, Lux Aliaga wrote:
> 
> On 16/12/2022 08:32, Konrad Dybcio wrote:
>>
>> On 15.12.2022 20:04, Lux Aliaga wrote:
>>> Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
>>> summary on what's working.
>>>
>>> - dmesg output to bootloader preconfigured display
>>> - USB
>>> - UFS
>>> - SMD RPM regulators
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>   .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 254 ++++++++++++++++++
>>>   2 files changed, 255 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 3e79496292e7..2b2a0170db14 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -157,6 +157,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += sdm850-lenovo-yoga-c630.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdm850-samsung-w737.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm4250-oneplus-billie2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6125-sony-xperia-seine-pdx201.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)    += sm6125-xiaomi-laurel-sprout.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6350-sony-xperia-lena-pdx213.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6375-sony-xperia-murray-pdx225.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm7225-fairphone-fp4.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>>> new file mode 100644
>>> index 000000000000..86e1ec47bf5e
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>>> @@ -0,0 +1,254 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/input/gpio-keys.h>
>>> +#include "sm6125.dtsi"
>>> +
>>> +/ {
>>> +    model = "Xiaomi Mi A3";
>>> +    compatible = "xiaomi,laurel-sprout", "qcom,sm6125";
>>> +    chassis-type = "handset";
>>> +
>>> +    /* required for bootloader to select correct board */
>>> +    qcom,msm-id = <394 0>; /* sm6125 v0 */
>> Unless you have a prototype device, this is not correct.
>>
>> Please run `cat /sys/bus/soc/devices/soc0/revision` and confirm
>> which revision is used on your phone.
> This segment has already been cross-referenced from downstream, and the device boots up successfully when using this ID, unless you're referring to the comment next to it, in which case I can recheck later, since currently I'm away from my device.
The device boots fine, because the DTB selection works on a "best match"
basis. If it can't find one for the exact version of the SoC, it may
try to boot the closest one.

Konrad
> 
