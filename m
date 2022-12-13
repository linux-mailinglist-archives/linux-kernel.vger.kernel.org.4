Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F864B3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiLMLDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiLMLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:02:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC011164
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:02:47 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so17083956ejm.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ1cU6HaRiZd2oaHJNwIBTgfx+qQipJfi6liPtZV9A8=;
        b=LhaEzW475ydrk+K+WcZDtR1DW46YBskNG+u1Hq5urOdDmTVyMKmeSMYZuiXGCG5/QY
         DweSEcRxM0ZjXiFzwQanSoDzPpddScoQPVxXGracyBbTlOWC8ySqOhpqgkmla4wMFm9+
         uPAQ3nvPG5hsv7AK8MIjhsmhskv2KGLeWb2c3WViZS2Hr63wczTcVNXo5o19TyeSU2hX
         MkJyazyb0l6+035FgVjDLohtaT2drXWGPAszT5G6DJb5svkL+hDYCI+64jYK8MDP8tIw
         iJ6trgwupISP30xVSlO3cwYaf/2/KvIHCY8YqGHYHZcTUofiekbPbuC7LYH67GPm6tzL
         O9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ1cU6HaRiZd2oaHJNwIBTgfx+qQipJfi6liPtZV9A8=;
        b=QIAGToQDcaHL2CW2JyINcWzm1LKNmVVluYQJAn4F2VuZ6L6QgCHwVDldKHgmnZ6rZw
         EML/35Bmv2nbnbhUUN5tMUy5pnriVDkPGvsJ7evI/zQ1tCRdWkWDu9IqrIajc/QO2f+x
         D0K69VoPqssKaJn6ENqwCZcjAsI+RTJ0gIUukKu3PpH6jh+P/Y9ehbJkUjlKCaRd+3X2
         BPuqfcF6n13/iOozEvudc/5PelvpKDY6PB12IHl2k1TRMVTxBaZQHaP0fajg1d94/O+s
         jFIUcVfxluHCI7YaF5B4TCDliQWMpMDmaOaAk+gjpshw7i5iR6mnLKLcX+iAfLuV2y0g
         ndjg==
X-Gm-Message-State: ANoB5pn6MUvsX8VW0jD7UG0yAb5/P5Rnh0rT7Qayz/wUjBjpcfBZ9Fmm
        YvsaugF4Lumy2gQClJOA5MkmgrHugtXtjoamOmo=
X-Google-Smtp-Source: AA0mqf7amJrs0pLWsSO3ihGM3wzALu7QIKv9vyrIllw3wDUYt0tKgh9ups0gafqXCr+n9j2BzcSr5n3foaqXX7f9ZRM=
X-Received: by 2002:a17:907:728c:b0:7c1:10cf:b81c with SMTP id
 dt12-20020a170907728c00b007c110cfb81cmr8911388ejc.315.1670929366153; Tue, 13
 Dec 2022 03:02:46 -0800 (PST)
MIME-Version: 1.0
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
 <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
 <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info> <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
 <20221212101449.4e465181@xps-13> <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
 <20221212173730.64224599@xps-13> <b75a8769-0cc8-beb3-931a-6755aede3af0@inbox.ru>
 <20221213104643.052d4a06@xps-13>
In-Reply-To: <20221213104643.052d4a06@xps-13>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Tue, 13 Dec 2022 14:02:34 +0300
Message-ID: <CALHCpMhOku2b+1y5Z=N5RJ6SvCvNakD2rSyRAqp6Gz3JWVvXGg@mail.gmail.com>
Subject: Re: nvmem-cells regression after adding 'call of_platform_populate()
 for MTD partitions'
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I looked closer at commit 658c4448bbbf and bcdf0315a61a, 5db1c2dbc04c16 com=
mits.
Looks like we have two different features binded to one property - "compati=
ble".

From one side it is the ability to forward the subnode of the mtd
partition to the nvmem subsystem (658c4448bbbf and ac42c46f983e).
And from another side is the ability to use custom initialization of
the mtd partition (bcdf0315a61a and 5db1c2dbc04c16).

