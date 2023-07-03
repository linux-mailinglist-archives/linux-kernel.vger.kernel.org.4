Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033274586D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGCJcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGCJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:32:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B345AE5C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:32:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7589b187so6457815e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688376722; x=1690968722;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pt2/umk2HTP0ld+Zs6aYb7U1mkhKMLkY91WmbeRY2IE=;
        b=V0vqiG0scmrOOhTUPVhqVpL6+/S5WyFqwqD728A8oejJAVTCF2jSU4XlbqRpFSTW1q
         LXefwtELXumb1gaLxd3K9QQTA6HBYf9JHH4tDKzZvwONil0pPhrbYmhMLi++jSRFZORk
         R5ldnxLNie9LEBT4Q/PCQ0RoWAWoUNDlfWvr/wolOaxNB0j3s5My411vbig4WAo8cdiu
         9exlxhNz/C3SNo+Be7vV34QGNCq/o+rjHbAIucCzErVXb+U6hqDnypsGHG+sOl4qevCe
         IPkLzCF5n6aAUhfNl+6YCDSHSu+LB7k3CEMtwBp1U/Fgeq50fcghHg++OZNV3KyxXVbe
         kdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376722; x=1690968722;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt2/umk2HTP0ld+Zs6aYb7U1mkhKMLkY91WmbeRY2IE=;
        b=IW6p+WexSFrK71QTpTN331w3ejVmABywz25l96u6YkhdXolvx7iHFV7ZjxMMQjNJLp
         yatTLRWGWSOF5h4Bjh5SxJPQSGu2KkOwqVUYdrBd9B85x+PchE7dk3QZTU/7EODX3EhL
         BzqFgXZZtqAsss4JN84PVShHa5aeYfHNqIQ4IS1Qval2OPB4HfDp0dU4dZvZHthsZ17o
         iC5WxTGMl3xdSjBWoTxap0obVUlbVesrnWHvKfjnXHOM0Or3Lccv/XjdigHlf6vWCT0m
         e09AeCYHxgy2yCPoX9S7PljoMOAT8M9WAC7wtEIM4aDpK6qRyXAxPHBWta823mSHBXRe
         y0Pw==
X-Gm-Message-State: ABy/qLbWqyXD8DxKHA+IaOWsGN43Vq3FcKiY7F7KaBHQpw9cMnEUOb69
        H9c8n1B9+OAtAEZrn8MMByJnlw==
X-Google-Smtp-Source: APBJJlF77M1kI/4h8ZhGQ//sEHL9qMT8JFHSWvvqU8lTeskM/kXxRBqn1pGsw6lt1Q6/72c4K7SlWg==
X-Received: by 2002:a05:6512:3e22:b0:4fb:8435:3efc with SMTP id i34-20020a0565123e2200b004fb84353efcmr7848946lfv.16.1688376721811;
        Mon, 03 Jul 2023 02:32:01 -0700 (PDT)
Received: from [192.168.7.21] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fbc0ea491dsm10632918wmc.40.2023.07.03.02.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:32:01 -0700 (PDT)
Message-ID: <83459098-5fe5-37e9-45fd-f9d2daca7221@linaro.org>
Date:   Mon, 3 Jul 2023 11:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 4/4] arm64: dts: amlogic-t7-a311d2-khadas-vim4: add
 initial device-tree
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Lucas Tanure <tanure@linux.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230629073419.207886-1-tanure@linux.com>
 <20230629073419.207886-5-tanure@linux.com>
 <b7aea1f3-1850-4e09-6e76-5e8c8c2851bf@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <b7aea1f3-1850-4e09-6e76-5e8c8c2851bf@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/07/2023 04:39, Xianwei Zhao wrote:
