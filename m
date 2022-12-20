Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21465283E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiLTVPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLTVPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:15:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858D13F2D;
        Tue, 20 Dec 2022 13:15:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48F8DB8197B;
        Tue, 20 Dec 2022 21:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF7AC433F0;
        Tue, 20 Dec 2022 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671570900;
        bh=SaFUQnlPhWnTefMSF5TAmmsvzt+RR7tzLYrYhfEmis0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dtq3Vii3FFUmY7uPnKp1pGMPMgrNezTyLuqse4FRH+UF9Ync/PyefOXNY71Hhc6IY
         +jLyZOuZsgMeL1q2fRu4KgHmMFUWQ6SVXtll2Dia6MNw47eAb33WTQNDEsvibdATi/
         4JXYj98wyj6t02rm2543hoNkkz52RCT64JDpOduLvWBfVtX7gO+UaUJKIjaIigufRJ
         e+G57//D5fOoFHj9CsNR7SaGXmzONTnzXUyQC9li6hGf3LkWbTGWsaTs4Jy80mKuqK
         czT/gO5oB/uyCkwCUvVn+Q+0kZmMBxEWE/7osckawfcClGGlR1QiOUVfjriS4/wnLo
         G12eip1n2jN4Q==
Date:   Tue, 20 Dec 2022 21:14:54 +0000
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
Subject: Re: [PATCH v3 5/7] soc: sifive: ccache: Add StarFive JH7110 support
Message-ID: <Y6IlztUSTEiBw7Pd@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-6-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VgU9tBCqHV9nCZZx"
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-6-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VgU9tBCqHV9nCZZx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 09:12:45AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> This adds support for the StarFive JH7110 SoC which also
> features this SiFive cache controller.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

I'll queue this and the ccache binding for v6.3 once -rc1 is tagged,
once again with the caveat that screaming from Emil with dissuade me.
Ordinarily, I'd wait for his R-b, but he is the author..

Thanks,
Conor.

> ---
>  drivers/soc/Makefile       | 2 +-
>  drivers/soc/sifive/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 69ba6508cf2c..534669840858 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -26,7 +26,7 @@ obj-y				+=3D qcom/
>  obj-y				+=3D renesas/
>  obj-y				+=3D rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+=3D samsung/
> -obj-$(CONFIG_SOC_SIFIVE)	+=3D sifive/
> +obj-y				+=3D sifive/
>  obj-y				+=3D sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+=3D tegra/
>  obj-y				+=3D ti/
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> index ed4c571f8771..e86870be34c9 100644
> --- a/drivers/soc/sifive/Kconfig
> +++ b/drivers/soc/sifive/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> -if SOC_SIFIVE
> +if SOC_SIFIVE || SOC_STARFIVE
> =20
>  config SIFIVE_CCACHE
>  	bool "Sifive Composable Cache controller"
> --=20
> 2.38.1
>=20
>=20

--VgU9tBCqHV9nCZZx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6IlzgAKCRB4tDGHoIJi
0kY+AP9enkrvYXKKa5SNA4sSbGwZDhvcoCcsSCloARVs+Qc36QD/cb/vWsgaFwSK
q42fkVYJ4ro/LJiPrNEB+YgA+WF5aQk=
=ZTcn
-----END PGP SIGNATURE-----

--VgU9tBCqHV9nCZZx--
