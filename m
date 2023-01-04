Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FE65D481
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjADNkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjADNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:40:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E31F9;
        Wed,  4 Jan 2023 05:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4249B815EB;
        Wed,  4 Jan 2023 13:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D8EC433D2;
        Wed,  4 Jan 2023 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672839608;
        bh=6RPhGmZBE71CH85bdeJy1dx/jV8rHmJ6XO+Ern62lKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gs8F77rztURAEf8MKD5C1YBEKaa82rFqsFfeb5D59iVj64bfLI+jUC3r1f+l71P84
         oU2p0kQK1ttDHHNcUd6yq9oC3uqjDWW2mgj4G/MAJPAOa8SKjDTnWl5d8biAXl7Wwb
         RRpfx3y+GHSyD9VieHs+48LLQl9ZZRksNhouRewp9SURTqoJqfwgV+b6uXFWKrDs5a
         vTlTeYPFohwTbQ8Ds5vB2B86xBy03yAbwkfoch6EL/uqXT2ZcZjGfiRvHNIAbS2chG
         VG64FXR6CcuTywWpZLe4D9oZiHOeLrZJlR8eaCGNxyNXysuAj6X0MSQ7elm0k/w6Ji
         pzTpQBHATHAiA==
Date:   Wed, 4 Jan 2023 13:40:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
Message-ID: <Y7WBtMmLzYvk60tD@spud>
References: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
 <Y7RmnswYX+1g5vci@spud>
 <CAMuHMdX--sfenmb7WMgpe5045YfR7UjXAM-T9ZNZO3eTN_R=bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ruz8Lc2+jwA+2Ea0"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX--sfenmb7WMgpe5045YfR7UjXAM-T9ZNZO3eTN_R=bg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ruz8Lc2+jwA+2Ea0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2023 at 02:26:53PM +0100, Geert Uytterhoeven wrote:
> Hi Conor,
>=20
> On Tue, Jan 3, 2023 at 6:32 PM Conor Dooley <conor@kernel.org> wrote:

> > I half wonder if this should actually have a fixes tag too. Since it
> > used what came after the @ in $full_name, it'd be possible to create
> > (an incorrect) DTS that would lead to a clash between pll names &
> > therefore probe would fail.
> > The tag would be:
> > Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock su=
pport")
>=20
> But I don't change any of that in my patch?
> /me confused.

The numbers in there were chosen to fit exactly what is in mpfs.dtsi
(IOW the correct node address), so doing
@@ -201,14 +200,13 @@ static int mpfs_ccc_register_plls(struct device *dev,=
 struct mpfs_ccc_pll_hw_clo
=20
 	for (unsigned int i =3D 0; i < num_clks; i++) {
 		struct mpfs_ccc_pll_hw_clock *pll_hw =3D &pll_hws[i];
-		char *name =3D devm_kzalloc(dev, 18, GFP_KERNEL);
=20
-		if (!name)
+		pll_hw->name =3D devm_kasprintf(dev, GFP_KERNEL, "ccc%s_pll%u",
+					      strchrnul(dev->of_node->full_name, '@'), i);
+		if (!pll_hw->name)
 			return -ENOMEM;
=20
 		pll_hw->base =3D data->pll_base[i];
-		snprintf(name, 18, "ccc%s_pll%u", strchrnul(dev->of_node->full_name, '@'=
), i);
-		pll_hw->name =3D (const char *)name;
 		pll_hw->hw.init =3D CLK_HW_INIT_PARENTS_DATA_FIXED_SIZE(pll_hw->name,
 								      pll_hw->parents,
 								      &mpfs_ccc_pll_ops, 0);

means that we no longer have to worry that someone would provide a
device tree with a node address that would make "ccc<node_address>_pll<N>"
exceed 18 characters. If that happened, the <N> would be cut off & both
pll 0 & 1 would be named identically. If that happens, pll1 would fail
to register.

Or am I misunderstanding something? Probably am..

Thanks,
Conor.


--Ruz8Lc2+jwA+2Ea0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7WBtAAKCRB4tDGHoIJi
0nJlAP0ehynrTFuwhxiPLMmtmC70nbFReqFv+jOE3ZccM7+A0AD/QybFXMjcM0ug
EYLfXR2feFYwXb7Mrqs0dstLrI08vQg=
=Z1hJ
-----END PGP SIGNATURE-----

--Ruz8Lc2+jwA+2Ea0--
