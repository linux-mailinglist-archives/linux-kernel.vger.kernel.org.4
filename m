Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE270185C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjEMQ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEMQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983D02D68;
        Sat, 13 May 2023 09:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29EED60A25;
        Sat, 13 May 2023 16:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55B2C433EF;
        Sat, 13 May 2023 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683997042;
        bh=KNZeIfqal/7YhgXOCqbE8Uiwnic5H94FhrfZg35KWYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CbyJ1ZL7J57XB8VusspB2KVJ9WgVFG13hYAon/5SnMAWwB/UtjeOxHtYsf8NHW33i
         XbCHL9boyiunKgQpTGaH4PK9hAVE1km8m89MKIcC6JCSI51Ko2tnpt4jtXkBlhjJ5V
         CP4Dn49/xcTuIx0KWXOoZbFz1edDacnkmtMc4Mzf19k+MXcGAlboH+Vnje3b9OAp78
         NP0ldwVVJJ/6XomonRF3pWpRKuNGNG3bCQUjo0oQEY9XvsIq4ChHY135TUYwWkwGSx
         hmnbdvs53kZbkivltRKFl8a3fwxEOPHlqcboVstVix1aaHLJbL3dSjbziuR4e2Bgqc
         VD+ByoWNsWwpw==
Date:   Sat, 13 May 2023 18:13:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <20230513181323.165c09f2@jic23-huawei>
In-Reply-To: <ZFe8N8EhNTOkLO0c@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
        <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
        <20230501155645.435242f0@jic23-huawei>
        <ZFVG1cyY/Ge/nXOh@carbian>
        <20230506174651.5c5740d9@jic23-huawei>
        <ZFe8N8EhNTOkLO0c@carbian>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2023 16:56:55 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Hello Jonathan,
