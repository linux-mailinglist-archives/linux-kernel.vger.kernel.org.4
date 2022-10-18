Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE5602417
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJRGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJRGCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:02:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53892F69;
        Mon, 17 Oct 2022 23:02:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q19so18957684edd.10;
        Mon, 17 Oct 2022 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HBz9XpNnk7C63vsH23J7JUztzuCUu1YkF+D3+RSiOA4=;
        b=AoovJkk3VKnbsFwNtjwsT2mAvNuKW6b13fZroyD5KTps0icjHPiNM7N3VkzJ137LtJ
         ppAmhHA1n/JjYx7+eh9H0nO5l/iBbWMYfL3c7myNGP9oJbrjYIguWujus90XzUEJo9o/
         o/pKPgfvYfcuuQgNjuxjhbdcYBuzefrn9OsWzdRSigacJ2vLKPvUZK6r0KZXO9EKtoW1
         2kEodbPrPuyacb0uC8kAhJ64rE/7oitpTpbjSRGSPryp/HNXRnUWgV4NlQUjPoX8/UrR
         bYL4UEhm9QZTs4MTph3lFkdKQMwziivWB2atygZgcPj2soee08E8GKpVF4WUDILmoULw
         4xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBz9XpNnk7C63vsH23J7JUztzuCUu1YkF+D3+RSiOA4=;
        b=SNuMOZKRIZPARLhZnCUpeGXVy+JKdXviOP0SWRvpdpG/F9Hgde4UmYARmBG+L0X2hH
         Fo9sDHxleKidVyIsGyE5COFLaSgfd1b3OQ1dRYA0aEw4u248p6RIbfN0Q2h048U5Mwau
         4RGb8+Xd99USAtHCqArffzt7XHtJxTd8/o/gcm9wjYE7/WwRD8h46rBc8by5sft9HQWu
         CKFo+UBMvlgOC8lUl3rOc6kRDHWdABLIoul6iFKZXUXRBYUrIbSccHAVZkEcZ5N9r3GH
         +/qgXr9lv0GN+nckthZtEE5hO8C/wt/YWcJ5scUBatYcIfMzOLIZjpR3RRhjfVL1XCOb
         qjgQ==
X-Gm-Message-State: ACrzQf0oEeLbfmHRl96tIAr5oqva556PoWve0h5thHgPgEllFstJggtY
        jAmoF0RdmepRSSSTxmXv1ic=
X-Google-Smtp-Source: AMsMyM6p9mc9oxWHggnNr/wzCdWjR8cyTndxlDysy7ONDnkdqi41siT9rCVvt/JYqXBlbH7FRWm+qw==
X-Received: by 2002:a05:6402:33c4:b0:448:e63e:4f40 with SMTP id a4-20020a05640233c400b00448e63e4f40mr1104615edc.203.1666072919886;
        Mon, 17 Oct 2022 23:01:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b07:7001:b004:9b9f:6a7a:db0f? ([2001:a61:2b07:7001:b004:9b9f:6a7a:db0f])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b00783c545544fsm6970754ejh.215.2022.10.17.23.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 23:01:59 -0700 (PDT)
Message-ID: <746850ef315a8d17f34a72e83b74f9c726d56d48.camel@gmail.com>
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
Date:   Tue, 18 Oct 2022 08:01:58 +0200
In-Reply-To: <7cea27d8-c3c6-4bc2-0072-1168c9c6a2f0@linaro.org>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
         <20221014123724.1401011-3-demonsingur@gmail.com>
         <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
         <f003f3ffa86fbeae6898c23638a4b0e1228a8657.camel@gmail.com>
         <7cea27d8-c3c6-4bc2-0072-1168c9c6a2f0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Mon, 2022-10-17 at 19:32 -0400, Krzysztof Kozlowski wrote:
