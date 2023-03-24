Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C16C7CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCXKb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjCXKbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:31:41 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA2231E1;
        Fri, 24 Mar 2023 03:31:28 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5456249756bso25159877b3.5;
        Fri, 24 Mar 2023 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679653888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8LJ+2gNxDWzsoGiFhmZ/B/FieuTyyGjuau6AfS/ml8=;
        b=oj4xmZQv8SdZ+QXoTWZ34SKWMeCxupNXfejiX3Lt0MOtSlOrvLNncbLNnnicWMpfzW
         opwxxhtbTelWiTBteCkWzskVHcOMlBZmDy2GgtGSyjd3WWfLrnSLWzFf45dyzGVT985F
         D5MvHp3xKPuRloSlE9Jt/mxSi+lBfJJOQZHGdv4eJ0stIOiI0Wo4JVeQPWlgDaK/ycRm
         UARaWcMj+9odpEly9N/vjqgLgfp2J7bp7tjrvj8wLVGUglRJZMKCmn2WrIl+sW0fkZBj
         DMJS6rPbmgxiOjpB9tfroqNrhRqLS1KCsoTCX0nCMn87RnMHQ4BX+FHbNOhepJwSl+7s
         t4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8LJ+2gNxDWzsoGiFhmZ/B/FieuTyyGjuau6AfS/ml8=;
        b=pwAAAJ79slixTzc3qnzGUyC7s8xc+Ph5dIb5BFh6DWsTGpDbGNPIRUhf0AE7+JL5LZ
         CgYqva8gqR7oSGQ4P+wMt6WEol0GBO5IjSEUGNjuUv8ubddVKp1iL98GEyIpCQSJ62QJ
         q52yUtgQJ33JEeVG0ioGLzE46xEhEiKqF04Sz0+ZCEBxhnYLnictjGsJsiHNeOuOTDWQ
         NBH0CPbnrCKFY7D5yfF2zZukUh4UZBWskRYUKHNUe41Ia3Ul1C7VkY/rd37cWrkv+VjL
         VV/AXiEYw92zsUKBkeIvJBDR3fJnkE9G1xboRgkFgghWI2OUpNOUlJwM9U1V2I66nuRX
         hDew==
X-Gm-Message-State: AAQBX9dV9vZfQ0yWoLpiFQX34dYpmVZB9CbMjuF3gTF5qS+mkNZm/vIX
        xR/+bv+XEDS4MyzRCF/IqFQADMCW+wATYHC6fyE=
X-Google-Smtp-Source: AKy350YCwRIztWFByFXdBbQ4j7qQpWwm9DOJaxzeYjSi7RZPTo610GlaH1m9RBJrbiYZ/O/ilFrAh5cp9ZufQUGaVow=
X-Received: by 2002:a81:ac67:0:b0:541:9063:8e9e with SMTP id
 z39-20020a81ac67000000b0054190638e9emr790386ywj.2.1679653888027; Fri, 24 Mar
 2023 03:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230323124510.2484808-1-noltari@gmail.com> <20230323124510.2484808-2-noltari@gmail.com>
 <20230324104020.54754079@xps-13>
In-Reply-To: <20230324104020.54754079@xps-13>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Fri, 24 Mar 2023 11:31:17 +0100
Message-ID: <CAKR-sGcbRRjqt3raXHcvfCfKFDfFWsuu+C7XW3qFckawMsqe4w@mail.gmail.com>
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

El vie, 24 mar 2023 a las 10:40, Miquel Raynal
(<miquel.raynal@bootlin.com>) escribi=C3=B3:
>
> Hi =C3=81lvaro,
>
> noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
>
> > Add new "mxic,disable-block-protection" binding documentation.
> > This binding allows disabling block protection support for those device=
s not
> > supporting it.
> >
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt b/=
Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > index ffab28a2c4d1..03f65ca32cd3 100644
> > --- a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > @@ -16,6 +16,9 @@ in children nodes.
> >  Required NAND chip properties in children mode:
> >  - randomizer enable: should be "mxic,enable-randomizer-otp"
> >
> > +Optional NAND chip properties in children mode:
> > +- block protection disable: should be "mxic,disable-block-protection"
> > +
>
> Besides the fact that nowadays we prefer to see binding conversions to
> yaml before adding anything, I don't think this will fly.
>
> I'm not sure exactly what "disable block protection" means, we
> already have similar properties like "lock" and "secure-regions", not
> sure they will fit but I think it's worth checking.

As explained in 2/2, commit 03a539c7a118 introduced a regression on
Sercomm H500-s (BCM63268) OpenWrt devices with Macronix MX30LF1G18AC
which hangs the device.

This is the log with block protection disabled:
[    0.495831] bcm6368_nand 10000200.nand: there is not valid maps for
state default
[    0.504995] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
[    0.511526] nand: Macronix MX30LF1G18AC
[    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    0.523516] bcm6368_nand 10000200.nand: detected 128MiB total,
128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
[    0.535912] Bad block table found at page 65472, version 0x01
[    0.544268] Bad block table found at page 65408, version 0x01
[    0.954329] 9 fixed-partitions partitions found on MTD device brcmnand.0
...

This is the log with block protection enabled:
[    0.495095] bcm6368_nand 10000200.nand: there is not valid maps for
state default
[    0.504249] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
[    0.510772] nand: Macronix MX30LF1G18AC
[    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    0.522780] bcm6368_nand 10000200.nand: detected 128MiB total,
128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
[    0.539687] Bad block table not found for chip 0
[    0.550153] Bad block table not found for chip 0
[    0.555069] Scanning device for bad blocks
[    0.601213] CPU 1 Unable to handle kernel paging request at virtual
address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
*** Device hangs ***

Enabling macronix_nand_block_protection_support() makes the device
unable to detect the bad block table and hangs it when trying to scan
for bad blocks.

>
> Otherwise, why would you disable the block protection? What does it
> mean exactly? I'm not in favor of a Macronix-specific property here.
>
> Thanks,
> Miqu=C3=A8l

--
=C3=81lvaro
