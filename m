Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FDF6B7446
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCMKim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCMKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:38:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461812F0F;
        Mon, 13 Mar 2023 03:38:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e65so2546512ybh.10;
        Mon, 13 Mar 2023 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678703891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UPx7fWX28Hu1CWuxEfXQgCtj/vv8NbL3fBW87iZqtg=;
        b=O5KOQLf1DzyYNcOLrTFfEvYswRjR0TOKc4krShaxzfcRB+7oy1V9cBbZGXC3B02/+j
         9G/4X+/om3IvQ8/wX1BqmArxqW/LV4yLFsGrI69qAVjmif1zXE2o3RtNYGOhMzx+s0LS
         UHegw0rgpYgmo0Wr0shxKfb+rGtvusvaRkbh44q1UjjsrNfMA+P1WXj78b5h1TFWgJxn
         3Ye8abWCtXclb7pNYZcFo1Qx3M5e/KPcVLElHLZN8uBIRibtZ7poua3dBJVhIESNwWvP
         QJ80Wp1y4RM+McHZbTTLJBBj36LJ6vRZex1f1+jaomrs01CiOsJErf3u3FGcx+CgdkH+
         XuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678703891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UPx7fWX28Hu1CWuxEfXQgCtj/vv8NbL3fBW87iZqtg=;
        b=pJ430+h1LTwWEStLXQaq/qHthjBYOzj5wNp1IAQ7+uJhH9wLrlP5IFZsJIJB9F33hA
         B2kwVxI+Cv1XR8qmDVFjO6wOoXwB1JINz0j8HEOjyTo4JBozOn9OUXF0XMw7TnWdnNwA
         O1X6FAsalKreT/yFywZ0s5j0O27NE0ldKPp+NtnGaysTQIz6S35RHAaJSgORcON+X7tT
         UcC0lcPzh2k+D+Hb79XZE+dtXSJlMBhkkNX7VaTydtMUxxfJBwNSWvBZfjZOUAktPlFu
         qP2yQR8xRiXb4MLYZt1+j7ZJQwwdGK+wq3cHu0CB9ELQBrUn9LCm0AR0kZ2F6v8W4uep
         rSqQ==
X-Gm-Message-State: AO0yUKVQKIx7Kc+islmfr7mWiRPp9ge8MHeDf0E/+o/OoVDRZrqtdPWb
        1nb1RYdhKJQy8VbqgdiGXkt7X6W741JYpg7HbBU=
X-Google-Smtp-Source: AK7set99rVYfgguSFnnxNLUGLfELBI8eRt2dbmYeR5cBdAdouUumnfZPAfmvXg52gTrAH/gcJ37MB+nm5NOSBDKlzXU=
X-Received: by 2002:a5b:40e:0:b0:ac2:ffe:9cc9 with SMTP id m14-20020a5b040e000000b00ac20ffe9cc9mr21078587ybp.3.1678703891374;
 Mon, 13 Mar 2023 03:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230110083238.19230-1-jim.t90615@gmail.com> <20230110083238.19230-4-jim.t90615@gmail.com>
 <d56c24c2-a017-8468-0b3a-bd93d6024c69@linaro.org>
In-Reply-To: <d56c24c2-a017-8468-0b3a-bd93d6024c69@linaro.org>
From:   Jim Liu <jim.t90615@gmail.com>
Date:   Mon, 13 Mar 2023 18:38:00 +0800
Message-ID: <CAKUZ0+HiR+GDG4EP8nxyVVMQrkotvyQP3N3Rs7+3d2aTLEtMoA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

Sorry for the mistake.
I think I need to explain more details about the clock.

The NPCM7xx / NPCM8xx  SGPIO feature have 4 pins.
picture is as below:
https://drive.google.com/file/d/1E9i_Avh-AZV9IEZO1HLMT4EtgCBe46OV/view?usp=
=3Dsharing

The clock is generated from npcm7xx APB.
The bus frequency is derived from npcm7xx APB not HC595/HC165.
Users can connect  1~8 HC595 on DOUT pin to decode the serial data for
HC595 A~H pin
and can connect  1~8 HC165 on DIN pin to encode the serial data to
send to NPCM7xx.

The test device is as below:
https://pdf1.alldatasheet.com/datasheet-pdf/view/345467/TI/SN74HC595N.html
https://pdf1.alldatasheet.com/datasheet-pdf/view/27899/TI/SN74HC165N.html

