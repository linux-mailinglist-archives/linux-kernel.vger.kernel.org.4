Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40F6FC651
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjEIM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjEIM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:27:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CE18C
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:27:40 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pwMQu-0005KF-Kj; Tue, 09 May 2023 14:27:08 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7F6961C0DEB;
        Tue,  9 May 2023 12:27:05 +0000 (UTC)
Date:   Tue, 9 May 2023 14:27:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Judith Mendez <jm@ti.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schuyler Patton <spatton@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: net: can: Add poll-interval for MCAN
Message-ID: <20230509-strike-available-6b2378172a59-mkl@pengutronix.de>
References: <20230501224624.13866-1-jm@ti.com>
 <20230501224624.13866-2-jm@ti.com>
 <20230505212948.GA3590042-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ruyafeokmkujpvvo"
Content-Disposition: inline
In-Reply-To: <20230505212948.GA3590042-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--ruyafeokmkujpvvo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.05.2023 16:29:48, Rob Herring wrote:
> On Mon, May 01, 2023 at 05:46:21PM -0500, Judith Mendez wrote:
> > On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> > routed to A53 Linux, instead they will use software interrupt by
> > hrtimer. To enable timer method, interrupts should be optional so
> > remove interrupts property from required section and introduce
> > poll-interval property.
> >=20
> > Signed-off-by: Judith Mendez <jm@ti.com>
> > ---
> > Changelog:
> > v3:
> >  1. Move binding patch to first in series
> >  2. Update description for poll-interval
> >  3. Add oneOf to specify using interrupts/interrupt-names or poll-inter=
val
> >  4. Fix example property: add comment below 'example'
> >=20
> > v2:
> >   1. Add poll-interval property to enable timer polling method
> >   2. Add example using poll-interval property
> >  =20
> >  .../bindings/net/can/bosch,m_can.yaml         | 36 +++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml=
 b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 67879aab623b..c024ee49962c 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > @@ -14,6 +14,13 @@ maintainers:
> >  allOf:
> >    - $ref: can-controller.yaml#
> > =20
> > +oneOf:
> > +  - required:
> > +      - interrupts
> > +      - interrupt-names
> > +  - required:
> > +      - poll-interval
>=20
> Move this next to 'required'.
>=20
> > +
> >  properties:
> >    compatible:
> >      const: bosch,m_can
> > @@ -40,6 +47,14 @@ properties:
> >        - const: int1
> >      minItems: 1
> > =20
> > +  poll-interval:
> > +    $ref: /schemas/types.yaml#/definitions/flag
>=20
> This is a common property already defined as a uint32. You shouldn't=20
> define a new type.
>=20
> A flag doesn't even make sense. If that's all you need, then just enable=
=20
> polling if no interrupt is present.

Ok, then it's implicit. No IRQs -> polling.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ruyafeokmkujpvvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRaPBYACgkQvlAcSiqK
BOjU0Af+Ksj/LqHQdcZruoOFgMEePW+7vKeglTP2i2NgKhr1bAPQseZHWsrdZ/2w
L2heATaiciw3M9roMdccpxRHix2NFMaYoE+yODdLUkEDcDWS+rQ+NKcJ7/MusnaJ
K65j0alWcKxu2W934e7eP+3/xrf4dwJucPIxsydEbL2+JXBOadhcJTHRjUcuHz8k
Jig4Xql76vsuccFjZZ1T6anurjbnxVg2lTcw8CBFdjMspC33RJd6QEw9QELrapem
0s1iBupm+b0uo0X37y31rW6+4OM2sntEKWkhrb2FUzvLMAuJqnr5HOktnbZuiqwr
Gb2/9REAlzjAgJefVzGeI/eSZtX48w==
=yn5E
-----END PGP SIGNATURE-----

--ruyafeokmkujpvvo--
