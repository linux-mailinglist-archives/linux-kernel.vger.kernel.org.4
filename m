Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27E629C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKOOsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiKOOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:48:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7799C1FCCF;
        Tue, 15 Nov 2022 06:48:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f18so3579381ejz.5;
        Tue, 15 Nov 2022 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zHT6RekA1nmfh/Fa6EaQoB6yFfjcdCvyRH3c7rFODNQ=;
        b=RlxHN93Yj9OnbkZdXw9Mn3k3B/xJmEfIPxLX2PX5msyQCVDUNH/UPmYNCeJsJGY9gW
         JRzactMuYbgcPv5cMoFnANg1gE66GVC0XpOWxi4xbVCuhcdGAF/YL5vGsZKdVuFWjonc
         t2DiSWyJmWjNJQwFGJiDF29YwMJ2ETY2K+GteQsENs7ajfmHmhdkh74gNAUNk1kMYyd1
         hVkB9NbKbICtRg1IVJGIMEWuZ3EBoyH/Kr31uZ/+9cFdNFawE6x4wjhlah3qPWOBSUZg
         QasE5Szs18zdVXE5iG96FLFuS6VeXntuYpT4kngWfhIh+d//R/6aFAYITbXshwDp5p5x
         Iy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHT6RekA1nmfh/Fa6EaQoB6yFfjcdCvyRH3c7rFODNQ=;
        b=6LCvEdEM6dGQ+qagVzvQK46ncOusWIUp5CxhTjCqrBXSN5eQRPnbI0gTZ4887vGJbL
         AxqUqXrdWm/JIoBuvkem7qdj/LPfiv6mWuWThhuDUCCvIVOEMP80nAT3NDkxLKuoSOe7
         v7igIvQLsQX7FOFPXY1WHiiegoOdsJujKHDX2hGY2BUJDH3eQsJ1we2WbEYbL7fiFH2H
         WEB6stNk+Z3/OHmINadcbt4fA/tSQdK2743OtZtofu4DbRXMYEOe+whsFJ6UEmG8X40T
         nTS5ufWAVHx1x8pXYReEpSBOAy6XjX1nuBgawwOX6qtXQivhSfHkQocVVojn/DNiQbaX
         1Xvw==
X-Gm-Message-State: ANoB5pm3PilE/DmqRALMx1w7tOHf6IwuvNPr7lyV8ZBjQodHWZyUK1nW
        Yll6ReWqIMQMTJvZ+3WxUljXpUy5hw/jDx+IFZ8=
X-Google-Smtp-Source: AA0mqf7LOaKoPqHeXJ99tFsmuSdIZrqrxDvqdwAbQeSK4h6uzJtvMmotfP+YMC8oYHtUDoWddxHpRg==
X-Received: by 2002:a17:906:b14f:b0:7ad:90db:c241 with SMTP id bt15-20020a170906b14f00b007ad90dbc241mr14051170ejb.284.1668523695572;
        Tue, 15 Nov 2022 06:48:15 -0800 (PST)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id ck11-20020a0564021c0b00b00461b169c02csm6222029edb.91.2022.11.15.06.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:48:15 -0800 (PST)
Message-ID: <0d6b3e4047df9f560079a562bc167bd7a0bf2d28.camel@gmail.com>
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Nov 2022 15:49:46 +0100
In-Reply-To: <20221114194447.2528f699@jic23-huawei>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
         <20221111143921.742194-6-linux@rasmusvillemoes.dk>
         <20221112170705.7efe1673@jic23-huawei>
         <095a454b55cf497392a621649f24e067@analog.com>
         <20221114194447.2528f699@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 19:44 +0000, Jonathan Cameron wrote:
> On Mon, 14 Nov 2022 13:52:26 +0000
> "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Saturday, November 12, 2022 7:07 PM
> > > To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Cc: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>; Lars-Peter
> > > Clausen
> > > <lars@metafoo.de>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>;
> > > devicetree@vger.kernel.org; Rob Herring <robh+dt@kernel.org>;
> > > linux-
> > > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for
> > > reset-gpio
> > >=20
> > > [External]
> > >=20
> > > On Fri, 11 Nov 2022 15:39:21 +0100
> > > Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > > =C2=A0=20
> > > > We have a board where the reset pin of the ad74412 is connected
> > > > to a
> > > > gpio, but also pulled low by default. Hence to get the chip out
> > > > of
> > > > reset, the driver needs to know about that gpio and set it high
> > > > before
> > > > attempting to communicate with it.=C2=A0=20
> > >=20
> > > I'm a little confused on polarity here.=C2=A0 The pin is a !reset so
> > > we need to drive it low briefly to trigger a reset.
> > > I'm guessing for your board the pin is set to active low? (an
> > > example
> > > in the dt would have made that clearer) Hence the pulse
> > > in here to 1 is actually briefly driving it low before restoring
> > > to high?
> > >=20
> > > For a pin documented as !reset that seems backwards though you
> > > have
> > > called it reset so that is fine, but this description doesn't
> > > make that
> > > celar.=C2=A0=20
> >=20
> > My opinion is that the driver shouldn't exactly know the polarity
> > of the reset,
> > and just assume that setting the reset GPIO to 1 means putting it
> > in reset,
> > and setting it to 0 means bringing out of reset.
>=20
> Agreed. I'd just like a comment + example in the dt-binding to make
> the point
> that the pin is !reset.
>=20
> Preferably with an example in the dt binding of the common case of it
> being wired
> up to an active low pin.
>=20
> The main oddity here is the need to pulse it rather than request it
> directly as
> in the reset state and then just set that to off.
>=20
>=20

Agreed... In theory we should be able to request the gpio with
GPIOD_OUT_HIGH and then just bring the device out of reset

- Nuno S=C3=A1

