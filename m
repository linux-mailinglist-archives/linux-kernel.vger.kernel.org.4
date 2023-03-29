Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED06CCFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjC2CDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC2CD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:03:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E491BFC;
        Tue, 28 Mar 2023 19:03:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so14635326pjt.5;
        Tue, 28 Mar 2023 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680055408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7SiNS5Tt8HG7sS+rmjltvOQvXGDc1Jn3ZRR7zsPOBU=;
        b=GyfPKUNjby+p9RTdGu6xQ/gPzYa7haQKt9nCxpw7OhlklYTw3S3lDNqj0fqALWq20i
         6D0UsSCf4FI9heZNLCRlVrxXnJ4OUwtca+8DAri/Ez125hxUmrXU6GZXhPhgnc8cShIt
         +PEBkMYxrOQyS79zLjYjia+RLpzfDxuVwE4484cATm+Sb6IjSAKQfwOhpqdLdbDz9kUO
         mKzFTuvafFv7nlKCg4DIylFn6jNbL3LQTc/WhFpA8nKIXHW/XTMbNnskCVL8yrQWqtIJ
         QXTprbc8GiRObrDU+V9ywIvjy+p4DM5N3MZufErAevwQYZbppSgmHobK1wT0qJtJNydF
         2e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680055408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7SiNS5Tt8HG7sS+rmjltvOQvXGDc1Jn3ZRR7zsPOBU=;
        b=YarIzOB/GBMogQdLYbanzXW4GIA3qy0hDwWh0b+/susqidadCkFPbhULcF1/Avhzo5
         d9Z6wqTfVfKwd6iBr8NvWqQgsZg7OBuNYZcov/TdcUe5plCKYgKXwwfuAe6TjY7C4jr+
         vBLgbBrmleGElX+w1TCR8T+1xXund7ZKoiY55hHFNs5tmzE16K3rr8o+0BpARzXKo4gR
         SVEBbWbsWTey/JEtHuk/PF1JP0x+M5A61Idj8X2Xpk/jrBMJyswODVAcV84RVFeVD1cI
         xagtrXmozfl3v73YJ+KLwbUMyk6NyfaOYwhz0EZKQsvqApP7rsLOjLcSYu3J65hqBHgx
         96tw==
X-Gm-Message-State: AAQBX9c3xRoCaeD84JVlaG2lCK7/bCIeLQzJg2oT/cfc+JUqyKmcIACG
        PAWmMI1LT6/2bu26c51/eFw=
X-Google-Smtp-Source: AKy350Zpgds9UeOT2MW92TTkVp6A2fhLrdm1OHYX0Es+2/MxXjDidNkhAwPpY0BATp4GzAHfTzZfcw==
X-Received: by 2002:a17:903:120b:b0:1a0:42d4:e38a with SMTP id l11-20020a170903120b00b001a042d4e38amr22998051plh.11.1680055407730;
        Tue, 28 Mar 2023 19:03:27 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm17583175plr.146.2023.03.28.19.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 19:03:27 -0700 (PDT)
Message-ID: <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com>
Date:   Wed, 29 Mar 2023 10:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device
 tree
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-9-ychuang570808@gmail.com>
 <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,


Thanks for your advice.


On 2023/3/29 上午 01:57, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-27 19:19:08)
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> new file mode 100644
>> index 000000000000..0740b0b218a7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> @@ -0,0 +1,231 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Shan-Chun Hung <schung@nuvoton.com>
>> + *         Jacky huang <ychuang3@nuvoton.com>
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +/ {
>> +       compatible = "nuvoton,ma35d1";
>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       cpus {
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +
>> +               cpu0: cpu@0 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a35";
>> +                       reg = <0x0 0x0>;
>> +                       enable-method = "psci";
>> +                       next-level-cache = <&L2_0>;
>> +               };
>> +
>> +               cpu1: cpu@1 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a35";
>> +                       reg = <0x0 0x1>;
>> +                       enable-method = "psci";
>> +                       next-level-cache = <&L2_0>;
>> +               };
>> +
>> +               L2_0: l2-cache0 {
> Just l2-cache for the node name. Doesn't it go under the cpu0 node as
> well?

This describes the level-2 cache which is external to and shared by cpu0 
& cpu1.
And only level-1 cache is inside of CPU core.
L2_0 is must, because both cpu0 and cpu1 has a next-level-cache = 
<&L2_0> property.

Many identical example of l2-cache node can be found in arm64 dts, such 
as k3-arm642.dtsi,
rk3328.dtsi, mt8195.dtsi, etc. Here is just a copy of similar arm64 
multi-core SoCs.

So we would like to keep this unchanged. Is it OK for you? Thanks.


>> +                       compatible = "cache";
>> +                       cache-level = <2>;
>> +               };
>> +       };
>> +
>> +       psci {
>> +               compatible = "arm,psci-0.2";
>> +               method = "smc";
>> +       };
>> +
>> +       timer {
>> +               compatible = "arm,armv8-timer";
>> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
>> +                             IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
>> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
>> +                             IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secure */
>> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
>> +                             IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
>> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
>> +                             IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
>> +               clock-frequency = <12000000>;
> Remove this property. The frequency should be read by the driver.

I will remove it.

>> +               interrupt-parent = <&gic>;
>> +       };
> Please create an 'soc' node for the SoC to hold all the nodes that have
> a reg property.

OK, we will use soc node in the next version.

>> +
>> +       sys: system-management@40460000 {
>> +               compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
>> +               reg = <0x0 0x40460000 0x0 0x200>;
>> +
>> +               reset: reset-controller {
>> +                       compatible = "nuvoton,ma35d1-reset";
>> +                       #reset-cells = <1>;
>> +               };
>> +       };
>> +
>> +       clk: clock-controller@40460200 {
>> +               compatible = "nuvoton,ma35d1-clk", "syscon";
>> +               reg = <0x00000000 0x40460200 0x0 0x100>;
>> +               #clock-cells = <1>;
>> +               clocks = <&clk_hxt>;
>> +               nuvoton,sys = <&sys>;
>> +       };
> It looks like the device at 40460000 is a reset and clock controller.
> Just make it one node and register the clk or reset device as an
> auxiliary device.

40460000 is for system control registers, including power contrl, 
multifunction pin control,
usb phy control, IP reset control, power-on setting information, and 
many other miscellaneous controls.
The registers of reset controller is only a subset of system control 
registers.

40460200 is for clock controller which is independent of the system 
control integration
The register base of clock controller is very close to system 
controller, but in fact the two are independent.


>> +
>> +       gic: interrupt-controller@50801000 {
>> +               compatible = "arm,gic-400";
>> +               reg =   <0x0 0x50801000 0 0x1000>, /* GICD */
>> +                       <0x0 0x50802000 0 0x2000>, /* GICC */
>> +                       <0x0 0x50804000 0 0x2000>, /* GICH */
>> +                       <0x0 0x50806000 0 0x2000>; /* GICV */
>> +               #interrupt-cells = <3>;
>> +               interrupt-parent = <&gic>;
>> +               interrupt-controller;
>> +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>> +                             IRQ_TYPE_LEVEL_HIGH)>;
>> +       };
>> +
>> +       uart0:serial@40700000 {
> Add a space after :

I will fix it. Thank you.

>> +               compatible = "nuvoton,ma35d1-uart";
>> +               reg = <0x0 0x40700000 0x0 0x100>;
>> +               interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&clk UART0_GATE>;
>> +               status = "disabled";
>> +       };


Best regards,
Jacky Huang


