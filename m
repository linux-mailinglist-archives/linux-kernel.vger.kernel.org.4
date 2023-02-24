Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F876A1E42
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjBXPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBXPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:14:49 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83E60D67;
        Fri, 24 Feb 2023 07:14:12 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id a3so9181670vsi.0;
        Fri, 24 Feb 2023 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/Ugj/lPoP2nwc4YeTQnUUlq67wDHca2rNmadKiTrpA=;
        b=S6mx4j4fLg+1PljQrKgoDf5QuHELQ5RsKg/gslSOReeUh7e4eBSfcTcx0wpicD9+YU
         9WIsKSn0M5UzEYL8Ic19e/p3N6Um5yW4UUBhidL31eHt9Zbk99SsUH6zsoSwFuIZdyyn
         0nZ7CqVAVyfl2vnwlTML3+wkYWdV+pLVGvGtWTXkAc6sZ3NCoJR7pA13aNBARN2wSIGz
         VmjkNHd8yjGFAjeNEXk2ozaWUFuCmsA8cxvR9w7nShAu7uHsf7tazcPQUWpza9ZSfGWA
         NFepwag0MqFsng81/feGxIuoPmtO798k/vUQUvpn/QCKwCBBL/Dp3SqG4tnF077Jx5yk
         IvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/Ugj/lPoP2nwc4YeTQnUUlq67wDHca2rNmadKiTrpA=;
        b=3wA/Fk+zzntk4B3werI6nCr8D/LFZHGf2KromTrQ3gAyl3ui5R0j2JE2kaXBBwPDCu
         zwj/cVsmVlFwk8TyHpC5oXoQPIrxX3CXvUoAKNaT1tJJKEz+ys7Y20u1TUrUkpBq7s+6
         63XazU50vtGTlj46RlOIonJu1EIoz5h6SVzWjjFtbjnGHXbCx+zKP/PD4S/rktKjxVv7
         Cnzj9RnXODyJykFYT/MMH/Kq2NjXRoDREogXj6UreCFcx+OsJWG7WP02XVY7/HAKz0bx
         6UTsyxPzES1ABUVF9Zf2fs1hPRWdcxs2qQ7iix2Uw9wguNBGggBuGcgflyPTF6x0WLvY
         k7zA==
X-Gm-Message-State: AO0yUKVQjFWOGRP5Hvyek1QJppffoRk7W0GEoSU0Mris422bPzYbcgaj
        E+0gGZwexO0sh8bcUF0ZMd1okE3hbeXFsIETvfuDNkD1ofA=
X-Google-Smtp-Source: AK7set+wlpGf1r7AsgBFwKL7/++mU1MNgFQGiYhuMDRD/5jCnnLy1vrM9UIXmWWuVLVg6qx7dLfHocEpHA4t3A27ulA=
X-Received: by 2002:a1f:4505:0:b0:401:95ca:ea53 with SMTP id
 s5-20020a1f4505000000b0040195caea53mr2689018vka.3.1677251603052; Fri, 24 Feb
 2023 07:13:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
 <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
 <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VfZ1r_sNus_qMYumja3YrJawA6hRHUbi-uPFUprorQ_Kw@mail.gmail.com> <CH2PR12MB3895124032E3276B54570676D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895124032E3276B54570676D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Feb 2023 17:12:17 +0200
Message-ID: <CAHp75Vc8=_bfuLrpygCFnDcAZMyGMQXN7xEiZv=Yn3u3NzRpjQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 4:42 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> > > > > > > Ah that=E2=80=99s my bad. The property should be called "ngpi=
os" like
> > > > > > > in the DT
> > > > > > documentation. Will fix.
> > > > > >
> > > > > > And why do you need it? What's a corner case that the GPIO
> > > > > > library doesn't handle yet?
> > > > >
> > > > > We have 2 gpiochips, gpiochip 0 supports 32 gpio pins and gpiochi=
p
> > > > > 1
> > > > supports only 24 pins.
> > > > > If I remove the logic from gpio-mlxbf3.c, the gpiolib.c logic wil=
l
> > > > > correctly set
> > > > the ngpios =3D 32 for gpiochip 0 but will wrongly set ngpios=3D32 f=
or gpiogchip
> > 1:
> > > >
> > > > So, either you need to have two entries in DT per chip or ngpios sh=
ould be
> > 56.
> > > >
> > > I already have 2 entries in my ACPI table, in the first entry, ngpios=
 =3D 32 and
> > in the second entry ngpios =3D 24.
> >
> > Can you show the DSDT excerpt of this device? (Also including the piece=
s for
> > pin control)
>
> Our ACPI tables are internal:
>
> Device(GPI0) {
>         Name(_HID, "MLNXBF33")
>         Name(_UID, Zero)
>         Name(_CCA, 1)
>         Name(_CRS, ResourceTemplate() {
>           // for fw_gpio[0] yu block
>          Memory32Fixed(ReadWrite, 0x13401100, 0x00000080)
>          // for yu_gpio_causereg0 block
>          Memory32Fixed(ReadWrite, 0x13401c00, 0x00000020)
>          Interrupt(ResourceConsumer, Edge, ActiveHigh, Shared)
>            { BF_RSH0_YU }
>        })
>        Name(_DSD, Package() {
>          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>          Package() {
>            Package () { "ngpios", 32 }, // Number of GPIO pins on gpio bl=
ock 0
>            Package () { "gpio-reserved-ranges", Package () {5, 1, 7, 3, 1=
1, 31}},
>          }
>        })
>      }
>  Device(GPI1) {
>        Name(_HID, "MLNXBF33")
>        Name(_UID, 1)
>        Name(_CCA, 1)
>        Name(_CRS, ResourceTemplate() {
>          // for fw_gpio[1] yu block
>          Memory32Fixed(ReadWrite, 0x13401180, 0x00000080)
>          // for yu_gpio_causereg1 block
>          Memory32Fixed(ReadWrite, 0x13401c20, 0x00000020)
>        })
>        Name(_DSD, Package() {
>          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>          Package() {
>            Package () { "ngpios", 24 }, // Number of GPIO pins on gpio bl=
ock 1
>            Package () { "gpio-reserved-ranges", Package () {0, 21}},
>          }
>        })
>   }
>
>     Device(PIN0) {
>       Name(_HID, "MLNXBF34")
>       Name(_UID, Zero)
>       Name(_CCA, 1)
>       Name(_CRS, ResourceTemplate() {
>         // for fw_gpio[0] and fw_gpio[1] yu blocks
>         Memory32Fixed(ReadWrite, 0x13401100, 0x00000100)
>       })
>      }

So far I see no issues with the tables. Thanks for sharing!

> > > Gpiochip_add_data_with_keys only reads the ngpios property if (ngpios
> > > =3D=3D 0) which is not the case when bgpio_init is called. bgpio_init=
 uses "sz"
> > argument to populate the ngpio in bgpio_init, which is not what we want=
.
> >
> > Maybe bgpio_init() is not a good API for your case?
>
> At the moment, bgpio_init handles all the direction in/out get/set gpio v=
alue for us.
> So I can either remove bgpio_init so that we get the correct ngpios prope=
rty, but will have to define get_gpio, set_gpio, dir in and dir out.
> Or I can keep bgpio_init and device_property_read_u32 in the gpio-mlxbf3.=
c driver.

So far it seems the issue is in bgpio_init() that doesn't handle
ngpios properly. Maybe we need to fix this first?

Btw, have you considered using the gpio-regmap approach?

--=20
With Best Regards,
Andy Shevchenko
