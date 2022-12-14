Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD664D147
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiLNUeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiLNUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:34:12 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE24A59E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:27:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so12380347lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jdBIBSBtwqHInA24/RAynPGJTAquxojB3hFzekjdJM=;
        b=wto1y5eNO5bCE0RDlK/WBPoH0U4c9fYxMejY9QkgopYgnVLuRPEBD6Z+rPr8/KPDpR
         b6uBpqUKfQG3MFD6ztAxVFmZstpkpvPhBz2xb5Sjb87Opxtr5iubYtormSn2ANRd5k2J
         pULwS8RFLG/Q5J0X4O9ZjvQyCVGM4bbLGI39Jem8Yco1ilBs8kFrJKvt9XSegjCGBEAt
         9ebzJGuZZtv+y+iIjUkWkShIYp04kwNk+RmGcJ1BZHlQAPzoalueLMAYkCZUNfjXluvg
         t6imjt1zAmfmitdE/WZUBc15c5cgkw6G3h2DjQYc7aSLNEE51FPqo1BSBPCeZJxu8EDI
         +uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jdBIBSBtwqHInA24/RAynPGJTAquxojB3hFzekjdJM=;
        b=yEmst5BDWFl8snqXCni8e5wMHwPT58xR992YRd4EMhlZMoMjGp2zwZwDxZh9a0lIMn
         lnfhrWZBzt2RC+6nPGQ9jSfrD4UltiXCmVsIORy8tkHHcW5vN7lpTMxOmRoQf3nmRPvz
         hRwCtzh5z1q437FWwcmtvWgSqHbHDAWr/lORx3ShsU/IFhHgyJx2yWHXy+LrvSMp8U36
         cWms/VtFld0ghf4t4fQQGEHEPuhoCdWSrLqv+kUCxW7He9TZ2T/cgv57e5WVePCwI/P/
         nlCB36zYybxOJFX9cH82xvO6CXX8POdUmgEN5WZiQTHANA0IJ6+nICGKJ+qyjtfreyW8
         VPjw==
X-Gm-Message-State: ANoB5pmhnYqqswGMGOurlvnzOdEsjvHPhmMvDbBRcK+1ZrZDbfwhQFQa
        HSbxmfLtkon3OkeFWsySVGU7k7kOrq5DH2EH
X-Google-Smtp-Source: AA0mqf4gNu8oEYGafcFFLQkhlXqbCwBt+ltW2Tduc2ZdlTGyj0WREmRKJgmrd1hMn3Upxp7LsBZG0Q==
X-Received: by 2002:ac2:4e81:0:b0:4b5:8176:10d2 with SMTP id o1-20020ac24e81000000b004b5817610d2mr9903826lfr.44.1671049634566;
        Wed, 14 Dec 2022 12:27:14 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512202c00b00494935ddb88sm924389lfs.240.2022.12.14.12.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 12:27:13 -0800 (PST)
Message-ID: <b62090b2-0772-7e9f-7a03-e97533d62230@linaro.org>
Date:   Wed, 14 Dec 2022 21:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel_sprout
To:     Lux Aliaga <they@mint.lgbt>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
 <cd025494-862b-70ec-a008-4be219f7f72f@mint.lgbt>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <cd025494-862b-70ec-a008-4be219f7f72f@mint.lgbt>
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



On 14.12.2022 18:45, Lux Aliaga wrote:
> Ok. I think that comment is incorrect. Changing the node name on extcon_usb breaks the "extcon" property in &usb3_dwc3, even after changing the reference.
> 
Please don't toppost, reply under the paragraph you're referencing.

