Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0C6EE640
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjDYRBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjDYRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:01:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF9CC;
        Tue, 25 Apr 2023 10:00:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PH0XQd048238;
        Tue, 25 Apr 2023 12:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682442033;
        bh=J4i9P8M4vj02VdbJ1MGzBrhfgcvu76IGU11zRvR08TU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=H5ZY2lxUTemRWuqE920A19T/9OL/DGTj4+GF75/nHatZwET8rOSaFabEU6/24y+r7
         cuUtD7KsM7ch2AhGNbzund8uvyGcvZG78kYVDDnPOigqzeIO7JpOU963P3xPJ5qz+h
         7yW2pY3GJ5bN3GpyNdtP2LvLrcqtpiwGe9y3/8+U=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PH0XKp010786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 12:00:33 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 12:00:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 12:00:32 -0500
Received: from [10.249.133.231] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PH0P84007258;
        Tue, 25 Apr 2023 12:00:26 -0500
Message-ID: <66a4c8e0-e1d1-4d7d-b0eb-ce092fea8695@ti.com>
Date:   Tue, 25 Apr 2023 22:30:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: Add overlay for OLDI-LCD1EVM Display
 and touch screen
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230425051235.15533-1-a-bhatia1@ti.com>
 <20230425051235.15533-2-a-bhatia1@ti.com>
 <90272486-864d-910c-a10b-4ba71a71f4b0@ti.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <90272486-864d-910c-a10b-4ba71a71f4b0@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 25-Apr-23 20:39, Andrew Davis wrote:
> On 4/25/23 12:12 AM, Aradhya Bhatia wrote:
>> From: Jyri Sarha <jsarha@ti.com>
>>
>> The OLDI-LCD1EVM add on board has Rocktech RK101II01D-CT panel with
>> integrated touch screen. The integrated touch screen is Goodix GT928.
>> Add DT nodes for these and connect the endpoint nodes with DSS.
>>
>> This patch was picked from TI's public tree based on 5.10 LTS kernel.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
>> [abhatia1@ti.com: Make syntax changes to support 6.1 DTSO format]
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |  2 +
>>   .../dts/ti/k3-am654-evm-oldi-lcd1evm.dtso     | 70 +++++++++++++++++++
>>   2 files changed, 72 insertions(+)
>>   create mode 100644
>> arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile
>> b/arch/arm64/boot/dts/ti/Makefile
>> index 6acd12409d59..8956b19e587a 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-am654-evm-oldi-lcd1evm.dtbo
> 
> This name is a bit odd, why "evm" twice? Looks like the first instance
> is the redundant one as most of the documents on this LCD board call it
> the "LCD1EVM". How about:
> 
> k3-am654-lcd1evm.dtbo

I didn't think I could change the name of the overlay picking the patch
from our tree, but if we are going to do it, can we take up another
approach, where it would be easier to add panels for AM62x family and
ensure uniformity throughout.

We have 2 different panels from Vendor A, and another one from Vendor B.
Vendor B panel connects to AM625-SK via an adapter board.

Vendor-A/Panel-1 only says the name, 'SK-LCD1' on its circuit board.
Vendor-A/Panel-2 doesn't have any name yet. We only have development
units.
Vendor-B/Panel-2 mentions '$(LCD_model) to AM62x SoC adapter board'.

Since, there are too many manufacturers, it is difficult to maintain
uniformity with the names of panel-boards. So, I have this approach in
mind (which I have used for our tree for AM62x), but would like your
comments.

k3-$soc-$board-$(panel_vendor)-$(brief_compatible).dtso

So, for AM625-SKs,
k3-am625-sk-$(vendor_name)-$(brief_compatible).dtso

and for the current panel Rocktech RK101II01D-CT, which applies on AM654
base-board,

k3-am654-base-board-rocktech-rk101.dtso.

This does become rather long, but also is distinguishable.

Let me know what you think.

> 
> I would like the overlay names to give some hint to what base DTB they
> apply to,

Agreed. That is indeed how it should be.

> or better yet, apply them here in the build which will check
> that they apply cleanly. Plus you can drop the silly "+= -@" below.
> 

The above approach will give a hint of the base EVM where a combined
build is not possible simply because there is no 'official' name for a
particular combination of panel and EVM.


Regards
Aradhya

> Let's see how this should be called, from the AM65x GP EVM doc[0] we
> get a nice picture on page 5 and the following:
> 
> "The AM65x GP EVM consists of a common processor board, an LCD adapter,
> and a one-lane PCIe/USB3 personality card."
> 
> So, this would translate to:
> 
> k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-lcd1evm.dtbo
> k3-am654-pcie-usb3.dtbo
> dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb>
> Next, from the AM65x IDK doc[1] also with a nice image on page 5:
> 
> "The AM65x IDK consists of a common processor board, IDK application board,
> and a two-lane PCIe personality card.:
> 
> So:
> 
> k3-am654-idk-dtbs := k3-am654-base-board.dtb k3-am654-idk.dtbo
> k3-am654-pcie-usb2.dtbo
> dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
> 
> Note that we do have all those missing dtso files in our evil vendor
> tree[2]
> and will be upstreaming them next, so this naming should all work out
> nicely.
> 
> Andrew
> 
> [0] https://www.ti.com/lit/ug/spruim7/spruim7.pdf
> [1] https://www.ti.com/lit/ug/spruim6a/spruim6a.pdf
> [2]
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/arch/arm64/boot/dts/ti?h=ti-linux-5.10.y
> 
>>     # Boards with J7200 SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>> @@ -45,3 +46,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>>     # Enable support for device-tree overlays
>>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>> +DTC_FLAGS_k3-am654-base-board += -@
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
>> b/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
>> new file mode 100644
>> index 000000000000..b2c790b314cf
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for
>> AM654-EVM.
>> + *
>> + * Copyright (C) 2023 Texas Instruments Incorporated -
>> http://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/pwm/pwm.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +&{/} {
>> +    display0 {
>> +        compatible = "rocktech,rk101ii01d-ct";
>> +        backlight = <&lcd_bl>;
>> +        enable-gpios = <&pca9555 8 GPIO_ACTIVE_HIGH>;
>> +        port {
>> +            lcd_in0: endpoint {
>> +                remote-endpoint = <&oldi_out0>;
>> +            };
>> +        };
>> +    };
>> +
>> +    lcd_bl: backlight {
>> +        compatible = "pwm-backlight";
>> +        pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
>> +        brightness-levels =
>> +            <0 32 64 96 128 160 192 224 255>;
>> +        default-brightness-level = <8>;
>> +    };
>> +};
>> +
>> +&dss {
>> +    status = "okay";
>> +};
>> +
>> +&dss_ports {
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    port@0 {
>> +        reg = <0>;
>> +
>> +        oldi_out0: endpoint {
>> +            remote-endpoint = <&lcd_in0>;
>> +        };
>> +    };
>> +};
>> +
>> +&main_i2c1 {
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    gt928: touchscreen@14 {
>> +        status = "okay";
>> +        compatible = "goodix,gt928";
>> +        reg = <0x14>;
>> +
>> +        interrupt-parent = <&pca9554>;
>> +        interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
>> +        touchscreen-size-x = <1280>;
>> +        touchscreen-size-y = <800>;
>> +
>> +        reset-gpios = <&pca9555 9 GPIO_ACTIVE_HIGH>;
>> +        irq-gpios = <&pca9554 3 GPIO_ACTIVE_HIGH>;
>> +    };
>> +};
