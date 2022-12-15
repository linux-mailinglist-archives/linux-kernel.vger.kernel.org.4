Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED264DCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLOOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLOOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:37:41 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68DC2E697
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:37:39 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 3so3085507vsq.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ15fTarDAUKgAtZxdlUAO/HtntI26TxSHF6pnz8lQo=;
        b=b9m1V265SGOkN31jd68sNj+j5fmo5HDI+hw3nbQZr1R02Ahnwd9JQdo99xOhAZtO9I
         0hodzAQ+KIq24tKSKp8dOEpnJl/ZfJHlQVn5RM1tK/+HD1hrVRL4IaCiRNqr3VL+js7a
         DG2v+3rv0oUiGi9LG/qrtBOfcxTeI+Pxd1K3chrFP8UYwofZ6oKKhiKVXCKiS7O8IIqC
         GYcRmSIzM3JwDuQ+Mr55E7Tyrw28ygVpZrLxwdgsp0FCMvT68PEsABwo8xu148SfEPYI
         w+vpNSPqRcpzg2URKvCVsxQBr8tQxfzdaNEIgY8NBrWBirkfwcgU99kWSPcuzcqCA5ql
         uGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZ15fTarDAUKgAtZxdlUAO/HtntI26TxSHF6pnz8lQo=;
        b=OP8sAJ/DgBI/zWRgK7xxg8LoHoNfhBMmwRf8QeR/hoBnw0qHNbxAZetRDFVnMkzO7X
         HDjZbmDZdwZ32TReYhV+vEVlajwY60zkqpj71qgLBpBvcTlTar3t9t42/S5Ky1HmXkFc
         3KUwxEiAth35PfTjPHsQ2qXIHYSpg5ZMjtfZxN6syKazwl5Fx3cSJAqyC++ydvc+KU7R
         zPUKCHUG8brw22yZlwpfLIUmQg8ayFUzQ+1r2dT3F6TWL9y/fKBbVb//Ry/CkiWtsNQA
         Smsa0ypUWSzmAQsn1TuzojNJQXtv10JMicGXiLjciBvlX7NFGq/ZZdsFWxvkc2wqvWC4
         uqyQ==
X-Gm-Message-State: ANoB5pk+rpJef41KUO355GuwL6mwvovoO3exeITpqvdXNmXD7kfV8wsz
        7LQgTbjDPKKsO3fi6wUAWh3RfLQU377JFz3/jTjm/w==
X-Google-Smtp-Source: AA0mqf4nXgavNXLmZisRGiafHkFikYttYt9CxLXkNHxbTBrRiHz8Qy0Px6pMKI3J0W1a1HDTxVJfB67KwVQbcKjnqTc=
X-Received: by 2002:a05:6102:30b4:b0:3b3:10b1:8e64 with SMTP id
 y20-20020a05610230b400b003b310b18e64mr4089245vsd.42.1671115058703; Thu, 15
 Dec 2022 06:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221214220727.1350784-2-jcormier@criticallink.com> <29f4e14f-a81a-d440-b564-5360f44c65c1@linaro.org>
 <CADL8D3ZUE5WbV0oS6hEVUNh9asrhTKQeGR4McR6Kh6qykSFw=Q@mail.gmail.com>
In-Reply-To: <CADL8D3ZUE5WbV0oS6hEVUNh9asrhTKQeGR4McR6Kh6qykSFw=Q@mail.gmail.com>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Thu, 15 Dec 2022 09:37:27 -0500
Message-ID: <CADL8D3ZT5znWjhpQpv6u-LTJfHNpkSrHZ-j-Hh_cgCZyTKw=Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: adi,ltc2945: Add binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending reply in plain text

On Thu, Dec 15, 2022 at 9:35 AM Jon Cormier <jcormier@criticallink.com> wrote:
>
> On Thu, Dec 15, 2022 at 4:42 AM Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 14/12/2022 23:07, Cormier, Jonathan wrote:
>>
>> Missing commit msg. Describe hardware.
>
> Thanks
>>
>>
>>
>>
>> > Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
>> > ---
>> >  .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++++++++++
>> >  1 file changed, 50 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
>> >
>> > diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
>> > new file mode 100644
>> > index 000000000000..9ca7a886dec8
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
>> > @@ -0,0 +1,50 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/hwmon/adi,ltc2945.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Analog Devices LTC2945 wide range i2c power monitor
>> > +
>> > +maintainers:
>> > +  - Guenter Roeck <linux@roeck-us.net>
>> > +
>> > +description: |
>> > +  Analog Devices LTC2945 wide range i2c power monitor over I2C.
>> > +
>> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/LTC2945.pdf
>> > +
>> > +properties:
>> > +  compatible:
>> > +    enum:
>> > +      - ltc2945
>>
>> That's not a correct compatible. Missing vendor prefix.
>>
> Okay, I assume I'll need to update the driver as well to handle that.
>>
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  shunt-resistor-micro-ohms:
>> > +    description:
>> > +      Shunt resistor value in micro-Ohms
>> > +    default: 1000
>> > +
>> > +required:
>> > +  - compatible
>> > +  - reg
>> > +
>> > +
>>
>> Just one blank line.
>>
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    i2c {
>> > +           #address-cells = <1>;
>> > +           #size-cells = <0>;
>>
>> Use 4 spaces for example indentation.
>>
>> > +
>> > +           ltc2945_i2c: ltc2945@6e {
>>
>> Node names should be generic.
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> > +              compatible = "ltc2945";
>> > +              reg = <0x6e>;
>> > +              /* 10 milli-Ohm shunt resistor */
>> > +              shunt-resistor-micro-ohms = <10000>;
>> > +           };
>> > +    };
>> > +...
>>
>> Best regards,
>> Krzysztof
>>
>
>
> --
> Jonathan Cormier
> Software Engineer
>
> Voice:  315.425.4045 x222
>
>
>
> http://www.CriticalLink.com
> 6712 Brooklawn Parkway, Syracuse, NY 13211
>
>



-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
