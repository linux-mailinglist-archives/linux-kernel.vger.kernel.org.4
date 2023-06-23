Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0873B48F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFWKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjFWKHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F182961;
        Fri, 23 Jun 2023 03:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD152619F3;
        Fri, 23 Jun 2023 10:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0B5C433C8;
        Fri, 23 Jun 2023 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687514734;
        bh=u13o1+rrFLOmxywhCwBs2AYh1dkZZnD42oB3y8jhIpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fh+7VyxZB1iLWw7j5+UyckQsRocruM9cSwxZG9GvVHMa8SEm06fMMZ4eTxtrpmSXy
         FmOYLwb7tc+/UkDHE9k/vuXLLiWesRnYqh2Pt5UU1C53VH03UU7i/a+x+j5ZOgCgXf
         PWCtyZoZwnrn8tcPOHB7bzWadciBfS9s3kSdiakWyt3dX7mgMe40vCjKukoP469Uq7
         5KK3Cn0zs2Fwkya5+kmy1/cGKnnfMkmIg46+8T3GCAiEtIs6jXgxuog1+thdql0Uwu
         y/Jm/skSiuPnAKtWOfCXC6BPvU8Rz6faa8a5zRuex5xjVYzra7xshse/l1Q40KNNzr
         U38C+9AV2c6BQ==
Date:   Fri, 23 Jun 2023 11:05:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2 0/5] spi: Add CSI support for Renesas RZ/V2M
Message-ID: <ZJVuan8ddJyhU23M@finisterre.sirena.org.uk>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <168748034127.332493.277333132642198960.b4-ty@kernel.org>
 <CAMuHMdU53jn5UP-5xB_YLh2T5gPaxL1dxWY5Vr5D8p2mUDnqwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNhmPaleGGTul9gb"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU53jn5UP-5xB_YLh2T5gPaxL1dxWY5Vr5D8p2mUDnqwA@mail.gmail.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNhmPaleGGTul9gb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 08:49:05AM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 23, 2023 at 2:32=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > [1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI
> >       commit: db63e7ad2895409f78a04f331f781baa7a879dd7
> > [2/5] clk: renesas: r9a09g011: Add CSI related clocks
> >       commit: 7c78eb3e5d30eaa217cecaa32711e41cd849d498
> > [3/5] spi: Add support for Renesas CSI
> >       commit: dcf92036cb3e1b7bf3472109e4290a0937b270dd
> > [4/5] arm64: dts: renesas: r9a09g011: Add CSI nodes
> >       commit: ef643c6b57020ee279d18636d9d967ee048dbffa
> > [5/5] arm64: defconfig: Enable Renesas RZ/V2M CSI driver
> >       commit: dfbd12ae0e7c761e07369f5a2d55fe06eb54ad31
>=20
> I hoped this would have been a bug in b4 thanks, but unfortunately it
> is not.
>=20
> Please do not apply unreviewed clock, DTS, and defconfig patches to
> your tree.  These are intended to go upstream through the renesas-clk
> and clk, renesas-dt and soc, resp. renesas-defconfig and soc trees.

Sorry, the series was only partially copied to me so it wasn't very
visible that there were other patches - I just saw a simple 2 patch
series in my inbox and it's not terribly visible in the rest of the
process that there's more patches.

--tNhmPaleGGTul9gb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSVbmkACgkQJNaLcl1U
h9DFMgf/ehmxBqPaGijsQRJEGrYX5x/j1Agmk7LmRCreemyD/EaJyaB1aT3mdcoC
7nS4KSunL13OM6AhhupjXibNhajMdQrVutiPRMQWoEOXlfTj8PU8wXCUrvlcIyMx
DXzKAJR8GrRvHH8QiyoS0rngoyLqNrO+cU09zZeZ1oxo2tVLX5V9BmAzzvbtAOdl
l5BpijDcQlRMLGVaZJ6NtJE4AcSZUCu3jjk96gqoIRM/GFoh4RfmL7XpqpxB/dBx
QNXN6bRIpFOfALKmwjkM5YSD4lCVH4rd6NC8Tsu0cLzuw1OWbPUikjsQhUCcofl7
RM/04tYgoCZb6kamopH8Ak4q8hydrA==
=/eXQ
-----END PGP SIGNATURE-----

--tNhmPaleGGTul9gb--
