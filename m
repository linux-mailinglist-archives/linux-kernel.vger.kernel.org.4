Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24DE732BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbjFPJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjFPJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:37:17 -0400
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9752117;
        Fri, 16 Jun 2023 02:37:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:210:0:640:45a:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id 061735EA2B;
        Fri, 16 Jun 2023 12:37:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6bZ0FPBDcOs0-YwIwcfPo;
        Fri, 16 Jun 2023 12:37:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1686908228;
        bh=ULF/TtnZNYokyyjXxQGcSPKNWj6sLoNSPxteRiEyMoY=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=LHs7sZhCMQnjyekXO06mp0vuGkhMGkLelGJTRwoEtsWSeivsCn3bKb1GMaB31bAJk
         /CE+2eLI4TNFvbba7eRPzu1iTJtXX/1dDufzd4RAEZN49kLtz6jPIVKnz31M0k+yBr
         QxvoX5qZK312G7cqu5/pCJnZMjz98oVMvy/xp2R8=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <b51d416312bda72d4825e6fded4f1dabc5fe12e6.camel@maquefel.me>
Subject: Re: [PATCH 33/43] gpio: ep93xx: add DT support for gpio-ep93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Jun 2023 15:37:02 +0300
In-Reply-To: <CAMRc=Mf1UYEBrGYic7VxzaqHcydHaOnH7MN49c6_B6tnu=pYpg@mail.gmail.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-34-nikita.shubin@maquefel.me>
         <CAMRc=Mf1UYEBrGYic7VxzaqHcydHaOnH7MN49c6_B6tnu=pYpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart!

On Fri, 2023-06-16 at 11:18 +0200, Bartosz Golaszewski wrote:
> On Mon, Apr 24, 2023 at 11:36=E2=80=AFAM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >=20
> > Add match table.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0drivers/gpio/gpio-ep93xx.c | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-
> > ep93xx.c
> > index ca508c7c4f2f..4e3d01fab012 100644
> > --- a/drivers/gpio/gpio-ep93xx.c
> > +++ b/drivers/gpio/gpio-ep93xx.c
> > @@ -363,9 +363,15 @@ static int ep93xx_gpio_probe(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_gpiochip_add_dat=
a(&pdev->dev, gc, egc);
> > =C2=A0}
> >=20
> > +static const struct of_device_id ep93xx_gpio_match[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "cirrus,ep9301-=
gpio" },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of table */ },
> > +};
> > +
> > =C2=A0static struct platform_driver ep93xx_gpio_driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0 =3D "gpio-ep93xx",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .of_match_table =3D ep93xx_gpio_match,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D ep93xx_gpio_probe,
> > =C2=A0};
> > --
> > 2.39.2
> >=20
>=20
> I guess this depends on patch 1/43 from this series? Are you going to
> send a v2?

Yes it depends, the splitting was done to adapt driver to splitted
platform data one for each port i.e. probe is called for each port
instance with 1/43.

Definitely there will be a v2 (actually b4 considers it a v3 version -
so be it), and may be some next series also.


>=20
> Bart

