Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B485F6110
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJFGbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJFGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:30:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34323FEE0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:30:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r17so2321034eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=E5zgckpqsR7kGRebj1WoqapOqCyfPYoLK+0nxo0YmRg=;
        b=IzdH9hbuhhKVVv/TqcfThDmJToOdCgKHWrCq5xzHeuHiIVrhrNBxWUE3r7XoCcfP6C
         Tg7DI/aRtBPtd381HQ0NrGuDhm16brD5p+2WKyGGPoTpzk3Iiynnu05VM1jVeQp8JsAa
         tTMxh6HTCCC+dn11a2zzjkuRhvul/kFstfHAgrzcGCqTzdB5dftaalmr3qw03+jHMUuB
         Ek+V9yw9vHH2YeBF1aA79blOJT4tDoUnUMumL7j46TWZXvr7LyTkWaTgjYB9k1UqIQyy
         eHEpcVskNYQxEbaDvA+A+yNu8WpW2j8g6YZqK3nn9Ke5Jdbc9f9r8eIQ58+R8INDkWDm
         3bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E5zgckpqsR7kGRebj1WoqapOqCyfPYoLK+0nxo0YmRg=;
        b=ApAEJvEpq0GzDvIUjy85jq/BDeW3xjcyOO84pD4QHp3dC7nh04Cguj7tpljQDDR/z3
         eur07/DxTNImI38VhJ2g1G2ccFR6c+zMFWPHqbCaQIpDr3abMYhNj171E7/BKMUVK6ue
         ArWVFhCR9sa7rJkgL/VGRh/pMq3h+D3bo+w+omcAxeqtjUISykcAvGVGc+K8RFmEJHh/
         56iVp2oqyPLrBtHXl/+XHY3Z9OXrKXJ4kifVmZilhmqX7bsSPv4UG0bduv5RhurikkkK
         jckMsMlVJm867mKclNUcDUiOOigltOHsvazT0banjWFBi3OHq+2fURd3oMVaGMkpxZCc
         /nnQ==
X-Gm-Message-State: ACrzQf3CnmCOiGpCAfKI36CFB4/KJWSzp6M4bXaMXm3t4A200sr6WtBD
        5JudB1FP60Qviv4zQzYDGTpQiUIJiv/r17Tb+trH8Q==
X-Google-Smtp-Source: AMsMyM4kgiY7kYzss5XNWBII5NQwLZc9xH4OQDmzGOuyTS+Wtd+QLTUBJEIMjHJRtjlR4xF00eyN+luoNu/FquSYzJ4=
X-Received: by 2002:a17:906:db03:b0:741:337e:3600 with SMTP id
 xj3-20020a170906db0300b00741337e3600mr2700263ejb.343.1665037853179; Wed, 05
 Oct 2022 23:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220922050718.1079651-1-Naresh.Solanki@9elements.com>
 <20220922050718.1079651-2-Naresh.Solanki@9elements.com> <3003378d-4283-6c05-50bf-29178c97ef8e@linaro.org>
 <a55d973b-4504-a104-a889-f9b7e264c1e9@roeck-us.net>
In-Reply-To: <a55d973b-4504-a104-a889-f9b7e264c1e9@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 6 Oct 2022 12:00:42 +0530
Message-ID: <CABqG17hprsbHkDnvuXkQaaJdbuNgkuZD_G8L7M9HX=w5bYo8rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Guenter, to summarize below properties that can be configured
based on input from
fan datasheet:
pwm controlled fan:
1.  max-rpm : Defines maximum rpm the fan supports
2.  tach-pulse/pulse-per-revolution( also referred as prescale) :
Determines the number of
 pulses received from the sensor/tach pin of fan per revolution.
3.  rpm-init (also ref. as fan-target-rpm): Determines the fan rpm
driver needs to configure
during probe.
4. pwm-input-polarity(normal or inverse) : Specifies fan pwm input
polarity as specified in
 fan datasheet. a fan controller driver can use this data to configure
pwm output polarity
accordingly during driver probe.

For a DC output controlled fan, voltage across fan is controlled to control=
 rpm.
Below is what I can think of:
5. voltage-range : Specifies valid voltage range for rpm control
example for 3V to 5V range:
     voltage-range=3D<3000 5000>;

Above mentioned properties are within the scope of fan.
Fan controllers like max6639/max6650 etc can have additional
properties specific to the
feather supported by the chip.

Let me know if I can go ahead with this.

Thanks,
Naresh Solanki

Regards,
Naresh Solanki



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email:  naresh.solanki@9elements.com
Mobile:  +91 9538631477

Sitz der Gesellschaft: Bochum
Handelsregister: Amtsgericht Bochum, HRB 17519
Gesch=C3=A4ftsf=C3=BChrung: Sebastian Deutsch, Eray Basar

Datenschutzhinweise nach Art. 13 DSGVO


On Thu, 6 Oct 2022 at 00:10, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/21/22 23:34, Krzysztof Kozlowski wrote:
> > On 22/09/2022 07:07, Naresh Solanki wrote:
> >> From: Marcello Sylvester Bauer <sylv@sylv.io>
> >>
> >> Add Devicetree binding documentation for Maxim MAX6639 temperature
> >> monitor with PWM fan-speed controller.
> >>
> >> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> >> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >> ---
> >>   .../bindings/hwmon/maxim,max6639.yaml         | 112 ++++++++++++++++=
++
> >>   1 file changed, 112 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max=
6639.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yam=
l b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> >> new file mode 100644
> >> index 000000000000..c845fb989af2
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> >> @@ -0,0 +1,112 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +
> >> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Maxim max6639
> >> +
> >> +maintainers:
> >> +  - Roland Stigge <stigge@antcom.de>
> >
> > Ack from Roland is needed here.
> >
> >> +
> >> +description: |
> >> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic=
, PWM
> >> +  fan-speed controller.  It monitors its own temperature and one exte=
rnal
> >> +  diode-connected transistor or the temperatures of two external diod=
e-connected
> >> +  transistors, typically available in CPUs, FPGAs, or GPUs.
> >> +
> >> +  Datasheets:
> >> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - maxim,max6639
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 0
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - "fan@0"
> >> +  - "fan@1"
> >> +
> >> +additionalProperties: false
> >> +
> >> +patternProperties:
> >
> > This goes after properties.
> >
> >> +  "^fan@[0-1]$":
> >> +    type: object
> >> +    description: |
> >> +      Represents the two fans and their specific configuration.
> >> +
> >> +    properties:
> >> +      reg:
> >> +        description: |
> >> +          The fan number.
> >> +        items:
> >
> > Skip items.
> >
> >> +          minimum: 0
> >> +          maximum: 1
> >> +
> >> +      pwm-polarity:
> >
> > Why is this property of fan, not of PWM source?
> >
>
> The chip provides pwm output to the fan. That typical for fan
> controller chips. Typically they also have options to configure
> the pwm frequency and either pwm or DC output (max6639 does not
> have the latter option).
>
> Guenter
