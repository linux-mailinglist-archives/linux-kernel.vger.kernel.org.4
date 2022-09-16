Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2396D5BAE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiIPNoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIPNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:44:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96A25FF56;
        Fri, 16 Sep 2022 06:44:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i26so35648165lfp.11;
        Fri, 16 Sep 2022 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=wNoaaN41RTRwHOeiLyTOa8sUtNtliLTsWjlT8aub0FE=;
        b=fX6AXvgDGrav8vlCvUvdHfWdcJW88ReqT2VNGbg29mI/V/VPpq2w0hdyU1SrQKIFpH
         oFsOwn2NWaptbIwYKTP1As0rtjwLbelD2fDVnNZ9j343ZO+g1VyOi8zpSTQ09NRacOtJ
         tzpGOGV0OW2N86NDq61jwscP3bgOyrm3LAjwKobmUSO5wvI15sz1c7h5gpHPOurciBLH
         6AeFBqUdiFrtD4vIGuwL2lpbJ3Vhrzz1ND9IBqrTAbCmZDNABMKzDYdfRZxLN7N3z8tP
         cgGFeU5OWKd1uJL4DwRXabyeo3aB0V9C8s7ehLgfH8V2QAy1aFECB0wFz5xzDEx5vyOa
         dzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=wNoaaN41RTRwHOeiLyTOa8sUtNtliLTsWjlT8aub0FE=;
        b=zQzxbz+PixNXUqel2k3V7RS7qMi+RTjEajYFBXgmVcO0CecVSWaKj3BxVRfuyGQf5d
         Q0feug5BepFAAUBOjzllhJwtSFpJVdW1c8xrIJp5Vt7LHHHAhnmTYKvl8bV/COgyWwNt
         Gt+GI8/kGRd+ZM7vUmz/v3QMU9hu77E10TDwU3/O5+vtmjlV8A000anCZMCaEJZ/Xke8
         NYH8J7q+XVaGLE6MNYPYwy7pO5o1DHjUdIuCwJfMrkF0+6B/mWxAWhSKCwFQxpUc4Hun
         Ss0OZMzkDX5p6PE4jA5khJeyENMqrEzp6N3LKQ2eh/CAeXaG7Wmkp46ohW6okq/ZvYZx
         OWdA==
X-Gm-Message-State: ACrzQf0gsBCO/jB1XUa23Lhl98FhWhe3w9HijHNsUC/bYqbQSyrqhq18
        GlgimGuCmFEtYIgUUOWyMzfsG+H7ja9wGw==
X-Google-Smtp-Source: AMsMyM5SZVZ0Om6WhntOKHsA63FRlXQO7aMXaRGH4hnffhP/lZHD1ffjBePdYE8qlwR1yG5BSf0o+A==
X-Received: by 2002:a05:6512:3f8b:b0:492:d1ed:5587 with SMTP id x11-20020a0565123f8b00b00492d1ed5587mr1818437lfa.355.1663335855784;
        Fri, 16 Sep 2022 06:44:15 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id g16-20020a0565123b9000b00499cf3e3ebesm3327983lfv.121.2022.09.16.06.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:44:15 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
 <20220913140553.GA2735@tom-ThinkPad-T14s-Gen-2i>
 <87sfkspa6b.fsf@gmail.com>
 <20220916131544.GA2701@tom-ThinkPad-T14s-Gen-2i>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Arec Kao <arec.kao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Jimmy Su <jimmy.su@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689
 DT bindings
