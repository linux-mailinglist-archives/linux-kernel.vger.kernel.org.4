Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E829B7004FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbjELKNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbjELKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:13:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B1712EAD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:12:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f42711865eso39008345e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683886353; x=1686478353;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TSlZKJ919JRC2x/Kcyg1XoCSxvFxqofhm3tIejqbIEw=;
        b=ZeRSSQ22T2vPKZNx8m1VSLUIamkTmCCuTt5yN1ud+13hbzqlf6JgM5E1mQLZSxlAXh
         Wz7JvkOVQ22QeNP2/RNI9DVXAE3fm3I7eDALbUvc8Q8sS3EY703ARNWsDFE42HztqU7F
         znUJascx6YQXCwRb8oxjJX4aGP4tnjtKpIY9KdmXc6QSGMq2wyOmey9Ofgw7yja02VA+
         WONBRldr4lycA0JWO9hNtEmZHoCpztiFchSQvMvP62veIj6kJggVNp8tz7vW80hZv3yO
         EGXd4qZLTyz92jC6XOpXnbgKKD2tAplzKpI1ykiKLCLClgx67nsusWXuesVIVP0sNhtV
         5G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886353; x=1686478353;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSlZKJ919JRC2x/Kcyg1XoCSxvFxqofhm3tIejqbIEw=;
        b=NGxR7KEoIaSstnE9AqnAFnI7CJ40mStgJEFfwxk0hr8F0BiJuOiGbpPXh39V/Egzlo
         xR+6g6pve4U6JztT7yRlVgmwn+CLGvGPvU/dfAmO+I/NwUaH7DtCKRX29glVxuD3Nv+c
         1Sli3QZ/LmF8WAHFTkjXU7riMxy9fqXdVnGEpeev3jtQr7OqufjlWlD3i+2864+/rTYq
         W6rfNpcR9SskvwQRyVlxkDru+x1C9TV96YAYPs9iJl0MDrKTRLGc675WOftcwB1HqZEq
         I2u25OuMYFZ+z1nmJH2trz4rRGQBqVAhgxnzny0kNX3De/sOh2mxzAJ2W96Bx3BGiu1O
         f4kQ==
X-Gm-Message-State: AC+VfDxi+FN6DFVkxKZ+oPt7Igp5fuiF3ffM9fEUCaCNKW41Mw7MUNhX
        pM5EBtQsiMIa3Ki2BSdf7rRNTw==
X-Google-Smtp-Source: ACHHUZ75ItjGV2J7MS/g2zgOpvjGZ/pYtVX4M+qKqib7xt9l8s55QKND0IhTKqbCLMGnvaUWRNM3jw==
X-Received: by 2002:a5d:5082:0:b0:307:a36b:e7a5 with SMTP id a2-20020a5d5082000000b00307a36be7a5mr8349933wrt.60.1683886352845;
        Fri, 12 May 2023 03:12:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:95e3:a02f:1d34:8191? ([2a01:e0a:982:cbb0:95e3:a02f:1d34:8191])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b0030642f5da27sm22872525wrn.37.2023.05.12.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 03:12:32 -0700 (PDT)
Message-ID: <db8bc4e8-3b41-43d5-6bc9-fb958635ce90@linaro.org>
Date:   Fri, 12 May 2023 12:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V4] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230510091129.151669-1-xianwei.zhao@amlogic.com>
 <b2bdb00f-63de-40a9-ebe6-32f83607b5d8@linaro.org>
 <d588b62f-970d-a974-814d-5b116bc547f9@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <d588b62f-970d-a974-814d-5b116bc547f9@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 09:03, xianwei.zhao wrote:
