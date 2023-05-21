Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B670AE44
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjEUN7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 09:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEUNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82CCBB;
        Sun, 21 May 2023 06:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BAC260B59;
        Sun, 21 May 2023 13:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4273AC433EF;
        Sun, 21 May 2023 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684677315;
        bh=pBCLLi539NwV8+/W4KsfZGUmhSMDLjN83ORiIGsKyD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cK/ec9CWGi3yDybEdGIX95PeMdA5wkUw3wyv9C1tGRMVsm4jLQTJGRk8vN45t6DMk
         gDy/AHrj628jCljwwcfoFfp2Tik+BvnFDfub90nmcKrLdIOdDhqbxLl6GEQq2119tt
         te+xml+FGGJceSPUkNja7qe+J4F3waEdhq1STW5I6QCri9KjAMZJZSK1sDXdkH7av+
         Ky0wWMiToEkdtTEW1YKuHfQxsEIXfPNDGaBJSgbMOoOpA5qsw3QKRxwYMhJ2zLXj1u
         6ML7cx178L1/n3gb78O9xsmX5vMzQ0a37czOvSk4L7xL6q9uN5NT/OZv96P/h+0Jkg
         TT3SPPqHKP00w==
Date:   Sun, 21 May 2023 14:55:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 01/10] dt-bindings: vendor-prefixes: add bouffalolab
Message-ID: <20230521-dribble-brook-7dd1ad2096bb@spud>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-2-jszhang@kernel.org>
 <a45c9193-aa63-650f-dbb3-14b6c3f74eeb@sholland.org>
 <ZGneH+ApaQVvv3SW@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FMaHoBVJWJuve3oJ"
Content-Disposition: inline
In-Reply-To: <ZGneH+ApaQVvv3SW@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FMaHoBVJWJuve3oJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2023 at 05:02:23PM +0800, Jisheng Zhang wrote:
> On Thu, May 18, 2023 at 09:53:12PM -0500, Samuel Holland wrote:
> > Hi Jisheng,
> >=20
> > Thanks for updating this series!
> >=20
> > On 5/18/23 10:22, Jisheng Zhang wrote:
> > > In the following commits, we will support bl808 SoC which is from
> > > Bouffalo Lab Technology (Nanjing) Co., Ltd.
> > >=20
> > > Add bouffalolab vendor prefix binding.
> > >=20
> > > Link: https://en.bouffalolab.com/
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b=
/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > index 82d39ab0231b..3566346f2f9e 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -200,6 +200,8 @@ patternProperties:
> > >      description: BOE Technology Group Co., Ltd.
> > >    "^bosch,.*":
> > >      description: Bosch Sensortec GmbH
> > > +  "^bouffalolab,.*":
> > > +    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
> >=20
> > Have you thought about using the "bflb" abbreviation as the vendor
>=20
> I did think about bflb vs bouffalolab. Here is what I thought: I came
> across "marvell" vs "mrvl" sevral years ago, I got an impression
> "marvell" vendor prefix is preferred if I read the discussions
> correctly.
>=20
> As for Bouffalolab vendor prefix, I have no preference, maybe DT
> maintainers can provide inputs here.
> Rob, Conor, Krzysztof, what's your opinion?

I had a look through the blame for vendor-prefixes.yaml since I had no
clue how easy it would be to find the marvell discussion - the commit
for gateworks' deprecated entry (done by Krzysztof says "Favor the
longer one (more descriptive)" & I think the same point is valid here.
I would have no idea what "bflb" was if I came across it in isolation!

Cheers,
Conor.

--FMaHoBVJWJuve3oJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGoivQAKCRB4tDGHoIJi
0nKuAP4hnuFH5NcKfffzyLkN8Barhu7GOpkz3/pxDVaBdSmPawEA7NUtHlY90ReQ
o+9cvTiUjzAl5IcXBx3fNh+I9wjCzw4=
=1Q15
-----END PGP SIGNATURE-----

--FMaHoBVJWJuve3oJ--
