Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86769E4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjBUQe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjBUQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:34:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81AC13DD6;
        Tue, 21 Feb 2023 08:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555C36112D;
        Tue, 21 Feb 2023 16:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A406C433D2;
        Tue, 21 Feb 2023 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676997257;
        bh=rScjK5VMyCZR5Ghp9Xxc1QS4YiviN+AcyuGZCuMiRvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBMq8NWq57Shnjk1qmarEq628THtxn2i9weKpl5EIslwqdTn0RISvGrycnu0NMX7D
         NX4jLf0LWPPdx+gVdgfq2CbeWU11SEWV2rGpC5nUGS6smzJSnoXTsK5RoLKstj5h1c
         yGLQp/4NJ9ITBs+TsO+x2U6jANTN++82vMCXCWJ8W5pfaVpSco8GMcUghkq+btNfYk
         LakAdK2joxng/PVW5RWh3Hp/vJdM1+/Jw1kgIVrGDscMmUCdYNYTxZJp3Mb7S38SP4
         9nleouZkPbo0xCQrwJe/l9vr/bRnKNtZnPbir2/ULiUu7RvVGkVobN8DCZKYK1cUa0
         +M0PKpVMOLAqA==
Date:   Tue, 21 Feb 2023 16:34:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/19] reset: starfive: Add StarFive JH7110 reset
 driver
Message-ID: <Y/TygwbxyuhbDooX@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-14-hal.feng@starfivetech.com>
 <CAJM55Z_O9K=sCRXga9pMOXk9YjXc1v_V0e5S-8xN9Mi8gvHzvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="di8SMzK5TxlOLwpm"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_O9K=sCRXga9pMOXk9YjXc1v_V0e5S-8xN9Mi8gvHzvg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--di8SMzK5TxlOLwpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 04:33:09PM +0100, Emil Renner Berthing wrote:
> On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > Add auxiliary driver to support StarFive JH7110 system
> > and always-on resets.
> >
> > Reported-by: kernel test robot <lkp@intel.com>

Drop the reported-by here too please Hal.

> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

> > +static int jh7110_reset_probe(struct auxiliary_device *adev,
> > +                             const struct auxiliary_device_id *id)
> > +{
> > +       struct reset_info *info =3D (struct reset_info *)(id->driver_da=
ta);
> > +       void __iomem **base =3D (void __iomem **)dev_get_drvdata(adev->=
dev.parent);
>=20
> Hi Hal,
>=20
> I saw the kernel test robot complain about this, but I still wonder if
> the extra level of indirection is really needed. Isn't it enough to
> just add the explicit casts, so
>=20
> dev_set_drvdata(priv->dev, (void *)priv->base);
>=20
> in the clock drivers and here just
>=20
> void __iomem *base =3D (void __iomem *)dev_get_drvdata(adev->dev.parent);

I *think* if you do that, sparse will complain that you cast away the
__iomem. The complaint is something like "cast removes address space
qualifier from expression".

The other option is, rather than set the base as the drvdata, just pass
the whole priv struct. That's what I did for mpfs at least & I thought I
had suggested it on v3, but must not have.
It looks prettier than the casting madness at least ;)

> > +
> > +       if (!info || !base)
> > +               return -ENODEV;
> > +
> > +       return reset_starfive_jh71x0_register(&adev->dev, adev->dev.par=
ent->of_node,
> > +                                             *base + info->assert_offs=
et,
> > +                                             *base + info->status_offs=
et,
> > +                                             NULL,
> > +                                             info->nr_resets,
> > +                                             NULL);
> > +}

--di8SMzK5TxlOLwpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/TybAAKCRB4tDGHoIJi
0pUxAQC1ZljYcv5/Q6mze0u0z96Oz5pkrLAITwYsm92VzYEYpAEAk6PbItP1RJvB
MFzAwz5syZ6Y4U9Krg0CMdAnSOLNGQ8=
=u5Rk
-----END PGP SIGNATURE-----

--di8SMzK5TxlOLwpm--
