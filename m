Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0356BF4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCQV6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCQV60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:58:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCA119F12;
        Fri, 17 Mar 2023 14:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BE37B825C3;
        Fri, 17 Mar 2023 21:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE7C433D2;
        Fri, 17 Mar 2023 21:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679090291;
        bh=ejuz/UUFuE1EsjILlvo9coUN1kdqCQYZ1xfi+zLQgwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bm7Tsift+VIiJFoZnWzTVLvd3mQGPNmFanMknxxBu8vuIJowq8el9sonFEkWSQXp4
         IZJKHPw8UlbLm3GUhXu3WwowYSfxuwN/C6XtYGQSwHivP6ByUAEIO4JXsr5WjcN8Qu
         O1VI14KMgNW7m3iJWN650AgE7wNFc6Dl2dmVlbLLYUYSp0Cf6Al8nwOJ3tplp2K+fV
         LnQgwTpAx0cceOvg7XgLf8Xjh9S5aLlf1RHPvoOmwehDyRVyd4f05+YkM76q5PYldL
         UYoUiSvi1i5c6i+OR3wXWIyH6kmWNH2ICp43Qbie/B5tP5Gq+UrRcgLVugTc1BIeZw
         3Rx7k2mgdnRzw==
Received: by mercury (Postfix, from userid 1000)
        id 4387F10620FB; Fri, 17 Mar 2023 22:58:08 +0100 (CET)
Date:   Fri, 17 Mar 2023 22:58:08 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2 08/12] power: supply: generic-adc-battery: use
 simple-battery API
Message-ID: <20230317215808.ulairtb5wzyghoyh@mercury.elektranox.org>
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-9-sre@kernel.org>
 <775fab33-0964-67f0-837a-b5fdd7ae7a2b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ejsfjyzjlbthid7i"
Content-Disposition: inline
In-Reply-To: <775fab33-0964-67f0-837a-b5fdd7ae7a2b@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ejsfjyzjlbthid7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2023 at 09:38:21AM +0200, Matti Vaittinen wrote:
> On 3/15/23 00:55, Sebastian Reichel wrote:
> > Use standard simple-battery API for constant battery
> > information like min and max voltage. This simplifies
> > the driver a lot and brings automatic support for DT.
> >=20
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> >   drivers/power/supply/generic-adc-battery.c | 64 ++--------------------
> >   include/linux/power/generic-adc-battery.h  | 18 ------
> >   2 files changed, 4 insertions(+), 78 deletions(-)
> >   delete mode 100644 include/linux/power/generic-adc-battery.h
> >=20
> > diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power=
/supply/generic-adc-battery.c
> > index 771e5cfc49c3..d4f63d945b2c 100644
> > --- a/drivers/power/supply/generic-adc-battery.c
> > +++ b/drivers/power/supply/generic-adc-battery.c
> > @@ -22,7 +22,6 @@
> >   #include <linux/slab.h>
> >   #include <linux/iio/consumer.h>
> >   #include <linux/iio/types.h>
> > -#include <linux/power/generic-adc-battery.h>
> >   #include <linux/devm-helpers.h>
> >   #define JITTER_DEFAULT 10 /* hope 10ms is enough */
> > @@ -48,9 +47,7 @@ struct gab {
> >   	struct power_supply		*psy;
> >   	struct power_supply_desc	psy_desc;
> >   	struct iio_channel	*channel[GAB_MAX_CHAN_TYPE];
> > -	struct gab_platform_data	*pdata;
> >   	struct delayed_work bat_work;
> > -	int	level;
> >   	int	status;
> >   	bool cable_plugged;
> >   	struct gpio_desc *charge_finished;
> > @@ -70,14 +67,6 @@ static void gab_ext_power_changed(struct power_suppl=
y *psy)
> >   static const enum power_supply_property gab_props[] =3D {
> >   	POWER_SUPPLY_PROP_STATUS,
> > -	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> > -	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
> > -	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > -	POWER_SUPPLY_PROP_CURRENT_NOW,
> > -	POWER_SUPPLY_PROP_TECHNOLOGY,
> > -	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > -	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> > -	POWER_SUPPLY_PROP_MODEL_NAME,
> >   };
> >   /*
> > @@ -97,17 +86,6 @@ static bool gab_charge_finished(struct gab *adc_bat)
> >   	return gpiod_get_value(adc_bat->charge_finished);
> >   }
> > -static int gab_get_status(struct gab *adc_bat)
> > -{
> > -	struct gab_platform_data *pdata =3D adc_bat->pdata;
> > -	struct power_supply_info *bat_info;
> > -
> > -	bat_info =3D &pdata->battery_info;
> > -	if (adc_bat->level =3D=3D bat_info->charge_full_design)
> > -		return POWER_SUPPLY_STATUS_FULL;
>=20
> Not sure if this is intentional but I don't see the POWER_SUPPLY_STATUS_F=
ULL
> being reported after applying your series. If this is intended, maybe it
> could be mentioned in commit log?

Right. I removed it, because 'level' is never written to and thus is
always 0. Apart from that the code needs to be a bit more flexible
anyways (i.e. should not just report full for exactly the same
value) and we currently do not have a way to calculate the current
charge value. Thus removing it makes sense at the moment. Something
better can be added once we have the required infrastructure.

-- Sebastian

--ejsfjyzjlbthid7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQU4mwACgkQ2O7X88g7
+prVVhAAhpl3ZoHtJgqt3V1R7+KvLvxhSz6k2iJrRLCzAVMUtkBlhXLMsMRCuDuj
ugqGyYYUFVyB4A4lBsJVimXca1qHs1kVmvpfpKdXrMBkW14ocqn2+Z9rCVF3pv9D
Zs+Lu6TeuL/LQqpg9tq3Wp4AtUIKtDE9vBJjVLwPvxpM+tNf2WHhmTHzpqlN/8IQ
Fp6EyTfo3lZRYfpsi0grFgZasFM35IJKZMSxf8gtFCh2KbfpapWV3xWkT/NdAs9u
HCUKnriDokHLvf/9/8+UIiiMJV539fl1yc+Ww+TNMd6oOh2NWRxEeOgjeOHDaR0r
n85KLxpc049pDopClplnxAil/oCs6Nw7+7/71BVo76L6jEX6VbId130Cb1RV3Nji
gxKVNIpNOCDwSUO/ZQB8OtbEMIPMYzNpECtdEW6tu0InZ1x/Rf/ZzWo/eUBHFEXk
kFQ4Cyi85uefu53PyNIMlJlIz4caTUWVAozXHZcKyPalDDvBvLltwiuaGZMEuEgV
1J6pWHYD7yVCieOijyBAqZpVh21b6JFPsPg9JGUjhfqRynRySTz6xdmGVb6YmS8Z
mRL17MmUKjxSu5wOOlvnFYr5AJRJkq4ZUDVTMbnLCtNHtYtINF+ihY7qQ4fcMxmS
gWxg89djqJj/uHT+aTu+Eo2BsmS86puv8HzgbGsb52u7PQXun9k=
=Yc9B
-----END PGP SIGNATURE-----

--ejsfjyzjlbthid7i--
