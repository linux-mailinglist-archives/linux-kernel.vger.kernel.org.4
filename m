Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDA6C7D25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjCXLV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjCXLVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:21:25 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173325B90;
        Fri, 24 Mar 2023 04:21:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e65so1664654ybh.10;
        Fri, 24 Mar 2023 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679656883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzzuuSV8TU4gXbg0fS4shS/O6UJkvfjdScq38tWCVsc=;
        b=f0Q8y7NnKZjFQjeQ5E8//xFRKFOj8QE84E/iygoxivW2yL3KkPKc01EFL37PMdUbU8
         5m27kT8rzvsY8QT6DhaT+P0rzX7zypBmsrXVOjc5l7PHxXP3tzj7dd0aBI2XdiipvRwE
         BpAWW9IWE5efcXWwpE1y8kSzJYWNB5jMGn2NJAbRBvrnNYjFHfVaKp/xVRJcHguVnbqU
         E0ZchFA4cO4JE1C1PL49FjnF7XCYtDilZM9/IbuulnwLW+SdIyZsSOfmgcYYgXgueufB
         1PkT/+ezJbceDjAa5LCm4OgbY12OBbaagL9uFcTJuiJAA1W8QNb+LUNM4uhThaicRh8M
         C4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679656883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzzuuSV8TU4gXbg0fS4shS/O6UJkvfjdScq38tWCVsc=;
        b=QQbQvhxVMLYl2ZDcQvULgdvt9o9WU5A+QJeAOid/ydSyxm6qtfb919d2Q3ke6QJbY9
         e4Ll/8s5KPvAL06xR223lnHRfGfZeRYQmSJbhdoAozmfkgk/q62+L6Xzr42kXBHg0WY0
         4rQEhThrEdnKcD35jiT6PY22Yym8WBF/QjJrOKAO4w8xV0S63Ti+w1CqAcGQQvAPFH1H
         LXiRFLpx7ndQx4wVpbOQAR2uMJAP6fqIzW0UZCeUviNei6bEr9Z4YJb3Q4WlvYQAA+17
         skb8QJr4YgURYkrq1WuAdB336Q6MXFZHM6Xuf3eao+SErA72+yFzC4A+LhpbZ1BaEa25
         MTCQ==
X-Gm-Message-State: AAQBX9fWfoDqVMYNSUtyahELXFQ7TsTQjuu61IL4mjFI61gNKDhY8Uni
        DT9lEcjaci6YknwU+pEe9sVjjWyholQ1cxyF17k=
X-Google-Smtp-Source: AKy350ZdYUk3LRlSE05bWW+bZ37IGyJKG7JJmZ+R7fSDXkOe6HFeEf8ws+eM2XfUuq0s6uyxUxARN0nuIPEZlqcxkws=
X-Received: by 2002:a05:6902:1108:b0:b6d:fc53:c5c0 with SMTP id
 o8-20020a056902110800b00b6dfc53c5c0mr1957446ybu.1.1679656882752; Fri, 24 Mar
 2023 04:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230323124510.2484808-1-noltari@gmail.com> <20230323124510.2484808-2-noltari@gmail.com>
 <20230324104020.54754079@xps-13> <CAKR-sGcbRRjqt3raXHcvfCfKFDfFWsuu+C7XW3qFckawMsqe4w@mail.gmail.com>
 <20230324114911.19e00ae1@xps-13>
