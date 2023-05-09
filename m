Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF96FC05E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjEIHZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:25:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A833C01;
        Tue,  9 May 2023 00:25:25 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F4846602E9A;
        Tue,  9 May 2023 08:25:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683617123;
        bh=QCGh3lAq+6+hpDBYQxXcBfE6/30zBXbnB7ZBE++m248=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbkomN7Tvzin8TZA38FF5NgF4U8q7JxzcIvLI/mS2qExUPWu4K1Pmp/uXSG8nUb5W
         av1+C2BiCxFT8XMwTFMFSpYFeDTSAQPcJgvWxvizi2KOrleGoHaQrmh4PghboHLNjc
         jmqnKGNmqZfP5+o+5cFG9IICTO3LWq9J6br3rHIrJgzkag01vr1olRlXwmyGeGga3n
         85WFg+ihga7Xno16IjeoYU7XL8IXw7V3DkRSNTDkSisbhixWAupiJXYRjyxKDJTkBJ
         IBoSONEQXINbI6nWEd0kr6rNEzDf7nRk8XKj3yVfB4p4kBH/ImwsAzAga6qJjd5izL
         prorw28QfDmiA==
Received: by mercury (Postfix, from userid 1000)
        id 9F0C71066FA2; Tue,  9 May 2023 09:25:20 +0200 (CEST)
Date:   Tue, 9 May 2023 09:25:20 +0200
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
Message-ID: <20230509072520.3e4jibiis654izom@mercury.elektranox.org>
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-8-jahau@rocketmail.com>
 <20230508113518.nfwchl5wusmnkjp6@mercury.elektranox.org>
 <899d6604-7b15-ac37-c624-987a2bb7875e@rocketmail.com>
 <20230508220605.kderc3nihhezouit@mercury.elektranox.org>
 <55fd9835-4246-00e8-b641-c8b0ee3f7e22@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iet7ywalyankg5v4"
