Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5425FB806
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJKQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJKQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:12:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343F4B4A7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:12:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so32502963ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnLUoFaU3blZOlls16zN1BYDLl6R08N8OQkYfhpp1PQ=;
        b=C0S97wP61qMnHd5sJB8dTaMCofVkvWwpNFKzyBLfHfHg69DtfnQKBUje86/cdY7ndH
         QJyVaozB2wOLzNa6bNcYv75uDXRT+qKu/n21yhSRgVEjyVsNVA8rhq/4MI+foJOIfp20
         G+GgnnRGahMDmiXIwMT6kMrQI1oXZAyoKa+lpr8xhuVdVEaOpnvQuFkrleWctaliD3LB
         NfEEDoInfqmEHnaAWV5GKhaUgG/27daamnXauCiGMf7gmteWQddeRkEDJ2MDdAxgTsRS
         9GwDGScv9aoLFq0E42LVTakeoiuLbO9bdi4EPtN1bMm9pmCt0gHNe6+f/D/FFAYGYZyz
         4bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnLUoFaU3blZOlls16zN1BYDLl6R08N8OQkYfhpp1PQ=;
        b=mnrXgun5XfFXVboqJCI6yjyFwzlHbqGrliGfp0blSilWJqGv8wyr7nObHIwaOBicX2
         JHPoZXMzDQK8eRAtB01CMtrTS7xiXn5OvgalShzWXkmxg3TMogfxyXcvvSQsg8HiKiB9
         CvS/XDwujjqHP3zR9LugDB1tmxHHNFUS9MEU3QFLTFfetjHJzjqPTRh9f9V90Fl/u2lE
         7sjcXOEAKfOdl3Qs/NzdtWQOULXlTlBCsC3PZFJFCZSXURejCBpCRlNKAGovm3f1Rqb1
         eczs75kLbr/uwcg5K7pEgWKqhaUWE1lOSuMQUZnCsea51AbdsdKGswgcDcUpSp69yHzJ
         p0+Q==
X-Gm-Message-State: ACrzQf2K/N/x3dzLcWgaHOMb6+AsyWvwIt60wDNB5tnndsfEbpK2A4PW
        lUGBCfpo1aPovngxGLxzkots5QU6g6FAfUKfFKJAiA==
X-Google-Smtp-Source: AMsMyM4z1eWSzZfxemacavXkYNnL4SVMx+5pP//9GryCIP9fr9/JFumBzMpiwxabLn0BH0YEyTwSbbBltx3ZQVlCMNY=
X-Received: by 2002:a17:907:a068:b0:78d:cbcf:f7bc with SMTP id
 ia8-20020a170907a06800b0078dcbcff7bcmr5857263ejc.519.1665504732114; Tue, 11
 Oct 2022 09:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
 <20221011104739.53262-2-Naresh.Solanki@9elements.com> <d2c83c4f-653c-438e-a91a-d17b846dec5b@roeck-us.net>
In-Reply-To: <d2c83c4f-653c-438e-a91a-d17b846dec5b@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 11 Oct 2022 21:42:01 +0530
Message-ID: <CABqG17hBJBU2rZSq4qy6Fn=pDH9ezwL=Fjh5vhj_G0cge-07mQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Guenter,

fan-common is intended for fan properties. i.e., those derived from
fan datasheets.
For min-rpm, some fans have minimum non zero rpm like 1900rpm below which
the fan cannot run.

But not sure what the best approach is but for chip specific setting
it should be in
chip specific DT schema. Suggestion?

Regards,
Naresh Solanki



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email:  naresh.solanki@9elements.com
Mobile:  +91 9538631477

Sitz der Gesellschaft: Bochum
Handelsregister: Amtsgericht Bochum, HRB 17519
Gesch=C3=A4ftsf=C3=BChrung: Sebastian Deutsch, Eray Basar

Datenschutzhinweise nach Art. 13 DSGVO

On Tue, 11 Oct 2022 at 20:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/11/22 03:47, Naresh Solanki wrote:
> > Add common fan properties bindings to a schema.
> >
> > Bindings for fan controllers can reference the common schema for the
> > fan
> >
> > child nodes:
> >
> >    patternProperties:
> >      "^fan@[0-2]":
> >        type: object
> >        allOf:
> >          - $ref: fan-common.yaml#
> >
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >   .../devicetree/bindings/hwmon/fan-common.yaml | 80 ++++++++++++++++++=
+
> >   1 file changed, 80 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/=
Documentation/devicetree/bindings/hwmon/fan-common.yaml
> > new file mode 100644
> > index 000000000000..abc8375da646
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common fan properties
> > +
> > +maintainers:
> > +  - Naresh Solanki <naresh.solanki@9elements.com>
> > +
> > +properties:
> > +  max-rpm:
> > +    description:
> > +      Max RPM supported by fan
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  pulse-per-revolution:
> > +    description:
> > +      The number of pulse from fan sensor per revolution.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  target-rpm:
> > +    description:
> > +      Target RPM the fan should be configured during driver probe.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  pwm-frequency:
> > +    description:
> > +      PWM frequency for fan.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  pwm-polarity-inverse:
> > +    description:
> > +      PWM polarity for fan.
> > +    type: boolean
> > +
> > +  label:
> > +    description:
> > +      Optional fan label
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +
>
> Same question as before:
>
> How are additional common bindings, such as min-rpm or fan-divider
> (also sometimes called fan-prescale) supposed to be handled ?
> As additions to this schema, or individually in each driver needing/
> using them ?
>
> Thanks,
> Guenter
