Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5876ADD2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCGLWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGLWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:22:45 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB812137;
        Tue,  7 Mar 2023 03:22:44 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A544FF805;
        Tue,  7 Mar 2023 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678188162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0hEM7ISBUqXXS/ZqJd+VTykSF0s9BCSq2N153XQuMY=;
        b=RQtVcjTA7kA4faWxb1cyqjsEPHmok7xwmu02vJX+83wq0qxG53hsnnFGx0txkT/FElcN7W
        tLnphAoKc/E8VL7XzXbFlOJ2oNWAiArwU38M4XZlJVBGQeCpfFnS6UJGhpgdLqqcVGU6HK
        0EIQQbThLZ11n79yKqzsysTs82zuVZqCfNDuujd2I0E9gmSgoRlxAEFejY0yvmypuDh3LT
        zv01ydejEWekSzEomsWk6cABvCknE2q84w/VX7yL4PsmRsiCCDGMb2UV96Vh82lLAD80Yb
        A9YzJvNnlT5OQcv1Vg2gtvWGni28yUf8rHGMkpbMS7mQYzmXaUy+qeNxKr3Crw==
Date:   Tue, 7 Mar 2023 12:22:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
Message-ID: <20230307122240.1694501c@xps-13>
In-Reply-To: <CAKXUXMwn8wLBtTru74Mo4D=X6gA-M3b3Zin0L_ugtN9-R2L7-A@mail.gmail.com>
References: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
        <20230307100350.1c0af7b9@xps-13>
        <1e321754-5bdd-4019-8524-2222ee369502@app.fastmail.com>
        <20230307113846.5dab6e66@xps-13>
        <CAKXUXMwn8wLBtTru74Mo4D=X6gA-M3b3Zin0L_ugtN9-R2L7-A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

lukas.bulwahn@gmail.com wrote on Tue, 7 Mar 2023 11:58:07 +0100:

> On Tue, Mar 7, 2023 at 11:38=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hi Arnd,
> >
> > arnd@arndb.de wrote on Tue, 07 Mar 2023 11:26:48 +0100:
> > =20
> > > On Tue, Mar 7, 2023, at 10:03, Miquel Raynal wrote: =20
> > > > Hi Lukas,
> > > >
> > > > lukas.bulwahn@gmail.com wrote on Tue,  7 Mar 2023 08:40:38 +0100:
> > > > =20
> > > >> Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the c=
onfig
> > > >> MTD_NAND_TMIO and its corresponding driver.
> > > >>
> > > >> Remove the reference in MTD_SHARPSL_PARTS to that removed config.
> > > >>
> > > >> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > >> ---
> > > >> Arnd, please ack.
> > > >> Miquel, please pick this minor non-urgent patch on top of the comm=
it above. =20
> > > >
> > > > Actually I guess the SHARPSL driver is not selectable right now, so
> > > > this should be sent as part of my next fixes PR. =20
> > >
> > > I don't see why not, it just depends on 'ARCH_PXA||COMPILE_TEST' and
> > > should work fine with CONFIG_MACH_SPITZ PDAs. =20
> >
> > Sorry, I overlooked the diff, indeed there is nothing broken, so I'll
> > queue it to nand/next. I thought MTD_SHARPSL_PARTS was not selectable
> > anymore without COMPILE_TEST, which would have been problematic.
> >
> > Fixes tag still welcome though :)
> > =20
>=20
> Arnd's commit is not broken. It does what Arnd writes in his commit
> message what it should do.
>
> And this patch is just a clean-up that removes references, but it is
> just "stylistic" and reduces the complexity of Kconfig dependency
> definitions for non-existing config symbols. I do not see that this
> patch fixes Arnd's patch. It is just a clean-up with a reference to
> Arnd's patch to understand why this clean up can be done now.
>=20
> If you REALLY want the Fixes: tag, I can sure add it. But, I do not
> claim that I am fixing anything here; nothing was broken in the first
> place. The reference to the commit of interest is in the commit
> message, and anyone can follow or extract the information if they are
> interested.
>
> So, please keep this patch in the queue for nand/next.

Wow, so much arguing just for a Fixes tag.

It is not broken, I know, but it is somehow incomplete as it creates a
stalled Kconfig symbol. And you come-in and fix the situation by
dropping the remaining symbol. So for me it's a fix, no matter how
deeply bogus (or not) the original commit was. It's not an insult, it's
a tag that allows easy parsing. Anyway, that's meaningless. I'll take
it like that.

Thanks,
Miqu=C3=A8l
