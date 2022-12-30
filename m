Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BCF659875
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiL3Mub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiL3Mu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:50:29 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B55712A89
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:50:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EDB60240004;
        Fri, 30 Dec 2022 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672404625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHjxCa2Edd0gHDw+qV8rTm16FhBycGbJZc+nok1Yk3A=;
        b=Zjio9gxyKAP2R3MIkjzFnaxZsGGp+keQGk5zo+7UJfjmzZYJLW0/umDCwzddbrZgv/RxcQ
        F8uPzhmAUArYcpZkg8vJFnSlL9v6bm1HhY+2tt0K50wNAzC5SqKpKnGE+0yaEK2cWO6Jmt
        LQ45M/OPL1QYxTJZ8Z+yBYzAhMl1tCkUxJUO0VSev0ws6PicgSVS92d/ol4tIRx51cg7nM
        1ueNb4MjexNaBHWMStgQB9uzAzbrblQI5Z5LesMQmD2ZeFI4dCvp3pOMgsoyg0OD94vvgo
        joycyzaUa+M7uIqazcF1cRdxJkPq9gCNQkzvFjydYnY+pfW5DDToLyf7pZOtzQ==
Date:   Fri, 30 Dec 2022 13:50:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Message-ID: <20221230135020.485a3efc@xps-13>
In-Reply-To: <32ddf1f8-eda1-da00-a3dc-901c4ee61217@linaro.org>
References: <20221220141352.1486360-1-arnd@kernel.org>
        <cae6328b-5204-a1ab-810d-8fb64e466453@linaro.org>
        <20221220165701.5696df1a@xps-13>
        <026225c6-f17f-e9da-b7c0-5d3473a97e89@linaro.org>
        <32ddf1f8-eda1-da00-a3dc-901c4ee61217@linaro.org>
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

Hi Tudor,

tudor.ambarus@linaro.org wrote on Mon, 26 Dec 2022 16:22:02 +0200:

> On 21.12.2022 08:49, Tudor Ambarus wrote:
> >=20
> >=20
> > On 20.12.2022 17:57, Miquel Raynal wrote: =20
> >> Hi Tudor,
> >> =20
> >=20
> > Hi,
> >  =20
> >> tudor.ambarus@linaro.org wrote on Tue, 20 Dec 2022 17:44:49 +0200:
> >> =20
> >>> Hi, Arnd,
> >>>
> >>> On 20.12.2022 16:13, Arnd Bergmann wrote: =20
> >>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>>
> >>>> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
> >>>> fails to build, as it includes the shared CFI header:
> >>>>
> >>>> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix >=
>>> selected. No NOR chip support can work. [-Werror=3Dcpp]
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0 62 | #warning No CONFIG_MTD_CFI_Ix selected=
. No NOR chip >>>> support can work.
> >>>>
> >>>> linux/mtd/spi-nor.h does not actually need to include cfi.h, so
> >>>> remove the inclusion here to fix the warning. This uncovers a
> >>>> missing #include in spi-nor/core.c so add that there to
> >>>> prevent a different build issue.
> >>>>
> >>>> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> >>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de> =20
> >>>
> >>> Looks good to me. I'll let the linux-0day bot run over it and apply it
> >>> once -rc1 is out. =20
> >>
> >> The issue sometimes produces build errors, shall I send it through a
> >> fixes PR instead?
> >> =20
> >=20
> > Yes, that I was thinking about.
> >  =20
>=20
> Seems that I shouldn't push to mtd/fixes, so:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Oh yes you can, sorry for the misunderstanding, but as I am often alone
to do it, I read your "I will apply" message last time and understood "I
will apply on spi-nor/next".=20

You can update mtd/fixes to -rc1 and push the patch, as long as we keep
each other in sync ;)

Thanks!
Miqu=C3=A8l
