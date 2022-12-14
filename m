Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEB64CEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLNRpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLNRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:45:32 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1329370
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:45:30 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NXN7F3BpJz1S5Cp
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:45:29 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:references:to
        :from:content-language:subject:user-agent:mime-version:date
        :message-id; s=dkim; t=1671039927; x=1671903928; bh=w6bOKPtV2u1s
        oTaKXMKuoV+EbJB0jG44bMMMfyoSbq0=; b=PXUFB0vl1gm97M6+IXnuTowKdydi
        KMxHdhSW+j+CatTgLZ7tE3piL8P1YZi753f/H/qOIS1shRtbYVaV1tcIC3gZZrjo
        nnOfiX4u4h9jfSg8xpobvV43+47ta44v6+hxZ2+rU/mdIrFY9neFG+iF4Oez6dVm
        Z2Ej377sMK/0G/DHAz7bIsvvYDaMssnHaLTdv5nmHSWrnhcPUgxGRNiyRpPyBoHj
        WLMsML5HZPk6Cgx6qeSHNKVaaZ4Jh+Gi2wVEq+/hpf2qA/TpQt6d6Jb9diuOAtf9
        dLeVPgXI8ozOWmVj5OrAXnY/3J5fyF2+u7C8aplePpf4CGbKbgtCT+Lj4w==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o6yWxU3cemwR for <linux-kernel@vger.kernel.org>;
        Wed, 14 Dec 2022 12:45:27 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NXN735T1Qz1S52g;
        Wed, 14 Dec 2022 12:45:19 -0500 (EST)
Message-ID: <cd025494-862b-70ec-a008-4be219f7f72f@mint.lgbt>
Date:   Wed, 14 Dec 2022 14:45:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel_sprout
Content-Language: en-US
From:   Lux Aliaga <they@mint.lgbt>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221214093342.153479-1-they@mint.lgbt>
 <ea20c58f-3a53-7cdd-8669-228c4acac49a@linaro.org>
 <5a511002-5cd2-b95b-a45a-faaf78e2f4a7@mint.lgbt>
In-Reply-To: <5a511002-5cd2-b95b-a45a-faaf78e2f4a7@mint.lgbt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. I think that comment is incorrect. Changing the node name on=20
extcon_usb breaks the "extcon" property in &usb3_dwc3, even after=20
changing the reference.

