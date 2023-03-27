Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A186CA2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjC0Lqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjC0Lqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:46:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2126AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:46:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o32so4874486wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679917597;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoNNd+rT3pYDdn0ALWhY8MLREO6XDm6Ukm32YWTQx0Y=;
        b=apzG9BkJ7UAgeU8x3OmgSVY3Ew1g+Ljf/PY3zvzYYp9rZMBqpAU4EzQNrJFoXOP/nQ
         GVZ3Tua/DGzqN2DQNm4yFU+RenLsbtd3Y7KoetI8WE3cPHu9btYn8ftHicfRT8MQ0lyd
         7JAGspCLEMkl9niIwCA1z4Cnueb0R2D5jZpIktVBd3/Nqnmf5rqQInKt0PUJlt0ucFMO
         zYfxINgKj9to6wo1K6UYCoipV3dwwyFA+y7q1nOn36FB4Gc9lHepkkCORwpIx0r576Rf
         YLwg2y3xqIBMERxxEUzdzip63XlwsB99l2mbwMu5h8MIwpfkOHc1ueexq4dJRrthWqiq
         85yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679917597;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoNNd+rT3pYDdn0ALWhY8MLREO6XDm6Ukm32YWTQx0Y=;
        b=lsjudsQUQkcAb8pfvXb2kpICgyuL14XjgiqhMo+Avl7KCGyIlG/q7Q0eS5AXotYWzX
         AQ3PJNVEB3gG/T4YWQAjfGggjv6YUZE2gb9fQNCrlGTctN1hJ4XM9FdAFljUZ/nwMw5E
         XbJg/RO+zu1LsiO9c/3bkcEP8g+gCDeGjl20qXqpIlyxxTOU37OxhidD7MEzycOPKCxO
         jZgJBeBQUqMj4glZoU1nwaZwFqmY/9eNw3zMEJecirSNwYrJSYT/jBji7yMF5s6rfiTV
         TXTXgQ3rd/9m4yqYyw1VWXnhXVrgH6y8LQOmE22yE7cDz/jcqpNMAvAh7aM5x6SHtTS5
         AEOQ==
X-Gm-Message-State: AO0yUKXnDsVhMP8vD2UHgs5Tju94CYfqXJEpzsEv+J3QnN+qb3sT/jkB
        gScXkalGFvCHTEmGnw4ePia0GA==
X-Google-Smtp-Source: AK7set/nTDdWWzm5kLGRggO27mQlNVt85ygCjp/5HVdPu419Xc86q2LHdju4dVBdAEbyjcjruMx/6w==
X-Received: by 2002:a05:600c:254:b0:3ed:38e7:af59 with SMTP id 20-20020a05600c025400b003ed38e7af59mr8822048wmj.39.1679917597114;
        Mon, 27 Mar 2023 04:46:37 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b003ef6ceedf14sm4429148wmb.38.2023.03.27.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:46:36 -0700 (PDT)
References: <20230321193014.26349-1-ddrokosov@sberdevices.ru>
 <20230321193014.26349-4-ddrokosov@sberdevices.ru>
 <1jmt3yo5r0.fsf@starbuckisacylon.baylibre.com>
 <20230327105115.ury3w4xpzhcpnqjg@CAB-WSD-L081021>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Date:   Mon, 27 Mar 2023 13:39:03 +0200
In-reply-to: <20230327105115.ury3w4xpzhcpnqjg@CAB-WSD-L081021>
Message-ID: <1jilemo1r9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 27 Mar 2023 at 13:51, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> On Mon, Mar 27, 2023 at 11:51:21AM +0200, Jerome Brunet wrote:
>> 
>> On Tue 21 Mar 2023 at 22:30, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>> 
>> > Add the documentation for Amlogic A1 PLL and Amlogic A1 Peripherals
>> > clock drivers.
>> > Introduce Amlogic A1 PLL and Amlogic A1 Peripherals device tree
>> > bindings and include them to MAINTAINERS.
>> >
>> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> > ---
>> >  .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++
>> >  .../bindings/clock/amlogic,a1-pll-clkc.yaml   |  59 +++++++++
>> >  MAINTAINERS                                   |   1 +
>> >  include/dt-bindings/clock/amlogic,a1-clkc.h   | 113 ++++++++++++++++++
>> >  .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  21 ++++
>> >  5 files changed, 267 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>> 
>> There is two drivers (and 2 independent patches). There should be 2
>> bindings patches as well.
>> 
>
> Before, in previous versions I had two versions, but it wasn't bisectable
> approach.

