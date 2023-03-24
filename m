Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A06C7FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCXOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:15:50 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48081CF7D;
        Fri, 24 Mar 2023 07:15:48 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-544f7c176easo35062857b3.9;
        Fri, 24 Mar 2023 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679667348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySioxTXfVeiUuAu7gfa+m5Ra1WVUaOvrDeGg4ldVbfI=;
        b=TYcg4XAKbVKi5wCyMd+7RflmoSwDkgDM6dTquxdNbVdR23qGjWBsOY/C0JVvlYJSNT
         +2EfVTemoe03Q4R6tcfhebkwUf8S4fjnmNP3yBlwO/FLrvxw4rnfWp6UDR2qxHfuRy1p
         LZSGVPcL1Agtj39KnTOgGQNtciy1s3v55MfUeFtSEkyNj++5srl5jEhzVwuSKCGmm+qX
         O/NKvEX4e5UPchjcw6F8ds1ECGKwwiJ4k2w6HOrPwtu+PEpWmhs+nv+siFmwzNptgREZ
         BL/Gw8o/07xXSbg2HwiTG+tLpD5ouUbM76hYdqu7gTTgAM0uIG7Fi5W58tASoETB3sv5
         o6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679667348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySioxTXfVeiUuAu7gfa+m5Ra1WVUaOvrDeGg4ldVbfI=;
        b=0wQNa+xzDbyqbxgwGnv71D0g4fvAprr2D2Y4mQQPFNs5Avf5/2d/DWx+lE1Mt+Ldi0
         /8QPoEebcKtTcO0SIavUYUZTxeMoC2r6rBnkbBoWaPnasCx86ShD6DDUx+n/RxrZVamg
         YXO3hcf9gsOd3p2ePZmp+biy+V2ij4zBT6wGLb1GLwgNuHfm77l9O2sRtSiwJYyCf7OD
         SFglOfo6gzUTFlfclBCZ0MdcFkrYh4Ad0qqzNJctzuq+Kj1UXpIyNMuCI9+D/pYOrGsq
         fb+nvlBIRrLpBYjb2vUGXi/wHJuFBt+QoczlAeOlErDWI9wHytmOzxeKh/TqZY9QQAbX
         sVVg==
X-Gm-Message-State: AAQBX9frxw/YMNNVZFx7GVw50m284EvGoiAy1pTmFdymoVLdfWlqwf5V
        DxzfQneaCxmqY9o3nPw6D5rtqSk6G+EVxCKQbAg=
X-Google-Smtp-Source: AKy350b2seUzPyEbZcYj+6GmFkydtsJW7YmxflUG2HreBCD6E6I0fvaXhiVQ6oU0JBg/wlhUy93KyPTmxQ4CVXMKt2s=
X-Received: by 2002:a05:690c:72e:b0:541:6763:3ce1 with SMTP id
 bt14-20020a05690c072e00b0054167633ce1mr1077614ywb.2.1679667347742; Fri, 24
 Mar 2023 07:15:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:ba8c:b0:490:be1c:c35a with HTTP; Fri, 24 Mar 2023
 07:15:47 -0700 (PDT)
In-Reply-To: <20230324144559.3473c537@xps-13>
References: <20230323124510.2484808-1-noltari@gmail.com> <20230323124510.2484808-2-noltari@gmail.com>
 <20230324104020.54754079@xps-13> <CAKR-sGcbRRjqt3raXHcvfCfKFDfFWsuu+C7XW3qFckawMsqe4w@mail.gmail.com>
 <20230324114911.19e00ae1@xps-13> <CAKR-sGc3R_k_+-hzv5DOOeRO-5rHL1k_dq7mpZLcv=FgZ1Moug@mail.gmail.com>
 <20230324144559.3473c537@xps-13>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Fri, 24 Mar 2023 15:15:47 +0100
Message-ID: <CAKR-sGdxFbMZYGcDnWHW9SU=6hchZMi75=BjGtDen_Ws1keORg@mail.gmail.com>
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

