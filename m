Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6968B05C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBEOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBEOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:48:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F11ADF0;
        Sun,  5 Feb 2023 06:48:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE556066C;
        Sun,  5 Feb 2023 14:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDEBC433EF;
        Sun,  5 Feb 2023 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675608495;
        bh=vQYR06IWX0d3i4oNFRcT+gjh4a36LQcL6uYULnjA2fI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eGuz5qqjkNtEoh0YTfOmkZmpl5IC4HWhFymjmx8oSqpyF4HHwvLwHtik2CdAhURsN
         QhsrD1XC42MLfiuZYc+XvrANULaV9Kp1k3Kqv3OJ8AdDV/VCqdcYkQEcgAfs0/t/n4
         o2YRQlTNDlOz9Vt7EQor44drgH3VpULPxSw6bTfp8d8Ng1QPlKJZLzDTavNyd4bWni
         qz08HaxxZ0tU8dyhd5gz90S/OrgKJIf3SbUJdNlN8am1lzQjSPD8KUe6pw9cE027tO
         3RUC/cHVOnQFzvH1+S1RY8eeF+aKeNAmH3RLeAurjQRX1LAVVZmEbEOkvyb/Z1flF7
         3KdD99OBW3UpQ==
Date:   Sun, 5 Feb 2023 15:02:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: dac: ad5592r: add gpio_chip names
Message-ID: <20230205150217.2c21fc18@jic23-huawei>
In-Reply-To: <CY4PR03MB33992B4DBEF40A9F960001289BD19@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20221117090130.51702-1-antoniu.miclaus@analog.com>
        <20221123204832.3e514378@jic23-huawei>
        <CY4PR03MB33992B4DBEF40A9F960001289BD19@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 13:11:30 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> --
> Antoniu Micl=C4=83u=C5=9F
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Wednesday, November 23, 2022 10:49 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] drivers: iio: dac: ad5592r: add gpio_chip names
> >=20
> > [External]
> >=20
> > On Thu, 17 Nov 2022 11:01:30 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >  =20
> > > Add array of explicit gpio names for the `gpiochip` structure of
> > > ad5592r, mainly for debug purposes. =20
> > Can you give an example of when this is more useful than the offset?
> > (which I'm assuming is also available when debugging?)
> >=20
> > Jonathan
> >  =20
> Hello Jonathan,
>=20
> I guess this patch is not mandatory. It is a gpio_chip structure member t=
hat was left unpopulated.
> Also, I think it is nice to see explicitly the gpios under cat /sys/kerne=
l/debug/gpio alongside the others.
> This is the current output when trying to debug on a rpi (without the pat=
ch applied):
>=20
> analog@analog:~ $ sudo cat /sys/kernel/debug/gpio
> gpiochip0: GPIOs 0-57, parent: platform/fe200000.gpio, pinctrl-bcm2711:
>  gpio-0   (ID_SDA              )
>  gpio-1   (ID_SCL              )
>  gpio-2   (SDA1                )
>  gpio-3   (SCL1                )
>  gpio-4   (GPIO_GCLK           )
>  gpio-5   (GPIO5               )
>  gpio-6   (GPIO6               )
> ....
> gpiochip2: GPIOs 496-503, parent: spi/spi0.0, spi0.0, can sleep:
>=20
> gpiochip1: GPIOs 504-511, parent: platform/soc:firmware:gpio, raspberrypi=
-exp-gpio, can sleep:
>  gpio-504 (BT_ON               )
>  gpio-505 (WL_ON               )
>  gpio-506 (PWR_LED_OFF         |led1                ) out lo ACTIVE LOW
>  gpio-507 (GLOBAL_RESET        )
>  gpio-508 (VDD_SD_IO_SEL       |vdd-sd-io           ) out hi
>  gpio-509 (CAM_GPIO            |power_ctrl          ) out lo
>  gpio-510 (SD_PWR_ON           |sd_vcc_reg          ) out hi
>  gpio-511 (SD_OC_N             )
>=20
> The gpiochip2, corresponding to ad5592r has no explicit gpios, due to the=
 fact that the
> gpio names were assigned.

Thanks for the info.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it an see if we missed anything.

We are a bit tight timing wise, so this might end up in next cycle.

Jonathan

>=20
> Regards,
> > >
> > > Since the gpios are configurable via the dts, generic names are
> > > used.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > >  drivers/iio/dac/ad5592r-base.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r=
-base.c
> > > index 7a9b5fc1e579..076bc9ecfb49 100644
> > > --- a/drivers/iio/dac/ad5592r-base.c
> > > +++ b/drivers/iio/dac/ad5592r-base.c
> > > @@ -124,6 +124,10 @@ static int ad5592r_gpio_request(struct gpio_chip=
 =20
> > *chip, unsigned offset) =20
> > >  	return 0;
> > >  }
> > >
> > > +static const char * const ad5592r_gpio_names[] =3D {
> > > +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6", =20
> > "GPIO7", =20
> > > +};
> > > +
> > >  static int ad5592r_gpio_init(struct ad5592r_state *st)
> > >  {
> > >  	if (!st->gpio_map)
> > > @@ -140,6 +144,7 @@ static int ad5592r_gpio_init(struct ad5592r_state=
 =20
> > *st) =20
> > >  	st->gpiochip.set =3D ad5592r_gpio_set;
> > >  	st->gpiochip.request =3D ad5592r_gpio_request;
> > >  	st->gpiochip.owner =3D THIS_MODULE;
> > > +	st->gpiochip.names =3D ad5592r_gpio_names;
> > >
> > >  	mutex_init(&st->gpio_lock);
> > > =20
>=20