> On 17/10/2022 05:38, Nuno S=C3=A1 wrote:
> > Hi Krzysztof,
> >=20
>=20
> (...)
>=20
> > > > @@ -353,6 +361,41 @@ patternProperties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: Boole=
an property which set's the adc as
> > > > single-ended.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: boolean
> > > > =C2=A0
> > > > +=C2=A0 "^temp@":
> > >=20
> > > There is already a property for thermocouple. Isn't a
> > > thermocouple a
> > > temperature sensor? IOW, why new property is needed?
> > >=20
> >=20
> > Well, most of the patternProps in this bindings are temperature
> > sensors... It's just that the device(s) support different types of
> > them. 'adi,sensor-type' is used to identify each sensor (as this
> > translates in different configurations being written in the device
> > channels).
>=20
> Sure.
>=20
> >=20
> > > > +=C2=A0=C2=A0=C2=A0 type: object
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Represents a channel which is being=
 used as an active
> > > > analog
> > > > temperature
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor.
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,sensor-type:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Identifies =
the sensor as an active analog
> > > > temperature
> > > > sensor.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.ya=
ml#/definitions/uint32
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 31
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,single-ended:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: Boolean pr=
operty which sets the sensor as
> > > > single-ended.
> > >=20
> > > Drop "Boolean property which sets" - it's obvious from the type.
> > >=20
> > >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: boolean
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,custom-temp:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is a t=
able, where each entry should be a pair
> > > > of
> > >=20
> > > "This is a table" - obvious from the type.
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 voltage(mv)=
-temperature(K). The entries must be
> > > > given in
> > > > nv and uK
> > >=20
> > > mv-K or nv-uK? Confusing...
> >=20
> > Yeah, a bit. In Cosmin defense, I think he's just keeping the same
> > "style" as the rest of the properties...
>=20
> That's not the best approach for two reasons:
> 1. The unit used by hardware matters less here, because bindings are
> used to write DTS. In many, many other cases there will be some
> translation (just take random voltage regulator bindings).
>=20
> 2. What the driver is doing matters even less.
>=20
> So just describe here what is expected in DTS.
>=20

Alright, I see. So we just refer to nv-uK as that is what I wanted for
dts to expect (reason being to have more resolution).

> >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 so that, th=
e original values must be multiplied by
> > > > 1000000. For
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more detail=
s look at table 71 and 72.
> > >=20
> > > There is no table 71 in the bindings... It seems you pasted it
> > > from
> > > somewhere.
> >=20
> > I'm fairly sure this refers to the datasheet. I see now that this
> > can
> > be confusing (again this kind of references are being (ab)used in
> > the
> > rest of the file).
>=20
> Yep, but there are now multiple datasheets, aren't there?
>=20

Hmm yeah that's true. By the time I wrote this binding I was not even
thinking on the possibility of new parts being added to it... I guess
the lesson in here is to avoid this kind os specific descriptions.

> >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note should=
 be signed, but dtc doesn't currently
> > > > maintain the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign.
> > >=20
> > > What do you mean? "Maintain" as allow or keep when building FDT?=C2=
=A0
> > > What's
> > > the problem of using negative numbers here and why it should be
> > > part
> > > of
> > > bindings?
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.ya=
ml#/definitions/uint64-matrix
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 64
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 2
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
> > >=20
> > > Instead describe the items with "description" (and maybe
> > > constraints)
> > > like here:
> > >=20
> > > https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetre=
e/bindings/iio/adc/st,stm32-adc.yaml#L278
> > >=20
> >=20
> > Neat... My only comment (which probably applies to my previous
> > ones) is
> > that the rest of the properties are already in this "style". So
> > maybe,
> > follow up patches with small clean-ups would be more appropriate?
>=20
> Of course. It would be great if the file was improved before or after
> this one.
>=20

Ok, IMO it would make sense to have it in this series but if Cosmin
does not feel like fixing my mess :), I'll send a separate patch with
your inputs...

- Nuno S=C3=A1
