Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD4620B83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiKHIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiKHIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:51:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F602DA86;
        Tue,  8 Nov 2022 00:51:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s12so11774167edd.5;
        Tue, 08 Nov 2022 00:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kRzenHJKW7SUmdyxPbW7TBO+s2zFUo40TmdxQBfees4=;
        b=FpfU2s1kOdyaiPi83ZwN2JP4LuVvpVlBJjB62ZrBm0ngLIjpE74ghzde6YHiQ/dcSK
         WBt0mX+FC7yVlqZkImpQvsHfRmzyBC2iU8HwhkexueNeqjA1OGIvc29R8h+PqikZXLns
         cKGDxNw9+g3frz7hQTkdsnqjqbZT0zQgl5QK+vNcIAHg6DudOswXsVZ+Pw9ZOtCcrqjn
         qZJHYX6egfh1W4GeofnmsDzGPM1OFaRW8EtVLT/dWRJAO3ZvscxABWvrYC2eLJS5b1D1
         z0AAMwvod1jOqU+8/H8bm0pppXg3uNwEVlnlXKIUSUiKEekAVw5WKLj+gGxl9+6cQOjn
         ZaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRzenHJKW7SUmdyxPbW7TBO+s2zFUo40TmdxQBfees4=;
        b=u+Bw+eWOCC70sSiROMRmgRibjpWqLmDGdanOYQ3i+agKiKp5VUP8iKGqSonyii2CUd
         /7b3vnIqQmBxlwZWiK+13JYcAcZ3vEnJw4/2lxYKP2Jk+F29vX526yGsLbq9KXTy7vqo
         mG+fYda30wO43dHCnEvutPy1fosoDlwB1TTrX9aREUCMs+NuJdRc0lnNiyzSAgoxeM34
         bO8QpzfsCgTVG2zjNRFRk90IkcJkoC+UvavB57pu/TMpmf1u0ZfLbqsybkjGGuTKVxii
         9nAM6tKMgJxePDIYafFl6OPwogPKBEou5EGYxFMUMNc4JrjzpqiiszIrG3pqpAsNpApm
         Ss4w==
X-Gm-Message-State: ACrzQf0nc80LBf7rNYKQOc/82XD8lqbR+RxJnCmrsONd3Gaf1+BZM2AJ
        9OEQdbI2dXkA4y7KhcY6JJA=
X-Google-Smtp-Source: AMsMyM65xiO+iPV1WqAee4U6PJ1Ob7mwksc2UNM7XMP8gkVUz+Me/KxMGngv5ETGeo3Vw21D2bkFzQ==
X-Received: by 2002:a05:6402:538f:b0:444:c17b:1665 with SMTP id ew15-20020a056402538f00b00444c17b1665mr55539158edb.98.1667897480354;
        Tue, 08 Nov 2022 00:51:20 -0800 (PST)
Received: from [10.76.84.153] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ky8-20020a170907778800b00782539a02absm4351636ejc.194.2022.11.08.00.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 00:51:20 -0800 (PST)
Message-ID: <c01b0e56563b2b6f8ef48ad90977646706a2c933.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
From:   Cosmin Tanislav <demonsingur@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Nov 2022 10:51:18 +0200
In-Reply-To: <20221106154634.2286faf3@jic23-huawei>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
         <20221103094436.2136698-2-demonsingur@gmail.com>
         <20221106154634.2286faf3@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-11-06 at 15:46 +0000, Jonathan Cameron wrote:
