Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395F65AF65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjABKRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjABKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:17:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED8F2F;
        Mon,  2 Jan 2023 02:17:07 -0800 (PST)
Received: from [192.168.1.22] (cst-prg-44-69.cust.vodafone.cz [46.135.44.69])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tomeu)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 297726602CC1;
        Mon,  2 Jan 2023 10:17:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672654625;
        bh=UKxDeH1K51ACF0O8y96Cck/rYbvF8NIxVYbACECak6Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LrlZI2puL6mGNOLF2of8embHNkndRivYQ6iU07VV5uWc+WZuX3EZ350ZQ+Ber/rz3
         QRIzJkH5rG++FIZ3VQj8XP45T5G3xNjIoxoM9pntjKF+OpPb91iDof1q4JGJGNrXlF
         mOqYHM/67IPG5udaxMu3BuwRax17mB6/jkNqa2ubBc5c5CgjNfHWVk+cfb4fS2j64j
         Pv1NDmi9aEnYZK4Zr+EifkExxbeLzpMA6ucN9LtMvT+vTO1vnidDta4hrd1UNXVono
         VmSfu26P4q4xdEGInSZZZiUOyLweaBZHZ6tlzJsgedCk/OhcE9vEzFJaCaur1YgmKB
         2ewvgJQyfZUNw==
Message-ID: <8cfe8595-79de-5980-d503-36847069940f@collabora.com>
Date:   Mon, 2 Jan 2023 11:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 4/8] arm64: dts: Add DT node for the VIPNano-QI on the
 A311D
To:     neil.armstrong@linaro.org
Cc:     italonicola@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
 <20221202115223.39051-5-tomeu.vizoso@collabora.com>
 <5e5babae-224d-51cf-4eac-6272df87a8e7@linaro.org>
Content-Language: en-US
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
In-Reply-To: <5e5babae-224d-51cf-4eac-6272df87a8e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 10:53, Neil Armstrong wrote:
> On 02/12/2022 12:52, Tomeu Vizoso wrote:
>> This "NPU" is very similar to the Vivante GPUs and Etnaviv works well
>> with it with just a few small changes.
>>
>> v2: Add reference to RESET_NNA (Neil)
>> v3: Fix indentation (Neil)
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi     | 11 +++++++++++
>>   .../boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts |  4 ++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi 
>> b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> index 45947c1031c4..61c8461df614 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> @@ -11,6 +11,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
>>   #include <dt-bindings/thermal/thermal.h>
>> +#include <dt-bindings/power/meson-g12a-power.h>
>>   / {
>>       interrupt-parent = <&gic>;
>> @@ -2484,4 +2485,14 @@ xtal: xtal-clk {
>>           #clock-cells = <0>;
>>       };
>> +    npu: npu@ff100000 {
>> +        compatible = "vivante,gc";
>> +        reg = <0x0 0xff100000 0x0 0x20000>;
>> +        interrupts = <0 147 4>;
>> +        clocks = <&clkc CLKID_NNA_CORE_CLK>,
>> +             <&clkc CLKID_NNA_AXI_CLK>;
>> +        clock-names = "core", "bus";
>> +        resets = <&reset RESET_NNA>;
>> +        power-domains = <&pwrc PWRC_G12A_NNA_ID>;
> 
> A status = "disable" is missing here.
> 
>> +    };
>>   };
>> diff --git 
>> a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts 
>> b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>> index 124a80901084..73f3d87dcefd 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>> @@ -15,6 +15,10 @@ / {
>>       compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
>>   };
>> +&npu {
>> +    status = "okay";
> 
> Tomeu, I think until the user-space stack is clean this should be removed
> and left disabled.

Sounds good to me, we can easily carry a patch in Mesa CI in the meantime.

> I can fix this while applying if you want,

I would appreciate it, thanks!

Tomeu

> Neil
> 
>> +};
>> +
>>   /*
>>    * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>>    * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> 
