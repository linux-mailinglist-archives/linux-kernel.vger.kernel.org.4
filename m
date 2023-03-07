Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DDB6ADC1C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCGKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCGKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:38:54 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B85098E;
        Tue,  7 Mar 2023 02:38:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CDFA7240014;
        Tue,  7 Mar 2023 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678185529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VglUMIXrPqjJ8c4O9VES4XFcHo1sdweKGqq4J4kTLIM=;
        b=JyVXXBDpnWD59CtM5qyfPqwq1g31JD32Fl7zyqZHdZccSVKXihZO+6lUgdm99HSu64V3hw
        X/5rfAmEhn89kGsyDb+TfbLUw0C7oV35wHyfyaFGEc6asGF2z3vQDWvTV2i3hr+OcAhger
        9sObtS36zyUZjiBXPU7/T1va0aeysICfSc6IGRQpcH8ETcOZV6xopsdysRZnLSqppfWSgv
        DFwIbM2r79h1V2YiOi2yDwk6xQjuMSkoYl22lKF17x6jM3z5v1UKz6nFTvIv1MAxdSevad
        MwpxYCOtSTlrD0sD0Reaac9lcS9bUhhclJgsHIEfBlHLzpe01xL1X68cJFFMUQ==
Date:   Tue, 7 Mar 2023 11:38:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
Message-ID: <20230307113846.5dab6e66@xps-13>
In-Reply-To: <1e321754-5bdd-4019-8524-2222ee369502@app.fastmail.com>
References: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
        <20230307100350.1c0af7b9@xps-13>
        <1e321754-5bdd-4019-8524-2222ee369502@app.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

arnd@arndb.de wrote on Tue, 07 Mar 2023 11:26:48 +0100:

> On Tue, Mar 7, 2023, at 10:03, Miquel Raynal wrote:
> > Hi Lukas,
> >
> > lukas.bulwahn@gmail.com wrote on Tue,  7 Mar 2023 08:40:38 +0100:
> >
> >> Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the config
> >> MTD_NAND_TMIO and its corresponding driver.
> >>=20
> >> Remove the reference in MTD_SHARPSL_PARTS to that removed config.
> >>=20
> >> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >> ---
> >> Arnd, please ack.
> >> Miquel, please pick this minor non-urgent patch on top of the commit a=
bove.
> >
> > Actually I guess the SHARPSL driver is not selectable right now, so
> > this should be sent as part of my next fixes PR.
>=20
> I don't see why not, it just depends on 'ARCH_PXA||COMPILE_TEST' and
> should work fine with CONFIG_MACH_SPITZ PDAs.

Sorry, I overlooked the diff, indeed there is nothing broken, so I'll
queue it to nand/next. I thought MTD_SHARPSL_PARTS was not selectable
anymore without COMPILE_TEST, which would have been problematic.

Fixes tag still welcome though :)

Thanks,
Miqu=C3=A8l