> Hi Neil,
>       Thank you for your reply.
> 
> On 2023/5/11 16:39, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi,
>>
>> On 10/05/2023 11:11, Xianwei Zhao wrote:
>>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>>> applications.
>>>
>>> Add basic support for the C3 based Amlogic AW409 board, which describes
>>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>>> booting up into the serial console.
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>> Link: https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com
>>> Link: https://lore.kernel.org/all/20230307222651.2106615-2-martin.blumenstingl@googlemail.com
>>>
>>> V3 -> V4: Move Link under the --- before the changelog.
>>> V2 -> V3: Remove '256m' from filename;
>>>            Keep alphabetical order of Makefile.
>>> V1 -> V2: Remove new arch, and use ARCH_MESON;
>>>            Modify node name, and delete superfluous blank line.
>>> ---
>>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>>   .../dts/amlogic/amlogic-c3-c302x-aw409.dts    | 29 +++++++
>>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>>>   3 files changed, 116 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
>>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index cd1c5b04890a..6f61798a109f 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -1,4 +1,5 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
>>> new file mode 100644
>>> index 000000000000..edce8850b338
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
>>> @@ -0,0 +1,29 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "amlogic-c3.dtsi"
>>> +
>>> +/ {
>>> +     model = "Amlogic C302 aw409 Development Board";
>>> +     compatible = "amlogic,aw409", "amlogic,c3";
>>> +     interrupt-parent = <&gic>;
>>> +     #address-cells = <2>;
>>> +     #size-cells = <2>;
>>> +
>>> +     aliases {
>>> +             serial0 = &uart_b;
>>> +     };
>>> +
>>> +     memory@0 {
>>> +             device_type = "memory";
>>> +             reg = <0x0 0x0 0x0 0x10000000>;
>>> +     };
>>> +};
>>> +
>>> +&uart_b {
>>> +     status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>> new file mode 100644
>>> index 000000000000..93b335aef605
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>> @@ -0,0 +1,86 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +
>>> +/ {
>>> +     cpus {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <0>;
>>> +
>>> +             cpu0: cpu@0 {
>>> +                     device_type = "cpu";
>>> +                     compatible = "arm,cortex-a35";
>>> +                     reg = <0x0 0x0>;
>>> +                     enable-method = "psci";
>>> +             };
>>> +
>>> +             cpu1: cpu@1 {
>>> +                     device_type = "cpu";
>>> +                     compatible = "arm,cortex-a35";
>>> +                     reg = <0x0 0x1>;
>>> +                     enable-method = "psci";
>>> +             };
>>> +     };
>>> +
>>> +     timer {
>>> +             compatible = "arm,armv8-timer";
>>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>> +     };
>>> +
>>> +     psci {
>>> +             compatible = "arm,psci-1.0";
>>> +             method = "smc";
>>> +     };
>>> +
>>> +     xtal: xtal-clk {
>>> +             compatible = "fixed-clock";
>>> +             clock-frequency = <24000000>;
>>> +             clock-output-names = "xtal";
>>> +             #clock-cells = <0>;
>>> +     };
>>> +
>>> +     soc {
>>> +             compatible = "simple-bus";
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             ranges;
>>> +
>>> +             gic: interrupt-controller@fff01000 {
>>> +                     compatible = "arm,gic-400";
>>> +                     #interrupt-cells = <3>;
>>> +                     #address-cells = <0>;
>>> +                     interrupt-controller;
>>> +                     reg = <0x0 0xfff01000 0 0x1000>,
>>> +                           <0x0 0xfff02000 0 0x2000>,
>>> +                           <0x0 0xfff04000 0 0x2000>,
>>> +                           <0x0 0xfff06000 0 0x2000>;
>>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>> +             };
>>> +
>>> +             apb4: bus@fe000000 {
>>> +                     compatible = "simple-bus";
>>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>>> +                     #address-cells = <2>;
>>> +                     #size-cells = <2>;
>>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>> +
>>> +                     uart_b: serial@7a000 {
>>> +                             compatible = "amlogic,meson-g12a-uart";
>>
>> This should be:
>>
>>         compatible = "amlogic,meson-g12a-uart", "amlogic,meson-gx-uart"
>>
>> to match the amlogic,meson-uart.yaml bindings.
>>
> 
> I will use strings 'amlogic,meson-s4-uart' instead of these, because of board C3 is only use 12M clock source for serial, the same as s4 series.

Sure.

Neil

> 
>> Please run :
>> make CHECK_DTBS=1 amlogic/amlogic-c3-c302x-aw409.dtb
>>
>> With that fixed, please add on v5:
> 
> Will do.
> 
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>>> +                             reg = <0x0 0x7a000 0x0 0x18>;
>>> +                             interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
>>> +                             status = "disabled";
>>> +                             clocks = <&xtal>, <&xtal>, <&xtal>;
>>> +                             clock-names = "xtal", "pclk", "baud";
>>> +                     };
>>> +
>>> +             };
>>> +     };
>>> +};
>>>
>>> base-commit: ae68fb187b59bc8645974320808ab2d7c41b1833
>>

