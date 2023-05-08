Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47F6FBAD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjEHWGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjEHWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:06:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8D1BEF;
        Mon,  8 May 2023 15:06:10 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A5D86603283;
        Mon,  8 May 2023 23:06:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683583569;
        bh=30FLbkryf1DzVdRImoadVvaZuoZnpMi7QPYoPUu10H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKC/6tMLrR7DAu5irdIpiNOu5zqWBMhc2YNYCL8NovmD4rsqqjFuvpbZ6JBuHYNfS
         8DvVuEPcntqmpaUIfqUtTbEmZjwDR5J8b4e3xnK1wlvtqZgbJ1VI+C3PRpDiAmoF49
         H23OhFEblMkcsI5B8jRhVmkJ1odzTOK4CvoO+CqqPfGYcQgwBUdyCJ526DmxKnAYz1
         Q8Y3DoBk9Bq2eFX74gPpOo4WSDwpBUlRLDE5SBJG7dx8MxR6IL1NGRCaPa4ncccewi
         bhhBuACE03qO6tb6BDAusxz81SjUmdUGPwLPnrQXU/lONhKG6X5tqitNfbeyRFszHX
         vcM1CSjb5PNJg==
Received: by mercury (Postfix, from userid 1000)
        id C4B491060F31; Tue,  9 May 2023 00:06:05 +0200 (CEST)
Date:   Tue, 9 May 2023 00:06:05 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 7/8] power: supply: rt5033_battery: Adopt status
 property from charger
Message-ID: <20230508220605.kderc3nihhezouit@mercury.elektranox.org>
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-8-jahau@rocketmail.com>
 <20230508113518.nfwchl5wusmnkjp6@mercury.elektranox.org>
 <899d6604-7b15-ac37-c624-987a2bb7875e@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrwzmvhxh7bd3zyc"
Content-Disposition: inline
In-Reply-To: <899d6604-7b15-ac37-c624-987a2bb7875e@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrwzmvhxh7bd3zyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 08, 2023 at 11:18:28PM +0200, Jakob Hauser wrote:
> On 08.05.23 13:35, Sebastian Reichel wrote:
> > On Sat, May 06, 2023 at 05:54:34PM +0200, Jakob Hauser wrote:
> > > The rt5033-battery fuelgauge can't get a status by itself. The rt5033=
-charger
> > > can, let's get this value.
> > >=20
> > > Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> > > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> > > ---
> > >   drivers/power/supply/rt5033_battery.c | 24 ++++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > >=20
> > > diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/su=
pply/rt5033_battery.c
> > > index 5c04cf305219..a6520716d813 100644
> > > --- a/drivers/power/supply/rt5033_battery.c
> > > +++ b/drivers/power/supply/rt5033_battery.c
> > > @@ -12,6 +12,26 @@
> > >   #include <linux/mfd/rt5033-private.h>
> > >   #include <linux/mfd/rt5033.h>
> > > +static int rt5033_battery_get_status(struct i2c_client *client)
> > > +{
> > > +	struct power_supply *charger;
> > > +	union power_supply_propval val;
> > > +	int ret;
> > > +
> > > +	charger =3D power_supply_get_by_name("rt5033-charger");
> > > +	if (!charger)
> > > +		return POWER_SUPPLY_STATUS_UNKNOWN;
> > > +
> > > +	ret =3D power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS=
, &val);
> > > +	if (ret) {
> > > +		power_supply_put(charger);
> > > +		return POWER_SUPPLY_STATUS_UNKNOWN;
> > > +	}
> >=20
> > struct rt5033_battery *battery =3D i2c_get_clientdata(client);
> > ret =3D power_supply_get_property_from_supplier(battery->psy, POWER_SUP=
PLY_PROP_STATUS, &val);
> > if (ret)
> >      val.intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>=20
> I don't think this works. There is no direct relationship between
> rt5033-charger and rt5033-battery. They operate independently from each
> other.

That should be fine as long as the supply dependency is properly declared.

