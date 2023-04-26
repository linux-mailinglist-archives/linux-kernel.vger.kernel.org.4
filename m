Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965636EEF48
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjDZHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbjDZHYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:24:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F3C2;
        Wed, 26 Apr 2023 00:24:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b73203e0aso41013680b3a.1;
        Wed, 26 Apr 2023 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682493876; x=1685085876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jytQvq7PwiJ5804Vo6WZEBrB2tNyybWr76L9KgVVYI8=;
        b=dXkt/Vghtssd+Yhu5uO3DuoAJBc/EQjfntlttjP5fNKJ1sKh8+/4RxarX/wwOhe6n9
         y8/fEtXiOLAi83aOWUjktYFyKq5HLkmUYW6glx37wF+gnJf6hm0N6IkvRsyzb+iNodQx
         pJNomD7kWbGM5MxqynjrLRmSksiY+e7C+OPp3erDxdDbDRtID6uQMycOwe73T9c8cVcP
         ghGZZg4YqjYGJTyvAABxvtuG5F9GXq6UDhrM/le71N/XqT8n4bs78w9RC+nQLLmQSeos
         RUhUBUVqPGdrfQd6GWJxsQt5gtaZoMBslF6jiJBHyF/Cts1btnVG51jTZMDmDroyJY/o
         9kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682493876; x=1685085876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jytQvq7PwiJ5804Vo6WZEBrB2tNyybWr76L9KgVVYI8=;
        b=jzgGrx+5wvUZIvMSaxzYYftTZg9OlP0Q0Mu7V8EfEYO98syzBA/n8MM9XWdLk58rhW
         aKHM6Nj4cC00snuEticATAXzZ1hTpQUDJ0rz3RwZcjOrNUIcp1IU19wOeSXiauauQjK7
         jDh00z5I1GbGjZU7fr+fFR+KaCHC8gpaj6U4eNuKl7KeFSbwP86LKCBiv5V9b3K2x2KO
         stGXn6bHRClVOxMxDpLaDXjc/MxuVEGnA1ZIaD0343fDiD4O3gNltn2XSmPgZVyoeFvN
         e7DTY2S8+vtWvhwtL6Pwq3rJgVT4CDJBOobwwJLD482rEiAWOcZ350ziNW5D8zP8O95n
         q/2g==
X-Gm-Message-State: AC+VfDxS4VyGsBdY0UPko5K7IdVhlYCaScKD6w/0LZcacByPdvhO+XXx
        1EHq2DPKPOiYEUl/iPT3M3eJnbgeLNQEbRucn9E=
X-Google-Smtp-Source: ACHHUZ4aSknLigFC1I8mL48sQqjw/Q8Xr2z5x5zoRf84sqXupYXCLRaiqjENzZgEfM+8Uq9m5qvm0Pz2/YyXqdKwX08=
X-Received: by 2002:a17:90b:60f:b0:249:67dd:5783 with SMTP id
 gb15-20020a17090b060f00b0024967dd5783mr1909237pjb.18.1682493876517; Wed, 26
 Apr 2023 00:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQoYRm3766SG7+VuwVzu_xH8aWihoKWMEp8xQGNgJ6oOtC9+g@mail.gmail.com>
In-Reply-To: <CAAQoYRm3766SG7+VuwVzu_xH8aWihoKWMEp8xQGNgJ6oOtC9+g@mail.gmail.com>
From:   liao jaime <jaimeliao.tw@gmail.com>
Date:   Wed, 26 Apr 2023 15:24:25 +0800
Message-ID: <CAAQoYRmXdMp7b2r+yCRUtGrbfQH-Cb8gMAVo7YscuQEM5kgajw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new binding
To:     Miquel Raynal <miquel.raynal@bootlin.com>, noltari@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi =C3=81lvaro

In nand_scan_tail(), each manufacturer init function call will be execute.
In macronix_nand_init(), block protect will be execute after flash detect.
I have validate MX30LF1G18AC in Linux kernel v5.15.
I didn't got situation "device hangs"  on my side.
BP is to prevent incorrect operations.
Please check the controller settings for tracing this issue.

