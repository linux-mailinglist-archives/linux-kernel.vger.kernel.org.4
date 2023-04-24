Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891B6E83F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDSVxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDSVxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:53:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F9F3C1E;
        Wed, 19 Apr 2023 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681941173; i=j.neuschaefer@gmx.net;
        bh=E3MwaTC39cHV5jEqiGIoFdw7WcRGnfVKbe7RZwo68iw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LMkeOne8W12inAaZ/YilffTeUnstAOesHyxyoojqAF5QqEUyGHFxXGenviIBKVZDv
         JnFaTLZIwIz3H+zJWTjMJ/H7Fpp+Gcf37ot94tS7gYcv30+KcJjbDGk6+QUbyjlRsc
         sEXODlI9TmrUm1cnPr8pVmari2bYex5Hp2SPEZ6F+rTqtyxKZKvg1n7n2SSHHdCqQT
         dr/LDcwBco9ZBLrQXmOqurNrgJzOy62MvR4W/y+N4LS8VaWG/i259Gqywatxeuextl
         ZuMxy4V9fyIuQhAxmG9bH4+B+NE6EvnU6fY6FZOvo7gZJ3nfZXxM4mLMo2i8DZjc1o
         I6NB30sJayYag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QWG-1ptfZl1Qe0-004QMs; Wed, 19
 Apr 2023 23:52:53 +0200
Date:   Wed, 19 Apr 2023 23:52:57 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     j.neuschaefer@gmx.net, avifishman70@gmail.com,
        benjaminfair@google.com, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzk+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux@roeck-us.net,
        mturquette@baylibre.com, openbmc@lists.ozlabs.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        tali.perry1@gmail.com, tglx@linutronix.de, tmaimon77@gmail.com,
        venture@google.com, wim@linux-watchdog.org, yuenn@google.com
Subject: Re: [PATCH v6 2/2] clk: wpcm450: Add Nuvoton WPCM450 clock/reset
 controller driver
Message-ID: <ZEBiuRH3DjVUO/Kp@probook>
References: <20230415111355.696738-1-j.neuschaefer@gmx.net>
 <20230415111355.696738-3-j.neuschaefer@gmx.net>
 <c04038f2-b7aa-7c37-df93-6950831579f6@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nBgbEHe+7HdynUHs"
Content-Disposition: inline
In-Reply-To: <c04038f2-b7aa-7c37-df93-6950831579f6@wanadoo.fr>
X-Provags-ID: V03:K1:TTKfScm3X+1lV46i2xneBJJ+mRnIdHaebMSneyl8EkLY7S7V6ir
 tmEvh62wdv/WVjbqdH7A84xGNb3RKFAch9n0YeCEcF0Igi49ekDymYcVSXXM2R9hgXdaLO7
 dp/ICD4eIfn/dwbQzeE8iunQWMeFvF0BYiArqRE9d8zM1ppM0/o03p5BANY3lRmUNvTqR9u
 b8Xg1w19VhdJqSmL5lteA==
UI-OutboundReport: notjunk:1;M01:P0:wJFEDQxfRL4=;ah7J+2kmEogfH5rqEMt6ppjheoH
 KrP7wiEcbiG50T6ZYLvyues+omkXepggjO1En8RKwfFQvj9Q+/y30OpG4QV4dyzjUN32pBp8k
 ZTOgqXUIPXH09ZtfnfM5ucGA2R7aA9xIY/8m0Qx0Yx4uhsV16pEv2Ha7tGLWu+a/yy6tayKSP
 xPZUwjW4slngP1ZdWok+JvE2R5s/MzPU9UbEGeuW32Lvdi4Qsmy2H+O/D+Mll3FavTSh+cu0A
 HRhfEflMdgGaYjR3Wrk9oXiLuozTAkbmMf3jCKoqkZbfksy0A2NgAmXsk8syQv9WZri75JWBM
 XOZe5Wg+QW0I6VMzgyXpbPtoSAvWQEFICalKEQfNxdnhRuXGb5EfRaolqY4L4+OjPFFKcEzFH
 Kwpj5X72qUDcZG1Wc4Ll5dlHra46FzDl/zktU65dDa0zbQWPNcGMkFeldM2tQ0KORW+S17Vxv
 bJI0IoSK+2qbFL8239d0Q9Ri/Cjp8AnawJWxWswlaEDN/ItKwjHD1P8WoNStTpfMfT7OBdGsJ
 Y4YhWqJPLhP/d1YvVS8CbI19IEIVGctfHMOh++sB4XXw9mAdMi983yL9429cG7UYEBYHLk7Mo
 HcNDjXXcynLxVelOIm0Wt2I4V9gB+p1H2V59i/4ozElhg74t2lo4Q6NXbx15TBHKhuyY4rZoM
 /PpP7mqUYeLL169L133ueg8iz2uzY3DtntdvNPRlHBO1J24vRPukY6oxol70s1Vk3cqi6vldI
 Z2OWlxj7ZzhJI4goYOm21BAmiSmrNtz07c0UP8kJgq5AUTo/YZexa5Yc8mrZqSyJi77YimMQe
 xf0z2cjZPWQdKZxeMR0MwDmDHCf//oF/Hr+QkfMG9d6w9yVC0UU05ikuA8AZS36uNOTOHH08q
 hKRT8qoU1bMND9hd87X4fZRw/56xTQwjo7noyODDFxPbqIBT8EW0TwbyA2MPek3sGnt7MVPDk
 oJSfanfvsoDljHysdHMo1TiqsIc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nBgbEHe+7HdynUHs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christophe,