> 
> 
> On 2023/6/29 15:34, Lucas Tanure wrote:
>> [ EXTERNAL EMAIL ]
>>
>> The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 SoC
>> family, on a board with the same form factor as the VIM3 models.
>>
>> - 8GB LPDDR4X 2016MHz
>> - 32GB eMMC 5.1 storage
>> - 32MB SPI flash
>> - 10/100/1000 Base-T Ethernet
>> - AP6275S Wireless (802.11 a/b/g/n/ac/ax, BT5.1)
>> - HDMI 2.1 video
>> - HDMI Input
>> - 1x USB 2.0 + 1x USB 3.0 ports
>> - 1x USB-C (power) with USB 2.0 OTG
>> - 3x LED's (1x red, 1x blue, 1x white)
>> - 3x buttons (power, function, reset)
>> - M2 socket with PCIe, USB, ADC & I2C
>> - 40pin GPIO Header
>> - 1x micro SD card slot
>>
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>>   .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  54 ++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 155 ++++++++++++++++++
>>   3 files changed, 210 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index cd1c5b04890a..166fec1e4229 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> new file mode 100644
>> index 000000000000..fffdab96b12e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2022 Wesion, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-t7.dtsi"
>> +
>> +/ {
>> +       model = "Khadas vim4";
>> +       compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
>> +
>> +       aliases {
>> +               serial0 = &uart_a;
>> +       };
>> +
>> +       memory@0 {
>> +               device_type = "memory";
>> +               reg = <0x0 0x0 0x2 0x0>; /* 8 GB */
>> +       };
>> +
>> +       reserved-memory {
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>> +
>> +               /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
>> +               secmon_reserved: secmon@5000000 {
>> +                       reg = <0x0 0x05000000 0x0 0x300000>;
>> +                       no-map;
>> +               };
>> +
>> +               /* 32 MiB reserved for ARM Trusted Firmware (BL32) */
>> +               secmon_reserved_bl32: secmon@5300000 {
>> +                       reg = <0x0 0x05300000 0x0 0x2000000>;
>> +                       no-map;
>> +               };
>> +       };
>> +
>> +       xtal: xtal-clk {
>> +               compatible = "fixed-clock";
>> +               clock-frequency = <24000000>;
>> +               clock-output-names = "xtal";
>> +               #clock-cells = <0>;
>> +       };
> Place xal in DTSI files is beterr,  the same as other Amlogic SoCs family. If frequency is different, reset value in here.

It's expected to have xtal in the board dts, since it's part of the board not the SoC.

Neil

> 
>> +
>> +};
>> +
>> +&uart_a {
>> +       status = "okay";
>> +       clocks = <&xtal>, <&xtal>, <&xtal>;
>> +       clock-names = "xtal", "pclk", "baud";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> new file mode 100644
>> index 000000000000..1423d4a79156
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> @@ -0,0 +1,155 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       cpus {
>> +               #address-cells = <0x2>;
>> +               #size-cells = <0x0>;
>> +
>> +               cpu-map {
>> +                       cluster0 {
>> +                               core0 {
>> +                                       cpu = <&cpu100>;
>> +                               };
>> +                               core1 {
>> +                                       cpu = <&cpu101>;
>> +                               };
>> +                               core2 {
>> +                                       cpu = <&cpu102>;
>> +                               };
>> +                               core3 {
>> +                                       cpu = <&cpu103>;
>> +                               };
>> +                       };
>> +
>> +                       cluster1 {
>> +                               core0 {
>> +                                       cpu = <&cpu0>;
>> +                               };
>> +                               core1 {
>> +                                       cpu = <&cpu1>;
>> +                               };
>> +                               core2 {
>> +                                       cpu = <&cpu2>;
>> +                               };
>> +                               core3 {
>> +                                       cpu = <&cpu3>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               cpu100: cpu@100 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a53";
>> +                       reg = <0x0 0x100>;
>> +                       enable-method = "psci";
>> +               };
>> +
>> +               cpu101: cpu@101{
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a53";
>> +                       reg = <0x0 0x101>;
>> +                       enable-method = "psci";
>> +               };
>> +
>> +               cpu102: cpu@102 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a53";
>> +                       reg = <0x0 0x102>;
>> +                       enable-method = "psci";
>> +               };
>> +
>> +               cpu103: cpu@103 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a53";
>> +                       reg = <0x0 0x103>;
>> +                       enable-method = "psci";
>> +               };
>> +
>> +               cpu0: cpu@0 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a73";
>> +                       reg = <0x0 0x0>;
>> +                       enable-method = "psci";
>> +               };
>> +
>> +               cpu1: cpu@1 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a73";
>> +                       reg = <0x0 0x1>;
>> +                       enable-method = "psci";
>> +               };
>> +
>> +               cpu2: cpu@2 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a73";
>> +                       reg = <0x0 0x2>;
>> +                       enable-method = "psci";
>> +               };
>> +
>> +               cpu3: cpu@3 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a73";
>> +                       reg = <0x0 0x3>;
>> +                       enable-method = "psci";
>> +               };
>> +       };
>> +
>> +       timer {
>> +               compatible = "arm,armv8-timer";
>> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +       };
>> +
>> +       psci {
>> +               compatible = "arm,psci-1.0";
>> +               method = "smc";
>> +       };
>> +
>> +       sm: secure-monitor {
>> +               compatible = "amlogic,meson-gxbb-sm";
>> +       };
>> +
>> +       soc {
>> +               compatible = "simple-bus";
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>> +
>> +               gic: interrupt-controller@fff01000 {
>> +                       compatible = "arm,gic-400";
>> +                       #interrupt-cells = <3>;
>> +                       #address-cells = <0>;
>> +                       interrupt-controller;
>> +                       reg = <0x0 0xfff01000 0 0x1000>,
>> +                             <0x0 0xfff02000 0 0x0100>;
>> +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
>> +               };
>> +
>> +               apb4: bus@fe000000 {
>> +                       compatible = "simple-bus";
>> +                       reg = <0x0 0xfe000000 0x0 0x480000>;
>> +                       #address-cells = <2>;
>> +                       #size-cells = <2>;
>> +                       ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> +
>> +                       uart_a: serial@78000 {
>> +                               compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
>> +                               reg = <0x0 0x78000 0x0 0x18>;
>> +                               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>> +                               status = "disabled";
>> +                       };
>> +               };
>> +
>> +       };
>> +};
>> -- 
>> 2.41.0
>>

