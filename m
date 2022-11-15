Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7762991D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiKOMoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKOMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:44:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CC388C;
        Tue, 15 Nov 2022 04:44:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m22so35653715eji.10;
        Tue, 15 Nov 2022 04:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/a5D3eDn25P2zD70aEtrJUizUDYQa3XfdcgF2CKk07M=;
        b=FIGrNo251Ia54dOwAS+tPZeGewHKYLx6cREggd4HLRQKGxeDz5hizuXPGg3ARgiqy4
         kI02OpHSLkh4CbLfGXot5TgAPbiTiEb9yEFue2AGlDJ0PRMOsgs/kkR9fT2xoWExfwZL
         yW2S5bhg37WM9ikoUSUhEkQ/JNNU64qTOlJC711Xq3fUGHcu+AKq5/YelKWTBWa7BAcL
         s9OJzBbQMYSEWTx6KvLWufU7/ugJb8WVbMievWF0ulOXFcMbQPrylgKsci+YEgGjOJ4b
         yuDwefyNBHHG2gzruiyosToq+ZUHqU+xw7A46InycNNBK6AxElIuK+bQTL4fZPMVVptK
         IIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/a5D3eDn25P2zD70aEtrJUizUDYQa3XfdcgF2CKk07M=;
        b=mfRX8lOOIjavsFoLsqO/42qgc+rn+6SV4bUhnmRsC+Ad+ZIQGnLLfPIfuD0Jamedkf
         ggSCvI7fv+4Lp5+nMEgjE7lq++M7n3vhGuZqhQrj7PkNh62pmyWxGjq9rPsCF6vU32LQ
         yxuRxPBbvHEwQXyfPjgXMhd571GnC0Q+5w6uiKiJDpnqYiygVTmmBxAgdVxkED4tAQ4S
         fa0UWWx7+RlLLpiVkHVXUnoAOVtVLC+Yj8F+1IZXRUDAm8GenQsGJ/jZA27m9EyYC/pj
         ANV3HI96n2aoMu5gxuyFFW/QOg++Nv9ts+df8L6e2u3wiGCEHIcGkXz8JhrUMRuJRIga
         wuFA==
X-Gm-Message-State: ANoB5pkYc9ra6guISsfcP0IsXg3J9iBN8/sRy3JK0d48DcSQit67XC6Y
        pBofP6NOOmMixHDUHNNfYzG99dykV7grkEus
X-Google-Smtp-Source: AA0mqf4FmN6EqB/hVkaZjHh/Njf71Zq8sDOu3/yAv2VAb0xbxx6F/KFOdntRWMw0CbuSfp4+TBtjXQ==
X-Received: by 2002:a17:906:7143:b0:78c:f5a1:86bf with SMTP id z3-20020a170906714300b0078cf5a186bfmr13393136ejj.245.1668516247001;
        Tue, 15 Nov 2022 04:44:07 -0800 (PST)
Received: from [10.76.84.153] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ee4-20020a056402290400b004585eba4baesm6101343edb.80.2022.11.15.04.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:44:06 -0800 (PST)
Message-ID: <c54200fb70d638c572a0596a78d956d9f61d89a4.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
From:   Cosmin Tanislav <demonsingur@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 14:43:53 +0200
In-Reply-To: <20221112154040.54dc5cf2@jic23-huawei>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
         <20221103094436.2136698-2-demonsingur@gmail.com>
         <20221106154634.2286faf3@jic23-huawei>
         <c01b0e56563b2b6f8ef48ad90977646706a2c933.camel@gmail.com>
         <20221112154040.54dc5cf2@jic23-huawei>
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

On Sat, 2022-11-12 at 15:40 +0000, Jonathan Cameron wrote:
> > > =C2=A0=C2=A0
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      Conversion range for ADC conversion 2.
> > > > +      0 - 0V to 12V
> > > > +      1 - -12V to +12V
> > > > +      2 - -2.5V to +2.5V
> > > > +      3 - -2.5V to 0V
> > > > +      4 - 0V to 2.5V
> > > > +      5 - 0V to 0.625V
> > > > +      6 - -104mV to +104mV
> > > > +      7 - 0V to 12V =20
> > >=20
> > > For a lot of similar cases we handle these numerically to give
> > > a human readable dts.  Is there a strong reason not to do so here (in=
 mv)
> > > =C2=A0=C2=A0
> >=20
> > I used this approach mostly because it maps dirrectly to register value=
s
> > and because it's easier to parse. dts isn't exactly nice at handling
> > negative values. I can switch it to mv array if you insist.
>=20
> We have quite a few existing cases of
> adi,[output-]range-microvolt so it would be good to copy that style here.
>=20

With this:

  adi,conv2-range-microvolt:
    description: Conversion range for ADC conversion 2.
    oneOf:
      - items:
          - enum: [-2500000, 0]
          - const: 2500000
      - items:
          - enum: [-12000000, 0]
          - const: 12000000
      - items:
          - const: -2500000
          - const: 0
      - items:
          - const: -104000
          - const: 104000
      - items:
          - const: 0
          - const: 625000

And this:

adi,conv2-range-microvolt =3D <(-12000000) 12000000>;

I get this:

Documentation/devicetree/bindings/iio/addac/adi,ad74115.example.dtb:
addac@0: adi,conv2-range-microvolt: 'oneOf' conditional failed,
one must be fixed:
        4282967296 is not one of [-2500000, 0]
        4282967296 is not one of [-12000000, 0]
        -2500000 was expected
        -104000 was expected
        625000 was expected
        From schema: Documentation/devicetree/bindings/iio/addac/adi,ad7411=
5.yaml

As I said, negative numbers don't play too nice...

> >=20
> > > =C2=A0=C2=A0
> > > > +    minimum: 0
> > > > +    maximum: 7
> > > > +    default: 0
> > > > +

