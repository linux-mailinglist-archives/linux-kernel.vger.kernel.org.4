Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377636921B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjBJPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBJPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:12:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D8211DC;
        Fri, 10 Feb 2023 07:12:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m2so16660782ejb.8;
        Fri, 10 Feb 2023 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A+uesByqCs0ybnziWaHlVRhSkDkrI54gGo+LelIbN8=;
        b=NcxhqzvhKnQBHRu7vDSI/EtzGftenCxn6fM4tdD9qWC1A+QBJCKveLuRtV7LBvRa1X
         GtJebkk99Je9xTzDWk8oVQ6GVQi57aVRooIO1yb5kJb8Z8CS5fPU2Hzn+ammy+BBMa6b
         Ljy45m+vuDGfFka0aJ5Bu3nU5F4tHrxQCV1jAGw0wMk9vz/x1Xy117FTQTuIzbTS/bEn
         OOD4xSjFbuBVqMhKyH6e8XESSSOEn07YICRuBhvAXy353NksaMNG8W5drTLbN/7Abhwd
         aW8ZBQu9OFwHH7xFiXqogDstKeYr5hKayE7XveSvxFw1B4G7r1sc5DKHA3Q+XtY67lJi
         7YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A+uesByqCs0ybnziWaHlVRhSkDkrI54gGo+LelIbN8=;
        b=Ll05A5ZgJHVHVvkBShZ2WP//ESQ1liDBHTlFHkQu3ydg3ko5b7ZzLHYYwLSE9abGe9
         aPPFtLw5WU063LBvCh4fY0vkJH4YiH4SP/nbEdoL1QWJRd4ijVSPHH7jDiNz6+/ppZXQ
         N+slLVYUcgSUoiAeJei/HFj8gPpHLJ/s+GqHlnXDyYWf2VdSmFa6ghkQf+e9Q2btl3i3
         IdfscbCHIXUngZegaisBinLVwJgvZxbloxcTofMk2qicMLAejFhs7hlsOa5gm2lUIg/o
         JkxMACA9P7BClSDQxdDILzAnmQaRJLYHcipcGSoidEYbPxhMe2pTJFaakhTW8/X/vqzI
         2rVw==
X-Gm-Message-State: AO0yUKWuMXKHoG2zs5AsDGOVI1inFdcLAS7ILLWW1H96Br2labE023x5
        k3NEN6cNhjwT11ZEVubnp14=
X-Google-Smtp-Source: AK7set9iTftYpF+BDslaKxYNqhbD69QGZFv+LHJY1PPCosR1059K4W/cpvwRhkJF7gayU8SO3yD6pA==
X-Received: by 2002:a17:907:d2a:b0:8af:3922:ace6 with SMTP id gn42-20020a1709070d2a00b008af3922ace6mr8959544ejc.40.1676041957041;
        Fri, 10 Feb 2023 07:12:37 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id mb20-20020a170906eb1400b0087bdb44bbc0sm2466930ejb.32.2023.02.10.07.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:12:36 -0800 (PST)
Date:   Fri, 10 Feb 2023 16:12:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Ni <wni@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Subject: Re: thermal/drivers/tegra: Getting rid of the get_thermal_instance()
 usage
Message-ID: <Y+Ze4tAM6Jpszq/3@orome>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome>
 <20230210131703.GF175687@linaro.org>
 <Y+ZQC85TM+O8p8gQ@orome>
 <365c469b-22f6-fb26-1872-5e9a5079af5d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JIDgmFM8RuLhVr6d"