Konrad
> On 14/12/2022 14:26, Lux Aliaga wrote:
>> I'm a bit confused at the "Node name: usb-id" comment. Should I change "extcon_usb" or "extcon-usb" to usb-id?
>>
>> On 14/12/2022 06:52, Krzysztof Kozlowski wrote:
>>> On 14/12/2022 10:33, Lux Aliaga wrote:
>>>> This commit implements support for the Xiaomi Mi A3
>>>> (xiaomi-laurel_sprout). Here's a summary on what's working.
>>>>
>>>> - dmesg output to bootloader preconfigured display
>>>> - USB
>>>> - UFS
>>>> - SMD RPM regulators
>>>>
>>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>>   .../dts/qcom/sm6125-xiaomi-laurel_sprout.dts  | 251 ++++++++++++++++++
>>>>   2 files changed, 252 insertions(+)
>>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>>> index d7669a7cee9f..7b4fbb4cbb84 100644
>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>> @@ -140,6 +140,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += sdm845-shift-axolotl.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdm850-lenovo-yoga-c630.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdm850-samsung-w737.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6125-sony-xperia-seine-pdx201.dtb
>>>> +dtb-$(CONFIG_ARCH_QCOM)    += sm6125-xiaomi-laurel_sprout.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6350-sony-xperia-lena-pdx213.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm7225-fairphone-fp4.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8150-hdk.dtb
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>>>> new file mode 100644
>>>> index 000000000000..edc5f13bae28
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>>>> @@ -0,0 +1,251 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "sm6125.dtsi"
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/input/input.h>
>>>> +#include <dt-bindings/input/gpio-keys.h>
>>>> +
>>>> +/ {
>>>> +    /* required for bootloader to select correct board */
>>>> +    qcom,msm-id = <0x18a 0x00>; /* sm6125 v1 */
>>>> +    qcom,board-id = <0x0b 0x00>;
>>>> +
>>>> +    model = "Xiaomi Mi A3";
>>>> +    compatible = "xiaomi,laurel_sprout", "qcom,sm6125";
>>>> +    chassis-type = "handset";
>>>> +
>>>> +    chosen {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +        ranges;
>>>> +
>>>> +        framebuffer0: framebuffer@5c000000 {
>>>> +            compatible = "simple-framebuffer";
>>>> +            reg = <0 0x5c000000 0 (1560 * 720 * 4)>;
>>>> +            width = <720>;
>>>> +            height = <1560>;
>>>> +            stride = <(720 * 4)>;
>>>> +            format = "a8r8g8b8";
>>>> +        };
>>>> +    };
>>>> +
>>>> +    extcon_usb: extcon-usb {
>>> Node name: usb-id
>>>
>>>> +        compatible = "linux,extcon-usb-gpio";
>>>> +        id-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
>>>> +    };
>>>> +
>>>> +    reserved_memory {
>>> No underscores in node names. Use same node name as other boards, don't
>>> invent own stuff.
>>>
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +        debug_mem: memory@ffb00000 {
>>>> +            reg = <0x0 0xffb00000 0x0 0xc0000>;
>>>> +            no-map;
>>>> +        };
>>>> +
>>>> +        last_log_mem: memory@ffbc0000 {
>>>> +            reg = <0x0 0xffbc0000 0x0 0x80000>;
>>>> +            no-map;
>>>> +        };
>>>> +
>>>> +        pstore_mem: ramoops@ffc00000 {
>>>> +            compatible = "ramoops";
>>>> +            reg = <0x0 0xffc40000 0x0 0xc0000>;
>>>> +            record-size = <0x1000>;
>>>> +            console-size = <0x40000>;
>>>> +            msg-size = <0x20000 0x20000>;
>>>> +        };
>>>> +
>>>> +        cmdline_mem: memory@ffd00000 {
>>>> +            reg = <0x0 0xffd40000 0x0 0x1000>;
>>>> +            no-map;
>>>> +        };
>>>> +    };
>>>> +};
>>>> +
>>>> +&rpm_requests {
>>>> +    regulators-0 {
>>>> +        compatible = "qcom,rpm-pm6125-regulators";
>>>> +
>>>> +        vreg_s6a: s6 {
>>>> +            regulator-min-microvolt = <936000>;
>>>> +            regulator-max-microvolt = <1422000>;
>>>> +        };
>>>> +
>>>> +        vreg_l1a: l1 {
>>>> +            regulator-min-microvolt = <1200000>;
>>>> +            regulator-max-microvolt = <1256000>;
>>>> +        };
>>>> +
>>>> +        vreg_l2a: l2 {
>>>> +            regulator-min-microvolt = <1000000>;
>>>> +            regulator-max-microvolt = <1056000>;
>>>> +        };
>>>> +
>>>> +        vreg_l3a: l3 {
>>>> +            regulator-min-microvolt = <1000000>;
>>>> +            regulator-max-microvolt = <1064000>;
>>>> +        };
>>>> +
>>>> +        vreg_l4a: l4 {
>>>> +            regulator-min-microvolt = <872000>;
>>>> +            regulator-max-microvolt = <976000>;
>>>> +        };
>>>> +
>>>> +        vreg_l5a: l5 {
>>>> +            regulator-min-microvolt = <1648000>;
>>>> +            regulator-max-microvolt = <3104000>;
>>>> +        };
>>>> +
>>>> +        vreg_l6a: l6 {
>>>> +            regulator-min-microvolt = <576000>;
>>>> +            regulator-max-microvolt = <656000>;
>>>> +        };
>>>> +
>>>> +        vreg_l7a: l7 {
>>>> +            regulator-min-microvolt = <872000>;
>>>> +            regulator-max-microvolt = <976000>;
>>>> +        };
>>>> +
>>>> +        vreg_l8a: l8 {
>>>> +            regulator-min-microvolt = <400000>;
>>>> +            regulator-max-microvolt = <728000>;
>>>> +        };
>>>> +
>>>> +        vreg_l9a: l9 {
>>>> +            regulator-min-microvolt = <1800000>;
>>>> +            regulator-max-microvolt = <1896000>;
>>>> +        };
>>>> +
>>>> +        vreg_l10a: l10 {
>>>> +            regulator-min-microvolt = <1800000>;
>>>> +            regulator-max-microvolt = <1896000>;
>>>> +        };
>>>> +
>>>> +        vreg_l11a: l11 {
>>>> +            regulator-min-microvolt = <1800000>;
>>>> +            regulator-max-microvolt = <1952000>;
>>>> +        };
>>>> +
>>>> +        vreg_l12a: l12 {
>>>> +            regulator-min-microvolt = <1800000>;
>>>> +            regulator-max-microvolt = <1996000>;
>>>> +        };
>>>> +
>>>> +        vreg_l13a: l13 {
>>>> +            regulator-min-microvolt = <1800000>;
>>>> +            regulator-max-microvolt = <1832000>;
>>>> +        };
>>>> +
>>>> +        vreg_l14a: l14 {
>>>> +            regulator-min-microvolt = <1800000>;
>>>> +            regulator-max-microvolt = <1904000>;
>>>> +        };
>>>> +
>>>> +        vreg_l15a: l15 {
>>>> +            regulator-min-microvolt = <3104000>;
>>>> +            regulator-max-microvolt = <3232000>;
>>>> +        };
>>>> +
>>>> +        vreg_l16a: l16 {
>>>> +            regulator-min-microvolt = <1800000>;
>>>> +            regulator-max-microvolt = <1904000>;
>>>> +        };
>>>> +
>>>> +        vreg_l17a: l17 {
>>>> +            regulator-min-microvolt = <1248000>;
>>>> +            regulator-max-microvolt = <1304000>;
>>>> +        };
>>>> +
>>>> +        vreg_l18a: l18 {
>>>> +            regulator-min-microvolt = <1200000>;
>>>> +            regulator-max-microvolt = <1264000>;
>>>> +        };
>>>> +
>>>> +        vreg_l19a: l19 {
>>>> +            regulator-min-microvolt = <1648000>;
>>>> +            regulator-max-microvolt = <2952000>;
>>>> +        };
>>>> +
>>>> +        vreg_l20a: l20 {
>>>> +            regulator-min-microvolt = <1648000>;
>>>> +            regulator-max-microvolt = <2952000>;
>>>> +        };
>>>> +
>>>> +        vreg_l21a: l21 {
>>>> +            regulator-min-microvolt = <2600000>;
>>>> +            regulator-max-microvolt = <2856000>;
>>>> +        };
>>>> +
>>>> +        vreg_l22a: l22 {
>>>> +            regulator-min-microvolt = <2944000>;
>>>> +            regulator-max-microvolt = <3304000>;
>>>> +        };
>>>> +
>>>> +        vreg_l23a: l23 {
>>>> +            regulator-min-microvolt = <3000000>;
>>>> +            regulator-max-microvolt = <3400000>;
>>>> +        };
>>>> +
>>>> +        vreg_l24a: l24 {
>>>> +            regulator-min-microvolt = <2944000>;
>>>> +            regulator-max-microvolt = <3304000>;
>>>> +        };
>>>> +    };
>>>> +};
>>>> +
>>>> +&hsusb_phy1 {
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +
>>>> +&sdc2_off_state {
>>>> +    sd-cd {
>>> Does not look like you tested the DTS against bindings. Please run `make
>>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>>> for instructions).
>>>
>>> that's missing -pins suffix but most likely it does not match other DTS
>>> neither. So probably was based on some old kernel.
>>>
>>>> +        pins = "gpio98";
>>>> +        bias-disable;
>>>> +        drive-strength = <2>;
>>>> +    };
>>>> +};
>>>> +
>>>> +&sdc2_on_state {
>>>> +    sd-cd {
>>> Same problems.
>>>
>>>> +        pins = "gpio98";
>>>> +        bias-pull-up;
>>>> +        drive-strength = <2>;
>>>> +    };
>>>> +};
>>> Best regards,
>>> Krzysztof
>>>