Date:   Fri, 16 Sep 2022 16:42:25 +0300
In-reply-to: <20220916131544.GA2701@tom-ThinkPad-T14s-Gen-2i>
Message-ID: <871qsbph75.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-09-16 at 15:15 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> Hi Mikhail,
>
> On Thu, Sep 15, 2022 at 11:11:57PM +0300, Mikhail Rudenko wrote:
>>
>> Hi Tommaso,
>>
>> On 2022-09-13 at 16:05 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
>> > Hi Mikhail,
>> >
>> > On Sun, Sep 11, 2022 at 11:01:34PM +0300, Mikhail Rudenko wrote:
>> >> Add device-tree binding documentation for OV4689 image sensor driver,
>> >> and the relevant MAINTAINERS entries.
>> >>
>> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> >> ---
>> >>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
>> >>  MAINTAINERS                                   |   7 +
>> >>  2 files changed, 148 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> >> new file mode 100644
>> >> index 000000000000..376330b5572a
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> >> @@ -0,0 +1,141 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: Omnivision OV4689 CMOS
>> >> +
>> >> +maintainers:
>> >> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
>> >> +
>> >> +description: |
>> >> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
>> >> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
>> >> +  at 2688x1520 resolution. It is programmable through an I2C
>> >> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>> >> +  connection.
>> >> +
>> >> +allOf:
>> >> +  - $ref: /schemas/media/video-interface-devices.yaml#
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    const: ovti,ov4689
>> >> +
>> >> +  reg:
>> >> +    maxItems: 1
>> >> +
>> >> +  clocks:
>> >> +    description:
>> >> +      External clock (XVCLK) for the sensor, 6-64 MHz
>> >> +    maxItems: 1
>> >> +
>> >> +  clock-names: true
>> >> +
>> >> +  dovdd-supply:
>> >> +    description:
>> >> +      Digital I/O voltage supply, 1.7-3.0 V
>> >> +
>> >> +  avdd-supply:
>> >> +    description:
>> >> +      Analog voltage supply, 2.6-3.0 V
>> >> +
>> >> +  dvdd-supply:
>> >> +    description:
>> >> +      Digital core voltage supply, 1.1-1.3 V
>> >> +
>> >> +  powerdown-gpios:
>> >> +    maxItems: 1
>> >> +    description:
>> >> +      GPIO connected to the powerdown pin (active low)
>> >> +
>> >> +  reset-gpios:
>> >> +    maxItems: 1
>> >> +    description:
>> >> +      GPIO connected to the reset pin (active low)
>> >> +
>> >> +  orientation: true
>> >> +
>> >> +  rotation: true
>> >> +
>> >> +  port:
>> >> +    $ref: /schemas/graph.yaml#/$defs/port-base
>> >> +    additionalProperties: false
>> >> +    description:
>> >> +      Output port node, single endpoint describing the CSI-2 transmitter
>> >> +
>> >> +    properties:
>> >> +      endpoint:
>> >> +        $ref: /schemas/media/video-interfaces.yaml#
>> >> +        unevaluatedProperties: false
>> >> +
>> >> +        properties:
>> >> +          data-lanes:
>> >> +            oneOf:
>> >> +              - items:
>> >> +                  - const: 1
>> >> +                  - const: 2
>> >> +                  - const: 3
>> >> +                  - const: 4
>> >> +              - items:
>> >> +                  - const: 1
>> >> +                  - const: 2
>> >> +              - items:
>> >> +                  - const: 1
>> >> +          link-frequencies: true
>> >> +
>> >> +        required:
>> >> +          - data-lanes
>> >> +          - link-frequencies
>> >> +
>> >> +required:
>> >> +  - compatible
>> >> +  - reg
>> >> +  - clocks
>> >> +  - clock-names
>> >> +  - dovdd-supply
>> >> +  - avdd-supply
>> >> +  - dvdd-supply
>> >> +  - powerdown-gpios
>> >> +  - reset-gpios
>> >> +  - port
>> >
>> > I think we don't need all of these entries as required.
>> > The only let me say "really" required are:
>> >
>> > - compatible
>> > - reg
>> > - clocks
>> > - port
>>
>> Thanks for the review! I agree that the driver may be modified to work
>> without powerdown and reset gpios and they are not required for sensor
>> operation. On contrary, supplies are obviously required. Of course, linux
>> provides dummy regulators if supplies are missing from device tree, but
>> I though the intention was to document hardware, not implementation
>> details. What do think of this?
>
> We have already discuss on this on the following thread sometimes ago :)
>
> https://www.patchwork.linux-fancy.com/project/linux-fancy/patch/20220630134835.592521-6-tommaso.merciai@amarulasolutions.com/
>
> Take a look and let me know.

Okay, if there already is a consensus regarding this matter, I'll make
the regulators optional in v3.

--
Best regards,
Mikhail Rudenko
