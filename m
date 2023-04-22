Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EB6EBA17
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 17:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDVP5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDVP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 11:57:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C40119;
        Sat, 22 Apr 2023 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1682178995; i=j.neuschaefer@gmx.net;
        bh=UFyq5axvJcNsz0Fjz36jtW09WWOe6XfQ8XnSNYq26OM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jhCwElgzyVzcf6zhLYMPdR8LNrsTH1p2aOeja5J1VeX8w1QqVr4hwlneJ84mKHWAx
         HdRY4P2N//q/bqGCME7wdPh/tlIWk24Tz71xyGbqA7AqbO/1Z6hGEhv50xDz/kDFwC
         1VFhxLOPAWMfDmtwtD4/YzEM9T18ZItzx+AN2HnOBvKScGMFd5FCvc8QPJisK0G1tK
         t/MHrY49vE5+xiCjY2oAhWGMV7yUovqiJ+rc3ht0LbqG6L6wXPV98ttR5Y7hiNs7MS
         15fmYYRNxbPpr/Kn+qYIdWaGIo5UxZuVCwI57WOdy66pgSa08q5xhPFScm9yNEFE5m
         V5uwwtU/RXgUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1q8sRl3ifz-00rsCB; Sat, 22
 Apr 2023 17:56:35 +0200
Date:   Sat, 22 Apr 2023 17:56:32 +0200
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
Message-ID: <ZEQDsLYaRywV9IbF@probook>
References: <20230415111355.696738-1-j.neuschaefer@gmx.net>
 <20230415111355.696738-3-j.neuschaefer@gmx.net>
 <c04038f2-b7aa-7c37-df93-6950831579f6@wanadoo.fr>
 <ZEBiuRH3DjVUO/Kp@probook>
 <1f1b088c-85d2-13ed-bbb1-043409dbe894@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wBtEmj/GHkQArSVj"
Content-Disposition: inline
In-Reply-To: <1f1b088c-85d2-13ed-bbb1-043409dbe894@wanadoo.fr>
X-Provags-ID: V03:K1:ylmmr/4kgHp15Xb1RvW1UVIaEunANbl10H6e0zPe9HHJJwa69i9
 OK8KpchVwUVb1Yp17kuenenlhkiRgUgMHqVt3vxHcPJ/KeWzRjr45JXCSTGMzrR9Y30jgNC
 UrcL3OberlEPUu90dCuqiknKtifX12y3FdlcXoCHV8lRkyfMSodJI1KRZsfWyLdb2/e/zKE
 zwA4auX2wBUod8gCT1NCg==
UI-OutboundReport: notjunk:1;M01:P0:97RAzFhE8GI=;jQrFiJ4qzZ+dN4UftPaapw/hkj4
 0jc9UjTbASAf/W4Vb0PHOu0bnnztUdn59FBN8ntko7pFeo6b7yKh5tewLZcZ8dYIhjAJAiefD
 ZhjyjSGx5CJ0Ugczh2ph7jcP4bVTO9oWr5Z+Uvc3orUp9kJZNiRVT9k9mjaN6IV2Ptqb4h7gE
 7aO6h+K/rPLIShMZDKV8x/v0uLm8HqrovZcB+3E1CwSqeO28RAPzaxeQ3HGNA2hO7McHrSRuF
 2l1Fisdfw/TpPmWHfrcV555Sty1AMkRdWeG9RxfPRlUr1/mi9XXtxaNR123bfTf3CvWpNlzwT
 iLBwTUJ3eaJTyWu49KJE0YTsSctARqeV04eidR27Z7UXs4Uud20QbZ4XgNY+SU7Zlki5hk809
 Yaol7YPIq7lmbD89k+jrAAW5RzFEo7zU/+UlHAPpg1jLelQB/WKUZ8uFOUmVQbe4VB7U83Wlj
 nlhQXvLgNvcH3yAuDQL5fze6DugzFKN7KRZsZ4XjNHGjrGjdpdBHsr3psxK7A6YKtgUjEADkh
 M8vG5D7GlC5qGRe1mUVVZRqi6im0J2b/N5nEtHk1WsWMePmKRDPl3pGsEfrrwOZnXlk4gRgYV
 dZ5f5Wca2qCDB8Eph41P0hkfU9/ON23sE9SkOk8wj2NL5RbxmTqOOLZ0iiqANS0nFyRRuHYH9
 hjqyGolutav+wUMToJeG8IrPbOSRbdaZpwK7JvFBdQPTC2jtjl3MYSkzdNoz3xETIOcSIF2it
 n3xeADDiUV6dSgfirmYLp+LDCJUz+q9LA3PF7+beZtQYP0v9OFRCbXOfDaOAwxbQPrmWRsxpW
 ZgbEnPgGkfkOMQoT+wborxIigG24uMfl9F8jdqKYRoHgs4bAj4G0Bc9DRIsrWOYESdNN2Xpag
 armu3PIYJYWtei8NSWYZRb8fdmOfI81PkqC2Za+ttLUfuo4wBdq56NG47E+5uwTAhZypSrZZz
 B51RHYqL/WfamVhyFQZ2SYCpXH4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wBtEmj/GHkQArSVj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2023 at 07:32:07AM +0200, Christophe JAILLET wrote:
> Le 19/04/2023 =C3=A0 23:52, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > On Sat, Apr 15, 2023 at 02:16:09PM +0200, Christophe JAILLET wrote:
> > > Le 15/04/2023 =C3=A0 13:13, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=
=A0:
[...]
> > > > +	// Enables/gates
> > > > +	for (i =3D 0; i < ARRAY_SIZE(clken_data); i++) {
> > > > +		const struct wpcm450_clken_data *data =3D &clken_data[i];
> > > > +
> > > > +		hw =3D clk_hw_register_gate_parent_data(NULL, data->name, &data-=
>parent, data->flags,
> > > > +						      clk_base + REG_CLKEN, data->bitnum,
> > > > +						      data->flags, &wpcm450_clk_lock);
> > >=20
> > > If an error occures in the 'for' loop or after it, should this be
> > > clk_hw_unregister_gate()'ed somewhere?
> >=20
> > Ideally yes =E2=80=94
> >=20
> > in this case, if the clock driver fails, the system is arguably in such
> > a bad state that there isn't much point in bothering.
> >=20
>=20
> Ok, but below we care about freeing clk_data->hws in the error handling
> path.
>=20
> Why do we handle just half of the resources?
> Shouldn't it be all (to be clean, if it makes sense) or nothing (to reduce
> the LoC and have a smaller driver)?

I thought about it for a bit, and I think I'm ok with reducing the
deallocation in this driver to nothing. I'll spin a new version.

Conversely, if I were to implement proper error handling here, I'd
convert it into a platform driver and use devm_* functions, because
dealing with all the little clock objects is just too painful and
fragile for my taste.


Thanks,
Jonathan

--wBtEmj/GHkQArSVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmREA4gACgkQCDBEmo7z
X9vELw//XtgZ45bo+nh7sRo2vLpDjlAMfwsWrnL/cHpN2rA/vinTR2rOZ8LwJAhG
iuL5Smhp3DQv8H6ZUxvhyy2xZ3qXAxej5h8PVaUZlxLNwmG9Ro4Gyoy+n8VJagCz
/FClvZ9sK6yGJXKayQwFZPdAGSZAN9CFpDiU10hteChB9U7UcoA5+UjUnY+15m6G
NwK1x6u4UHUu6uQRBFapTX9RMBMMmc7zfJcq4nXvVfMaw+g9V6wPeiCJHetTnXC3
A9q28JWdro6ZTu/DxfdEobpemv+gOM515g1HNZjORwy24vbfW6CuVxmAW64S3cwU
Vu+OSfC7k4xY71pOGB2VrXpTqeSipobJmx3tU59wyjypysp3Mp/tUldd56eJGpko
SMOrlH+LK866KMwUs7/qXNHdtDnsX4UtbdsiwwNCePgUeMqMcGLTd9wueVlUn/vj
13SRz6wsdtKrvFA1daTP/7m1eFZ6dnLEU6AJAcZGVk60Bvq7NHYD7tnyMIJnM1xt
3L82jBDW/58n290YMgVTKGt+zS+ZrFcn11ReMksvdWRKCUJRczmVLqhtLPA2IHjU
D8vpmqO52/qEVskIwIJ+I/nlmY+3JnFBakdP8EQkSKGkfCJSrEBfehrYLeNDmgFg
I/NeOR+jh1tSTebpHJGeeuWUKGO8AZeOs5IgrElfVRvkxiLRJeU=
=+Ar6
-----END PGP SIGNATURE-----

--wBtEmj/GHkQArSVj--
