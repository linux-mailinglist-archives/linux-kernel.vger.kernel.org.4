Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C924074A497
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGFTy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGFTy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:54:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0501BF4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:54:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so1531026e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1688673264; x=1691265264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuVvG3BnDFxkTPXo/K80PofqjuOmjeBLoSNoRSO8Tkk=;
        b=EM7Ih9ky0EKcMXDZLyRqf4bHE0C/Bm/+bXLcQmrChNW+i6oYVesSL7wcdYcOUNYTng
         4sYxO0gQDulBob147UmvOUMMOHGXsYbfC8w94iQNMM9EL9aqoUt4WlCh8wr7OQl/CNTc
         PvhW9UEWD71vOgoaNbgFygcLIU8wp4Rwp2uM1gowuFWDIqxzvD+LtzkQ6ZaA8j0gNs1X
         5FWjE3612UOPRXAFDGtUyOjmbLwVFZkWCacZT7A62FWl07net9tdeIHkhqjZ1nYxc/+H
         TOK23kxUGPbBJ0pGH5x3CFrMXKHPx2N56w0yZjD6tAwaz1ybkxLmv/jmaR2voMRsgJap
         iExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688673264; x=1691265264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuVvG3BnDFxkTPXo/K80PofqjuOmjeBLoSNoRSO8Tkk=;
        b=IQno7xqfBmFQirGIfECmuiByQbpUDfqWE1+WN0SuvmOAnmKew4cS4JI5PPiPX9ONo0
         XHXSENFD5rvXgTGatHIBXy8ChRPJBnqa64SzE/R+we+zR7z+MRaUNATX+kPKUvVlwA+r
         OFmAX5nTWHeNd0l5CQYdCFO+j2KrH6CAlJqtrf7+g/tVviuD1ytY5kHaiRCc9xaisLka
         AykIppQ7n4m7XU6lWLfGzFavhBbmOMKTkBVMMzfGZafY7FpsSLgJMYqZyaRe5jdqu7z5
         z8ovyLR8IXWxg1f3FXprfglwnC+Ll8cq6f2rzLkXV2a2bprihsld1TJzlwGnWfsKdY84
         uVQg==
X-Gm-Message-State: ABy/qLYStE1hrY3bssaNZxP183iGLZFLbOzOlFu53Sa59JhuCx6eKf0Z
        ILmuWP+WifMbUmuVmd8aJ49f04phnj55x3VBb3yu3Q==
X-Google-Smtp-Source: APBJJlEgDjjQfAwnjdSywHTs1YhBWjn0vCcjmstqCiJrEiz4zcRjWNw/kajhTv+KRxG6qrUaBr86RkzoN4luz9Q2xok=
X-Received: by 2002:a19:6701:0:b0:4f9:58ed:7bba with SMTP id
 b1-20020a196701000000b004f958ed7bbamr2796688lfc.16.1688673263648; Thu, 06 Jul
 2023 12:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230706081554.1616839-1-alex@shruggie.ro> <20230706081554.1616839-2-alex@shruggie.ro>
 <20230706191157.GA163793-robh@kernel.org>
In-Reply-To: <20230706191157.GA163793-robh@kernel.org>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Thu, 6 Jul 2023 22:54:12 +0300
Message-ID: <CAH3L5QrM7ejd4DfBwp1ru9FK1qaK7ZcSaVP718_smw-r=aC9aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
To:     Rob Herring <robh@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 10:12=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Jul 06, 2023 at 11:15:54AM +0300, Alexandru Ardelean wrote:
> > For VSC8351 and similar PHYs, a new property was added to generate a cl=
ock
> > signal on the CLKOUT pin.
> > This change documents the change in the device-tree bindings doc.
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt=
 b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > index 0a3647fe331b..133bdd644618 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > @@ -31,6 +31,10 @@ Optional properties:
> >                         VSC8531_LINK_100_ACTIVITY (2),
> >                         VSC8531_LINK_ACTIVITY (0) and
> >                         VSC8531_DUPLEX_COLLISION (8).
> > +- vsc8531,clkout-freq-mhz : For VSC8531 and similar PHYs, this will ou=
tput
>
> Please don't continue this naming pattern with 'vsc8531' prefix. The
> prefix should be the vendor prefix.

ack
will change to "mscc,clkout-freq-mhz"

>
> > +                       a clock signal on the CLKOUT pin of the chip.
> > +                       The supported values are 25, 50 & 125 Mhz.
> > +                       Default value is no clock signal on the CLKOUT =
pin.
> >  - load-save-gpios    : GPIO used for the load/save operation of the PT=
P
> >                         hardware clock (PHC).
> >
> > @@ -69,5 +73,6 @@ Example:
> >                  vsc8531,edge-slowdown        =3D <7>;
> >                  vsc8531,led-0-mode   =3D <VSC8531_LINK_1000_ACTIVITY>;
> >                  vsc8531,led-1-mode   =3D <VSC8531_LINK_100_ACTIVITY>;
> > +                vsc8531,clkout-freq-mhz      =3D <50>;
> >               load-save-gpios         =3D <&gpio 10 GPIO_ACTIVE_HIGH>;
> >          };
> > --
> > 2.40.1
> >
