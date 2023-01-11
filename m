Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31420665057
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbjAKAXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjAKAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:23:14 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300234F126;
        Tue, 10 Jan 2023 16:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lB3/oUiQ+pVa3onRwFzKH8YJVkOYTVRbneHLzsVtvD4=; b=czfF3gI5EhN07SWurtEOumrABb
        F5oGtQmkN7dmn4KMRc9NnpsWCE31Lps7MoC2Xchrnf8aKA70fK0tIOb6FP8PqVsgBlpm1YzVDDZOP
        JKg8zgIT+Du2L1R0Y7galc/ycYbEqySqtMnQT77KcZ3uZUGdIbIfyk2UUEx4O4ZKs2ao=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41152 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pFOtV-0002cr-Nn; Tue, 10 Jan 2023 19:23:06 -0500
Date:   Tue, 10 Jan 2023 19:23:05 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230110192305.0214a1075518c7d5774e8166@hugovil.com>
In-Reply-To: <c4b5c190-5fb5-17f2-69ce-7137ef7f33db@wanadoo.fr>
References: <20230110160124.3853593-1-hugo@hugovil.com>
        <20230110160124.3853593-2-hugo@hugovil.com>
        <c4b5c190-5fb5-17f2-69ce-7137ef7f33db@wanadoo.fr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 19:50:42 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 10/01/2023 =E0 17:01, Hugo Villeneuve a =E9crit=A0:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> > digital converter (ADC) with an I2C interface.
> >=20
> > Datasheet: https://www.ti.com/lit/gpn/ads7924
> >=20
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
>=20
> Hi,
>=20
> should there be a v3, a few nits below.

Hi,
there will definitely be a V3 (missing include), thanks for the input, I wi=
ll incorporate these changes into V3.

Hugo.


>=20
> CJ
>=20
> >   MAINTAINERS                  |   7 +
> >   drivers/iio/adc/Kconfig      |  11 +
> >   drivers/iio/adc/Makefile     |   1 +
> >   drivers/iio/adc/ti-ads7924.c | 492 +++++++++++++++++++++++++++++++++++
> >   4 files changed, 511 insertions(+)
> >   create mode 100644 drivers/iio/adc/ti-ads7924.c
> >=20
>=20
> [...]
>=20
> > +static int ads7924_get_channels_config(struct i2c_client *client,
> > +				       struct iio_dev *indio_dev)
> > +{
> > +	struct ads7924_data *priv =3D iio_priv(indio_dev);
> > +	struct device *dev =3D priv->dev;
> > +	struct fwnode_handle *node;
> > +	int num_channels =3D 0;
> > +
> > +	device_for_each_child_node(dev, node) {
> > +		u32 pval;
> > +		unsigned int channel;
> > +
> > +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> > +			dev_err(dev, "invalid reg on %pfw\n", node);
> > +			continue;
> > +		}
> > +
> > +		channel =3D pval;
> > +		if (channel >=3D ADS7924_CHANNELS) {
> > +			dev_err(dev, "invalid channel index %d on %pfw\n",
> > +				channel, node);
> > +			continue;
> > +		}
> > +
> > +		num_channels++;
> > +	}
> > +
> > +	if (num_channels > 0) {
> > +		dev_dbg(dev, "found %d ADC channels\n", num_channels);
> > +		return 0;
> > +	} else {
> > +		return -EINVAL;
> > +	}
>=20
> 	if (num_channels <=3D 0)
> 		return -EINVAL;
>=20
> 	dev_dbg(dev, "found %d ADC channels\n", num_channels);
> 	return 0;
>=20
> is much more usual.
>=20
> > +}
> > +
>=20
> [...]
>=20
> > +static int ads7924_reset(struct iio_dev *indio_dev)
> > +{
> > +	struct ads7924_data *data =3D iio_priv(indio_dev);
> > +
> > +	if (data->reset_gpio) {
> > +		gpiod_set_value(data->reset_gpio, 1); /* Assert. */
> > +		/* Educated guess: assert time not specified in datasheet... */
> > +		mdelay(100);
> > +		gpiod_set_value(data->reset_gpio, 0); /* Deassert. */
> > +	} else {
> > +		int ret;
>=20
> having 'ret' near 'struct ads7924_data *data' is more usual and saves 1 L=
oC.
>=20
> > +
> > +		/*
> > +		 * A write of 10101010 to this register will generate a
> > +		 * software reset of the ADS7924.
> > +		 */
> > +		ret =3D regmap_write(data->regmap, ADS7924_RESET_REG, 0b10101010);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +};
>=20
>=20


--=20
Hugo Villeneuve <hugo@hugovil.com>