>=20
> On Sat, May 06, 2023 at 05:46:51PM +0100, Jonathan Cameron wrote:
> > On Fri, 5 May 2023 20:11:33 +0200
> > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> >  =20
> > > Hello Jonathan,
> > >=20
> > > On Mon, May 01, 2023 at 03:56:45PM +0100, Jonathan Cameron wrote: =20
> > > > On Tue, 25 Apr 2023 00:22:27 +0200
> > > > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> > > >    =20
> > > > > Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can sup=
port
> > > > > ranges from =C2=B12G to =C2=B116G, digital output through I=C2=B2=
C/SPI.
> > > > > Add support for basic accelerometer features such as reading acce=
leration
> > > > > via IIO using raw reads, triggered buffer (data-ready), or the WM=
I IRQ.
> > > > >=20
> > > > > Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-=
Technical-Reference-Manual-Rev-5.0.pdf
> > > > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>   =20
> > > >=20
> > > > Two tiny things inline. =20
> > > >    =20
> > > > > +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> > > > > +{
> > > > > +	struct device *dev =3D regmap_get_device(data->regmap);
> > > > > +	__le16 buf_status;
> > > > > +	int ret, fifo_bytes;
> > > > > +
> > > > > +	ret =3D regmap_bulk_read(data->regmap, data->chip_info->buf_sta=
tus1,
> > > > > +			       &buf_status, sizeof(buf_status));
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Error reading buffer status\n");
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	fifo_bytes =3D le16_to_cpu(buf_status);
> > > > > +	fifo_bytes &=3D data->chip_info->buf_smp_lvl_mask;   =20
> > > >=20
> > > > Slight preference for FIELD_GET() as it saves me checking the mask =
includes
> > > > lowest bits.   =20
> > >=20
> > > This will mean I have the remove the chip_info member buf_smp_lvl_mask
> > > and use KX132_MASK_BUF_SMP_LVL directly because otherwise the
> > > __builtin_constant_p function will cause an error when building.=20
> > > Check: https://elixir.bootlin.com/linux/latest/source/include/linux/b=
itfield.h#L65
> > >=20
> > > I can change it to FIELD_GET() if you want to. =20
> >=20
> > Good point.  You could use le16_get_bits() though which I'm fairly sure=
 will take
> > a variable just fine.
> >  =20
>=20
> I don't think it will work.=20
>=20
> From the commit log introducing the {type}_get_bits to <linux/bitfield.h>
> "    Field specification must be a constant; __builtin_constant_p() doesn=
't
>     have to be true for it, but compiler must be able to evaluate it at
>     build time.  If it cannot or if the value does not encode any bitfiel=
d,
>     the build will fail. "
>=20
> Actually Geert Uytterhoeven tried to solve excatly this issue, but it
> seems that the patch was not accepted.=20
> Check: https://lore.kernel.org/linux-iio/3a54a6703879d10f08cf0275a2a69297=
ebd2b1d4.1637592133.git.geert+renesas@glider.be/
>=20
>=20
> So which solution would be the best:
>=20
> 1. Use directly KX132_MASK_BUF_SMP_LVL, the only reason I was trying to
> avoid this was to make this function generic enough for other chip
> variants
>=20
> 2. Copy the field_get() definition from drivers/clk/at91 or from the comm=
it
> of Geert and use it in this driver
>=20
> 3. leave it as it is ?=20
This fine.  Sorry for the diversion to nowhere!

Jonathan

>=20
> 4. another solution ?
>=20
> > > =20
> > > >=20
> > > >    =20
> > > > > +
> > > > > +	return fifo_bytes;
> > > > > +}
> > > > > +
> > > > >  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned in=
t samples,
> > > > >  			       bool irq)
> > > > >  {
> > > > > @@ -1036,6 +1157,32 @@ const struct kx022a_chip_info kx022a_chip_=
info =3D {
> > > > >  };
> > > > >  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> > > > > =20
> > > > > +const struct kx022a_chip_info kx132_chip_info =3D {
> > > > > +	.name		  =3D "kx132-1211",
> > > > > +	.regmap_config	  =3D &kx132_regmap_config,
> > > > > +	.channels	  =3D kx132_channels,
> > > > > +	.num_channels	  =3D ARRAY_SIZE(kx132_channels),
> > > > > +	.fifo_length	  =3D KX132_FIFO_LENGTH,
> > > > > +	.who		  =3D KX132_REG_WHO,
> > > > > +	.id		  =3D KX132_ID,
> > > > > +	.cntl		  =3D KX132_REG_CNTL,
> > > > > +	.cntl2		  =3D KX132_REG_CNTL2,
> > > > > +	.odcntl		  =3D KX132_REG_ODCNTL,
> > > > > +	.buf_cntl1	  =3D KX132_REG_BUF_CNTL1,
> > > > > +	.buf_cntl2	  =3D KX132_REG_BUF_CNTL2,
> > > > > +	.buf_clear	  =3D KX132_REG_BUF_CLEAR,
> > > > > +	.buf_status1	  =3D KX132_REG_BUF_STATUS_1,
> > > > > +	.buf_smp_lvl_mask =3D KX132_MASK_BUF_SMP_LVL,   =20
> > > >=20
> > > > There are some things in here (typically where the define isn't used
> > > > anywhere else) where I think it would be easier to follow if the
> > > > value was listed here.  Masks and IDs for example.=20
> > > >    =20
> > >=20
> > > After removing buf_smp_lvl_mask, which members will be easier to unde=
rstand (besides id) ?  =20
> >=20
> > I haven't gone through them.  Length seems an obvious one.  It's a numb=
er not a magic value.
> > Register addresses might also be simpler if they aren't used elsewhere.
> >=20
> > Not really about understanding just about a define that adds nothing if=
 all we do is
> > assign it to a variable of the same name. =20
>=20
> Do you have a strong opinion about this ?=20
>=20
> I would really prefer to leave it like this, for the following reasons:
>=20
> 1. If I directly use values here, I have to do it also in the previous
> patch where I introduce the chip_info for the kx022a -> this means I
> will have defines in the h file which are not used at all -> the defines =
should
> be deleted -> the patch will get unnecessarily bigger. I received
> multiple comments about removing unnecessary changes and reducing of the
> patch size when possible.
>=20
> 2. Consistency: having all the defines in one place really seems to be
> better for understanding IMO. I find the mix of values and defines in=20
> the chip-info a bit confusing, e.g., I will use the direct value for=20
> KX132_REG_CNTL but not for KX132_REG_CNTL2 because KX132_REG_CNTL2 is
> referenced in a regmap_range.=20
>=20
> --
> Kind Regards
> Mehdi Djait