Content-Disposition: inline
In-Reply-To: <55fd9835-4246-00e8-b641-c8b0ee3f7e22@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iet7ywalyankg5v4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 09, 2023 at 03:01:32AM +0200, Jakob Hauser wrote:
> On 09.05.23 00:06, Sebastian Reichel wrote:
> > On Mon, May 08, 2023 at 11:18:28PM +0200, Jakob Hauser wrote:
> > > On 08.05.23 13:35, Sebastian Reichel wrote:
> > > > On Sat, May 06, 2023 at 05:54:34PM +0200, Jakob Hauser wrote:
> > > > > The rt5033-battery fuelgauge can't get a status by itself. The rt=
5033-charger
> > > > > can, let's get this value.
> > > > >=20
> > > > > Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> > > > > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> > > > > ---
> > > > >    drivers/power/supply/rt5033_battery.c | 24 +++++++++++++++++++=
+++++
> > > > >    1 file changed, 24 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/powe=
r/supply/rt5033_battery.c
> > > > > index 5c04cf305219..a6520716d813 100644
> > > > > --- a/drivers/power/supply/rt5033_battery.c
> > > > > +++ b/drivers/power/supply/rt5033_battery.c
> > > > > @@ -12,6 +12,26 @@
> > > > >    #include <linux/mfd/rt5033-private.h>
> > > > >    #include <linux/mfd/rt5033.h>
> > > > > +static int rt5033_battery_get_status(struct i2c_client *client)
> > > > > +{
> > > > > +	struct power_supply *charger;
> > > > > +	union power_supply_propval val;
> > > > > +	int ret;
> > > > > +
> > > > > +	charger =3D power_supply_get_by_name("rt5033-charger");
> > > > > +	if (!charger)
> > > > > +		return POWER_SUPPLY_STATUS_UNKNOWN;
> > > > > +
> > > > > +	ret =3D power_supply_get_property(charger, POWER_SUPPLY_PROP_ST=
ATUS, &val);
> > > > > +	if (ret) {
> > > > > +		power_supply_put(charger);
> > > > > +		return POWER_SUPPLY_STATUS_UNKNOWN;
> > > > > +	}
> > > >=20
> > > > struct rt5033_battery *battery =3D i2c_get_clientdata(client);
> > > > ret =3D power_supply_get_property_from_supplier(battery->psy, POWER=
_SUPPLY_PROP_STATUS, &val);
> > > > if (ret)
> > > >       val.intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > >=20
> > > I don't think this works. There is no direct relationship between
> > > rt5033-charger and rt5033-battery. They operate independently from ea=
ch
> > > other.
> >=20
> > That should be fine as long as the supply dependency is properly declar=
ed.
> >=20
> > > I had a short try and the status property of rt5033-battery was "unkn=
own".
> > >=20
> > > Just for the record, the full function I tried was:
> > >=20
> > > static int rt5033_battery_get_status(struct i2c_client *client)
> > > {
> > >          struct rt5033_battery *battery =3D i2c_get_clientdata(client=
);
> > >          union power_supply_propval val;
> > >          int ret;
> > >=20
> > >          ret =3D power_supply_get_property_from_supplier(battery->psy,
> > >                                               POWER_SUPPLY_PROP_STATU=
S,
> > >                                               &val);
> > >          if (ret)
> > >                  val.intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > >=20
> > >          return val.intval;
> > > }
> > >=20
> > > Later on I added a read-out of the "ret" value. It is "-19". I guess =
that's
> > > the "return -ENODEV;" from function
> > > power_supply_get_property_from_supplier(). [2]
> > >=20
> > > [2] https://github.com/torvalds/linux/blob/v6.4-rc1/drivers/power/sup=
ply/power_supply_core.c#L397-L421
> >=20
> > I suppose your DT is missing the connection between the charger and
> > the battery:
> >=20
> > rt5033_charger: charger {
> >      compatible =3D "rt5033-charger";
> >      ...
> > }
> >=20
> > fuel-gauge {
> >      compatible =3D "rt5033-battery";
> >      ...
> >      power-supplies =3D <&rt5033_charger>; // you are probably missing =
this
> > };
> >=20
> > See also Documentation/devicetree/bindings/power/supply/power-supply.ya=
ml
>=20
> ...
>=20
> Thanks for the hints.
>=20
> This leads to updating the dt-bindings because adding the "power-supplies"
> property is important to be aware of.

It should already be part of the binding, because richtek,rt5033-battery.ya=
ml has

allOf:
  - $ref: power-supply.yaml#

> Btw. first it didn't work. It took me quite some time to debug. I needed =
to
> add "psy_cfg.of_node =3D client->dev.of_node;" to the rt5033-battery probe
> function.
>=20
> Now it works. However, there is a new problem. The battery driver gets
> probed first. The charger driver a bit later. In the meantime the battery
> driver spams dmesg with several "Failed to register power supply" because
> the charger driver isn't available yet. Once the charger driver is there,=
 it
> works fine and dmesg becomes silent.
>=20
> With the current state of the patchset:
> dmesg | grep rt5033
> [   13.628030] rt5033 6-0034: Device found (rev. 6)
> [   13.633552] rt5033-led: Failed to locate of_node [id: -1]
> [   13.790478] rt5033-charger rt5033-charger: DMA mask not set
>=20
> With the changes discussed here:
> dmesg | grep rt5033
> [   15.741915] rt5033-battery 4-0035: Failed to register power supply
> [   15.752894] rt5033-battery 4-0035: Failed to register power supply
> [   15.795458] rt5033-battery 4-0035: Failed to register power supply
> [   15.910760] rt5033-battery 4-0035: Failed to register power supply
> [   15.913187] rt5033 6-0034: Device found (rev. 6)
> [   15.914341] rt5033-led: Failed to locate of_node [id: -1]
> [   15.920052] rt5033-battery 4-0035: Failed to register power supply
> [   15.927262] rt5033-battery 4-0035: Failed to register power supply
> [   16.017131] rt5033-battery 4-0035: Failed to register power supply
> [   16.017401] rt5033-charger rt5033-charger: DMA mask not set
>=20
> The message is comming from the rt5033-battery probe function, it's the
> power_supply_register() that fails.
>=20
> Any ideas what could be done about this?

Replace the dev_err() with dev_err_probe():

if (IS_ERR(battery->psy))
    return dev_err_probe(&client->dev, PTR_ERR(battery->psy), "Failed to re=
gister power supply\n");

That will avoid printing an error for -EPROBE_DEFER.

Greetings,

-- Sebastian

--iet7ywalyankg5v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRZ9VUACgkQ2O7X88g7
+pr/Ag//eBPYQF9XRUneLbrr48ySTBKivB7FqbLJzfJg1llA51Bu95ykEeNTnyFv
EyrTeoQTUJt+NeXg7wpnNbWSgqpX0pLpuQBe9zekWfHYtPkdzc4zO2C1wngtCZfG
lldbyh4HdDEU1rFw79EUlWpilgO68BNBl1cPl8RQsztWcNKqTRtoVRga5aTxq8q3
LkC7j5q2StxkVgKGwbBhYXb+mTQER8lTP05gT9B+173jCtkuOz7Rs+JdJLEbuKVG
rxFqYNps9oOMzhUXxHJ1zeXvZ8s3oxzt+iWN7wiMMYTgc0GVIlwFo+RCxXSb+boM
tSQ7PWnhungvLXu+gP9KSzNLWgz+x7Ei+MjJcMvMs95s7sG8G8UtsByooxm9CCxG
5GMavPtLppwbPTvimy5HuqFWsZmu2dcLRTszVgugceXA1ExCKJ4r75dDyGiRxkiM
FAD0i4eJ4HPR3i9h9tq8xOGPWNncUlj2xdthdE7qMP3vOtm+1borjIaXL7W53VbM
WkVE/DO2NTU7dJLS2sGK+IPmMO/pIOwyL/Od6yw7rvZxS5zR7+BsEupr6UYyxiFg
pcei8d2mAIFtZjVK+90zPeB6BbpHAAbvwycKFE6/wDI1ltA7ym7tvdKVzZYy2It5
tGOAakYDtqAQjSTHe1iyXnAES3LwG9g5KpPZZT89BZ3vfnLJ2vQ=
=18VY
-----END PGP SIGNATURE-----

--iet7ywalyankg5v4--