On Sat, Apr 15, 2023 at 02:16:09PM +0200, Christophe JAILLET wrote:
> Le 15/04/2023 =C3=A0 13:13, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > This driver implements the following features w.r.t. the clock and reset
> > controller in the WPCM450 SoC:
> >=20
> > - It calculates the rates for all clocks managed by the clock controller
> > - It leaves the clock tree mostly unchanged, except that it enables/
> >    disables clock gates based on usage.
> > - It exposes the reset lines managed by the controller using the
> >    Generic Reset Controller subsystem
> >=20
> > NOTE: If the driver and the corresponding devicetree node are present,
> >        the driver will disable "unused" clocks. This is problem until
> >        the clock relations are properly declared in the devicetree (in a
> >        later patch). Until then, the clk_ignore_unused kernel parameter
> >        can be used as a workaround.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@publ=
ic.gmane.org>
> > ---
[...]
> > +	// Enables/gates
> > +	for (i =3D 0; i < ARRAY_SIZE(clken_data); i++) {
> > +		const struct wpcm450_clken_data *data =3D &clken_data[i];
> > +
> > +		hw =3D clk_hw_register_gate_parent_data(NULL, data->name, &data->par=
ent, data->flags,
> > +						      clk_base + REG_CLKEN, data->bitnum,
> > +						      data->flags, &wpcm450_clk_lock);
>=20
> If an error occures in the 'for' loop or after it, should this be
> clk_hw_unregister_gate()'ed somewhere?

Ideally yes =E2=80=94

in this case, if the clock driver fails, the system is arguably in such
a bad state that there isn't much point in bothering.


>=20
> CJ
>=20
> > +		if (IS_ERR(hw)) {
> > +			pr_err("Failed to register gate: %pe\n", hw);
> > +			goto err_free;
> > +		}
> > +		clk_data->hws[data->bitnum] =3D hw;
> > +	}



Best regards,
Jonathan

--nBgbEHe+7HdynUHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmRAYpUACgkQCDBEmo7z
X9v2qw/9EiZBIWVLXrb/H+SBZLajTH8gs/+wWatpfYY9MHKe6PQ4wEqD3wHZvC1j
XNyEizeN9zKD617uEUNnj4LS65mXB9jpk+IBn2V3S9m8aK0ZnohGPIBQbp7fJxRD
scBOpgCKxii9YUjJFDwfJc+aGteD1FZCV5ufF6W7tAlpqdpRJiV4Sxyui6tplBjb
tmz3EbyRRYJ5IW+qM84oS9xocMvIyFUcSqIAyHZNzS2QyUzl48dHpwjfGn2jJ2q8
enIxwqOsbNUNyYJHynYGVqQGTusRYJxd6Qg7c2fZyOtsRdvvS/cvTvaNeFap27zr
4ciW+NTiD40FzGgrq8glOz18+fBi4HIpR9XYDIYSPNAIiQEmj3Uzn78EQ7xNrSk5
6pjoPtE6AkYtGe/M7CAAjHkV6xiuKIXTXxZQMCI/vw22rg76CJkNzq1UapIqmYUQ
klfYRnd/UFavPt57hVLC94KgBZO2tmikTOksaSnZw6tN0CCXwaz9MnAPR/aaA8YC
8eO/7oNgydKM/K1fUrFBWbR0Td8MLlHmH35xsa9kdVayHin9v7oK8oqtCDFQvDHL
1cd6KQcPHppWTQ7A8nWIjlmm+lm0Y5n1dfRL7/k/Lj6RrpkTOp6BQ+xqIM4LCpQb
SQNXKoHLuiincVsxMWIWi+qDKYENxeosPds/iY3v6vSY82fkv50=
=r2E3
-----END PGP SIGNATURE-----

--nBgbEHe+7HdynUHs--
