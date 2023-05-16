Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A079670566F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEPSz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjEPSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:55:54 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF4D83E3;
        Tue, 16 May 2023 11:55:40 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55a14807e4cso249689787b3.1;
        Tue, 16 May 2023 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263339; x=1686855339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zjhKxXZ2gpvpHSpguCPEqJAmKWOCbduBitIzKKEQiU=;
        b=O30FOywTZfkbog0liQGZBCRx+U3VmxOGahGSzjoTlQWmLi0A4z9CQaiUUqUyWWpO9d
         DkovN5OC88Lo4lJ57fd9+xtllYJl1+8nPm+GUN91fhLAjeKuycV0C7JRcJyQ86gfRRmg
         gW9mTKWaIR0vQc2wi3rfrmG7efUgNIEy/ihXAhAU7GV5He6M42iSHW4cPcQbQflGvsQh
         bRc0gOvzeHNRItOrsPozm9A0Ga8mCVat6dQUeZFFv2+ojcdJqb631MB+bPAZTg5EF7sM
         IMYRxLC8+oPaptNKAUnIjhJDT0OAfMhUwGU3H4HCdtYwhOySql2zGowxMXq6HVJ4EQH1
         xhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263339; x=1686855339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zjhKxXZ2gpvpHSpguCPEqJAmKWOCbduBitIzKKEQiU=;
        b=lEmEzaYJanVm14TdiWFgnOCXeOhfQcSJZRDlC59vzErQzTxyBTr1DwUidCtkmOkha1
         +8pMMAezH8JkBUVAdsXSKZdTNmj+93PgIg6OdET86KvvFyihDAnzHIyVTOBc33l/db92
         QpLew5vwazURMuyxg6TdN27fSyM/sPChYZZ0cbWsv9cx6cXpXigsgHffCBcNjdDzNMy1
         x8wvM2Qyyteu0HIm6yIcAcQxmyq0ShyaFpvbZ+ngHz0zwpuGeGmgneSPi/FrJVtN+1kv
         hA/6mP5kTbpdQoIzDeuiB+ZlqhH/pcFV7WO0tL61zOz1WpWWgmcJCJfyjk9kd5O008Ca
         hc3Q==
X-Gm-Message-State: AC+VfDyQGR7Y7cnPGh3EAI5hnRZ+zwW4v9dYVStcWFYyF7ajOVxX39se
        bzzkXsZHeh9BWnmGevmEp7dETIbdpynpdvhhiD0=
X-Google-Smtp-Source: ACHHUZ7UduhEioLlYF8Ao9DNhUH22GYELG+g8RTz2z48/XuswuxdY2B1i/TlyfXagmKsE1kCaXPxaYPUNT9E8zO9jgA=
X-Received: by 2002:a0d:ffc1:0:b0:561:3fb7:1333 with SMTP id
 p184-20020a0dffc1000000b005613fb71333mr9294631ywf.43.1684263338914; Tue, 16
 May 2023 11:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQoYRm3766SG7+VuwVzu_xH8aWihoKWMEp8xQGNgJ6oOtC9+g@mail.gmail.com>
 <CAAQoYRmXdMp7b2r+yCRUtGrbfQH-Cb8gMAVo7YscuQEM5kgajw@mail.gmail.com>
In-Reply-To: <CAAQoYRmXdMp7b2r+yCRUtGrbfQH-Cb8gMAVo7YscuQEM5kgajw@mail.gmail.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Tue, 16 May 2023 20:55:28 +0200
Message-ID: <CAKR-sGdiLzZ7iVbLmz1uPwYoUXQZ2qGwmCBAq_-OKXfVT=Pj-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new binding
To:     liao jaime <jaimeliao.tw@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaime,

I've reproduced the issue on a Comtrend VR-3032u (MX30LF1G08AA). After
forcing it to check block protection (it's not supported on that
device), the NAND controller stops reading/writing anything.

@Florian is it possible that low level ops (GET_FEATURES/SET_FEATURES)
aren't supported on BCM63268 NAND controllers and this is causing the
issue?

Best regards,
=C3=81lvaro.

