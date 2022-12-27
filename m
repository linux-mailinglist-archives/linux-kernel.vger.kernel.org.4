Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13B656FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiL0VIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiL0VH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:07:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2281AC57;
        Tue, 27 Dec 2022 12:58:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7870B80E8C;
        Tue, 27 Dec 2022 20:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00168C433D2;
        Tue, 27 Dec 2022 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672174718;
        bh=QHEGwcrBeKpSgFkBiLCph3tiMgxRBw1ycy8RzAhX6PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwFIma1MMVDat719aZNerCFUekEoWxXFJzPinva5LqNzBLiCWUNYwTlRK1s3IGHTs
         3XR47blM/w40zCnndMiIxo1zbm8pbXn/tOwS7+gww9TvW6Oxt1isjBzC9W8EfXAN/q
         RGF1xD9d8fzeiuA/sJAFt1lD3ThsMJT+mluTNYrQn/ki7bHaJ333Ma3A476Wak33Tf
         A547kIY5lw09vFV8mj9Xa94QKyXXqxgB5o04Z46NefpNmy781p1hkFUAkRkwgl6LWa
         DkbPk5uPSpZL7WNGMRl7KRI5zfz4a4gOGv/lXpfMedvIT8t5tOKXAypj1F8wwpGgsM
         PluBSTjlKQu3Q==
Date:   Tue, 27 Dec 2022 20:58:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Message-ID: <Y6tceOCC+YFtSY6F@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
 <Y6Ipv0BUummgqNaw@spud>
 <e23460e8-0ca4-b20b-e48e-faeca4f30e88@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="464m7fZGrAuzw6lu"
Content-Disposition: inline
In-Reply-To: <e23460e8-0ca4-b20b-e48e-faeca4f30e88@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--464m7fZGrAuzw6lu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 25, 2022 at 10:31:41PM +0800, Hal Feng wrote:
> On Tue, 20 Dec 2022 21:31:43 +0000, Conor Dooley wrote:
> > On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
> > > From: Emil Renner Berthing <kernel@esmil.dk>
> > >=20
> > > Add initial device tree for the JH7110 RISC-V SoC by StarFive
> > > Technology Ltd.
> > >=20
> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > > Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---

> > > +		gpio: gpio@13040000 {
> >=20
> > > +		gpioa: gpio@17020000 {
> >=20
> > Out of curiousity, why gpio & gpioa?
>=20
> Oh, is it easier to read if I change "gpio" and "gpioa"
> to "sysgpio" and "aongpio"? Thanks.

I think those would be more reader friendly, that's for sure.


--464m7fZGrAuzw6lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6tceAAKCRB4tDGHoIJi
0j1sAP9thq/K0P0uAxqb9fdxkY32mRYoo0Mkz4I81vVs0Y3poAD+OeXBv0pzKxhA
5mWXZb9nal9rZttUALcPO3BAiMtptA4=
=zfRm
-----END PGP SIGNATURE-----

--464m7fZGrAuzw6lu--