NPCM7xx/NPCM8xx have two sgpio modules;
each module can support up to 64 output pins,and up to 64 input pins.
If the user needs 64 output pins , user needs to connect 8 HC595.
If the user needs 64 input pins , user needs to connect 8 HC165.

the HC595 and HC165 connect is as below:
NPCM7xx_DOUT    ->   HC595  SER pin
NPCM7xx_SCLK     ->   HC595  SRCLK pin
NPCM7xx_LDSH    ->    HC595  RCLK pin

NPCM7xx_SCLK     ->   HC165  CLK pin
NPCM7xx_LDSH     ->   HC165  SH/LD pin
NPCM7xx_DIN        ->    HC165  QH pin

The frequency is not derived from the input clock. so i think maybe
the yaml needs to describe it.
if yaml file still didn't need please let me know.

And if you have any confusion about the sgpio feature or the connect
test please let me know.


Best regards,
Jim

On Tue, Jan 10, 2023 at 6:35=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/01/2023 09:32, Jim Liu wrote:
> > Add dt-bindings document for the Nuvoton NPCM7xx and NPCM8xx sgpio driv=
er
> >
> > Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> > ---
> > Changes for v4:
> >    - modify in/out property
> >    - modify bus-frequency property
> > Changes for v3:
> >    - modify description
> >    - modify in/out property name
> > Changes for v2:
> >    - modify description
> > ---
> >  .../bindings/gpio/nuvoton,sgpio.yaml          | 92 +++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpi=
o.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml =
b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> > new file mode 100644
> > index 000000000000..3c01ce61f8d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> > @@ -0,0 +1,92 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton SGPIO controller
> > +
> > +maintainers:
> > +  - Jim LIU <JJLIU0@nuvoton.com>
> > +
> > +description:
> > +  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
> > +  Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595=
)
> > +  and parallel to serial IC (HC165), and use APB3 clock to control it.
> > +  This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
> > +  NPCM7xx/NPCM8xx have two sgpio module each module can support up
> > +  to 64 output pins,and up to 64 input pin, the pin is only for gpi or=
 gpo.
> > +  GPIO pins have sequential, First half is gpo and second half is gpi.
> > +  GPIO pins can be programmed to support the following options
> > +  - Support interrupt option for each input port and various interrupt
> > +    sensitivity option (level-high, level-low, edge-high, edge-low)
> > +  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,ou=
tput-ngpios GPIO lines.
> > +    nuvoton,input-ngpios GPIO lines is only for gpi.
> > +    nuvoton,output-ngpios GPIO lines is only for gpo.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,npcm750-sgpio
> > +      - nuvoton,npcm845-sgpio
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  nuvoton,input-ngpios:
> > +    description: The numbers of GPIO's exposed.
> > +      GPIO lines is only for gpi.
> > +    minimum: 0
> > +    maximum: 64
> > +
> > +  nuvoton,output-ngpios:
> > +    description: The numbers of GPIO's exposed.
> > +      GPIO lines is only for gpo.
> > +    minimum: 0
> > +    maximum: 64
> > +
> > +  bus-frequency:
> > +    description: Directly connected to APB bus and
> > +      its shift clock is from APB bus clock divided by a programmable =
value.
>
> The bus frequency is derived from input clocks, isn't it? We already
> questioned this property and this does not help justify it existence.
> Drop it.
>
> > +    default: 8000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - gpio-controller
> > +  - '#gpio-cells'
> > +  - interrupts
> > +  - nuvoton,input-ngpios
> > +  - nuvoton,output-ngpios
> > +  - clocks
> > +  - bus-frequency
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    gpio8: gpio@101000 {
> > +        compatible =3D "nuvoton,npcm750-sgpio";
> > +        reg =3D <0x101000 0x200>;
> > +        clocks =3D <&clk NPCM7XX_CLK_APB3>;
> > +        interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +        bus-frequency =3D <8000000>;
> > +        gpio-controller;
> > +        #gpio-cells =3D <2>;
> > +        nuvoton,input-ngpios =3D <64>;
> > +        nuvoton,output-ngpios =3D <64>;
> > +        status =3D "disabled";
>
> I reminded you about this twice. So this is third time. Or maybe even
> fourth?
>
> Best regards,
> Krzysztof
>
