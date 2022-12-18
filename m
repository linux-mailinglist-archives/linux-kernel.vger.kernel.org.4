Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225F64FF1B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLRO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiLRO0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:26:40 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4B7642
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:26:36 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NZlWv3d9hz1S5D8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 09:26:35 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :content-language:references:to:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671373594; x=1672237595; bh=NtwwfTJ
        35XqFurSMfDIwOCOk77rKIDyhJoth9Mky+S8=; b=bcKYcqzP75ADnN0WPmHDuOQ
        wvC7HEwVJmu2K3xh90z+iaho/HE/skHkXYlIwHoZzxCUO7XBRNh/YhWHzh239i/U
        kXjD1eqRZl145wtfxjbrg4JqmuxTFcUA8Qdy+ZTNlPGYVK4pyzxY9nVnkFarOEyO
        cvDXjmvLHnvlbckkXrbsOaA2Qf5GI0ncEsPsK/ecFus413wjGXMLXgj4WSnOVNUc
        gHY5Dgbd1fvd+NdaJUaK8N7qgD92WCdGyExrUEauT1WMUsD0NTlRwc/W2Uww+KZd
        3mxc+WYsnActE+RwwXn1HghKohERCgm1wKi/iGq/8EOlCqbk+A1CxuVToRvdwWQ=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1VYkJDCQqN06 for <linux-kernel@vger.kernel.org>;
        Sun, 18 Dec 2022 09:26:34 -0500 (EST)
Received: from [192.168.0.15] (pc-16-114-239-201.cm.vtr.net [201.239.114.16])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NZlWk4kNpz1S4t5;
        Sun, 18 Dec 2022 09:26:25 -0500 (EST)
Message-ID: <672d61c2-33a6-4b3b-fbb5-a12556d673a5@mint.lgbt>
Date:   Sun, 18 Dec 2022 11:26:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
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
 <07f2a180-8a93-6c54-6d97-208ac8426fa6@linaro.org>
Content-Language: en-US
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <07f2a180-8a93-6c54-6d97-208ac8426fa6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/12/2022 11:23, Konrad Dybcio wrote:
> On 16.12.2022 21:27, Lux Aliaga wrote:
>> On 16/12/2022 08:32, Konrad Dybcio wrote:
>>> On 15.12.2022 20:04, Lux Aliaga wrote:
>>>> Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
>>>> summary on what's working.
>>>>
>>>> - dmesg output to bootloader preconfigured display
>>>> - USB
>>>> - UFS
>>>> - SMD RPM regulators
>>>>
>>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>>> ---
>>>>  =C2=A0 arch/arm64/boot/dts/qcom/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>>  =C2=A0 .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts=C2=A0 | 254 +++=
+++++++++++++++
>>>>  =C2=A0 2 files changed, 255 insertions(+)
>>>>  =C2=A0 create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-la=
urel-sprout.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts=
/qcom/Makefile
>>>> index 3e79496292e7..2b2a0170db14 100644
>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>> @@ -157,6 +157,7 @@ dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D s=
dm850-lenovo-yoga-c630.dtb
>>>>  =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sdm850-samsun=
g-w737.dtb
>>>>  =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm4250-oneplu=
s-billie2.dtb
>>>>  =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm6125-sony-x=
peria-seine-pdx201.dtb
>>>> +dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm6125-xiaomi-laurel=
-sprout.dtb
>>>>  =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm6350-sony-x=
peria-lena-pdx213.dtb
>>>>  =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm6375-sony-x=
peria-murray-pdx225.dtb
>>>>  =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm7225-fairph=
one-fp4.dtb
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dt=
s b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>>>> new file mode 100644
>>>> index 000000000000..86e1ec47bf5e
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
>>>> @@ -0,0 +1,254 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/input/input.h>
>>>> +#include <dt-bindings/input/gpio-keys.h>
>>>> +#include "sm6125.dtsi"
>>>> +
>>>> +/ {
>>>> +=C2=A0=C2=A0=C2=A0 model =3D "Xiaomi Mi A3";
>>>> +=C2=A0=C2=A0=C2=A0 compatible =3D "xiaomi,laurel-sprout", "qcom,sm6=
125";
>>>> +=C2=A0=C2=A0=C2=A0 chassis-type =3D "handset";
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* required for bootloader to select correct boa=
rd */
>>>> +=C2=A0=C2=A0=C2=A0 qcom,msm-id =3D <394 0>; /* sm6125 v0 */
>>> Unless you have a prototype device, this is not correct.
>>>
>>> Please run `cat /sys/bus/soc/devices/soc0/revision` and confirm
>>> which revision is used on your phone.
>> This segment has already been cross-referenced from downstream, and th=
e device boots up successfully when using this ID, unless you're referrin=
g to the comment next to it, in which case I can recheck later, since cur=
rently I'm away from my device.
> The device boots fine, because the DTB selection works on a "best match=
"
> basis. If it can't find one for the exact version of the SoC, it may
> try to boot the closest one.
>
> Konrad

Confirmed it. It's an sm6125 v1. Will fix.

--=20
Lux Aliaga
https://nixgoat.me/

