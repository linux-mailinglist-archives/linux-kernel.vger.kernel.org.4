Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655AB600B08
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJQJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJQJhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:37:40 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109E5C9CE;
        Mon, 17 Oct 2022 02:37:31 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x13so6238360qkg.11;
        Mon, 17 Oct 2022 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N3bkZamI0hi6hpaZyb2y3x0Y+G3pNP3ABy8QhyBtLdc=;
        b=b/ny7Y57z2JGyKhT6o0TS8o0YiCYqrQr7viaEUoVLFR0Wx1evWzrF6tXp5DE+S6kON
         lCrpT3vUrz9188ZUOTvFHJjBuaO06pmCnWSfVcwzdU00fSvZSc48Lhapdn06LYLdRc19
         FnnLGsHW17ilt6FDbBX+RqW18xBXZL+rgbZ1ANt4nJu5rjlGHMjilOVeSDPBn75ea9AZ
         cGPMZkxZRVZb4Z6mfrkY9Vl6b1ncVHaTF8hLJk61qepAZ1B5a8RsOZ5Tzu3yeUrJ2IT1
         SdZ1wGoKpARnA7KWn/TdehWVCiUPcp/X9GZQCfMGv4w0aY7bdQ3/W5Fw8gsQhIAcLYYH
         OE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3bkZamI0hi6hpaZyb2y3x0Y+G3pNP3ABy8QhyBtLdc=;
        b=R+Mf/5dC8neh9OheN9Gs83C4jMTBBr/tNDQZOUwLxmck4dRj7r2eiBb2G4kZH7VhJc
         ROX7IOL80ZiMHR5Zqtdg0NykxEa601/Je1NpY6Fpx0n5CB4+LxPXExJ+9wsAr0qVXTmT
         vPacdbwcADMd816mREKlG/7G7mrsMe4MFP2uJN4km9ayQT77rQghIjE7KUSgWosdBJo4
         6nwgPHrs3o9gP6wjap6ZbJKAeFhOQsMB+03TzuZWIVbW0K/Gsw0NkpgU4rJE6dDbRQ9L
         9ZqsGxhmbzPiUXlaLSHIOmaLnIKFQsJgRtTBf/jm3B0XOviGR68LQjb1RQIqg0k9GoQv
         kheQ==
X-Gm-Message-State: ACrzQf2WNlr4o7VNGYbCYciBtcdb4CFOsQKx+oU3xnCCiMM7MPXX5uXG
        wEVlcd4FqhZCJDTAkP96YHQ=
X-Google-Smtp-Source: AMsMyM6/Po+9PDBX5JS/6KSZoLPQ4MAOC5I0bpy9JDx8uCprXiw0wojeHAn4irnFEy+SDbgCzgei5w==
X-Received: by 2002:a05:620a:458c:b0:6ee:8d8e:6673 with SMTP id bp12-20020a05620a458c00b006ee8d8e6673mr6740748qkb.327.1665999450072;
        Mon, 17 Oct 2022 02:37:30 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id t26-20020a37ea1a000000b006b5cc25535fsm9041379qkj.99.2022.10.17.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:37:29 -0700 (PDT)
Message-ID: <f003f3ffa86fbeae6898c23638a4b0e1228a8657.camel@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support
 more parts
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Date:   Mon, 17 Oct 2022 11:38:51 +0200
In-Reply-To: <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
         <20221014123724.1401011-3-demonsingur@gmail.com>
         <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
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

Hi Krzysztof,

As I wrote the original bindings, let me reply to some of your
points...

