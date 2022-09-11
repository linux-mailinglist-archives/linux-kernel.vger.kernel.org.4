Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB65B586B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiILK3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiILK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECADE38685;
        Mon, 12 Sep 2022 03:28:38 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7D3A6601FE1;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978517;
        bh=csuEsJifKVJyLRd1XpzpXHyhSvlWfN/+RiTgurHozt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBQhSNbb14ZZXY4urBm4VWUdYii3jxLQAQJ5yFtGvzYDFZL8uL7jOMdrlu3XgrKMf
         mRQCuSzsMS336AoTuLFGe++JTaZE87uC7WbKBUX5onGz41MBar3jXPxxBq6zCecxrg
         /hDzErS0Go6RWGHL/oioHn3hbMyGg1eCCz6V1M24D30fJndp1vbCtwGw3nUh1NABQE
         601C+ALp/MHqa6QgUa2piHoLVVvrTAXI9kaIkl/lEwGYkbjDUORjDk2T5E7/Q5/B91
         CVhjoPK96/v/Ulbcs8IR+S2snWNmVOxzB/RsEBIewQ75xSwXJAIusK8Lb8+92ONevi
         QGkoeCBsTim+A==
Received: by mercury (Postfix, from userid 1000)
        id A83E8106335A; Sun, 11 Sep 2022 14:27:38 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:27:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: restart-handler: add common
 schema
Message-ID: <20220911122738.jjve6fs63fj733ug@mercury.elektranox.org>
References: <20220907123630.57383-1-krzysztof.kozlowski@linaro.org>
 <20220907163218.aja4pazw3sbxnoop@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jm67xm5kqtnotww6"
Content-Disposition: inline
In-Reply-To: <20220907163218.aja4pazw3sbxnoop@pali>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jm67xm5kqtnotww6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 07, 2022 at 06:32:18PM +0200, Pali Roh=E1r wrote:
> On Wednesday 07 September 2022 14:36:30 Krzysztof Kozlowski wrote:
> > Add common schema for restart and shutdown handlers, so they all use
> > same meaning of "priority" field.  The Linux drivers already have this
> > property and some systems want to customize it per-board in DTS.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > See also:
> > https://lore.kernel.org/all/8fe93da3-f768-16ae-7025-1cfa97a42b27@linaro=
=2Eorg/
> > https://lore.kernel.org/all/20220831081715.14673-1-pali@kernel.org/
> > ---
> >  .../bindings/power/reset/gpio-restart.yaml    | 13 ++------
> >  .../bindings/power/reset/restart-handler.yaml | 30 +++++++++++++++++++
> >  2 files changed, 33 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/resta=
rt-handler.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart=
=2Eyaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> > index a72d5c721516..d3d18e0f5db3 100644
> > --- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> > @@ -25,6 +25,9 @@ description: >
> >    inactive-delay, the GPIO is driven active again.  After a delay spec=
ified by wait-delay, the
> >    restart handler completes allowing other restart handlers to be atte=
mpted.
> > =20
> > +allOf:
> > +  - $ref: restart-handler.yaml#
> > +
> >  properties:
> >    compatible:
> >      const: gpio-restart
> > @@ -41,16 +44,6 @@ properties:
> >        in its inactive state.
> > =20
> >    priority:
> > -    $ref: /schemas/types.yaml#/definitions/uint32
> > -    description: |
> > -      A priority ranging from 0 to 255 (default 129) according to the =
following guidelines:
> > -
> > -        0:   Restart handler of last resort, with limited restart capa=
bilities.
> > -        128: Default restart handler; use if no other restart handler =
is expected to be available,
> > -             and/or if restart functionality is sufficient to restart =
the entire system.
> > -        255: Highest priority restart handler, will preempt all other =
restart handlers.
> > -    minimum: 0
> > -    maximum: 255
> >      default: 129
> > =20
> >    active-delay:
> > diff --git a/Documentation/devicetree/bindings/power/reset/restart-hand=
ler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.ya=
ml
> > new file mode 100644
> > index 000000000000..f5d22ca0cd45
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Restart and shutdown handler generic binding
> > +
> > +maintainers:
> > +  - Sebastian Reichel <sre@kernel.org>
> > +
> > +description:
> > +  Restart and shutdown handler device is responsible for powering off =
the
> > +  system, e.g. my cutting off the power.  System might have several re=
start
> > +  handlers, which usually are tried from most precise to last resort.
> > +
> > +properties:
> > +  priority:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>=20
> IIRC priority is signed integer number, not unsigned.
>=20
> > +    description: |
> > +      A priority ranging from 0 to 255 according to the following guid=
elines::
> > +        0:   Restart handler of last resort, with limited restart capa=
bilities.
> > +        128: Typical, default restart handler; use if no other restart=
 handler
> > +             is expected to be available, and/or if restart functional=
ity is
> > +             sufficient to restart the entire system.
> > +        255: Highest priority restart handler, will preempt all other =
restart handlers.
> > +    minimum: 0
> > +    maximum: 255
>=20
> And IIRC also other values (above 255 or below 0) are allowed for tuning
> two "highest" or two "last resort" handlers.
>=20
> This needs to be checked / tested to ensure that new schema is not incorr=
ect.

priority is blindly copied into the priority field of struct
notifier_block, which is of type int. But that is an implementation
detail. I think the proposal from Krzysztof looks good. But let's
wait a bit to give Rob a chance to review.

-- Sebastian

--jm67xm5kqtnotww6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd1DoACgkQ2O7X88g7
+pqS+A//YH8tttmtMUPbKLQ3SdPDIFr6POfYz3R6gLWk4aUpJfjKkrXVEFhkYS5N
rM3quasa6z53XqmP6Ix5bQYpmsWjml+5AJdDp+k+a8wvFJKuZPkNx0XfvY5+BVtZ
c+qPiSY+DETFcrbUw22O/faMLYn5YtsW3TR70y2vrlrW4avEkfXGEI6U4wAjDmfs
xyTVhQSXVmQaWo1WEwfjm9W7INBsNdCZDNMwYP/4nBqbRIrXt9ncAmsVbyvyzDHt
/p7wD5EUmY+SLOdvE0jUAUoZx+Ml/KhrgpvLaDZeW59PqZAdbirPvtA6njhGYVbU
tjyRyARMJP5KehBhJOnpYwdfj4ZpKAx+pHLi1lCkepxQv+OuuhivL7K9+a+gp3Ly
rVKj799tbeWIS+P/JWbX7eN+xCa9HMweHsppvKjkSH8fslXcrSlLTa1wjJQLrdHk
VnhAFOs5EcIYJwSe7LECw/CwI8gtbVpaeNsqADH/Farh2B+Rf3g1gdFC5ieYX8Mq
VfTcQMR+z1RW/+/T7j1HIZHzVcEI3IO58aP8o+8QZ3lobCxF2byejZgio/kVjt4T
UxaGzggheWK8xy7yQjqQlDZXoruRiLr0oxodJF+C2jM+3nyG9eRSAt4+IoaM0vb2
qNqk+xBfGmZlDKENUnQMqKqs+Efl961/ynOtCHy+0R4yLEiaBJo=
=Iw6r
-----END PGP SIGNATURE-----

--jm67xm5kqtnotww6--