On 14/12/2022 14:26, Lux Aliaga wrote:
> I'm a bit confused at the "Node name: usb-id" comment. Should I change=20
> "extcon_usb" or "extcon-usb" to usb-id?
>
> On 14/12/2022 06:52, Krzysztof Kozlowski wrote:
>> On 14/12/2022 10:33, Lux Aliaga wrote:
>>> This commit implements support for the Xiaomi Mi A3
>>> (xiaomi-laurel_sprout). Here's a summary on what's working.
>>>
>>> - dmesg output to bootloader preconfigured display
>>> - USB
>>> - UFS
>>> - SMD RPM regulators
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> ---
>>> =C2=A0 arch/arm64/boot/dts/qcom/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 .../dts/qcom/sm6125-xiaomi-laurel_sprout.dts=C2=A0 | 251=20
>>> ++++++++++++++++++
>>> =C2=A0 2 files changed, 252 insertions(+)
>>> =C2=A0 create mode 100644=20
>>> arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile=20
>>> b/arch/arm64/boot/dts/qcom/Makefile
>>> index d7669a7cee9f..7b4fbb4cbb84 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -140,6 +140,7 @@ dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D=20
>>> sdm845-shift-axolotl.dtb
>>> =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sdm850-lenovo-y=
oga-c630.dtb
>>> =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sdm850-samsung-=
w737.dtb
>>> =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm6125-sony-xpe=
ria-seine-pdx201.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm6125-xiaomi-laurel_=
sprout.dtb
>>> =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm6350-sony-xpe=
ria-lena-pdx213.dtb
>>> =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm7225-fairphon=
e-fp4.dtb
>>> =C2=A0 dtb-$(CONFIG_ARCH_QCOM)=C2=A0=C2=A0=C2=A0 +=3D sm8150-hdk.dtb
>>> diff --git=20
>>> a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts=20
>>> b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>>> new file mode 100644
>>> index 000000000000..edc5f13bae28
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>>> @@ -0,0 +1,251 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sm6125.dtsi"
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/input/gpio-keys.h>
>>> +
>>> +/ {
>>> +=C2=A0=C2=A0=C2=A0 /* required for bootloader to select correct boar=
d */
>>> +=C2=A0=C2=A0=C2=A0 qcom,msm-id =3D <0x18a 0x00>; /* sm6125 v1 */
>>> +=C2=A0=C2=A0=C2=A0 qcom,board-id =3D <0x0b 0x00>;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 model =3D "Xiaomi Mi A3";
>>> +=C2=A0=C2=A0=C2=A0 compatible =3D "xiaomi,laurel_sprout", "qcom,sm61=
25";
>>> +=C2=A0=C2=A0=C2=A0 chassis-type =3D "handset";
>>> +
>>> +=C2=A0=C2=A0=C2=A0 chosen {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 framebuffer0: framebuffer=
@5c000000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ompatible =3D "simple-framebuffer";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0 0x5c000000 0 (1560 * 720 * 4)>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
idth =3D <720>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
eight =3D <1560>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
tride =3D <(720 * 4)>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
ormat =3D "a8r8g8b8";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 extcon_usb: extcon-usb {
>> Node name: usb-id
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "linux,ext=
con-usb-gpio";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id-gpio =3D <&tlmm 102 GP=
IO_ACTIVE_HIGH>;
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 reserved_memory {
>> No underscores in node names. Use same node name as other boards, don'=
t
>> invent own stuff.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug_mem: memory@ffb0000=
0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x0 0xffb00000 0x0 0xc0000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
o-map;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_log_mem: memory@ffbc=
0000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x0 0xffbc0000 0x0 0x80000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
o-map;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstore_mem: ramoops@ffc00=
000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ompatible =3D "ramoops";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x0 0xffc40000 0x0 0xc0000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
ecord-size =3D <0x1000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
onsole-size =3D <0x40000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
sg-size =3D <0x20000 0x20000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdline_mem: memory@ffd00=
000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x0 0xffd40000 0x0 0x1000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
o-map;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +};
>>> +
>>> +&rpm_requests {
>>> +=C2=A0=C2=A0=C2=A0 regulators-0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "qcom,rpm-=
pm6125-regulators";
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_s6a: s6 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <936000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1422000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l1a: l1 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1200000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1256000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l2a: l2 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1000000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1056000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l3a: l3 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1000000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1064000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l4a: l4 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <872000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <976000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l5a: l5 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1648000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <3104000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l6a: l6 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <576000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <656000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l7a: l7 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <872000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <976000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l8a: l8 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <400000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <728000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l9a: l9 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1800000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1896000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l10a: l10 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1800000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1896000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l11a: l11 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1800000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1952000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l12a: l12 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1800000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1996000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l13a: l13 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1800000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1832000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l14a: l14 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1800000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1904000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l15a: l15 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <3104000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <3232000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l16a: l16 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1800000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1904000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l17a: l17 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1248000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1304000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l18a: l18 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1200000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <1264000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l19a: l19 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1648000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <2952000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l20a: l20 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <1648000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <2952000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l21a: l21 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <2600000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <2856000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l22a: l22 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <2944000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <3304000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l23a: l23 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <3000000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <3400000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vreg_l24a: l24 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-min-microvolt =3D <2944000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egulator-max-microvolt =3D <3304000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +};
>>> +
>>> +&hsusb_phy1 {
>>> +=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> +};
>>> +
>>> +
>>> +&sdc2_off_state {
>>> +=C2=A0=C2=A0=C2=A0 sd-cd {
>> Does not look like you tested the DTS against bindings. Please run `ma=
ke
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
>>
>> that's missing -pins suffix but most likely it does not match other DT=
S
>> neither. So probably was based on some old kernel.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pins =3D "gpio98";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bias-disable;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drive-strength =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +};
>>> +
>>> +&sdc2_on_state {
>>> +=C2=A0=C2=A0=C2=A0 sd-cd {
>> Same problems.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pins =3D "gpio98";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bias-pull-up;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drive-strength =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +};
>> Best regards,
>> Krzysztof
>>
--=20
Lux Aliaga
https://nixgoat.me/