> On Thu,  3 Nov 2022 11:44:35 +0200
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
>=20
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >=20
> > The AD74115H is a single-channel, software-configurable, input and
> > output device for industrial control applications. The AD74115H
> > provides a wide range of use cases, integrated on a single chip.
> >=20
> > These use cases include analog output, analog input, digital output,
> > digital input, resistance temperature detector (RTD), and thermocouple
> > measurement capability. The AD74115H also has an integrated HART modem.
> >=20
> > A serial peripheral interface (SPI) is used to handle all communication=
s
> > to the device, including communications with the HART modem. The digita=
l
> > input and digital outputs can be accessed via the SPI or the
> > general-purpose input and output (GPIO) pins to support higher
> > speed data rates.
> >=20
> > The device features a 16-bit, sigma-delta analog-to-digital converter
> > (ADC) and a 14-bit digital-to-analog converter (DAC).
> > The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> > be used as the DAC and ADC reference.
> >=20
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>=20
> Hi Cosmin,
>=20
> A few questions inline.  Complex device so I'll doubt we'll ever get this
> binding to be as tidy as for simpler devices.  Hence most of the below ar=
e
> suggestions rather than requirements from me.
>=20
> Jonathan
>=20
> > ---
> >  .../bindings/iio/addac/adi,ad74115.yaml       | 370 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 377 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad7=
4115.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.ya=
ml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > new file mode 100644
> > index 000000000000..621f11d5c1f3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > @@ -0,0 +1,370 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/addac/adi,ad74115.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD74115H device
> > +
> > +maintainers:
> > +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> > +
> > +description: |
> > +  The AD74115H is a single-channel software configurable input/output
> > +  device for industrial control applications. It contains functionalit=
y for
> > +  analog output, analog input, digital output, digital input, resistan=
ce
> > +  temperature detector, and thermocouple measurements integrated into =
a single
> > +  chip solution with an SPI interface. The device features a 16-bit AD=
C and a
> > +  14-bit DAC.
> > +
> > +    https://www.analog.com/en/products/ad74115h.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad74115h
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
>=20
> I'm not seeing any child nodes, so why do we need these two?
>=20

Will fix.

> > +
> > +  avdd-supply: true
> > +  avcc-supply: true
> > +  dvcc-supply: true
> > +  aldo1v8-supply: true
>=20
> aldo1v8 is an output pin. "1.8 V Analog LDO Output. Do not use ALDO1V8 ex=
ternally."
> The associated input is avcc.  Given we shouldn't connect anything to the=
 pin,
> we don't want it in the binding docs
>=20

Will fix.

> > +  dovdd-supply: true
> > +  refin-supply: true
> > +
>=20
> ...
>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Conversion range for ADC conversion 2.
> > +      0 - 0V to 12V
> > +      1 - -12V to +12V
> > +      2 - -2.5V to +2.5V
> > +      3 - -2.5V to 0V
> > +      4 - 0V to 2.5V
> > +      5 - 0V to 0.625V
> > +      6 - -104mV to +104mV
> > +      7 - 0V to 12V
>=20
> For a lot of similar cases we handle these numerically to give
> a human readable dts.  Is there a strong reason not to do so here (in mv)
>=20

I used this approach mostly because it maps dirrectly to register values
and because it's easier to parse. dts isn't exactly nice at handling
negative values. I can switch it to mv array if you insist.

>=20
> > +    minimum: 0
> > +    maximum: 7
> > +    default: 0
> > +
> > +  adi,sense-agnd-buffer-lp:
> lp is a little ambiguous, given we have a habit of using it for low pass
> in filters etc. Perhaps worth spelling these out?
>      adi,sens-agnd-buffer-low-power etc?

Will fix.

>=20
> > +    type: boolean
> > +    description: |
> > +      Whether to enable low-power buffered mode for the AGND sense pin=
.
> > +
> > +  adi,lf-buffer-lp:
> > +    type: boolean
> > +    description: |
> > +      Whether to enable low-power buffered mode for the low-side filte=
red
> > +      sense pin.
> > +
> > +  adi,hf-buffer-lp:
> > +    type: boolean
> > +    description: |
> > +      Whether to enable low-power buffered mode for the high-side filt=
ered
> > +      sense pin.
> > +
> > +  adi,ext2-buffer-lp:
> > +    type: boolean
> > +    description: Whether to enable low-power buffered mode for the EXT=
2 pin.
> > +
> > +  adi,ext1-buffer-lp:
> > +    type: boolean
> > +    description: Whether to enable low-power buffered mode for the EXT=
1 pin.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cpol
> > +  - avdd-supply
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - if:
> > +      properties:
> > +        adi,digital-input-sink-range-high: true
> > +    then:
> > +      properties:
> > +        adi,digital-input-sink-microamp:
> > +          maximum: 7400
> > +
> > +additionalProperties: false
>=20
> Does this need to be unevalutatedProperties to allow
> for the extra ones in spi-periphera-props.yaml?
>=20

Will fix.

> > +