Hi Miqu=C3=A8l,

2023-03-24 14:45 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.com>:
> Hi =C3=81lvaro,
>
> noltari@gmail.com wrote on Fri, 24 Mar 2023 12:21:11 +0100:
>
>> El vie, 24 mar 2023 a las 11:49, Miquel Raynal
>> (<miquel.raynal@bootlin.com>) escribi=C3=B3:
>> >
>> > Hi =C3=81lvaro,
>> >
>> > noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:
>> >
>> > > Hi Miqu=C3=A8l,
>> > >
>> > > El vie, 24 mar 2023 a las 10:40, Miquel Raynal
>> > > (<miquel.raynal@bootlin.com>) escribi=C3=B3:
>> > > >
>> > > > Hi =C3=81lvaro,
>> > > >
>> > > > noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
>> > > >
>> > > > > Add new "mxic,disable-block-protection" binding documentation.
>> > > > > This binding allows disabling block protection support for those
>> > > > > devices not
>> > > > > supporting it.
>> > > > >
>> > > > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.c=
om>
>> > > > > ---
>> > > > >  Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3 +++
>> > > > >  1 file changed, 3 insertions(+)
>> > > > >
>> > > > > diff --git
>> > > > > a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>> > > > > b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>> > > > > index ffab28a2c4d1..03f65ca32cd3 100644
>> > > > > --- a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>> > > > > +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
>> > > > > @@ -16,6 +16,9 @@ in children nodes.
>> > > > >  Required NAND chip properties in children mode:
>> > > > >  - randomizer enable: should be "mxic,enable-randomizer-otp"
>> > > > >
>> > > > > +Optional NAND chip properties in children mode:
>> > > > > +- block protection disable: should be
>> > > > > "mxic,disable-block-protection"
>> > > > > +
>> > > >
>> > > > Besides the fact that nowadays we prefer to see binding conversion=
s
>> > > > to
>> > > > yaml before adding anything, I don't think this will fly.
>> > > >
>> > > > I'm not sure exactly what "disable block protection" means, we
>> > > > already have similar properties like "lock" and "secure-regions",
>> > > > not
>> > > > sure they will fit but I think it's worth checking.
>> > >
>> > > As explained in 2/2, commit 03a539c7a118 introduced a regression on
>> > > Sercomm H500-s (BCM63268) OpenWrt devices with Macronix MX30LF1G18AC
>> > > which hangs the device.
>> > >
>> > > This is the log with block protection disabled:
>> > > [    0.495831] bcm6368_nand 10000200.nand: there is not valid maps
>> > > for
>> > > state default
>> > > [    0.504995] nand: device found, Manufacturer ID: 0xc2, Chip ID:
>> > > 0xf1
>> > > [    0.511526] nand: Macronix MX30LF1G18AC
>> > > [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
>> > > 2048, OOB size: 64
>> > > [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB total,
>> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
>> > > [    0.535912] Bad block table found at page 65472, version 0x01
>> > > [    0.544268] Bad block table found at page 65408, version 0x01
>> > > [    0.954329] 9 fixed-partitions partitions found on MTD device
>> > > brcmnand.0
>> > > ...
>> > >
>> > > This is the log with block protection enabled:
>> > > [    0.495095] bcm6368_nand 10000200.nand: there is not valid maps
>> > > for
>> > > state default
>> > > [    0.504249] nand: device found, Manufacturer ID: 0xc2, Chip ID:
>> > > 0xf1
>> > > [    0.510772] nand: Macronix MX30LF1G18AC
>> > > [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
>> > > 2048, OOB size: 64
>> > > [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB total,
>> > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
>> > > [    0.539687] Bad block table not found for chip 0
>> > > [    0.550153] Bad block table not found for chip 0
>> > > [    0.555069] Scanning device for bad blocks
>> > > [    0.601213] CPU 1 Unable to handle kernel paging request at
>> > > virtual
>> > > address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
>> > > *** Device hangs ***
>> > >
>> > > Enabling macronix_nand_block_protection_support() makes the device
>> > > unable to detect the bad block table and hangs it when trying to sca=
n
>> > > for bad blocks.
>> >
>> > Please trace nand_macronix.c and look:
>> > - are the get_features and set_features really supported by the
>> >   controller driver?
>>
>> This is what I could find by debugging:
>> [    0.494993] bcm6368_nand 10000200.nand: there is not valid maps for
>> state default
>> [    0.505375] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
>> [    0.512077] nand: Macronix MX30LF1G18AC
>> [    0.515994] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
>> 2048, OOB size: 64
>> [    0.523928] bcm6368_nand 10000200.nand: detected 128MiB total,
>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
>> [    0.534415] bcm6368_nand 10000200.nand: ll_op cmd 0xa00ee
>> [    0.539988] bcm6368_nand 10000200.nand: ll_op cmd 0x600a0
>> [    0.545659] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
>> [    0.551214] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x0=
0
>> [    0.557843] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
>> [    0.563475] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x0=
0
>> [    0.569998] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
>> [    0.575653] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x0=
0
>> [    0.582246] bcm6368_nand 10000200.nand: ll_op cmd 0x80010000
>> [    0.588067] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATURES =3D 0x0=
0
>> [    0.594657] nand: nand_get_features: addr=3Da0 subfeature_param=3D[00
>> 00 00 00] -> 0
>> [    0.602341] macronix_nand_block_protection_support:
>> ONFI_FEATURE_ADDR_MXIC_PROTECTION=3D0
>> [    0.610548] macronix_nand_block_protection_support: !=3D
>> MXIC_BLOCK_PROTECTION_ALL_LOCK
>> [    0.624760] Bad block table not found for chip 0
>> [    0.635542] Bad block table not found for chip 0
>> [    0.640270] Scanning device for bad blocks
>>
>> I don't know how to tell if get_features / set_features is really
>> supported...
>
> Looks like your driver does not support exec_op but the core provides a
> get/set_feature implementation.

According to Florian, low level should be supported on brcmnand
controllers >=3D 4.0
Also:
https://github.com/nomis/bcm963xx_4.12L.06B_consumer/blob/e2f23ddbb20bf7568=
9372b6e6a5a0dc613f6e313/shared/opensource/include/bcm963xx/63268_map_part.h=
#L1597

>
>>
>> > - what is the state of the locking configuration in the chip when you
>> >   boot?
>>
>> Unlocked, I guess...
>> How can I check that?
>
> It's in your dump, the chip returns 0, meaning it's all unlocked,
> apparently.

Well, I can read/write the device if block protection isn=E2=80=99t disable=
d,
so I guess we can confirm it=E2=80=99s unlocked=E2=80=A6

>
>> > - is there anything that locks the device by calling mxic_nand_lock() =
?
>
> So nobody locks the device I guess? Did you add traces there?

It doesn=E2=80=99t get to the point that it enabled the lock/unlock functio=
ns
since it fails when checking if feature is 0x38, so there=E2=80=99s no poin=
t
in adding those traces=E2=80=A6

>
>> > - finding no bbt is one thing, hanging is another, where is it hanging
>> >   exactly? (offset in nand/ and line in the code)
>>
>> I've got no idea...
>
> You can use ftrace or just add printks a bit everywhere and try to get
> closer and closer.

I think that after trying to get the feature it just start reading
nonsense from the NAND and at some point it hangs due to that garbage=E2=80=
=A6
Is it posible that the NAND starts behaving like this after getting
the feature due to some specific config of my device?

>
> I looked at the patch, I don't see anything strange. Besides, I have a
> close enough datasheet and I don't see what could confuse the device.
>
> Are you really sure this patch is the problem? Is the WP pin wired on
> your design?

There=E2=80=99s no WP pin in brcmnand controllers < 7.0

>
> Thanks,
> Miqu=C3=A8l
>

Thanks,
=C3=81lvaro
