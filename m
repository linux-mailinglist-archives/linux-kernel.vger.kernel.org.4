Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3972187B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjFDQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFDQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:14:58 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45224E9;
        Sun,  4 Jun 2023 09:14:56 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 047C25E6D2;
        Sun,  4 Jun 2023 19:14:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qEUGiEkW1eA0-oeBVAj5J;
        Sun, 04 Jun 2023 19:14:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685895293;
        bh=/V/HqiX1id/DnU0bm5FSD7RsKIyCf6EMpzWFWI+ort0=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=CMIBI8c9/RFfROAYnQ8d/hI0EKUAycmR5ceh/VlD72pws4IT/MhkLLxAEgFvmaY9h
         xYGr8V3OjFI3IGMKr3X3KDj5nhaAdNA/tuCuhIFsdLEWd20MB2Yrrawd+Z2BuDPOrD
         m8/sEcfWAhJlBTcCoNUB4qiGE78MavipK4nBtgfM=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <61b9be215d7eb9908b2dd6750f1598cbb6842f65.camel@maquefel.me>
Subject: Re: [PATCH v1 28/43] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 04 Jun 2023 22:14:52 +0300
In-Reply-To: <ZHjNR1n6tZbTAJWS@smile.fi.intel.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601054549.10843-10-nikita.shubin@maquefel.me>
         <ZHjNR1n6tZbTAJWS@smile.fi.intel.com>
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

Hello Andy!

On Thu, 2023-06-01 at 19:54 +0300, Andy Shevchenko wrote:
> On Thu, Jun 01, 2023 at 08:45:33AM +0300, Nikita Shubin wrote:
> > - get keymap from the device tree
> > - find register range from the device tree
> > - get interrupts from device tree
>=20
> ...
>=20
> > +/* flags for the ep93xx_keypad driver */
> > +#define EP93XX_KEYPAD_DISABLE_3_KEY=C2=A0=C2=A0=C2=A0=C2=A0(1<<0)=C2=
=A0=C2=A0/* disable 3-key
> > reset */
> > +#define EP93XX_KEYPAD_DIAG_MODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(1<<1)=C2=A0=C2=A0=
/*
> > diagnostic mode */
> > +#define EP93XX_KEYPAD_BACK_DRIVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(1<<2)=C2=A0=C2=A0/* back driving
> > mode */
> > +#define EP93XX_KEYPAD_TEST_MODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(1<<3)=C2=A0=C2=A0=
/* scan
> > only column 0 */
> > +#define EP93XX_KEYPAD_AUTOREPEAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(1<<4)=C2=A0=C2=A0/* enable key
> > autorepeat */
>=20
> > +static int ep93xx_keypad_flags;
> > +module_param(ep93xx_keypad_flags, int, 0);
> > +MODULE_PARM_DESC(ep93xx_keypad_flags, "EP93XX keypad flags.");
>=20
> Why? This pretty much looks like missing DT description.

From other patches from this series, i learned NOT to add new DT
entities, not even with vendor prefix, no way!

May be i missing something of course...

Either way=20

https://elixir.bootlin.com/linux/v6.4-rc4/source/arch/arm/mach-ep93xx/core.=
c#L577

static struct ep93xx_keypad_platform_data ep93xx_keypad_data;

Was never used in different ways than initializing all to zeroes
including flags since 2.6 (didn't look before through), so i would
prefer to drop this completely than moving it into device tree.

May we should drop ep93xx_keypad entirely, i don't have hardware to
test it anyway, neither does Alexander.


>=20
> Please, write your commit message better, so we can understand the
> point of
> such decisions w/o asking.
>=20

