Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A93693011
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBKKly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:41:50 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D992130;
        Sat, 11 Feb 2023 02:41:46 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-16dcb07b805so3255255fac.0;
        Sat, 11 Feb 2023 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w3ENwturTSVxpGAb53NQkes3ra0RwonBTVMe/uFWC4=;
        b=BdKfBodZZEAhg9xZniosTKvGuwpsi4IPN9ItHqMSqnRq2G54b93yerAyj/TFV2jNPO
         h7rru1P6SSkGFFVoPonCp6Zu+HiPdYgGiZIye6RWBLT82l0uvq9WFzWccfA6jeZu3z0C
         TGiywwNYjgKqFoOR3nTFch32+qPtwOmt5UQ150u8CYdwcrdsGFWTbIJ0CdoYKO42Au4q
         Rx44iZiU3l0Jbzk2B/BOv2xMVkThN5zdOQRQ4SD+AhlhcjBvwV/m+FCrE/IVrNSNEvOu
         j9GZatFeCAhQ4kQ5GVM+rzAhhb/VMAlPEFt4aXHRVp5hw5pwqXX62sQ3BhnFug1/IwsV
         RjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w3ENwturTSVxpGAb53NQkes3ra0RwonBTVMe/uFWC4=;
        b=mwRzBALMTJcHLAC5C3EC9FII8N+PlPdYyth0DBjc/nJXwRol9zsEraRVN/TYGr59Of
         oPZzyZbRyaWEjXWVBp9H3mEkn/roS0//pbu5Xi40z+kw2HQhpfsRperSpziRSGLy2b2H
         WPvWt+eKAdcEGTEMH5QvUz+zNQGKR8B+4BdolvZk0EUsE7xn6ciXd27dZ5s/lZv9RhfU
         AfTUPW5Lvt3N2ehXgDno6ViPs1zy+VM+/j3VG8/zdX8M8zt361BKKQPoNcHKc8ObV9jt
         1hHz71X7OIoR96TKEYZEyCPef0qOJmHvRHPkp9cxUW0vweRQHFcog20iSU1ck2wqH5pv
         wGUQ==
X-Gm-Message-State: AO0yUKUv+d5x7NSZLc3dnOlIFkOwN2uU2yYAPS8oqPO4upRy1xNEzOFz
        DnM6GSUOPqa8nMJ+3Xg20rP5LnjmGZtTCDJr9Xg=
X-Google-Smtp-Source: AK7set++hY0o5rtqajrPlrbeemsE+KMliKbNdYr3ndx3MXPYLiebW82GBenachb/3/jgK+3D7bTp6He6QvMyWLz7rR4=
X-Received: by 2002:a05:6870:63a2:b0:16a:a8b5:16fe with SMTP id
 t34-20020a05687063a200b0016aa8b516femr1978267oap.144.1676112106286; Sat, 11
 Feb 2023 02:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com> <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
In-Reply-To: <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 11 Feb 2023 11:41:35 +0100
Message-ID: <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 10:10 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arin=
c9.com> wrote:
>
> Is this mediatek,sysctl property required after your changes on the
> watchdog code?

I don't really understand the question :-) Yes, it is. Since we have
introduced a new phandle in the watchdog node to be able to access the
reset status register through the 'sysc' syscon node.
We need the bindings to be aligned with the mt7621.dtsi file and we
are getting the syscon regmap handler via
'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Ar=C4=B1n=
=C3=A7.

Thanks,
    Sergio Paracuellos
>
> Ar=C4=B1n=C3=A7
>
> On 11.02.2023 10:33, Sergio Paracuellos wrote:
> > MT7621 SoC provides a system controller node for accessing to some regi=
sters.
> > Add a phandle in this node to avoid using MIPS related arch operations =
and
> > includes in watchdog driver code.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >   .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 ++++++=
+
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621=
-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.=
yaml
> > index b2b17fdf4..a668d0c2f 100644
> > --- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.ya=
ml
> > +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.ya=
ml
> > @@ -19,6 +19,12 @@ properties:
> >     reg:
> >       maxItems: 1
> >
> > +  mediatek,sysctl:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle to system controller 'sysc' syscon node which
> > +      controls system registers
> > +
> >   required:
> >     - compatible
> >     - reg
> > @@ -30,4 +36,5 @@ examples:
> >       watchdog@100 {
> >         compatible =3D "mediatek,mt7621-wdt";
> >         reg =3D <0x100 0x100>;
> > +      mediatek,sysctl =3D <&sysc>;
> >       };