On Sun, 2022-10-16 at 21:59 -0400, Krzysztof Kozlowski wrote:
> On 14/10/2022 08:37, Cosmin Tanislav wrote:
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >=20
> > Add support for the following parts:
> > =C2=A0* LTC2984
> > =C2=A0* LTC2986
> > =C2=A0* LTM2985
> >=20
> > The LTC2984 is a variant of the LTC2983 with EEPROM.
> > The LTC2986 is a variant of the LTC2983 with only 10 channels,
> > EEPROM and support for active analog temperature sensors.
> > The LTM2985 is software-compatible with the LTC2986.
> >=20
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > ---
> > =C2=A0.../bindings/iio/temperature/adi,ltc2983.yaml | 63
> > +++++++++++++++++--
> > =C2=A01 file changed, 59 insertions(+), 4 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > index 722781aa4697..c33ab524fb64 100644
> > ---
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > @@ -4,19 +4,27 @@
> > =C2=A0$id:
> > http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
> > =C2=A0$schema: http://devicetree.org/meta-schemas/core.yaml#
> > =C2=A0
> > -title: Analog Devices LTC2983 Multi-sensor Temperature system
> > +title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor
> > Temperature system
> > =C2=A0
> > =C2=A0maintainers:
> > =C2=A0=C2=A0 - Nuno S=C3=A1 <nuno.sa@analog.com>
> > =C2=A0
> > =C2=A0description: |
> > -=C2=A0 Analog Devices LTC2983 Multi-Sensor Digital Temperature
> > Measurement System
> > +=C2=A0 Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor
> > Digital
> > +=C2=A0 Temperature Measurement Systems
> > +
> > =C2=A0=C2=A0
> > https://www.analog.com/media/en/technical-documentation/data-sheets/298=
3fc.pdf
> > +=C2=A0
> > https://www.analog.com/media/en/technical-documentation/data-sheets/298=
4fb.pdf
> > +=C2=A0
> > https://www.analog.com/media/en/technical-documentation/data-sheets/298=
61fa.pdf
> > +=C2=A0
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ltm=
2985.pdf
> > =C2=A0
> > =C2=A0properties:
> > =C2=A0=C2=A0 compatible:
> > =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ltc2983
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ltc2984
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ltc2986
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ltm2985
> > =C2=A0
> > =C2=A0=C2=A0 reg:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > @@ -26,7 +34,7 @@ properties:
> > =C2=A0
> > =C2=A0=C2=A0 adi,mux-delay-config-us:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The LTC2983 performs 2 or 3 internal co=
nversion cycles per
> > temperature
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The device performs 2 or 3 internal con=
version cycles per
> > temperature
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result. Each conversion cycle is p=
erformed with different
> > excitation and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input multiplexer configurations. =
Prior to each conversion,
> > these
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excitation circuits and input swit=
ch configurations are
> > changed and an
> > @@ -145,7 +153,7 @@ patternProperties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,three-conversion-cycles:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Boolean pr=
operty which set's three conversion cycles
> > removing
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parasitic resis=
tance effects between the LTC2983 and the
> > diode.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parasitic resis=
tance effects between the device and the
> > diode.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: boolean
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,average-on:
> > @@ -353,6 +361,41 @@ patternProperties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: Boolean p=
roperty which set's the adc as
> > single-ended.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: boolean
> > =C2=A0
> > +=C2=A0 "^temp@":
>=20
> There is already a property for thermocouple. Isn't a thermocouple a
> temperature sensor? IOW, why new property is needed?
>=20

Well, most of the patternProps in this bindings are temperature
sensors... It's just that the device(s) support different types of
them. 'adi,sensor-type' is used to identify each sensor (as this
translates in different configurations being written in the device
channels).

> > +=C2=A0=C2=A0=C2=A0 type: object
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Represents a channel which is being use=
d as an active analog
> > temperature
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor.
> > +
> > +=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,sensor-type:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Identifies the =
sensor as an active analog temperature
> > sensor.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/=
definitions/uint32
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 31
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,single-ended:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: Boolean proper=
ty which sets the sensor as
> > single-ended.
>=20
> Drop "Boolean property which sets" - it's obvious from the type.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: boolean
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,custom-temp:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is a table=
, where each entry should be a pair of
>=20
> "This is a table" - obvious from the type.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 voltage(mv)-tem=
perature(K). The entries must be given in
> > nv and uK
>=20
> mv-K or nv-uK? Confusing...

Yeah, a bit. In Cosmin defense, I think he's just keeping the same
"style" as the rest of the properties...

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 so that, the or=
iginal values must be multiplied by
> > 1000000. For
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more details lo=
ok at table 71 and 72.
>=20
> There is no table 71 in the bindings... It seems you pasted it from
> somewhere.

I'm fairly sure this refers to the datasheet. I see now that this can
be confusing (again this kind of references are being (ab)used in the
rest of the file).

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note should be =
signed, but dtc doesn't currently
> > maintain the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign.
>=20
> What do you mean? "Maintain" as allow or keep when building FDT?=C2=A0
> What's
> the problem of using negative numbers here and why it should be part
> of
> bindings?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/=
definitions/uint64-matrix
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 64
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 2
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
>=20
> Instead describe the items with "description" (and maybe constraints)
> like here:
>=20
> https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bi=
ndings/iio/adc/st,stm32-adc.yaml#L278
>=20

Neat... My only comment (which probably applies to my previous ones) is
that the rest of the properties are already in this "style". So maybe,
follow up patches with small clean-ups would be more appropriate?
>=20


- Nuno S=C3=A1
