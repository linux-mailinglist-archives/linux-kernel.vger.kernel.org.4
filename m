Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853B4738E43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFUSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFUSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66E4107;
        Wed, 21 Jun 2023 11:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C05C6167F;
        Wed, 21 Jun 2023 18:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0855C433C9;
        Wed, 21 Jun 2023 18:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687371117;
        bh=9v9goyvtQUiL0Qdj2HtwIciXoTyai42W0bpnzYLHHkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8nvt6561PKdO78SQ+P57VegX3c96Wp41o6Tq8Tk6RevjXUQWE8bfi3ctVIQFDAMK
         qc0IjZuN4cp1FKeRaQqXlK9YUnqNhI4XfVUIelqM9yZaem4eSns9Oi49tupElZQfhM
         BzhaHaF8O9evPM9SBODc072i/R58IDA2rimLsZsAPMv7RHmb5jDSvqN7zsFgdiNwiZ
         hMHrXaOgDEhBzEhJkgcQTHeOZ+xkQBY50is2I1serBNhBE9UjQg46sNuSlV+4eW0Ly
         wbXVIaxYS7CT8gVkmPm0IUF8qZ7t9+SQoG30EwdBFw4baw/UnedoyowohvBnfGfGFt
         xBHppij4HnNZQ==
Date:   Wed, 21 Jun 2023 19:11:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
Message-ID: <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
References: <20230621133215.109254-1-tanure@linux.com>
 <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r8ifSacFha/D1Rvk"
Content-Disposition: inline
In-Reply-To: <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r8ifSacFha/D1Rvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lucas,

On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
> On 21/06/2023 15:32, Lucas Tanure wrote:
> > Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> > There is no need for an extra compatible line in the driver, but
> > add T7 compatible line for documentation.
> >=20
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uar=
t.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > index 01ec45b3b406..860ab58d87b0 100644
> > --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > @@ -33,6 +33,7 @@ properties:
> >                - amlogic,meson8b-uart
> >                - amlogic,meson-gx-uart
> >                - amlogic,meson-s4-uart
> > +              - amlogic,meson-t7-uart
> >            - const: amlogic,meson-ao-uart
> >        - description: Always-on power domain UART controller on G12A So=
Cs
> >          items:
> > @@ -46,6 +47,7 @@ properties:
> >            - amlogic,meson8b-uart
> >            - amlogic,meson-gx-uart
> >            - amlogic,meson-s4-uart
> > +          - amlogic,meson-t7-uart
>=20
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).

Check back on the previous version, I should've posted an untested
version of what you need to add.

Cheers,
Conor.

--r8ifSacFha/D1Rvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJM9aAAKCRB4tDGHoIJi
0iPmAQCB2/L7TXDqGzhLNnWtm2aGh/w/O0jkMMU06UwMv1mW7wD+IiKLI9x7+bbA
i66ElkRSOzKYf154fLEAit0ALQC0cQY=
=QmUG
-----END PGP SIGNATURE-----

--r8ifSacFha/D1Rvk--
