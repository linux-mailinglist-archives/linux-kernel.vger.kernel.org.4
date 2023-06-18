Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC4D7347ED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFRTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 15:16:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B6F5;
        Sun, 18 Jun 2023 12:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976A560DCF;
        Sun, 18 Jun 2023 19:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F95C433C0;
        Sun, 18 Jun 2023 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687115812;
        bh=mP8T1ASBLz9yF5+LfqYXClRBj0tfB2v2jcwuuySoPKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbJ8j8piIg2GaSBa8rWY6dUZBgm7/wL4k8ZeVH4fnTMbgUT15yDmQXjVbegnKCcSO
         qVK+SeNyt8BB17OqxQbnLV+yqyEttEaVpRgOyBgCpvAmAaGR/oarQh2IjFG13B8oz2
         I9czn0mTPnDZ030K3X7sKbIzN8qdV+25YeKq3J9rX6rZuQMp37llg7siFiPaTTC/Pd
         4zMH9Jdop2CQu01M6tlEsU2PBrn+1JEA6zMTycVKiC0uumk1Xy4f663aBKj4KD/MYV
         BfllbD+UMwNO2mRO3p0bPeunlPdfUi/NUGrj+b3bQRktNH2W8HnKk8Z1C9WCBAT1eQ
         Ar4SRL7yANn5Q==
Date:   Sun, 18 Jun 2023 20:16:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: clock: Bindings for Meson T7 clock
 controller
Message-ID: <20230618-silver-spherical-e7363a9fc3b0@spud>
References: <20230615182938.18487-1-tanure@linux.com>
 <20230615182938.18487-3-tanure@linux.com>
 <20230615-capable-implicit-90a8f0265616@spud>
 <CAJX_Q+2Gm6mr_2cbhCh7a_bOw09W2PBxyOAvasGCrPTdcruczQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BJPwe1aiOa3RKn6U"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+2Gm6mr_2cbhCh7a_bOw09W2PBxyOAvasGCrPTdcruczQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BJPwe1aiOa3RKn6U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2023 at 06:39:17PM +0100, Lucas Tanure wrote:
> On Thu, Jun 15, 2023 at 10:41=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > Hey Lucas,
> >
> > On Thu, Jun 15, 2023 at 07:29:34PM +0100, Lucas Tanure wrote:
> > > Add documentation for T7 the clock controller.
> >
> > Other than the bot's complaint, few comments for ya.
> >
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > ---
> > >  .../bindings/clock/amlogic,mesont7.yaml       |  69 +++
> > >  include/dt-bindings/clock/mesont7-clkc.h      | 487 ++++++++++++++++=
++
> > >  2 files changed, 556 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,m=
esont7.yaml
> > >  create mode 100644 include/dt-bindings/clock/mesont7-clkc.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/amlogic,mesont7.=
yaml b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
> > > new file mode 100644
> > > index 000000000000..18e7cca0c0e1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
> >
> > The filename should match the compatible - please test the bindings,
> > dt_binding_check will complain.
> >
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/amlogic,mesont7-clk.yaml#
> >
> > and this should match the filename
> >
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Amlogic Meson T7 Clock Controller
> > > +
> > > +maintainers:
> > > +  - Lucas Tanure <tanure@linux.com>
> > > +
> > > +description: |
> > > +  The Amlogic Meson T7 clock controller generates and supplies clock=
 to
> > > +  various peripherals within the SoC.
> > > +
> > > +  This binding uses common clock bindings
> > > +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >
> > This doesn't add anything as you're adding a yaml binding. I'd drop it
> > (and the | from description: since you would no longer have formatting
> > to preserve).
> >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: amlogic,t7-clkc
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: basic registers
> >
> > What does "basic registers" mean? I think you should be more specific in
> > your description.
> >
> > > +      - description: pll registers
> > > +      - description: cpu_clk registers
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: basic
> > > +      - const: pll
> > > +      - const: cpu_clk
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: xtal
> > > +
> > > +  '#clock-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - clocks
> > > +  - clock-names
> > > +  - '#clock-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  # Clock controller node:
> > > +  - |
> > > +    clkc: clock-controller {
> >
> > The comment above and the node name here can be dropped.
> > You do however need to change "clock-controller" to
> > "clock-controller@<addr>".
> >
> > > +        compatible =3D "amlogic,t7-clkc";
> > > +        #clock-cells =3D <1>;
> > > +        reg =3D <0x0 0x0000 0x00 0x49c>,
> > > +              <0x0 0x8000 0x00 0x320>,
> > > +              <0x0 0xe040 0x00 0x0bc>;
> >
> > Drop the 0x0 stuff from here.
> >
> > > +        reg-names =3D "basic", "pll", "cpu_clk";
> > > +        clocks =3D <&xtal>;
> > > +        clock-names =3D "xtal";
> > > +        status =3D "okay";
> >
> > status can be dropped, okay is the default.
> >
> > Cheers,
> > Conor.
> >
> I will drop this patch for now, wait for the S4 clock driver to be
> upstreamed, and use that as a base.

Why? Is the t7-clkc IP the same or very similar to the S4?


--BJPwe1aiOa3RKn6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI9YHgAKCRB4tDGHoIJi
0pTeAQCTxIXdRlt+4mb9a05/Kfer0GAM2qFkhTwzSLdmPX4jYwEAxZtr/ZglN5FX
V0pBA6p+7HCWHtSFGaf63zHs1OoVqQw=
=Lgfe
-----END PGP SIGNATURE-----

--BJPwe1aiOa3RKn6U--
