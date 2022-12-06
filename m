Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB00643E64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiLFIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiLFIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:20:01 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF11A83E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:18:53 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4387A1BF20F;
        Tue,  6 Dec 2022 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670314732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S85P/+unHj6WfJF7lTAK0jbzKUnO/6gheXWbSSkrvk0=;
        b=JJfK/UI5HAr0Th8hY/ol509drdMRFeEjuQWYe1p1irD4rmMZdn84Z2ua8yt7hR1fF2OTk1
        s5PCfucEqUB16Rqvvc5f6ULY1gBSfsbIIyz6iSdL4Scu5AmcXf1jlmtBhW5wJ50v+LNVoN
        7zBCatR1xaUoa7k/KKBZzlapM6BEUmI9GMpSe7zxlOOrCyiZ2LqCcgRj27upgDRbTX5XoQ
        7G6dncEK2KZB8jyWEj9ivuIEJdozB7D48ilbF1Ap50YHVy15su4y9qWkUGagnixv/ioswJ
        5Zwq2x4XK5Qv0Xa0tNksbyZdHoVWnsHKbcRvoVuajMJxxuIWfZLsEC0gFulT+g==
Date:   Tue, 6 Dec 2022 09:18:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vlim <vlim@gigadevice.com>
Cc:     Michael Walle <michael@walle.cc>,
        Victor Lim <victorswlim@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikhyat.goyal@amd.com" <vikhyat.goyal@amd.com>,
        "amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>,
        "alejandro.carmona@amd.com" <alejandro.carmona@amd.com>
Subject: Re: [PATCH] Linux: SPI: add Gigadevice part #
Message-ID: <20221206091846.02f6396f@xps-13>
In-Reply-To: <TY0PR06MB5658B73E2F22472D0AF48BDBBB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
References: <20221204080000.4100-1-vlim@gigadevice.com>
        <dee37d18f8de5af7d07388031fc08571@walle.cc>
        <TY0PR06MB5658B73E2F22472D0AF48BDBBB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlim,

vlim@gigadevice.com wrote on Tue, 6 Dec 2022 01:27:13 +0000:

> Hi, Michael,
>=20
> I will redo the patch following this doc.
> At the meantime, can you point out a few mistakes that I am making so tha=
t I can correct it in the next submit.

Here are a few:
- The title is wrong (git log --oneline <file> for hints)
- The commit log is useless
- Don't make unrelated changes in your commit, one change =3D=3D one commit
- Don't change how the code looks like for no reason or justification

And please avoid top posting when answering.

Good luck!

Thanks,
Miqu=C3=A8l

>=20
> ________________________________
> From: Michael Walle <michael@walle.cc>
> Sent: Monday, December 5, 2022 00:22
> To: Victor Lim <victorswlim@gmail.com>
> Cc: tudor.ambarus@microchip.com <tudor.ambarus@microchip.com>; p.yadav@ti=
.com <p.yadav@ti.com>; miquel.raynal@bootlin.com <miquel.raynal@bootlin.com=
>; richard@nod.at <richard@nod.at>; vigneshr@ti.com <vigneshr@ti.com>; linu=
x-mtd@lists.infradead.org <linux-mtd@lists.infradead.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>; vikhyat.goyal@amd.com <vikhyat=
.goyal@amd.com>; amit.kumar-mahapatra@amd.com <amit.kumar-mahapatra@amd.com=
>; alejandro.carmona@amd.com <alejandro.carmona@amd.com>; Vlim <vlim@gigade=
vice.com>
> Subject: Re: [PATCH] Linux: SPI: add Gigadevice part #
>=20
> [You don't often get email from michael@walle.cc. Learn why this is impor=
tant at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> =E6=AD=A4=E4=B8=BA=E5=A4=96=E9=83=A8=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=B0=A8=
=E9=98=B2=E9=92=93=E9=B1=BC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=B3=A8=E6=
=84=8F=E9=82=AE=E4=BB=B6=E6=98=AF=E5=90=A6=E6=B6=89=E5=8F=8A=E6=95=8F=E6=84=
=9F=E4=BF=A1=E6=81=AF
>=20
> This is an external email, beware of phishing emails. Please pay close at=
tention to whether the email contains sensitive information
>=20
>=20
> Hi,
>=20
> Am 2022-12-04 09:00, schrieb Victor Lim:
> > Edited gigadevice.c =20
>=20
> Please have a look at
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>=20
> -michael