> I had a short try and the status property of rt5033-battery was "unknown".
>=20
> Just for the record, the full function I tried was:
>=20
> static int rt5033_battery_get_status(struct i2c_client *client)
> {
>         struct rt5033_battery *battery =3D i2c_get_clientdata(client);
>         union power_supply_propval val;
>         int ret;
>=20
>         ret =3D power_supply_get_property_from_supplier(battery->psy,
>                                              POWER_SUPPLY_PROP_STATUS,
>                                              &val);
>         if (ret)
>                 val.intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>=20
>         return val.intval;
> }
>=20
> Later on I added a read-out of the "ret" value. It is "-19". I guess that=
's
> the "return -ENODEV;" from function
> power_supply_get_property_from_supplier(). [2]
>=20
> [2] https://github.com/torvalds/linux/blob/v6.4-rc1/drivers/power/supply/=
power_supply_core.c#L397-L421

I suppose your DT is missing the connection between the charger and
the battery:

rt5033_charger: charger {
    compatible =3D "rt5033-charger";
    ...
}

fuel-gauge {
    compatible =3D "rt5033-battery";
    ...
    power-supplies =3D <&rt5033_charger>; // you are probably missing this
};

See also Documentation/devicetree/bindings/power/supply/power-supply.yaml

-- Sebastian

>=20
> > > +
> > > +	power_supply_put(charger);
> > > +	return val.intval;
> > > +}
> > > +
> > >   static int rt5033_battery_get_capacity(struct i2c_client *client)
> > >   {
> > >   	struct rt5033_battery *battery =3D i2c_get_clientdata(client);
> > > @@ -84,6 +104,9 @@ static int rt5033_battery_get_property(struct powe=
r_supply *psy,
> > >   	case POWER_SUPPLY_PROP_CAPACITY:
> > >   		val->intval =3D rt5033_battery_get_capacity(battery->client);
> > >   		break;
> > > +	case POWER_SUPPLY_PROP_STATUS:
> > > +		val->intval =3D rt5033_battery_get_status(battery->client);
> > > +		break;
> > >   	default:
> > >   		return -EINVAL;
> > >   	}
> > > @@ -96,6 +119,7 @@ static enum power_supply_property rt5033_battery_p=
rops[] =3D {
> > >   	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> > >   	POWER_SUPPLY_PROP_PRESENT,
> > >   	POWER_SUPPLY_PROP_CAPACITY,
> > > +	POWER_SUPPLY_PROP_STATUS,
> > >   };
> > >   static const struct regmap_config rt5033_battery_regmap_config =3D {
> > > --=20
> > > 2.39.2
> > >=20
> >=20
> > Otherwise LGTM.
> >=20
> > -- Sebastian
>=20
> Kind regards,
> Jakob

--lrwzmvhxh7bd3zyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRZckoACgkQ2O7X88g7
+ppblg/7BnQBaLkuno5lVhBhcw4cUNiy1gy27gX/JpVMRBrWDXNksVmbyhYkmibx
j0YNTckaeIpddrEClqT0GQafJoxT3gae6k/iTRXiZ+VlNLLL6M8iRuq4tDPmRAtT
uRHeJD0OmwGMr0yYA/Lk8AmX+aLO4bgeajAvcRZ98pBNlWTs8o+SAO8t+gurC4o6
nJAkAHgB4R6izM4cibzXJf9wmmLJIyEauedL7bJA6CT89K1wBtPFjjoP6QdLB3rg
wjSbevlCCW6wIObTZHQhmQKlHIXDax0TL7rzHnZO/QTdhflT+lFXl0MgQJo1QZ1K
vRiU6K6q/JLW1sKY46LG4eDuLIhiQJteH/3uY3jRWODDc+2KbbFHWvMOEmm0zIra
wHrJ+plsNn9RG/rkDqO+OFuQxT4fqf1SwA8ElXOx3qPfPLx4sdqjfP/kNYWOPzbI
W9yg4RC8lrXPN1UJBgguA5m4VdFsT5uLl9kV9n19dFR0FH/h+E41gIFzB3QaQqz3
r2dgAkc0sVuWBXRKvhOLOkG1DKhuvbVK4f1PH96EqesisVOAs5HnGO7FvjcCN9nj
fq6gzhoIiRWwifTfYv6NVF0wHDpxkt/05+shuTWeo3amFuisnvo9IpczyD6o2l0D
/IGl9LV4TEtXQEwQC+Y5+CQx02YAZego1oSwB91hd04AICYLO6o=
=+mRH
-----END PGP SIGNATURE-----

--lrwzmvhxh7bd3zyc--
