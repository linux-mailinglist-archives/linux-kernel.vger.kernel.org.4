Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431ED69462C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBMMqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBMMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:46:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8BB1ADC8;
        Mon, 13 Feb 2023 04:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676292366; x=1707828366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zddgii00RYTRCzy4JajwyXC5VS7tCsfV5RBESAwfvSg=;
  b=jUt3I+FbW25ghA/sNvZClt8toKtwD8x9dx7Zda7tdC68Bm8jukScfnFM
   y2I+znOdNS8zBcRmos95qJCMKt4E68CuDnNipIzrVuoy8oXXkIh56HWBD
   1sNZOUU96X+xC/kPn6MxEf/nGjRMZHVnmsISIGLgNbJhxwYrsjwikCaO4
   ikS8Yclf5ZWISOtcLvaB7Nk9DtzzLj60KPAlzVC5eKY/RU0iJorv58RIf
   dEjKjtkx3GzHzuRp2EMXGAS3IfVpfZZN36dhN1AFO99NeL3dSgSB49+Gk
   mRYVaIEKcMwWvi+2X4lHjV1LGNrBRwdvKx3ek3WRH7otUoHazWy8QR6RO
   A==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669100400"; 
   d="asc'?scan'208";a="200687912"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Feb 2023 05:46:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 05:46:05 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 13 Feb 2023 05:46:03 -0700
Date:   Mon, 13 Feb 2023 12:45:38 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y+ow8tfAHo1yv1XL@wendy>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
 <20230112120141.fpjwhtjuaxrwqt5m@pengutronix.de>
 <Y8Ai0aF5A+O43kjZ@wendy>
 <Y8ruML/XnJHjVWy/@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d06DW3i8sK38cMCJ"
Content-Disposition: inline
In-Reply-To: <Y8ruML/XnJHjVWy/@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--d06DW3i8sK38cMCJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Uwe!

Was nice to meet you at FOSDEM, if I'd seen that presentation before
working on this driver I think the version count would have been
substantially lower!

On Fri, Jan 20, 2023 at 07:40:32PM +0000, Conor Dooley wrote:
> On Thu, Jan 12, 2023 at 03:10:09PM +0000, Conor Dooley wrote:
> > On Thu, Jan 12, 2023 at 01:01:41PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Tue, Jan 10, 2023 at 11:48:05PM +0100, Uwe Kleine-K=F6nig wrote:

> *sigh*, me again...
>=20
> Picked this up this afternoon to try and respin a v14 and ran into a bit
> of an issue with this suggestion:
>=20
> > > 	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX)
> > > 	if (*prescale)
> > > 		*prescale -=3D 1;
>=20
> In theory this works out, but with integer division it doesn't AFAICT.
>=20
> Take for example:
> period_ns =3D 10,000
> clk_rate =3D 62.5 MHz
>=20
> The prescale calculation is:
> (10000 * 62.5E6) / (1E9 * 255) - 1 =3D 1.451 -> 1
>=20
> For period_steps then:
> (10000 * 62.5E6) / (1E9 * (1 + 1)) - 1 =3D 311.5 -> 311
>=20
> prescale is a u16, since it's valid for that division to return 256.
> The register is only 8 bits wide though, so 311 overflows it and 55 ends
> up in the register.
> The period then is:
> (55 + 1) * (1 + 1) / 62.5E6, or a period of 1792 ns.
>=20
> I think it needs to be a div_u64_round_up(), which I know is not a real
> function, otherwise we compute invalid values for period steps.
>=20
> Quoting you previously:
> > I thought a bit about that (without pencil and paper on my way to work
> > today), and the optimal solution is non-trivial. In fact you have to
> > pick parameters A and B such that for a given C
> >=20
> > 	(A + 1) * (B + 1) is maximal with
> >=20
> > 	0 <=3D A < 0x100
> > 	0 <=3D B < 0xff
> > 	(A + 1) * (B + 1) <=3D C
>=20
> As we need (period_steps + 1) * (prescale + 1) maximal, *but* also want
> to maximise period_steps so that duty resolution etc is maximal too.
> We pick prescale, using the formula below, by setting period_steps to
> the maximum possible value:
> > 	            period * clk_rate
> > 	prescale =3D -------------------
> > 	           NSEC_PER_SEC * 0xff
>=20
> Given we set period_steps to the max here, we only actually pick the
> lower bound on prescale, not the actual value of it.
> We must round it to the nearest possible value before using it to go
> back and calculate period_steps.
>=20
> With the previous code, missing the -=3D 1, the division result was purely
> truncated:
> (10000 * 62.5E6) / (1E9 * 255) =3D 2.451 -> 2
> That 2 was written into the register, and then the hardware rounds that
> up to 3, as does the period_steps calculation.
>=20
> period_steps here is:
> (10000 * 62.5E6) / (1E9 * (2 + 1)) - 1 =3D 207.833 -> 207
>=20
> Finally, the period:
> (207 + 1) * (2 + 1) / 62.5E6, or a period of 9984 ns.
>=20
> This is the same operation, unless I am yet again overlooking something,
> as doing a div_u64_round_up() type thing, followed by a subtraction of 1
>=20
> We don't need to worry about writing something too big into the register
> either, as we are protected against values of tmp that, when divided by
> 0xff, would produce values larger than 255:
> > /*
> >  * The hardware adds one to the register value, so decrement by one to
> >  * account for the offset
> >  */
> > if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) { (PERIOD_MAX is 0xff00)
> > 	*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > 	*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> >=20
> > 	return;
> > }
>=20
> What am I missing this time? haha

So my "plan" I guess is to rebase this on v6.3-rc1 & re-submit with the
various minor bits fixed.
Trying the proposed "fixes" to the period calculation that we had
discussed pointed out the above issue, and it appears, to me at least,
that we made a mess of translating from regular calculations to integer
ones.

Cheers,
Conor.


--d06DW3i8sK38cMCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+ow8gAKCRB4tDGHoIJi
0icOAQCcx3scSfDj18iHQbxSESPavXkS87/Xlcb5j3+R2yDf9gEAm/owNFfpq3/t
XxD5zIYT0u1k/G0Mxamq3ZHD+wVtIQ0=
=+gkG
-----END PGP SIGNATURE-----

--d06DW3i8sK38cMCJ--
