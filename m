Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8652E6140FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJaW4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaW4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:56:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356312088;
        Mon, 31 Oct 2022 15:56:39 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E127A6602392;
        Mon, 31 Oct 2022 22:56:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667256998;
        bh=d4ZDF7yNzt45BG5IwBmzo19KGa/W2CS+ai5sbtkGhqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZlkQTRsMn8Nv+BvRPD8pDapFV9jKHIHA+cEwdFkvEWKTiiCFO8jG1jsVvneOn+ks
         Z6YYsmqQuwNiYFaajsWVelZl07OBrVPUtjANVFl08rE8k+PX8RZl4ij3psEYQrvCBN
         YPGMSWeWy4E9U2tnKGskYZmzs5728MAJW/5sdrrRzGdv9o0w4+f1ZkhpJzCnDGvRb6
         1C/sOcVJHH7/Y+M9gBaRtjMWrpqU6TdQzdhp8vbWrkiGLl1W5nXltAO1CCkucw0Vz+
         fIw7vc5SsxiPsfCS0Vpl2L/eFBTE7YV0axrSV8+v0OfxtBC/1Nmv8sajOjCPK4F85x
         /w2nrILhSoFNw==
Received: by mercury (Postfix, from userid 1000)
        id A9EEB1061C6E; Mon, 31 Oct 2022 23:56:35 +0100 (CET)
Date:   Mon, 31 Oct 2022 23:56:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: expect specific type for
 monitored-battery
Message-ID: <20221031225635.ntziphignf7m4h3w@mercury.elektranox.org>
References: <20221028231255.565363-1-krzysztof.kozlowski@linaro.org>
 <20221031192617.GA3283833-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g4cml5cuuq25joaa"
Content-Disposition: inline
In-Reply-To: <20221031192617.GA3283833-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g4cml5cuuq25joaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2022 at 02:26:17PM -0500, Rob Herring wrote:
> On Fri, Oct 28, 2022 at 07:12:55PM -0400, Krzysztof Kozlowski wrote:
> > Core schema does not define type of monitored-battery, so the schemas
> > are expected to reference proper type.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml    | 2 +-
> >  .../devicetree/bindings/power/supply/ingenic,battery.yaml      | 1 +
> >  .../devicetree/bindings/power/supply/rohm,bd99954.yaml         | 1 +
> >  .../devicetree/bindings/power/supply/sc2731-charger.yaml       | 2 +-
> >  Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml  | 3 ++-
> >  5 files changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yam=
l b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> > index 65fc6049efc1..b04c86ed0f58 100644
> > --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> > @@ -59,6 +59,7 @@ properties:
> >      description: integer, I2C address of the fuel gauge.
> > =20
> >    monitored-battery:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> >      description: |
> >         phandle of battery characteristics node.
> >         The fuel gauge uses the following battery properties:
> > @@ -66,7 +67,6 @@ properties:
> >         - charge-full-design-microamp-hours
> >         - voltage-min-design-microvolt
> >         Both or neither of the *-full-design-*-hours properties must be=
 set.
> > -       See Documentation/devicetree/bindings/power/supply/battery.yaml
> > =20
> >    power-supplies: true
> > =20
> > diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,bat=
tery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.=
yaml
> > index 46527038bf22..8bdacc30e9d8 100644
> > --- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.ya=
ml
> > +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.ya=
ml
> > @@ -27,6 +27,7 @@ properties:
> >      const: battery
> > =20
> >    monitored-battery:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>=20
> We should not have a type definition multiple times for the same=20
> property. We need to add a common schema defining the type instead.

I suppose monitored-battery should become part of
Documentation/devicetree/bindings/power/supply/power-supply.yaml

-- Sebastian

--g4cml5cuuq25joaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNgUqMACgkQ2O7X88g7
+pryjBAAkpxr6IqOn4AJXSVWzSXdYTWp4410K5OIufBxl9taikERbricnu+H+raV
c4jSVm0De2m+iEN8jTHst13aPTWA3E+zPhX4zZwiLGqHEHePzDIln5fXpdj+uljC
iUmLcP+cE5OdxrZy1lA7FSz4BODvoVko3iZXVdtQRIhlxArQwgtGOFmPXXwOsZtj
QK272Z3CQvJxROkayfr2zQ6Mz48dalFo5vshhSbAOF4lk6Mv/lyRJdQhokvgXz82
BQkjr01mF9X9vN+0382tI4X2tlg7MXsU0LY6jlR8vJMv4rQZeymk3n3FeqxD5vDo
PS/HTUzE/A8n65EeFmFRZv391nfJK4N0RvzaASdkx4gL+7YnGJEwfr7U6JVvN8Wn
hPc7ZwWiTCgKUU0h6cyt1jWn2WcogM+7I6NLc3pRdn2hxivr40jU+Db2vuWUNlPw
eubqRYR0AZ17JaM2tIFSkY+Q351ybwBx/9L80bxYsp4V1KtyEfArRsE3plNoFzt+
2ILG6O/9yo8Ug1xU3rHugZAMTtcZZJHKqNniV8zz8RHrcSG5cbJnEm45pJxuu9bq
Imope39t7KTpZW9ky15vSD0E0pQh1oKppH2gj66IrCeAmdy4bXYGm9nWO8od29Tq
+ONEpPwXICQFHYWM35aCMVOOjSpo8gUIIQAtAQD3G/WbnOM5doc=
=yI7O
-----END PGP SIGNATURE-----

--g4cml5cuuq25joaa--