El mi=C3=A9, 26 abr 2023 a las 9:24, liao jaime (<jaimeliao.tw@gmail.com>) =
escribi=C3=B3:
>
> Hi =C3=81lvaro
>
> In nand_scan_tail(), each manufacturer init function call will be execute=
.
> In macronix_nand_init(), block protect will be execute after flash detect=
.
> I have validate MX30LF1G18AC in Linux kernel v5.15.
> I didn't got situation "device hangs"  on my side.
> BP is to prevent incorrect operations.
> Please check the controller settings for tracing this issue.
>
> Thanks
> Jaime
>
> >
> > Hello YouChing and Jaime,
> >
> > I still didn't get any feedback from you (or Macronix) on this issue.
> > Did you have time to look into it?
> >
> > Thanks,
> > =C3=81lvaro.
> >
> > El vie, 24 mar 2023 a las 18:04, =C3=81lvaro Fern=C3=A1ndez Rojas
> > (<noltari@gmail.com>) escribi=C3=B3:
> > >
> > > Hi Miqu=C3=A8l,
> > >
> > > 2023-03-24 15:36 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com>=
:
> > > > Hi =C3=81lvaro,
> > > >
> > > > + YouChing and Jaime from Macronix
> > > > TLDR for them: there is a misbehavior since Mason added block
> > > > protection support. Just checking if the blocks are protected seems=
 to