Thanks
Jaime

>
> Hello YouChing and Jaime,
>
> I still didn't get any feedback from you (or Macronix) on this issue.
> Did you have time to look into it?
>
> Thanks,
> =C3=81lvaro.
>
> El vie, 24 mar 2023 a las 18:04, =C3=81lvaro Fern=C3=A1ndez Rojas
> (<noltari@gmail.com>) escribi=C3=B3:
> >
> > Hi Miqu=C3=A8l,
> >
> > 2023-03-24 15:36 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com>:
> > > Hi =C3=81lvaro,
> > >
> > > + YouChing and Jaime from Macronix
> > > TLDR for them: there is a misbehavior since Mason added block
> > > protection support. Just checking if the blocks are protected seems t=
o
> > > misconfigure the chip entirely, see below. Any hints?
> >
> > Could it be that the NAND is stuck expecting a read 0x00 command which
> > isn=E2=80=99t sent after getting the features?
> >
> > >
> > > noltari@gmail.com wrote on Fri, 24 Mar 2023 15:15:47 +0100:
> > >
> > >> Hi Miqu=C3=A8l,
> > >>
> > >> 2023-03-24 14:45 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com=
>:
> > >> > Hi =C3=81lvaro,
> > >> >
> > >> > noltari@gmail.com wrote on Fri, 24 Mar 2023 12:21:11 +0100:
> > >> >
> > >> >> El vie, 24 mar 2023 a las 11:49, Miquel Raynal
> > >> >> (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> > >> >> >
> > >> >> > Hi =C3=81lvaro,
> > >> >> >
> > >> >> > noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:
> > >> >> >
> > >> >> > > Hi Miqu=C3=A8l,
> > >> >> > >
> > >> >> > > El vie, 24 mar 2023 a las 10:40, Miquel Raynal
> > >> >> > > (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> > >> >> > > >
> > >> >> > > > Hi =C3=81lvaro,
> > >> >> > > >
> > >> >> > > > noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
> > >> >> > > >
> > >> >> > > > > Add new "mxic,disable-block-protection" binding documenta=
tion.
> > >> >> > > > > This binding allows disabling block protection support fo=
r
> > >> >> > > > > those
> > >> >> > > > > devices not
> > >> >> > > > > supporting it.
> > >> >> > > > >
> > >> >> > > > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@=
gmail.com>
> > >> >> > > > > ---
> > >> >> > > > >  Documentation/devicetree/bindings/mtd/nand-macronix.txt =
| 3
> > >> >> > > > > +++
> > >> >> > > > >  1 file changed, 3 insertions(+)
> > >> >> > > > >
> > >> >> > > > > diff --git
> > >> >> > > > > a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > >> >> > > > > b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > >> >> > > > > index ffab28a2c4d1..03f65ca32cd3 100644
> > >> >> > > > > --- a/Documentation/devicetree/bindings/mtd/nand-macronix=
.txt
> > >> >> > > > > +++ b/Documentation/devicetree/bindings/mtd/nand-macronix=
.txt
> > >> >> > > > > @@ -16,6 +16,9 @@ in children nodes.
> > >> >> > > > >  Required NAND chip properties in children mode:
> > >> >> > > > >  - randomizer enable: should be "mxic,enable-randomizer-o=
tp"
> > >> >> > > > >
> > >> >> > > > > +Optional NAND chip properties in children mode:
> > >> >> > > > > +- block protection disable: should be
> > >> >> > > > > "mxic,disable-block-protection"
> > >> >> > > > > +
> > >> >> > > >
> > >> >> > > > Besides the fact that nowadays we prefer to see binding
> > >> >> > > > conversions
> > >> >> > > > to
> > >> >> > > > yaml before adding anything, I don't think this will fly.
> > >> >> > > >
> > >> >> > > > I'm not sure exactly what "disable block protection" means,=
 we
> > >> >> > > > already have similar properties like "lock" and
> > >> >> > > > "secure-regions",
> > >> >> > > > not
> > >> >> > > > sure they will fit but I think it's worth checking.
> > >> >> > >
> > >> >> > > As explained in 2/2, commit 03a539c7a118 introduced a regress=
ion
> > >> >> > > on
> > >> >> > > Sercomm H500-s (BCM63268) OpenWrt devices with Macronix
> > >> >> > > MX30LF1G18AC
> > >> >> > > which hangs the device.
> > >> >> > >
> > >> >> > > This is the log with block protection disabled:
> > >> >> > > [    0.495831] bcm6368_nand 10000200.nand: there is not valid=
 maps
> > >> >> > > for
> > >> >> > > state default
> > >> >> > > [    0.504995] nand: device found, Manufacturer ID: 0xc2, Chi=
p ID:
> > >> >> > > 0xf1
> > >> >> > > [    0.511526] nand: Macronix MX30LF1G18AC
> > >> >> > > [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page =
size:
> > >> >> > > 2048, OOB size: 64
> > >> >> > > [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB to=
tal,
> > >> >> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > >> >> > > [    0.535912] Bad block table found at page 65472, version 0=
x01
> > >> >> > > [    0.544268] Bad block table found at page 65408, version 0=
x01
> > >> >> > > [    0.954329] 9 fixed-partitions partitions found on MTD dev=
ice
> > >> >> > > brcmnand.0
> > >> >> > > ...
> > >> >> > >
> > >> >> > > This is the log with block protection enabled:
> > >> >> > > [    0.495095] bcm6368_nand 10000200.nand: there is not valid=
 maps
> > >> >> > > for
> > >> >> > > state default
> > >> >> > > [    0.504249] nand: device found, Manufacturer ID: 0xc2, Chi=
p ID:
> > >> >> > > 0xf1
> > >> >> > > [    0.510772] nand: Macronix MX30LF1G18AC
> > >> >> > > [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page =
size:
> > >> >> > > 2048, OOB size: 64
> > >> >> > > [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB to=
tal,
> > >> >> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > >> >> > > [    0.539687] Bad block table not found for chip 0
> > >> >> > > [    0.550153] Bad block table not found for chip 0
> > >> >> > > [    0.555069] Scanning device for bad blocks
> > >> >> > > [    0.601213] CPU 1 Unable to handle kernel paging request a=
t
> > >> >> > > virtual
> > >> >> > > address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
> > >> >> > > *** Device hangs ***
> > >> >> > >
> > >> >> > > Enabling macronix_nand_block_protection_support() makes the d=
evice
> > >> >> > > unable to detect the bad block table and hangs it when trying=
 to
> > >> >> > > scan
> > >> >> > > for bad blocks.
> > >> >> >
> > >> >> > Please trace nand_macronix.c and look:
> > >> >> > - are the get_features and set_features really supported by the
> > >> >> >   controller driver?
> > >> >>
> > >> >> This is what I could find by debugging:
> > >> >> [    0.494993] bcm6368_nand 10000200.nand: there is not valid map=
s for
> > >> >> state default
> > >> >> [    0.505375] nand: device found, Manufacturer ID: 0xc2, Chip ID=
:
> > >> >> 0xf1
> > >> >> [    0.512077] nand: Macronix MX30LF1G18AC
> > >> >> [    0.515994] nand: 128 MiB, SLC, erase size: 128 KiB, page size=
:
> > >> >> 2048, OOB size: 64
> > >> >> [    0.523928] bcm6368_nand 10000200.nand: detected 128MiB total,
> > >> >> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > >> >> [    0.534415] bcm6368_nand 10000200.nand: ll_op cmd 0xa00ee
> > >> >> [    0.539988] bcm6368_nand 10000200.nand: ll_op cmd 0x600a0
> > >> >> [    0.545659] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> > >> >> [    0.551214] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> > >> >> 0x00
> > >> >> [    0.557843] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> > >> >> [    0.563475] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> > >> >> 0x00
> > >> >> [    0.569998] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> > >> >> [    0.575653] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> > >> >> 0x00
> > >> >> [    0.582246] bcm6368_nand 10000200.nand: ll_op cmd 0x80010000
> > >> >> [    0.588067] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =
=3D
> > >> >> 0x00
> > >> >> [    0.594657] nand: nand_get_features: addr=3Da0 subfeature_para=
m=3D[00
> > >> >> 00 00 00] -> 0
> > >> >> [    0.602341] macronix_nand_block_protection_support:
> > >> >> ONFI_FEATURE_ADDR_MXIC_PROTECTION=3D0
> > >> >> [    0.610548] macronix_nand_block_protection_support: !=3D
> > >> >> MXIC_BLOCK_PROTECTION_ALL_LOCK
> > >> >> [    0.624760] Bad block table not found for chip 0
> > >> >> [    0.635542] Bad block table not found for chip 0
> > >> >> [    0.640270] Scanning device for bad blocks
> > >> >>
> > >> >> I don't know how to tell if get_features / set_features is really
> > >> >> supported...
> > >> >
> > >> > Looks like your driver does not support exec_op but the core provi=
des a
> > >> > get/set_feature implementation.
> > >>
> > >> According to Florian, low level should be supported on brcmnand
> > >> controllers >=3D 4.0
> > >> Also:
> > >> https://github.com/nomis/bcm963xx_4.12L.06B_consumer/blob/e2f23ddbb2=
0bf75689372b6e6a5a0dc613f6e313/shared/opensource/include/bcm963xx/63268_map=
_part.h#L1597
> > >
> > > Just to be sure, you're using a mainline controller driver, not this
> > > one?
> >
> > Yes, this was just to prove that the HW I=E2=80=99m using has get/set f=
eatures support.
> > I=E2=80=99m using OpenWrt, so it=E2=80=99s linux v5.15 driver.
> >
> > >
> > >> >
> > >> >>
> > >> >> > - what is the state of the locking configuration in the chip wh=
en
> > >> >> > you
> > >> >> >   boot?
> > >> >>
> > >> >> Unlocked, I guess...
> > >> >> How can I check that?
> > >> >
> > >> > It's in your dump, the chip returns 0, meaning it's all unlocked,
> > >> > apparently.
> > >>
> > >> Well, I can read/write the device if block protection isn=E2=80=99t =
disabled,
> > >> so I guess we can confirm it=E2=80=99s unlocked=E2=80=A6
> > >>
> > >> >
> > >> >> > - is there anything that locks the device by calling mxic_nand_=
lock()
> > >> >> > ?
> > >> >
> > >> > So nobody locks the device I guess? Did you add traces there?
> > >>
> > >> It doesn=E2=80=99t get to the point that it enabled the lock/unlock =
functions
> > >> since it fails when checking if feature is 0x38, so there=E2=80=99s =
no point
> > >> in adding those traces=E2=80=A6
> > >
> > > Right, it returns before setting these I guess.
> > >
> > >>
> > >> >
> > >> >> > - finding no bbt is one thing, hanging is another, where is it
> > >> >> > hanging
> > >> >> >   exactly? (offset in nand/ and line in the code)
> > >> >>
> > >> >> I've got no idea...
> > >> >
> > >> > You can use ftrace or just add printks a bit everywhere and try to=
 get
> > >> > closer and closer.
> > >>
> > >> I think that after trying to get the feature it just start reading
> > >> nonsense from the NAND and at some point it hangs due to that garbag=
e=E2=80=A6
> > >
> > > It should refuse to mount the device somehow, but in no case the kern=
el
> > > should hang.
> >
> > Yes, I think that this is a side effect (maybe a different bug somewher=
e else).
> >
> > >
> > >> Is it posible that the NAND starts behaving like this after getting
> > >> the feature due to some specific config of my device?
> > >>
> > >> >
> > >> > I looked at the patch, I don't see anything strange. Besides, I ha=
ve a
> > >> > close enough datasheet and I don't see what could confuse the devi=
ce.
> > >> >
> > >> > Are you really sure this patch is the problem? Is the WP pin wired=
 on
> > >> > your design?
> > >>
> > >> There=E2=80=99s no WP pin in brcmnand controllers < 7.0
> > >
> > > What about the chip?
> >
> > Maybe it has a GPIO controlling that, but I don=E2=80=99t have that inf=
o=E2=80=A6
> >
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> > >