Content-Disposition: inline
In-Reply-To: <365c469b-22f6-fb26-1872-5e9a5079af5d@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JIDgmFM8RuLhVr6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2023 at 03:36:59PM +0100, Daniel Lezcano wrote:
> On 10/02/2023 15:09, Thierry Reding wrote:
> > On Fri, Feb 10, 2023 at 02:17:03PM +0100, Daniel Lezcano wrote:
> > > Hi Thierry,
> > >=20
> > > On Thu, Jan 26, 2023 at 01:55:52PM +0100, Thierry Reding wrote:
> > > > On Tue, Jan 24, 2023 at 08:57:23PM +0100, Daniel Lezcano wrote:
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > does anyone know what is the purpose of the get_thermal_instance(=
) usage in
> > > > > this code:
> > > > >=20
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git=
/tree/drivers/thermal/tegra/soctherm.c?h=3Dthermal/linux-next#n623
> > > > >=20
> > > > > The driver is using a function which is reserved for the thermal =
core. It
> > > > > should not.
> > > > >=20
> > > > > Is the following change ok ?
> > > > >=20
> > > > > diff --git a/drivers/thermal/tegra/soctherm.c
> > > > > b/drivers/thermal/tegra/soctherm.c
> > > > > index 220873298d77..5f552402d987 100644
> > > > > --- a/drivers/thermal/tegra/soctherm.c
> > > > > +++ b/drivers/thermal/tegra/soctherm.c
> > > > > @@ -620,9 +620,8 @@ static int tegra_thermctl_set_trip_temp(struct
> > > > > thermal_zone_device *tz, int trip
> > > > >   				continue;
> > > > >=20
> > > > >   			cdev =3D ts->throt_cfgs[i].cdev;
> > > > > -			if (get_thermal_instance(tz, cdev, trip_id))
> > > > > -				stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > > > -			else
> > > > > +			stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > > > +			if (!stc)
> > > > >   				continue;
> > > > >=20
> > > > >   			return throttrip_program(dev, sg, stc, temp);
> > > > > @@ -768,9 +767,9 @@ static int tegra_soctherm_set_hwtrips(struct =
device
> > > > > *dev,
> > > > >   			continue;
> > > > >=20
> > > > >   		cdev =3D ts->throt_cfgs[i].cdev;
> > > > > -		if (get_thermal_instance(tz, cdev, trip))
> > > > > -			stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > > > -		else
> > > > > +
> > > > > +		stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > > > +		if (!stc)
> > > > >   			continue;
> > > > >=20
> > > > >   		ret =3D throttrip_program(dev, sg, stc, temperature);
> > > >=20
> > > > There's a small difference in behavior after applying this patch. P=
rior
> > > > to this I get (on Tegra210):
> > > >=20
> > > > 	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing the=
rmtrips, will use critical trips as shut down temp
> > > > 	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when cpu reaches 102500 mC
> > > > 	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for cpu to 102500
> > > > 	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when cpu reaches 102500 mC
> > > > 	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when gpu reaches 103000 mC
> > > > 	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for gpu to 103000
> > > > 	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when gpu reaches 103000 mC
> > > > 	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when pll reaches 103000 mC
> > > > 	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when mem reaches 103000 mC
> > > >=20
> > > > and after these changes, it turns into:
> > > >=20
> > > > 	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing the=
rmtrips, will use critical trips as shut down temp
> > > > 	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when cpu reaches 102500 mC
> > > > 	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for cpu to 102500
> > > > 	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when cpu reaches 102500 mC
> > > > 	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when gpu reaches 103000 mC
> > > > 	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for gpu to 103000
> > > > 	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when gpu reaches 103000 mC
> > > > 	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when pll reaches 103000 mC
> > > > 	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for pll to 103000
> > > > 	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when pll reaches 103000 mC
> > > > 	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when mem reaches 103000 mC
> > > > 	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for mem to 103000
> > > > 	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when mem reaches 103000 mC
> > > >=20
> > > > The "programming throttle ..." messages are something I've added lo=
cally
> > > > to trace what gets called. So it looks like for "pll" and "mem" the=
rmal
> > > > zones, we now program trip points whereas we previously didn't.
> > >=20
> > > The DT descriptioni (tegra210.dtsi) says one thing and the implementa=
tion says
> > > something else.
> > >=20
> > > If we refer to the PLL description, there is one 'hot' trip point and
> > > one 'critical' trip point. No polling delay at all, so we need the
> > > interrupts.
> > >=20
> > > Logically, we should set the 'hot' trip point first, when the trip
> > > point is crossed, we setup the next trip point, which is the critical.
> > >=20
> > > With these two trip points, the first one will send a notification to
> > > the userspace and the second one will force a shutdown of the
> > > system. For both, no cooling device is expected.
> >=20
> > I think the intention here is to use the soctherm's built-in throttling
> > mechanism as a last resort measure to try and cool the system down. I
> > suppose that could count as "passive" cooling, so specifying it as the
> > cooling device for the "passive" trip point may be more appropriate.
> >=20
> > The throttling that happens here is quite severe, so we don't want it to
> > happen too early. I would expect that our "passive" trip point shouldn't
> > be a lot less than the "hot" temperature. I suspect that's the reason
> > why the "hot" trip point was reused for this.
> >=20
> > I'm also beginning to think that we should just not expose the soctherm
> > throttling as a cooling device and instead keep it internal to the
> > soctherm driver entirely.
>=20
> Yes, and perhaps separate it from the sensor driver.
>=20
> There is a similar hardware limiter for the qcom platform [1]. The
> description in the device tree is separated from the sensor and the bindi=
ng
> has temperatures to begin the mitigation [2].

The hardware throttling is controlled using registers that are part of
the SOCTHERM block, so we can't separate it from the sensor driver. I
don't think that's much of a problem, though. The code for this already
exists in the current soctherm driver, so it's just a matter of removing
the cooling device registration code.

>=20
> There is no trip point associated as those are related to the in-kernel
> mitigation.
>=20
> If this mitigation is a heavy mitigation, above what the kernel is able to
> do with a passive cooling device. It would make sense to just have
> configured outside of the thermal zone.
>=20
> So the configuration would be something like:
>=20
> myperformance_limite {
> 	@ =3D <0x...>
> 	temperature_limit =3D 95000;
> };
>=20
> thermal_zone {
>=20
> 	cpu : {
> 		trips {
> 			alert {
> 			temperature =3D 90000;
> 			hysteresis =3D 2000;
> 			type =3D passive;
> 			};
>=20
> 			hot {
> 			temperature =3D 97000;
> 			type =3D hot;
> 			};
>=20
> 			critical {
> 			temperature =3D 100000;
> 			hysteresis =3D 2000;
> 			type =3D critical;
> 			};
>=20
> 			cooling-maps =3D <&cpu NO_LIMIT NO_LIMIT>;
> 		};
> 	}
> };
>=20
> The behavior will be a passive mitigation, if it fails the hardware limit=
er
> will take over, if that fails then hot sends a notification to the usersp=
ace
> (giving the opportunity to hotplug a cpu or kill a task or suspend), if t=
hat
> fails then shutdown.

Yeah, that's exactly what I had in mind.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tre=
e/drivers/thermal/qcom/lmh.c?h=3Dthermal/bleeding-edge
>=20
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tre=
e/arch/arm64/boot/dts/qcom/sdm845.dtsi?h=3Dthermal/bleeding-edge#n3922
>=20
> [ ... ]
>=20
> > On the DT side, I think most of the cooling maps can be cleaned up. We
> > can remove the entries for "critical" and "hot" trip points if the
> > driver unconditionally programs the automated throttling.
>=20
> You may want to keep the critical trip points at least. Even if the hardw=
are
> limiter is certainly very effective, having the critical point is another
> fail safe allowing to gracefully shutdown the system before a wild hardwa=
re
> reset.

Yeah. What I meant was to remove only the cooling map entries for
critical and hot since they would be unused. We absolutely want to
keep the trip points themselves around to make sure the system will
forcefully shutdown as a last resort.

Thierry

--JIDgmFM8RuLhVr6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPmXuIACgkQ3SOs138+
s6E70g//SZakR92FgARoCs1Tvvl43y7WhezvnE4SIRYQBbKlq1VB+sm3TNbX2z3T
telPoTjq5rEfejY1fQ67Eqd7EfWmH5FJxTaaqhR4+oVwJyxTQhb2tCXKtuUzqPtQ
JueUak0KK1hdtVCDZapCLmJHoThPVakQvzDiPouVZ0ZZjdi/VwTatJngod6lkAhR
rqu1OSqjggldjx/iMWOycTb3AQ1XfSsVb4w4q5bq3bntIpIyhSpwiZB/tMwGQsCn
LKIsMFJ2MvXr85l1m426pjWdr6aqZMxwU+hUyvTb3deP6XBMgGvYtP7ouaS7dE8Q
hawWwQdv2eA2/loxDV2PvqM9hsmT/0ZFeQlcH3oMucf0LzxsFxpbnabASSIdmou8
DEEaJ4Kdr+AtiQQmXkEdTqKs8i7tQ0i3aZJTYrbzQjMklDdQaH0KTRW9VQCXmPev
OsgkcZiNjNrfHbYyA5wP6o3TplZouIhN9dUDHh3YMyJ9V1JEK1gsAuEHlWrHe6Bn
JbtyDDksaE48LWNDob1C5l0QCJcVfvwSAQzZjJMhomUpmtXAOpgX4ZmVQpsbVHdT
pO1So70fP5fpXypmj8fQdV4Dddsi9Qyu9zUhq1pSjeSMW4f2KAPdCEraMh6sxlbQ
lCZGSDilnLwFpsMGQNf12sQPbhJwhTJ56VLXTcyV9iQplR41uBA=
=EWv3
-----END PGP SIGNATURE-----

--JIDgmFM8RuLhVr6d--
