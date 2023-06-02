Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011887207D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjFBQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3A13E;
        Fri,  2 Jun 2023 09:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D4E65040;
        Fri,  2 Jun 2023 16:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE00C433D2;
        Fri,  2 Jun 2023 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685724212;
        bh=LvLxezSRvVTgNsRffgBGO6C8gYI6UvntcIExudbKqNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmyCJYVSDwmFCNCoc1vhaDzagypYzlnDyqjrVC72Fj43xovmAquJcQyAyeDkTc86b
         f/37c7yqJnfFFcrtFRI0Q6porV0kCKjwrVOXcxpTtHacTHtb5/1jGMsBOFoBxh9Ii0
         rjXnaQxYWYutWdleYhMz9/mzKvYj1xLqWHPnd8e7/zSbAxBKJLO6hRXy2j0A/Hk1Il
         8UWwF8eWOF0XtKk4QKm/hRiVtLb21XsqdmVZ5Vxi6iEQoeHmeKBxviC5N2ENlF7SLY
         LPm+QS4NIBjJpKGo8rkubF72AuSnhcp0op/V8TMatiCqMotY6iL6/MDslGUVyTflOP
         80osdajcpJeeA==
Date:   Fri, 2 Jun 2023 17:43:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        yanhong.wang@starfivetech.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Message-ID: <20230602-drained-wheat-b6c5ea009f16@spud>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
 <20230519-smokeless-guileless-2a71cae06509@wendy>
 <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
 <20230602183922.649b8e88@blackhole.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XZe2o3rTonuyYBx7"
Content-Disposition: inline
In-Reply-To: <20230602183922.649b8e88@blackhole.lan>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XZe2o3rTonuyYBx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 06:39:22PM +0200, Torsten Duwe wrote:
> On Tue, 23 May 2023 10:56:43 +0800
> Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>=20
> > On 2023/5/19 22:16, Conor Dooley wrote:
> > > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
> > >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> > >> [...]
> > >> >  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> > >> >  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> > >> > =20
> > >> > +/* PLL clocks */
> > >> > +#define JH7110_CLK_PLL0_OUT			0
> > >> > +#define JH7110_CLK_PLL1_OUT			1
> > >> > +#define JH7110_CLK_PLL2_OUT			2
> > >>=20
> > >> In U-Boot commit 58c9c60b Yanhong Wang added:
> > >>=20
> > >> +
> > >> +#define JH7110_SYSCLK_PLL0_OUT                       190
> > >> +#define JH7110_SYSCLK_PLL1_OUT                       191
> > >> +#define JH7110_SYSCLK_PLL2_OUT                       192
> > >> +
> > >> +#define JH7110_SYSCLK_END                    193
> > >>=20
> > >> in that respective file.
> > >>=20
> > >> > +#define JH7110_PLLCLK_END			3
> > >> > +
> > >> >  /* SYSCRG clocks */
> > >> >  #define JH7110_SYSCLK_CPU_ROOT			0
> > >>=20
> > >> If the symbolic names referred to the same items, would it be possib=
le
> > >> to keep the two files in sync somehow?
> > >=20
> > > Ohh, that's not good.. If you pass the U-Boot dtb to Linux it won't
> > > understand the numbering. The headers are part of the dt-binding :/
> >=20
> > Because PLL driver is separated from SYSCRG drivers in Linux,
>=20
> Can you _please_ point me at that "PLL driver" "in Linux" ?

It's patch 2 in this series:
https://lore.kernel.org/linux-riscv/20230512022036.97987-1-xingyu.wu@starfi=
vetech.com/T/#m4b2d74c36b3bb961a1187ec5cda1a0a0de875f0e

HTH,
Conor.

> I seem to be unable to find it. All I can see is a stub in
> drivers/clk/starfive/clk-starfive-jh7110-sys.c, which simply
> sets the PLLs to 1000, 1066 and 1188 MHz fixed, respectively.
>=20
> The comment above says
>=20
> | They will be dropped and registered in the PLL clock driver instead.
>=20
> and that's the one I'm looking for.
>=20
> Thanks,
>=20
> 	Torsten

--XZe2o3rTonuyYBx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHocLQAKCRB4tDGHoIJi
0mn5AP9oqsWN8DLcjo3FRlcFhZHaUoQ1i/9UxPlGb0p70AL3BAD/fPfxE6au0mU2
ReztwYuH1w4rZKxGC5MTp/53/xXkdA4=
=1yWs
-----END PGP SIGNATURE-----

--XZe2o3rTonuyYBx7--