> > > > misconfigure the chip entirely, see below. Any hints?
> > >
> > > Could it be that the NAND is stuck expecting a read 0x00 command whic=
h
> > > isn=E2=80=99t sent after getting the features?
> > >
> > > >
> > > > noltari@gmail.com wrote on Fri, 24 Mar 2023 15:15:47 +0100:
> > > >
> > > >> Hi Miqu=C3=A8l,
> > > >>
> > > >> 2023-03-24 14:45 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.c=
om>:
> > > >> > Hi =C3=81lvaro,
> > > >> >
> > > >> > noltari@gmail.com wrote on Fri, 24 Mar 2023 12:21:11 +0100:
> > > >> >
> > > >> >> El vie, 24 mar 2023 a las 11:49, Miquel Raynal
> > > >> >> (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> > > >> >> >
> > > >> >> > Hi =C3=81lvaro,
> > > >> >> >
> > > >> >> > noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:
> > > >> >> >
> > > >> >> > > Hi Miqu=C3=A8l,
> > > >> >> > >
> > > >> >> > > El vie, 24 mar 2023 a las 10:40, Miquel Raynal
> > > >> >> > > (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> > > >> >> > > >
> > > >> >> > > > Hi =C3=81lvaro,
> > > >> >> > > >
> > > >> >> > > > noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +010=
0:
> > > >> >> > > >
> > > >> >> > > > > Add new "mxic,disable-block-protection" binding documen=
tation.
> > > >> >> > > > > This binding allows disabling block protection support =
for
> > > >> >> > > > > those
> > > >> >> > > > > devices not
> > > >> >> > > > > supporting it.
> > > >> >> > > > >
> > > >> >> > > > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltar=
i@gmail.com>
> > > >> >> > > > > ---
> > > >> >> > > > >  Documentation/devicetree/bindings/mtd/nand-macronix.tx=
t | 3
> > > >> >> > > > > +++
> > > >> >> > > > >  1 file changed, 3 insertions(+)
> > > >> >> > > > >
> > > >> >> > > > > diff --git
> > > >> >> > > > > a/Documentation/devicetree/bindings/mtd/nand-macronix.t=
xt
> > > >> >> > > > > b/Documentation/devicetree/bindings/mtd/nand-macronix.t=
xt
> > > >> >> > > > > index ffab28a2c4d1..03f65ca32cd3 100644
> > > >> >> > > > > --- a/Documentation/devicetree/bindings/mtd/nand-macron=
ix.txt
> > > >> >> > > > > +++ b/Documentation/devicetree/bindings/mtd/nand-macron=
ix.txt
> > > >> >> > > > > @@ -16,6 +16,9 @@ in children nodes.
> > > >> >> > > > >  Required NAND chip properties in children mode:
> > > >> >> > > > >  - randomizer enable: should be "mxic,enable-randomizer=
-otp"
> > > >> >> > > > >
> > > >> >> > > > > +Optional NAND chip properties in children mode:
> > > >> >> > > > > +- block protection disable: should be
> > > >> >> > > > > "mxic,disable-block-protection"
> > > >> >> > > > > +
> > > >> >> > > >
> > > >> >> > > > Besides the fact that nowadays we prefer to see binding
> > > >> >> > > > conversions
> > > >> >> > > > to
> > > >> >> > > > yaml before adding anything, I don't think this will fly.
> > > >> >> > > >
> > > >> >> > > > I'm not sure exactly what "disable block protection" mean=
s, we
> > > >> >> > > > already have similar properties like "lock" and
> > > >> >> > > > "secure-regions",
> > > >> >> > > > not
> > > >> >> > > > sure they will fit but I think it's worth checking.
> > > >> >> > >
> > > >> >> > > As explained in 2/2, commit 03a539c7a118 introduced a regre=
ssion
> > > >> >> > > on
> > > >> >> > > Sercomm H500-s (BCM63268) OpenWrt devices with Macronix
> > > >> >> > > MX30LF1G18AC
> > > >> >> > > which hangs the device.
> > > >> >> > >
> > > >> >> > > This is the log with block protection disabled:
> > > >> >> > > [    0.495831] bcm6368_nand 10000200.nand: there is not val=
id maps
> > > >> >> > > for
> > > >> >> > > state default
> > > >> >> > > [    0.504995] nand: device found, Manufacturer ID: 0xc2, C=
hip ID:
> > > >> >> > > 0xf1
> > > >> >> > > [    0.511526] nand: Macronix MX30LF1G18AC
> > > >> >> > > [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, pag=
e size:
> > > >> >> > > 2048, OOB size: 64
> > > >> >> > > [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB =
total,
> > > >> >> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > > >> >> > > [    0.535912] Bad block table found at page 65472, version=
 0x01
> > > >> >> > > [    0.544268] Bad block table found at page 65408, version=
 0x01
> > > >> >> > > [    0.954329] 9 fixed-partitions partitions found on MTD d=
evice
> > > >> >> > > brcmnand.0
> > > >> >> > > ...
> > > >> >> > >
> > > >> >> > > This is the log with block protection enabled:
> > > >> >> > > [    0.495095] bcm6368_nand 10000200.nand: there is not val=
id maps
> > > >> >> > > for
> > > >> >> > > state default
> > > >> >> > > [    0.504249] nand: device found, Manufacturer ID: 0xc2, C=
hip ID:
> > > >> >> > > 0xf1
> > > >> >> > > [    0.510772] nand: Macronix MX30LF1G18AC
> > > >> >> > > [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, pag=
e size:
> > > >> >> > > 2048, OOB size: 64
> > > >> >> > > [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB =
total,
> > > >> >> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > > >> >> > > [    0.539687] Bad block table not found for chip 0
> > > >> >> > > [    0.550153] Bad block table not found for chip 0
> > > >> >> > > [    0.555069] Scanning device for bad blocks
> > > >> >> > > [    0.601213] CPU 1 Unable to handle kernel paging request=
 at
> > > >> >> > > virtual
> > > >> >> > > address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
> > > >> >> > > *** Device hangs ***
> > > >> >> > >
> > > >> >> > > Enabling macronix_nand_block_protection_support() makes the=
 device
> > > >> >> > > unable to detect the bad block table and hangs it when tryi=
ng to
> > > >> >> > > scan
> > > >> >> > > for bad blocks.
> > > >> >> >
> > > >> >> > Please trace nand_macronix.c and look:
> > > >> >> > - are the get_features and set_features really supported by t=
he
> > > >> >> >   controller driver?
> > > >> >>
> > > >> >> This is what I could find by debugging:
> > > >> >> [    0.494993] bcm6368_nand 10000200.nand: there is not valid m=
aps for
> > > >> >> state default
> > > >> >> [    0.505375] nand: device found, Manufacturer ID: 0xc2, Chip =
ID:
> > > >> >> 0xf1
> > > >> >> [    0.512077] nand: Macronix MX30LF1G18AC
> > > >> >> [    0.515994] nand: 128 MiB, SLC, erase size: 128 KiB, page si=
ze:
> > > >> >> 2048, OOB size: 64
> > > >> >> [    0.523928] bcm6368_nand 10000200.nand: detected 128MiB tota=
l,
> > > >> >> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > > >> >> [    0.534415] bcm6368_nand 10000200.nand: ll_op cmd 0xa00ee
> > > >> >> [    0.539988] bcm6368_nand 10000200.nand: ll_op cmd 0x600a0
> > > >> >> [    0.545659] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> > > >> >> [    0.551214] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURE=
S =3D
> > > >> >> 0x00
> > > >> >> [    0.557843] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> > > >> >> [    0.563475] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURE=
S =3D
> > > >> >> 0x00
> > > >> >> [    0.569998] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> > > >> >> [    0.575653] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURE=
S =3D
> > > >> >> 0x00
> > > >> >> [    0.582246] bcm6368_nand 10000200.nand: ll_op cmd 0x80010000
> > > >> >> [    0.588067] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURE=
S =3D
> > > >> >> 0x00
> > > >> >> [    0.594657] nand: nand_get_features: addr=3Da0 subfeature_pa=
ram=3D[00
> > > >> >> 00 00 00] -> 0
> > > >> >> [    0.602341] macronix_nand_block_protection_support:
> > > >> >> ONFI_FEATURE_ADDR_MXIC_PROTECTION=3D0
> > > >> >> [    0.610548] macronix_nand_block_protection_support: !=3D
> > > >> >> MXIC_BLOCK_PROTECTION_ALL_LOCK
> > > >> >> [    0.624760] Bad block table not found for chip 0
> > > >> >> [    0.635542] Bad block table not found for chip 0
> > > >> >> [    0.640270] Scanning device for bad blocks
> > > >> >>
> > > >> >> I don't know how to tell if get_features / set_features is real=
ly
> > > >> >> supported...
> > > >> >
> > > >> > Looks like your driver does not support exec_op but the core pro=
vides a
> > > >> > get/set_feature implementation.
> > > >>
> > > >> According to Florian, low level should be supported on brcmnand
> > > >> controllers >=3D 4.0
> > > >> Also:
> > > >> https://github.com/nomis/bcm963xx_4.12L.06B_consumer/blob/e2f23ddb=
b20bf75689372b6e6a5a0dc613f6e313/shared/opensource/include/bcm963xx/63268_m=
ap_part.h#L1597
> > > >
> > > > Just to be sure, you're using a mainline controller driver, not thi=
s
> > > > one?
> > >
> > > Yes, this was just to prove that the HW I=E2=80=99m using has get/set=
 features support.
> > > I=E2=80=99m using OpenWrt, so it=E2=80=99s linux v5.15 driver.
> > >
> > > >
> > > >> >
> > > >> >>
> > > >> >> > - what is the state of the locking configuration in the chip =
when
> > > >> >> > you
> > > >> >> >   boot?
> > > >> >>
> > > >> >> Unlocked, I guess...
> > > >> >> How can I check that?
> > > >> >
> > > >> > It's in your dump, the chip returns 0, meaning it's all unlocked=
,
> > > >> > apparently.
> > > >>
> > > >> Well, I can read/write the device if block protection isn=E2=80=99=
t disabled,
> > > >> so I guess we can confirm it=E2=80=99s unlocked=E2=80=A6
> > > >>
> > > >> >
> > > >> >> > - is there anything that locks the device by calling mxic_nan=
d_lock()
> > > >> >> > ?
> > > >> >
> > > >> > So nobody locks the device I guess? Did you add traces there?
> > > >>
> > > >> It doesn=E2=80=99t get to the point that it enabled the lock/unloc=
k functions
> > > >> since it fails when checking if feature is 0x38, so there=E2=80=99=
s no point
> > > >> in adding those traces=E2=80=A6
> > > >
> > > > Right, it returns before setting these I guess.
> > > >
> > > >>
> > > >> >
> > > >> >> > - finding no bbt is one thing, hanging is another, where is i=
t
> > > >> >> > hanging
> > > >> >> >   exactly? (offset in nand/ and line in the code)
> > > >> >>
> > > >> >> I've got no idea...
> > > >> >
> > > >> > You can use ftrace or just add printks a bit everywhere and try =
to get
> > > >> > closer and closer.
> > > >>
> > > >> I think that after trying to get the feature it just start reading
> > > >> nonsense from the NAND and at some point it hangs due to that garb=
age=E2=80=A6
> > > >
> > > > It should refuse to mount the device somehow, but in no case the ke=
rnel
> > > > should hang.
> > >
> > > Yes, I think that this is a side effect (maybe a different bug somewh=
ere else).
> > >
> > > >
> > > >> Is it posible that the NAND starts behaving like this after gettin=
g
> > > >> the feature due to some specific config of my device?
> > > >>
> > > >> >
> > > >> > I looked at the patch, I don't see anything strange. Besides, I =
have a
> > > >> > close enough datasheet and I don't see what could confuse the de=
vice.
> > > >> >
> > > >> > Are you really sure this patch is the problem? Is the WP pin wir=
ed on
> > > >> > your design?
> > > >>
> > > >> There=E2=80=99s no WP pin in brcmnand controllers < 7.0
> > > >
> > > > What about the chip?
> > >
> > > Maybe it has a GPIO controlling that, but I don=E2=80=99t have that i=
nfo=E2=80=A6
> > >
> > > >
> > > > Thanks,
> > > > Miqu=C3=A8l
> > > >