You are confusing bisectable and Rob's robot. Splitting patches is more
that likely to help bisect (and patches backport) - not the other way around.

> a1-clkc schema depends on a1-pll-clkc headers and vice versa.
> It means dt schemas checkers will show us failure if we split them into two
> patchsets.

Only because you are patches are not upstream yet ...

> I know, that we can use raw digits instead of CLKID names, but IMO it doesn't
> look like production schema and it requires one more patchset above the
> series with proper CLKID definitons usage and proper header including.
>
> BTW, there is an example of Rob's test bot failure found in the previous
> v10 patch series due to chicken or the egg problem.
> https://lore.kernel.org/all/167769997208.7087.5344356236212731922.robh@kernel.org/
>
> Please advise what's the best practice to resolve that..

Don't use the header in your example would solve the problem and
still be correct DT wise.

The examples are just examples, they are not required to actually
matches a real HW, as far as I know.

>
>> >  create mode 100644 include/dt-bindings/clock/amlogic,a1-clkc.h
>> >  create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
>> >
>> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>> > new file mode 100644
>> > index 000000000000..cb6d8f4eb959
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>> > @@ -0,0 +1,73 @@
>> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Amlogic Meson A/C serials Peripheral Clock Control Unit
>> > +
>> > +maintainers:
>> > +  - Neil Armstrong <neil.armstrong@linaro.org>
>> > +  - Jerome Brunet <jbrunet@baylibre.com>
>> > +  - Jian Hu <jian.hu@jian.hu.com>
>> > +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: amlogic,a1-clkc
>> > +
>> > +  '#clock-cells':
>> > +    const: 1
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  clocks:
>> > +    items:
>> > +      - description: input fixed pll div2
>> > +      - description: input fixed pll div3
>> > +      - description: input fixed pll div5
>> > +      - description: input fixed pll div7
>> > +      - description: input hifi pll
>> > +      - description: input oscillator (usually at 24MHz)
>> > +
>> > +  clock-names:
>> > +    items:
>> > +      - const: fclk_div2
>> > +      - const: fclk_div3
>> > +      - const: fclk_div5
>> > +      - const: fclk_div7
>> > +      - const: hifi_pll
>> > +      - const: xtal
>> > +
>> > +required:
>> > +  - compatible
>> > +  - '#clock-cells'
>> > +  - reg
>> > +  - clocks
>> > +  - clock-names
>> > +
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
>> > +    apb {
>> > +        #address-cells = <2>;
>> > +        #size-cells = <2>;
>> > +
>> > +        clock-controller@800 {
>> > +            compatible = "amlogic,a1-clkc";
>> > +            reg = <0 0x800 0 0x104>;
>> > +            #clock-cells = <1>;
>> > +            clocks = <&clkc_pll CLKID_FCLK_DIV2>,
>> > +                     <&clkc_pll CLKID_FCLK_DIV3>,
>> > +                     <&clkc_pll CLKID_FCLK_DIV5>,
>> > +                     <&clkc_pll CLKID_FCLK_DIV7>,
>> > +                     <&clkc_pll CLKID_HIFI_PLL>,
>> > +                     <&xtal>;
>> > +            clock-names = "fclk_div2", "fclk_div3",
>> > +                          "fclk_div5", "fclk_div7",
>> > +                          "hifi_pll", "xtal";
>> > +        };
>> > +    };
>> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>> > new file mode 100644
>> > index 000000000000..77a13b1f9d5a
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>> > @@ -0,0 +1,59 @@
>> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Amlogic Meson A/C serials PLL Clock Control Unit
>> > +
>> > +maintainers:
>> > +  - Neil Armstrong <neil.armstrong@linaro.org>
>> > +  - Jerome Brunet <jbrunet@baylibre.com>
>> > +  - Jian Hu <jian.hu@jian.hu.com>
>> > +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: amlogic,a1-pll-clkc
>> > +
>> > +  '#clock-cells':
>> > +    const: 1
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  clocks:
>> > +    items:
>> > +      - description: input fixpll_in
>> > +      - description: input hifipll_in
>> > +
>> > +  clock-names:
>> > +    items:
>> > +      - const: fixpll_in
>> > +      - const: hifipll_in
>> > +
>> > +required:
>> > +  - compatible
>> > +  - '#clock-cells'
>> > +  - reg
>> > +  - clocks
>> > +  - clock-names
>> > +
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/clock/amlogic,a1-clkc.h>
>> > +    apb {
>> > +        #address-cells = <2>;
>> > +        #size-cells = <2>;
>> > +
>> > +        clock-controller@7c80 {
>> > +            compatible = "amlogic,a1-pll-clkc";
>> > +            reg = <0 0x7c80 0 0x18c>;
>> > +            #clock-cells = <1>;
>> > +            clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
>> > +                     <&clkc_periphs CLKID_HIFIPLL_IN>;
>> > +            clock-names = "fixpll_in", "hifipll_in";
>> > +        };
>> > +    };
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 39ff1a717625..8438bc9bd636 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -1895,6 +1895,7 @@ L:	linux-amlogic@lists.infradead.org
>> >  S:	Maintained
>> >  F:	Documentation/devicetree/bindings/clock/amlogic*
>> >  F:	drivers/clk/meson/
>> > +F:	include/dt-bindings/clock/a1*
>> >  F:	include/dt-bindings/clock/gxbb*
>> >  F:	include/dt-bindings/clock/meson*
>> >  
>> > diff --git a/include/dt-bindings/clock/amlogic,a1-clkc.h b/include/dt-bindings/clock/amlogic,a1-clkc.h
>> > new file mode 100644
>> > index 000000000000..95131779982c
>> > --- /dev/null
>> > +++ b/include/dt-bindings/clock/amlogic,a1-clkc.h
>> > @@ -0,0 +1,113 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> > +/*
>> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> > + * Author: Jian Hu <jian.hu@amlogic.com>
>> > + *
>> > + * Copyright (c) 2023, SberDevices. All Rights Reserved.
>> > + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> > + */
>> > +
>> > +#ifndef __A1_CLKC_H
>> > +#define __A1_CLKC_H
>> > +
>> > +#define CLKID_FIXPLL_IN		0
>> > +#define CLKID_USB_PHY_IN	1
>> > +#define CLKID_USB_CTRL_IN	2
>> > +#define CLKID_HIFIPLL_IN	3
>> > +#define CLKID_SYSPLL_IN		4
>> > +#define CLKID_DDS_IN		5
>> > +#define CLKID_SYS		6
>> > +#define CLKID_CLKTREE		7
>> > +#define CLKID_RESET_CTRL	8
>> > +#define CLKID_ANALOG_CTRL	9
>> > +#define CLKID_PWR_CTRL		10
>> > +#define CLKID_PAD_CTRL		11
>> > +#define CLKID_SYS_CTRL		12
>> > +#define CLKID_TEMP_SENSOR	13
>> > +#define CLKID_AM2AXI_DIV	14
>> > +#define CLKID_SPICC_B		15
>> > +#define CLKID_SPICC_A		16
>> > +#define CLKID_MSR		17
>> > +#define CLKID_AUDIO		18
>> > +#define CLKID_JTAG_CTRL		19
>> > +#define CLKID_SARADC_EN		20
>> > +#define CLKID_PWM_EF		21
>> > +#define CLKID_PWM_CD		22
>> > +#define CLKID_PWM_AB		23
>> > +#define CLKID_CEC		24
>> > +#define CLKID_I2C_S		25
>> > +#define CLKID_IR_CTRL		26
>> > +#define CLKID_I2C_M_D		27
>> > +#define CLKID_I2C_M_C		28
>> > +#define CLKID_I2C_M_B		29
>> > +#define CLKID_I2C_M_A		30
>> > +#define CLKID_ACODEC		31
>> > +#define CLKID_OTP		32
>> > +#define CLKID_SD_EMMC_A		33
>> > +#define CLKID_USB_PHY		34
>> > +#define CLKID_USB_CTRL		35
>> > +#define CLKID_SYS_DSPB		36
>> > +#define CLKID_SYS_DSPA		37
>> > +#define CLKID_DMA		38
>> > +#define CLKID_IRQ_CTRL		39
>> > +#define CLKID_NIC		40
>> > +#define CLKID_GIC		41
>> > +#define CLKID_UART_C		42
>> > +#define CLKID_UART_B		43
>> > +#define CLKID_UART_A		44
>> > +#define CLKID_SYS_PSRAM		45
>> > +#define CLKID_RSA		46
>> > +#define CLKID_CORESIGHT		47
>> > +#define CLKID_AM2AXI_VAD	48
>> > +#define CLKID_AUDIO_VAD		49
>> > +#define CLKID_AXI_DMC		50
>> > +#define CLKID_AXI_PSRAM		51
>> > +#define CLKID_RAMB		52
>> > +#define CLKID_RAMA		53
>> > +#define CLKID_AXI_SPIFC		54
>> > +#define CLKID_AXI_NIC		55
>> > +#define CLKID_AXI_DMA		56
>> > +#define CLKID_CPU_CTRL		57
>> > +#define CLKID_ROM		58
>> > +#define CLKID_PROC_I2C		59
>> > +#define CLKID_DSPA_EN		60
>> > +#define CLKID_DSPA_EN_NIC	61
>> > +#define CLKID_DSPB_EN		62
>> > +#define CLKID_DSPB_EN_NIC	63
>> > +#define CLKID_RTC		64
>> > +#define CLKID_CECA_32K		65
>> > +#define CLKID_CECB_32K		66
>> > +#define CLKID_24M		67
>> > +#define CLKID_12M		68
>> > +#define CLKID_FCLK_DIV2_DIVN	69
>> > +#define CLKID_GEN		70
>> > +#define CLKID_SARADC		71
>> > +#define CLKID_PWM_A		72
>> > +#define CLKID_PWM_B		73
>> > +#define CLKID_PWM_C		74
>> > +#define CLKID_PWM_D		75
>> > +#define CLKID_PWM_E		76
>> > +#define CLKID_PWM_F		77
>> > +#define CLKID_SPICC		78
>> > +#define CLKID_TS		79
>> > +#define CLKID_SPIFC		80
>> > +#define CLKID_USB_BUS		81
>> > +#define CLKID_SD_EMMC		82
>> > +#define CLKID_PSRAM		83
>> > +#define CLKID_DMC		84
>> > +#define CLKID_GEN_SEL		85
>> > +#define CLKID_PWM_A_SEL		86
>> > +#define CLKID_PWM_B_SEL		87
>> > +#define CLKID_PWM_C_SEL		88
>> > +#define CLKID_PWM_D_SEL		89
>> > +#define CLKID_PWM_E_SEL		90
>> > +#define CLKID_PWM_F_SEL		91
>> > +#define CLKID_DSPA_A_SEL	92
>> > +#define CLKID_DSPA_B_SEL	93
>> > +#define CLKID_DSPB_A_SEL	94
>> > +#define CLKID_DSPB_B_SEL	95
>> > +#define CLKID_CECA_32K_SEL	96
>> > +#define CLKID_CECB_32K_SEL	97
>> > +#define NR_CLKS			98
>> > +
>> > +#endif /* __A1_CLKC_H */
>> > diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
>> > new file mode 100644
>> > index 000000000000..740fe8c4db5d
>> > --- /dev/null
>> > +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
>> > @@ -0,0 +1,21 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> > +/*
>> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> > + * Author: Jian Hu <jian.hu@amlogic.com>
>> > + *
>> > + * Copyright (c) 2023, SberDevices. All Rights Reserved.
>> > + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> > + */
>> > +
>> > +#ifndef __A1_PLL_CLKC_H
>> > +#define __A1_PLL_CLKC_H
>> > +
>> > +#define CLKID_FIXED_PLL		0
>> > +#define CLKID_FCLK_DIV2		1
>> > +#define CLKID_FCLK_DIV3		2
>> > +#define CLKID_FCLK_DIV5		3
>> > +#define CLKID_FCLK_DIV7		4
>> > +#define CLKID_HIFI_PLL		5
>> > +#define NR_PLL_CLKS		6
>> > +
>> > +#endif /* __A1_PLL_CLKC_H */
>> 

