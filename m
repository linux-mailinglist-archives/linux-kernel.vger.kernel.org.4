Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC76510D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiLSRAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiLSRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:00:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690CC13CE8;
        Mon, 19 Dec 2022 09:00:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09A51B80EF3;
        Mon, 19 Dec 2022 17:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ED3C433D2;
        Mon, 19 Dec 2022 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671469234;
        bh=k0vP8vhlTYUEUENAWD2qoXo6BWQdHZVBcBn/j/1G/UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpIxsUctCG+ggHNypNGWg+9ZKP1xB1X3d6338HaxLzLoBGYMLoShGsAahMpVuX1xd
         xr0udtMZ5DWFPVMgD5lFU5X+5jfNUh5PdmlyyZVTIp9bPZwrQ6jbh0HU5eOdbjMR9M
         fcFKSg00/u4zb7jDL+fh9bsJt7RSCfLd29hjSSw3/yHSz2u1Btg8WGSKkFvpDNTaeg
         5Dp9rxZyOXA5LNovbUpw+IGevsKGX6HiVleb30fNYx8gnkasQs3IRhT9bXeTKa15pS
         5sxKMWzy5q4moFqYR/WNnBRw9IOsF+9DsG+yRO1BsqV0nPQgZ+/qUiVyxoskZ5E+MJ
         OBYDT+mbweh4A==
Date:   Mon, 19 Dec 2022 17:00:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v3 00/12] riscv: Allwinner D1/D1s platform support
Message-ID: <Y6CYrVukEW1VMf8R@spud>
References: <20221208090237.20572-1-samuel@sholland.org>
 <Y53/ruLoggBDXozF@spud>
 <e9428f30cf0c6a239af01c0c2db9c511f3561a8c.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1Myp6idsTSAhtZvC"
Content-Disposition: inline
In-Reply-To: <e9428f30cf0c6a239af01c0c2db9c511f3561a8c.camel@icenowy.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Myp6idsTSAhtZvC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 05:43:17PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2022-12-17=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 17:43 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, Dec 08, 2022 at 03:02:25AM -0600, Samuel Holland wrote:
> > > This series adds the Kconfig/defconfig plumbing and devicetrees for
> > > a
> > > range of Allwinner D1 and D1s-based boards. Many features are
> > > already
> > > enabled, including USB, Ethernet, and WiFi.
> > >=20
> > > The devicetrees use bindings from the following series which have
> > > not
> > > yet been merged to linux-next:
> > > =C2=A0- In-package LDO regulators:
> > > =C2=A0=C2=A0
> > > https://lore.kernel.org/lkml/20221208084127.17443-1-samuel@sholland.o=
rg/
> > > =C2=A0- Ethernet MAC binding fix (not a new issue with D1):
> > > =C2=A0=C2=A0
> > > https://lore.kernel.org/lkml/20221208061616.7806-1-samuel@sholland.or=
g/
> > > =C2=A0- TI ADC101C ADC (accepted, not yet in linux-next):
> > > =C2=A0=C2=A0
> > > https://lore.kernel.org/lkml/20221125220903.8632-1-samuel@sholland.or=
g/
> > >=20
> > > The only remaining DT validation issue is that gpio-fan is missing
> > > a
> > > YAML conversion, although one is on the list here:
> > > https://lore.kernel.org/lkml/20220126200350.3633576-1-clabbe@baylibre=
=2Ecom/
> >=20
> > With the above 4 in next:
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Corentin's patch looked like it needed only minor changes. I shall go
> > ping it :)
>=20
> In addition I think Corentin's patch shouldn't be a blocking issue.
> This patchset does not depend on DT binding being converted to YAML,
> TXT binding is enough as dependency.

I rid RISC-V of warnings and I would like it to stay that way please.
There's other stuff outstanding anyway and Corentin has already sent a
v2 :)


--1Myp6idsTSAhtZvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6CYrQAKCRB4tDGHoIJi
0jm1AQCxFAoy0OVLOEwILVBPezoKFbbLuL52TrriLLuZyhtvxAD+P99BF/pHCiDs
qImJEY24BG8loa7iDlE9m0SUWZl8qA0=
=r6VJ
-----END PGP SIGNATURE-----

--1Myp6idsTSAhtZvC--