In-Reply-To: <20230324114911.19e00ae1@xps-13>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Fri, 24 Mar 2023 12:21:11 +0100
Message-ID: <CAKR-sGc3R_k_+-hzv5DOOeRO-5rHL1k_dq7mpZLcv=FgZ1Moug@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new binding
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, masonccyang@mxic.com.tw,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El vie, 24 mar 2023 a las 11:49, Miquel Raynal
(<miquel.raynal@bootlin.com>) escribi=C3=B3:
>
> Hi =C3=81lvaro,
>
> noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:
>
> > Hi Miqu=C3=A8l,
> >
> > El vie, 24 mar 2023 a las 10:40, Miquel Raynal
> > (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> > >
> > > Hi =C3=81lvaro,
> > >
> > > noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
> > >
> > > > Add new "mxic,disable-block-protection" binding documentation.
> > > > This binding allows disabling block protection support for those de=
vices not
> > > > supporting it.
> > > >
> > > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.tx=
t b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > > > index ffab28a2c4d1..03f65ca32cd3 100644
> > > > --- a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > > > +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > > > @@ -16,6 +16,9 @@ in children nodes.
> > > >  Required NAND chip properties in children mode:
> > > >  - randomizer enable: should be "mxic,enable-randomizer-otp"
> > > >
> > > > +Optional NAND chip properties in children mode:
> > > > +- block protection disable: should be "mxic,disable-block-protecti=
on"
> > > > +
> > >
> > > Besides the fact that nowadays we prefer to see binding conversions t=
o
> > > yaml before adding anything, I don't think this will fly.
> > >
> > > I'm not sure exactly what "disable block protection" means, we
> > > already have similar properties like "lock" and "secure-regions", not
> > > sure they will fit but I think it's worth checking.
> >
> > As explained in 2/2, commit 03a539c7a118 introduced a regression on
> > Sercomm H500-s (BCM63268) OpenWrt devices with Macronix MX30LF1G18AC
> > which hangs the device.
> >
> > This is the log with block protection disabled:
> > [    0.495831] bcm6368_nand 10000200.nand: there is not valid maps for
> > state default
> > [    0.504995] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> > [    0.511526] nand: Macronix MX30LF1G18AC
> > [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
> > 2048, OOB size: 64
> > [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB total,
> > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > [    0.535912] Bad block table found at page 65472, version 0x01
> > [    0.544268] Bad block table found at page 65408, version 0x01
> > [    0.954329] 9 fixed-partitions partitions found on MTD device brcmna=
nd.0
> > ...
> >
> > This is the log with block protection enabled:
> > [    0.495095] bcm6368_nand 10000200.nand: there is not valid maps for
> > state default
> > [    0.504249] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> > [    0.510772] nand: Macronix MX30LF1G18AC
> > [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
> > 2048, OOB size: 64
> > [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB total,
> > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > [    0.539687] Bad block table not found for chip 0
> > [    0.550153] Bad block table not found for chip 0
> > [    0.555069] Scanning device for bad blocks
> > [    0.601213] CPU 1 Unable to handle kernel paging request at virtual
> > address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
> > *** Device hangs ***
> >
> > Enabling macronix_nand_block_protection_support() makes the device
> > unable to detect the bad block table and hangs it when trying to scan
> > for bad blocks.
>
> Please trace nand_macronix.c and look:
> - are the get_features and set_features really supported by the
>   controller driver?

This is what I could find by debugging:
[    0.494993] bcm6368_nand 10000200.nand: there is not valid maps for
state default
[    0.505375] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
[    0.512077] nand: Macronix MX30LF1G18AC
[    0.515994] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    0.523928] bcm6368_nand 10000200.nand: detected 128MiB total,
128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
[    0.534415] bcm6368_nand 10000200.nand: ll_op cmd 0xa00ee
[    0.539988] bcm6368_nand 10000200.nand: ll_op cmd 0x600a0
[    0.545659] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
[    0.551214] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x00
[    0.557843] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
[    0.563475] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x00
[    0.569998] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
[    0.575653] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x00
[    0.582246] bcm6368_nand 10000200.nand: ll_op cmd 0x80010000
[    0.588067] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x00
[    0.594657] nand: nand_get_features: addr=3Da0 subfeature_param=3D[00
00 00 00] -> 0
[    0.602341] macronix_nand_block_protection_support:
ONFI_FEATURE_ADDR_MXIC_PROTECTION=3D0
[    0.610548] macronix_nand_block_protection_support: !=3D
MXIC_BLOCK_PROTECTION_ALL_LOCK
[    0.624760] Bad block table not found for chip 0
[    0.635542] Bad block table not found for chip 0
[    0.640270] Scanning device for bad blocks

I don't know how to tell if get_features / set_features is really supported=
...

> - what is the state of the locking configuration in the chip when you
>   boot?

Unlocked, I guess...
How can I check that?

> - is there anything that locks the device by calling mxic_nand_lock() ?
> - finding no bbt is one thing, hanging is another, where is it hanging
>   exactly? (offset in nand/ and line in the code)

I've got no idea...

>
> >
> > >
> > > Otherwise, why would you disable the block protection? What does it
> > > mean exactly? I'm not in favor of a Macronix-specific property here.
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > --
> > =C3=81lvaro
>
>
> Thanks,
> Miqu=C3=A8l