What I mean:
According to ac42c46f983e I can create DT like this:
 - |
    partitions {
        compatible =3D "fixed-partitions";
        #address-cells =3D <1>;
        #size-cells =3D <1>;

        partition@0 {
            compatible =3D "nvmem-cells";
            reg =3D <0x40000 0x10000>;
            #address-cells =3D <1>;
            #size-cells =3D <1>;
            macaddr_gmac1: macaddr_gmac1@0 {
                reg =3D <0x0 0x6>;
            };
        };
    };


And according to 5db1c2dbc04c16 I can create DT like this:
 - |
    partitions {
        compatible =3D "fixed-partitions";
        #address-cells =3D <1>;
        #size-cells =3D <1>;

        partition@0 {
            compatible =3D "u-boot,env";
            reg =3D <0x40000 0x10000>;
        };
    };

But I can not use them both, because only one "compatible" property allowed=
.
This will be incorrect:
 - |
    partitions {
        compatible =3D "fixed-partitions";
        #address-cells =3D <1>;
        #size-cells =3D <1>;

        partition@0 {
            compatible =3D "u-boot,env";  # from ac42c46f983e
            compatible =3D "nvmem-cells"; # from 5db1c2dbc04c
            reg =3D <0x40000 0x10000>;
            #address-cells =3D <1>;
            #size-cells =3D <1>;
            macaddr_gmac1: macaddr_gmac1@0 {
                reg =3D <0x0 0x6>;
            };
        };
    };

> compatible: Duplicate property name

=D0=B2=D1=82, 13 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:46, Miquel Rayn=
al <miquel.raynal@bootlin.com>:
>
> Hi Maxim,
>
> fido_max@inbox.ru wrote on Mon, 12 Dec 2022 20:57:49 +0300:
>
> > Hi, Miquel!
> >
> > On 12.12.2022 19:37, Miquel Raynal wrote:
> >
> > > Let me try to recap the situation for all the people I just involved:
> > >
> > > * An Ethernet driver gets its mac address from an nvmem cell. The
> > >    Ethernet controller DT node then has an "nvmem-cells" property
> > >    pointing towards an nvmem cell.
> > > * The nvmem cell comes from an mtd partition.
> > > * The mtd partition is flagged with a particular compatible
> > >    (which is also named "nvmem-cells") to tell the kernel that the no=
de
> > >    produces nvmem cells.
> > > * The mtd partition itself has no driver, but is the child node of a
> > >    "partitions" container which has one (in this case,
> > >    "fixed-partitions", see the snippet below).
> > >
> > > Because the "nvmem-cells" property of the Ethernet node points at the
> > > nvmem-cell node, the core create a device link between the Ethernet
> > > controller (consumer) and the mtd partition (producer).
> > >
> > > The device link in this case will never be satisfied because no drive=
r
> > > matches the "nvmem-cells" compatible of the partition node.
> > >
> > > Reverting commit bcdf0315a61a ("mtd: call of_platform_populate() for =
MTD
> > > partitions") would IMHO not make much sense, the problem comes from t=
he
> > > device link side and even there, there is nothing really "wrong",
> > > because I really expect the mtd device to be ready before the
> > > Ethernet controller probe, the device link is legitimate.
> > >
> > > So I would like to explore other alternatives. Here are a bunch of
> > > ideas, but I'm open:
> >
> > How about to create simple driver with compatible=3D"nvmem-cell" and to=
 move all the suff from main mtd driver which serves nvmem-cell to the prob=
e function?
>
> This is probably worth the try but I doubt you can make it work without
> regressions because IIRC the nvmem registration happens no matter the
> compatible (not mentioning the user-otp and factory-otp cases). You can
> definitely try this out if you think you can come up with something
> though.
>
> But I would like to hear from the device-link gurus :) because even if
> we fix mtd with a "trick" like above, I guess we'll very likely find
> other corner cases like that and I am interested in understanding the
> rationale of what could be a proper fix.
>
> Thanks,
> Miqu=C3=A8l
