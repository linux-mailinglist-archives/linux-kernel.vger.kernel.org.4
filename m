Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772FA6093BC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJWNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJWNqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:46:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB25B06F;
        Sun, 23 Oct 2022 06:46:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu30so11746184wrb.8;
        Sun, 23 Oct 2022 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cq6ml4rMvsUZl0nbZA+VtI9dxWSfIwNhhZth1xvqK1U=;
        b=FzoUqcb6qJbIqhCt3TliEUVGR/X71bCFhiCCI5D83ibto6Qv5XXoB+RiebX3FVhQK5
         Fw8x1nrQm9OP0jft7Dxc8iKozpZqHdb02nYLVLYKpVheXjsdy9z/ouiHLg/J5MTLJfpO
         OuFaw5Sr5RQrgUX/GN6iFK+eqyDDnWQXC0TE1zAZbKFr9ydEmmAK6SV1iynhBZ6MeXT4
         RPBNsbet6SeEjqLJc79SUd0IoAWk7xeE0s7FWblyZSts9TwS/eQ1Ai1L7t8smDwJ7L+L
         3QvI9+Uf3CsqFwDRtVAeKumZ9u+FWb8vRRLaul2qqq7Y8GU1oPd5NNPkNxG/8W6qOnDD
         w5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq6ml4rMvsUZl0nbZA+VtI9dxWSfIwNhhZth1xvqK1U=;
        b=DW0RUJd7wNDxfIt9HgE7yn8opDam3M+zQXMxg1xrJCOPPNOTd73iTvOtN79SuDd5Lz
         hqkLaYKCiECDvKy4EnCP7ST+Io8vnRRTdvb9o+G8hlt1LZQKHMvt/HWN67xnku4eV+yp
         5mJ+ftppN8xkBLSdO0o7ySwhE6ihYH60baxGsAfxMrOwrIuOSuyFCGfx78GHIBKT9xRD
         NjnczhPD5a1+bIarz2fstcuE0Bjwqpsx6+E8X9HwpEieKNdJrsGdMHp72rBbs65144hg
         lD9dZXpr1N0tyb/mMNRJYeVu7t3XHgY4fTu6MP2O0C2s8WSmb7WUZWnjXeInPz+bqQWA
         s6lA==
X-Gm-Message-State: ACrzQf3FJnAob3PeVZszGrLaytnllpNjbT+LDEvxXyVaJGDHTbrFuopg
        cRSKbiF76t63VYKli7NHwPg=
X-Google-Smtp-Source: AMsMyM5cEBhGyIJhCn4sJCAomHqAAqJkVvaoiWF4egAgFRcx4BOvDf6EzslOacVsYxuehLGoMpyFNA==
X-Received: by 2002:a5d:5a05:0:b0:235:474c:c12 with SMTP id bq5-20020a5d5a05000000b00235474c0c12mr12571964wrb.659.1666532775302;
        Sun, 23 Oct 2022 06:46:15 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b07:7001:b004:9b9f:6a7a:db0f? ([2001:a61:2b07:7001:b004:9b9f:6a7a:db0f])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm5585928wmq.7.2022.10.23.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:46:14 -0700 (PDT)
Message-ID: <5cfc6dbb2a324746ece4f6cc0e633ccedfce2c54.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: temperature: ltc2983: refine
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Date:   Sun, 23 Oct 2022 15:46:13 +0200
In-Reply-To: <20221023135124.1fdeab5e@jic23-huawei>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
         <20221020090257.1717053-4-demonsingur@gmail.com>
         <20221023135124.1fdeab5e@jic23-huawei>
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

On Sun, 2022-10-23 at 13:51 +0100, Jonathan Cameron wrote:
> On Thu, 20 Oct 2022 12:02:55 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
>=20
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >=20
> > =C2=A0* make sure addresses are represented as hex
> > =C2=A0* add note about wrong unit value for adi,mux-delay-config-us
> > =C2=A0* simplify descriptions
> > =C2=A0* add descriptions for the items of custom sensor tables
> > =C2=A0* add default property values where applicable
> > =C2=A0* use conditionals to extend minimum reg value
> > =C2=A0=C2=A0 for single ended sensors
> > =C2=A0* remove " around phandle schema $ref
> > =C2=A0* remove label from example and use generic temperature
> > =C2=A0=C2=A0 sensor name
> >=20
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>=20
> Hi Cosmin,
>=20
> Just one question inline from me (other than the build bot report
> that I'll
> assume you'll fix for v3).
>=20
> Otherwise looks like a nice cleanup to me.
>=20
> I wonder a bit on whether it is worth splitting up, but that would be
> rather messy to actually do so will leave that to the dt experts to
> comment
> on.
>=20
> Jonathan
>=20
>=20
> > ---
> > =C2=A0.../bindings/iio/temperature/adi,ltc2983.yaml | 309 +++++++++++--=
-
> > ----
> > =C2=A01 file changed, 182 insertions(+), 127 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > index 722781aa4697..3e97ec841fd6 100644
> > ---
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > l
> > @@ -26,25 +26,25 @@ properties:
> > =C2=A0
> > =C2=A0=C2=A0 adi,mux-delay-config-us:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The LTC2983 performs 2 or 3 internal co=
nversion cycles per
> > temperature
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result. Each conversion cycle is perfor=
med with different
> > excitation and
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input multiplexer configurations. Prior=
 to each conversion,
> > these
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excitation circuits and input switch co=
nfigurations are
> > changed and an
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 internal 1ms delay ensures settling pri=
or to the conversion
> > cycle in most
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cases. An extra delay can be configured=
 using this property.
> > The value is
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rounded to nearest 100us.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Extra delay prior to each conversion, i=
n addition to the
> > internal 1ms
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delay, for the multiplexer to switch in=
put configurations
> > and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excitation values.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This property is supposed to be in micr=
oseconds, but to
> > maintain
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatibility, this value will be multi=
plied by 100 before
> > usage.
>=20
> This new text has me a little confused.=C2=A0 Previously we talked
> rounding, now it
> is saying the value is multiplied (which would make it definitely not
> in micro
> secs!)..=C2=A0 So are we papering over a driver bug here?
>=20
>=20

Hi Jonathan,

Let me try to make this one clear as it was my mess...

The multiplication is done internally by the device. I messed up in
this one as this value is clearly not in us but it is the raw value.
So, tecnically, there's nothing wrong in the driver as it just reads
this property and directly writes it. But of course this is misleading
and wrong from the bindings point of view.

That said, me and Cosmin did spoke about just having this property
'deprecated' and add a new one (the driver would need to be changed
accordingly) - no idea also about a new name for it :)

But for this round, Cosmin decided to have this stated on the
description and see what you and dt maintainers had to say about it and
if making it 'deprecated' is the way to go (or something else).

- Nuno S=C3=A1

