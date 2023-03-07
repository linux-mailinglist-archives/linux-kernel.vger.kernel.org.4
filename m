Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0A6ADCC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCGLCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCGLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:01:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E1C73AFC;
        Tue,  7 Mar 2023 02:58:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so50483099edb.9;
        Tue, 07 Mar 2023 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678186698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLQHemRIXRE4FrIg6JDLewKbHFCJRHBj5gtISGj6+Lk=;
        b=aU3b0QfFtNND0Irkk/Mc18zoqOmiezu9rIcyeh4HVIuUkcZjXjhTNUzykoPV18OnTs
         gi5a53S9vy/d+rotfmbKzGXLgiMn4312e0IJ2YsV3H3bhnuNAvFugA552nfFkt12o5Es
         XdaftS00MXt5ymcJm1gESWyuhoMTRpisCOFmvzCbrGHPvayGiizIE9s5cYdfM/oumXaB
         h/dav8wUa68z+iu3eohWb1NV6aptQZT3ZRMryfW5y7Kd1OydeiTjuBUrbrUIuRbgtCKJ
         g4Bq904pxhTLWZVfey5ElxXyxBDHL8p59uU9HPWw/gspI9FGhrTZGN4jp4e5UnM1/r5x
         +iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678186698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLQHemRIXRE4FrIg6JDLewKbHFCJRHBj5gtISGj6+Lk=;
        b=uwgHvGqskkx8QaFmuCO70+myrNE7f+tTQhdcThvfGD9MHR6KAXCtxNi8Jzr2jCehpu
         p7gg/zRUgNGkhnBne1UmQRjIGCruSu1ODK8WRaWDnOH2HNSieuVOeMOZ7pc3hBYiM3mO
         apF11RPsfvfnUr+7xyB7dQCF9HjkWfJIXIfspV66ueJ6ae8sX48mPDl980PZJxh1elXN
         U0eODp3o0p74Il3dtnd4I0OoF/V/WyG0e5Mt9ssw8q2nraUcUgdjXACHhEcnNrre0pDv
         E0cX1qIfp1OyHIfCRHDThV5gcA8O/TuhcoC/BneeaNRPiRNoi7LO0bEPD8ZHICX3jcQa
         Iaig==
X-Gm-Message-State: AO0yUKUwnFScWsB4pRKV3nhoOFO9v15b/826bvJQaEBFXz2nOM0LMaDc
        RQ8H1eTFAN66zkm8FNOM8U0zDpi4mr75iZhryVo=
X-Google-Smtp-Source: AK7set/wDNUrNS4Lkg0oycNkwpaiZjj0SnAa4fQgceS30Sq51ZBWEWmjKvP54F+a3R1s+oLjaWc/fU/1EA9M08vNswU=
X-Received: by 2002:a50:8a9d:0:b0:4bc:5de1:ee5 with SMTP id
 j29-20020a508a9d000000b004bc5de10ee5mr7666471edj.2.1678186698578; Tue, 07 Mar
 2023 02:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
 <20230307100350.1c0af7b9@xps-13> <1e321754-5bdd-4019-8524-2222ee369502@app.fastmail.com>
 <20230307113846.5dab6e66@xps-13>
In-Reply-To: <20230307113846.5dab6e66@xps-13>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 7 Mar 2023 11:58:07 +0100
Message-ID: <CAKXUXMwn8wLBtTru74Mo4D=X6gA-M3b3Zin0L_ugtN9-R2L7-A@mail.gmail.com>
Subject: Re: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 11:38=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Arnd,
>
> arnd@arndb.de wrote on Tue, 07 Mar 2023 11:26:48 +0100:
>
> > On Tue, Mar 7, 2023, at 10:03, Miquel Raynal wrote:
> > > Hi Lukas,
> > >
> > > lukas.bulwahn@gmail.com wrote on Tue,  7 Mar 2023 08:40:38 +0100:
> > >
> > >> Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the con=
fig
> > >> MTD_NAND_TMIO and its corresponding driver.
> > >>
> > >> Remove the reference in MTD_SHARPSL_PARTS to that removed config.
> > >>
> > >> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > >> ---
> > >> Arnd, please ack.
> > >> Miquel, please pick this minor non-urgent patch on top of the commit=
 above.
> > >
> > > Actually I guess the SHARPSL driver is not selectable right now, so
> > > this should be sent as part of my next fixes PR.
> >
> > I don't see why not, it just depends on 'ARCH_PXA||COMPILE_TEST' and
> > should work fine with CONFIG_MACH_SPITZ PDAs.
>
> Sorry, I overlooked the diff, indeed there is nothing broken, so I'll
> queue it to nand/next. I thought MTD_SHARPSL_PARTS was not selectable
> anymore without COMPILE_TEST, which would have been problematic.
>
> Fixes tag still welcome though :)
>

Arnd's commit is not broken. It does what Arnd writes in his commit
message what it should do.

And this patch is just a clean-up that removes references, but it is
just "stylistic" and reduces the complexity of Kconfig dependency
definitions for non-existing config symbols. I do not see that this
patch fixes Arnd's patch. It is just a clean-up with a reference to
Arnd's patch to understand why this clean up can be done now.

If you REALLY want the Fixes: tag, I can sure add it. But, I do not
claim that I am fixing anything here; nothing was broken in the first
place. The reference to the commit of interest is in the commit
message, and anyone can follow or extract the information if they are
interested.

So, please keep this patch in the queue for nand/next.

Lukas

> Thanks,
> Miqu=C3=A8l
