Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0047339F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFPTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjFPTeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:34:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD010D8;
        Fri, 16 Jun 2023 12:34:07 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7050B1C0E73; Fri, 16 Jun 2023 21:34:06 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:34:05 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, james.morse@arm.com,
        kristina.martsenko@arm.com, robh@kernel.org,
        jintack.lim@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 4.14 3/6] arm64: Add missing Set/Way CMO encodings
Message-ID: <ZIy5LbnHn6ocT6+3@duo.ucw.cz>
References: <20230615114016.649846-1-sashal@kernel.org>
 <20230615114016.649846-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HQEFTndQhllEz4qV"
Content-Disposition: inline
In-Reply-To: <20230615114016.649846-3-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HQEFTndQhllEz4qV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Marc Zyngier <maz@kernel.org>
>=20
> [ Upstream commit 8d0f019e4c4f2ee2de81efd9bf1c27e9fb3c0460 ]
>=20
> Add the missing Set/Way CMOs that apply to tagged memory.

We are not adding users of these in 4.14, so we don't need the
defines, either... right?

Best regards,
							Pavel
						=09
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -98,8 +98,14 @@
>  				       (!!x)<<8 | 0x1f)
> =20
>  #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
> +#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
> +#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
>  #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
> +#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
> +#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
>  #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
> +#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
> +#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
> =20
>  #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
>  #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HQEFTndQhllEz4qV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy5LQAKCRAw5/Bqldv6
8t6UAKCRXwU968VDdxxVkmZaPr+JqQgYFwCgpfGhXoQtrt1HIgg3/exPR731iGE=
=ayhq
-----END PGP SIGNATURE-----

--HQEFTndQhllEz4qV--
