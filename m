Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62CD660FBB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjAGPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjAGPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:01:11 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4793A40C22;
        Sat,  7 Jan 2023 07:01:09 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id a64so4350579vsc.2;
        Sat, 07 Jan 2023 07:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gN0b8GLZtqDqOVLUZ6Zz+XrKDlju/yDUolOd415APRo=;
        b=QU7bsGI/KUKdsezLj8gIOhr4SscvGbhYdFzS79Pyqja+wu9tVXdvVc5yaA9WLbuXOV
         7BLBouWGgQpp4/74pQRgtaHQiGD2vO9lIBPa2hw9shS06mbo4+am2+neXxovqRiP4zeX
         atlXX5lM+jxxuRsmW2NnCPx91U/dZl4Cqe8dEz+1aTnShXdVypKoMXUZ54foEEmRbXMJ
         O6HMz6X9u43TLQ1W6rsJi9civabMPlADgrR9hXD0TYQb+nqKOQCnkuOnIboJNwIro/mg
         2zqWpu3q4LDGYl0Uyj/Epu+c7sXDrdg2cVNhLus7IR8m3A+OJqkk71TMbYLYoSSwJgWo
         ZCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN0b8GLZtqDqOVLUZ6Zz+XrKDlju/yDUolOd415APRo=;
        b=qjdPa6M9/etTnIBy7a9s7lZNLcaX0Ma5/Y3Mp6svrUNWY+vKujKXRqWcBlX7t/XG9J
         hFBjJonaKlS9VEBAmYLTjHhhf3Lq3KrYfm2yZbcW0qTq07SxSCBWozLvi8sbQPxPKn2B
         dS+gAZC7/5PPGzbw5fzBwu1/ZYWVCShsMz7n0Ky/1M+foI78cjziCFeDUM8aUgWWQEQF
         lKAij3YeTF+vdkosA59UweDHcCLQYeF7JxqkfyP4qKzaDliX4wgnyofluCZPyiyRdzrV
         CFayvmwiVgPXLuIVWxZQsgCioYRtXqsBO03Ca1rVGcOVsGKPitqnN4AQBx/1sCHkuAMC
         LX4w==
X-Gm-Message-State: AFqh2kqzAwonXOo8aBcwUiGNeJDXmhzrzQsOb+Jr8Y0W2mwDjftKcZow
        ce6Z7TD1WrqPe9eGJYurUQ+Oe0ucPV2tOIX8/J0=
X-Google-Smtp-Source: AMrXdXvWo3inc/U3YtP6hG72GMVCNJmeyWlS6d5m4UwsQ7/lePrxejZKskx/Z3RdHRkyL7EpoGcdGP+p4OV7hupKci0=
X-Received: by 2002:a67:d991:0:b0:3ce:8b8f:b8f4 with SMTP id
 u17-20020a67d991000000b003ce8b8fb8f4mr3297389vsj.46.1673103668099; Sat, 07
 Jan 2023 07:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-9-linux.amoon@gmail.com>
 <Y7X/xadXIA2f9lHz@google.com>
In-Reply-To: <Y7X/xadXIA2f9lHz@google.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Jan 2023 20:30:51 +0530
Message-ID: <CANAwSgSMrQ7v=7-CmnXC0VCerFB0nroDPHuWuCDWZD6Oct15TA@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] dt-bindings: usb: Add binding for Via lab
 VL817Q7 hub controller
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, 5 Jan 2023 at 04:07, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Wed, Dec 28, 2022 at 10:03:17AM +0000, Anand Moon wrote:
> > The VIA Lab VL817-Q7 is a USB 3.1 Gen 1 4-Port hub controller that
> > features 4 downstream ports, an internal 5V regulator and has
> > external reset pin.
> >
> > Add a device tree binding for its USB protocol part.
> > The internal LDO is not covered by this and can just be modelled
> > as a fixed regulator.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  .../bindings/usb/vialab,vl817q7.yaml          | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> > new file mode 100644
> > index 000000000000..4ae995160fd5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Via labs VL817Q7 USB 3.1 hub controller
>
> nit: VIA Labs VL817-Q7
>
Ok
> > +
> > +maintainers:
> > +  - Anand Moon <linux.amoon@gmail.com>
> > +
> > +allOf:
> > +  - $ref: usb-device.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - vialab,usb2109
>
> This is not a valid compatible string as Johan already noted.
>
> Besides that the VL817-Q7 provides both a 3.1 and a 2.0 USB hub, which
> are enumerated separately. Please also add a compatible string for the
> 2.0 hub (assuming 0x2109 is the 3.1 hub).
>
Yes, correct,
actually, I would like to rename this file to vialab,vl817.yaml
since vialab,vl817-q7 is used for USB 3.1 hub and vialab,vl817-q5 is
used for USB 2.0 hub.

[0] https://datasheet.lcsc.com/lcsc/1808111624_VIA-Tech-VL817-Q7-B0_C209756.pdf

> > +
> > +  reg: true
> > +
> > +  reset-gpios:
> > +    description: GPIO controlling the RESET# pin.
> > +
> > +  vdd-supply:
> > +    description:
> > +      the regulator that provides 5.0V core power to the hub.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    usb {
> > +        dr_mode = "host";
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        hub: hub@1 {
> > +            compatible = "vialab,usb2109"
> > +            reg = <1>;
> > +            reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> > +        };
>
> Please also add a node for the other hub and link the two nodes with
> each other through the 'peer-hub' property. See realtek,rts5411.yaml
> for reference.

Ok, I will update the example according,

Thanks

-Anand.
