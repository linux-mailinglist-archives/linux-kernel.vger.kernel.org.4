Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE3C747E41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGEHam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGEHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:30:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B641E4F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:30:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGwxk-00074H-2x; Wed, 05 Jul 2023 09:30:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGwxd-00CDDv-9E; Wed, 05 Jul 2023 09:30:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGwxc-002Nyt-Mr; Wed, 05 Jul 2023 09:30:00 +0200
Date:   Wed, 5 Jul 2023 09:30:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
Message-ID: <20230705073000.oxlb7e7sdkdxurps@pengutronix.de>
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-2-frank.li@vivo.com>
 <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
 <20230703174347.4m6hcmify4jwsozv@pengutronix.de>
 <11052797-b006-11bb-e4eb-987ddd568b24@kernel.org>
 <20805fef-d6aa-91d8-999e-04b1d6b7a37a@vivo.com>
 <20230704141954.fcmol2yswkpbnpaw@pengutronix.de>
 <20230705101537.000059d2@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3w7pvwtu25s3yawr"
Content-Disposition: inline
In-Reply-To: <20230705101537.000059d2@Huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3w7pvwtu25s3yawr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 05, 2023 at 10:15:37AM +0800, Jonathan Cameron wrote:
> On Tue, 4 Jul 2023 16:19:54 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello,
> >=20
> > On Tue, Jul 04, 2023 at 05:06:12PM +0800, Yangtao Li wrote:
> > > On 2023/7/4 16:48, Krzysztof Kozlowski wrote:
> > >  =20
> > > > [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=E6=
=9D=A5=E8=87=AA krzk@kernel.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=
=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSenderIden=
tification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=82=B9=
=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
> > > >=20
> > > > On 03/07/2023 19:43, Uwe Kleine-K=C3=B6nig wrote: =20
> > > > > Hello Krzysztof,
> > > > >=20
> > > > > On Mon, Jul 03, 2023 at 02:31:59PM +0200, Krzysztof Kozlowski wro=
te: =20
> > > > > > On 03/07/2023 11:04, Yangtao Li wrote: =20
> > > > > > > There are more than 700 calls to the devm_request_threaded_ir=
q method.
> > > > > > > Most drivers only request one interrupt resource, and these e=
rror
> > > > > > > messages are basically the same. If error messages are printed
> > > > > > > everywhere, more than 1000 lines of code can be saved by remo=
ving the
> > > > > > > msg in the driver. =20
> > > > > >=20
> > > > > > ...
> > > > > >  =20
> > > > > > > +int devm_request_threaded_irq_emsg(struct device *dev, unsig=
ned int irq,
> > > > > > > +                              irq_handler_t handler, irq_han=
dler_t thread_fn,
> > > > > > > +                              unsigned long irqflags, const =
char *devname,
> > > > > > > +                              void *dev_id, const char *emsg)
> > > > > > > +{
> > > > > > > +   int rc;
> > > > > > > +
> > > > > > > +   rc =3D devm_request_threaded_irq(dev, irq, handler, NULL,=
 irqflags,
> > > > > > > +                                  devname, dev_id);
> > > > > > > +   if (rc && rc !=3D -EPROBE_DEFER) {
> > > > > > > +           dev_err(dev, "Failed to request %sinterrupt %u %s=
 %s: %pe\n",
> > > > > > > +                   thread_fn ? "threaded " : "", irq, devnam=
e ? : dev_name(dev),
> > > > > > > +                   emsg ? : "", ERR_PTR(rc)); =20
> > > > > > It is open-coding dev_err_probe(). Just use dev_err_probe inste=
ad. =20
> > > > > dev_err_probe is supposed to be only called in probe functions, w=
hile
> > > > > devm_request_threaded_irq might be called in other contexts (e.g.=
 when a
> > > > > device is opened). That's why I asked to not use dev_err_probe() =
in v2 =20
> > > > True, but then all the callers of this function will forget to set
> > > > deferred probe reason. =20
> >=20
> > That's another reason for letting the driver issue the error message and
> > not the request_irq function.
> > =20
> > > So let's use dev_err_probe?
> > >=20
> > > BTW, any suggestions for names here, keep using
> > > devm_request_threaded_irq_emsg or change to a new name? =20
> >=20
> > I would have called it devm_request_threaded_irq_verbose() which I
> > consider easier to understand. But maybe  is just my (green)
> > bikeshed.
>=20
> If going to use dev_err_probe() internally maybe can just use
> devm_request_threaded_irq_probe() thus reflecting that and making
> it different to the devm_request_threaded_irq()?

I like devm_request_threaded_irq_probe(), thanks for that suggestion
(even though it's red :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3w7pvwtu25s3yawr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSlG/cACgkQj4D7WH0S
/k7NJAf/W/VmS09wlRNdQ8cSrZRQMlAZTlz/61ILtur39hnGBqdq32Vg8eyL4OLD
hIkfsr7VsST40mM9u3ar/g4g0upuPF64MagUJ1Xo4H8oSsg7AoEdMRCeQUYmP0ru
EZnLjykOQRjPbKG1w3qbh6P380EMUUmebcsvq2hftoWNOFN839DtdIwQbbjDyU88
WAQY4KYps2wtAkIFsdRwc5B2AfPcRvsA2u1eGoTdHO7GMxTW1gHSP0+JdPbCwo+G
yNja5Eoh59NpRQxNLmHbKDdT2QVmov+o8+UQdmULeTeAIMHJhPasklv4XckQahBg
MdJl4H/H2ukouHulyntW3si+qNnScg==
=whBA
-----END PGP SIGNATURE-----

--3w7pvwtu25s3yawr--
