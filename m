Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BFB7218AA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjFDQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjFDQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:29:39 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B060B3;
        Sun,  4 Jun 2023 09:29:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 8DE955E7D4;
        Sun,  4 Jun 2023 19:29:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YTUVaSkWwGk0-fmMbjBf0;
        Sun, 04 Jun 2023 19:29:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685896174;
        bh=qoROymkVmkGkOdy5uIWZJj6wLlMG+g04m/Wm+5N/tGk=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=mEfzG2iaO4HhMY8fIX+qHpwZa2R1nFWXq0KwfViPIRzFWmHCojnJwS8/CwlD+vyCW
         OnccQ5Hd6tz/bBc+t1rTRBjTXXLMChYf6PmwugrasT1x0T1j8AEkRlR6Q4aN4gzQVk
         BprNYVCDg2vV79T4ofn76F9GLUNefnuQkNYC7AQs=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <b48f2218c0a13273f9976aa082ebb67c3e3d5e75.camel@maquefel.me>
Subject: Re: [PATCH v1 26/43] pata: cirrus: add DT support for Cirrus EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 04 Jun 2023 22:29:35 +0300
In-Reply-To: <32a041b0-d02d-4353-4794-094b96271e3a@omp.ru>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601054549.10843-8-nikita.shubin@maquefel.me>
         <32a041b0-d02d-4353-4794-094b96271e3a@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey!

On Fri, 2023-06-02 at 23:03 +0300, Sergey Shtylyov wrote:
> Hello!
>=20
> On 6/1/23 8:45 AM, Nikita Shubin wrote:
>=20
> > - find register range from the device tree
> > - get interrupts from device tree
>=20
> =C2=A0=C2=A0 Hm... I'm not seeing such changes in your patch?

I meant that from now on it will take irq's and register from device
tree:
https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/ata/pata_ep93xx.c#=
L928

If CONFIG_OF_IRQ is enabled.

You are right

> > get interrupts from device tree

Is confusing.


>=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >=20
> > Notes:
> > =C2=A0=C2=A0=C2=A0 v0 -> v1:
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 - fixed headers
> > =C2=A0=C2=A0=C2=A0 - dropped coma in id table
> >=20
> > =C2=A0drivers/ata/pata_ep93xx.c | 8 ++++++++
> > =C2=A01 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> > index c6e043e05d43..8d363bc71342 100644
> > --- a/drivers/ata/pata_ep93xx.c
> > +++ b/drivers/ata/pata_ep93xx.c
> > @@ -40,6 +40,7 @@
> > =C2=A0#include <linux/ata.h>
> > =C2=A0#include <linux/libata.h>
> > =C2=A0#include <linux/platform_device.h>
> > +#include <linux/mod_devicetable.h>
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/dmaengine.h>
> > =C2=A0#include <linux/ktime.h>
> > @@ -1016,9 +1017,16 @@ static int ep93xx_pata_remove(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> > =C2=A0
> > +static const struct of_device_id ep93xx_pata_of_ids[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "cirrus,ep=
9312-pata" },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ep93xx_pata_of_ids);
> > +
> > =C2=A0static struct platform_driver ep93xx_pata_platform_driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D DRV_NAME,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D ep93xx_pata_of_ids,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe =3D ep93xx_pata_=
probe,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove =3D ep93xx_pata=
_remove,
>=20
> MBR, Sergey

