Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159176FE5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjEJVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjEJVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:03:09 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED911E5D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:03:06 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4E246CB671
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:55:23 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7CA491C0007;
        Wed, 10 May 2023 20:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683752042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmQCtxST+exa6SSBpml6OW3Btx1Cfsjd48HbCNm2+V4=;
        b=oMbduGZOJaO60CrrGnZd2qWJpEeKrdfvEJnYftup7CnEMeL0yJwnE9SCzQscq6zGq8JRlL
        8FpjeM3BjB8kXtuind6T6pXq3BYAntOsCfVabbjyYi1PF1+RjQ6Xzn+RxQhjWz5PJK8mnu
        6Ed9Rgn8hFr5Of1C55jkXbUMXTCdSkSwLhr9exNDr6A/VTXaa3qMU2wl6GoY000zQIARyq
        vjRPInrJphwZFaqXGt6ebiiXaZqccH9eNRI60QUdSSMfGcEafuaKo1ZYBqyO3ZO7N5/ORF
        +7ImQWA/1vPBvXsZei+BVlHCeLfJzdWI7nCR5T8Vv0r/XaznMJs0kLyqSCDPmQ==
Date:   Wed, 10 May 2023 22:53:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] mtd: rawnand: meson: rename node for chip select
Message-ID: <20230510225359.061c2df6@xps-13>
In-Reply-To: <CAFBinCAbTuNGEG13f71F8vhN3yGce+kkYJ7PHMpZbh8DzSapJg@mail.gmail.com>
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
        <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
        <CAFBinCAbTuNGEG13f71F8vhN3yGce+kkYJ7PHMpZbh8DzSapJg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin & Arseniy,

martin.blumenstingl@googlemail.com wrote on Wed, 10 May 2023 22:40:37
+0200:

> Hello Arseniy,
>=20
> On Wed, May 10, 2023 at 1:13=E2=80=AFPM Arseniy Krasnov
> <AVKrasnov@sberdevices.ru> wrote:
> >
> > This renames node with values for chip select from "reg" to "cs". It is
> > needed because when OTP access is enabled on the attached storage, MTD
> > subsystem registers this storage in the NVMEM subsystem. NVMEM in turn
> > tries to use "reg" node in its own manner, supposes that it has another
> > layout. All of this leads to device initialization failure. =20
> In general: if we change the device-tree interface (in this case:
> replacing a "reg" with a "cs" property) the dt-bindings have to be
> updated as well.

True, and I would add, bindings should not be broken.

> Documentation/devicetree/bindings/mtd/nand-controller.yaml and
> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml show
> that the chip select of a NAND chip is specified with a "reg"
> property.

All NAND controller binding expect the chip-select to be in the
'reg' property, very much like a spi device would use reg to store the
cs as well: the reg property tells you how you address the device.

I also fully agree with Martin's comments below. Changing reg is likely
a wrong approach :)

> Also the code has to be backwards compatible with old .dtbs.
>=20
> > Example:
> >
> > [...] nvmem mtd0-user-otp: nvmem: invalid reg on /soc/bus@ffe00000/...
> > [...] mtd mtd0: Failed to register OTP NVMEM device
> > [...] meson-nand ffe07800.nfc: failed to register MTD device: -22
> > [...] meson-nand ffe07800.nfc: failed to init NAND chips
> > [...] meson-nand: probe of ffe07800.nfc failed with error -22 =20
> This is odd - can you please share your definition of the &nfc node?
>=20
> &nfc {
>       nand_chip0: nand@0 {
>         reg =3D <0>;
>       };
> };
>=20
> This should result in nand_set_flash_node() being called with
> &nand_chip0 (if it's called with &nfc then something is buggy in our
> driver).
> If there's no child nodes within &nand_chip0 then why would the
> MTD-to-NVMEM code think that it has to parse something?
> If you do have child nodes and those are partitions, then make sure
> that the structure is correct (see the extra "partitions" node inside
> which all partitions are nested):
> &nand_chip0 {
>     partitions {
>         compatible =3D "fixed-partitions";
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>=20
>         partition@0 {
>             label =3D "u-boot";
>             reg =3D <0x0000000 0x4000>;
>             read-only;
>         };
>     };
> };
>=20
>=20
> Best regards,,
> Martin


Thanks,
Miqu=C3=A8l
