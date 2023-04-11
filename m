Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755BF6DE582
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDKULJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EB559E;
        Tue, 11 Apr 2023 13:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60E960FA2;
        Tue, 11 Apr 2023 20:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62F8C433EF;
        Tue, 11 Apr 2023 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681243782;
        bh=PL0YCjrpk8wMnvPj0o2kokiqLnGSaS7cu9sqJvxA2r8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLvo2IUWiVWwN+k7aEhcC8og0gthh8g1MjyBRUk8SSIE3PZr7W3GWIMdDtFvZXzgz
         ZPVAN1JCvxH8AHLHLlBjLSWvcH9BqzAYEQxnrWuRuLUJk1w5H4kQu9mVW3drDkr0dj
         yd5a1VG5/TlrqdsA8cJBBKDdmjgCbzobE23LPZTFw5HZvb78SvWHaVJFU5OWJSfWCY
         aMm7J5doHsjkVEkEzNqNOfQuCUIfh8BbJkDZg/BSn5FzC5sLeOjIjQINu8XxBa4k4g
         HjqPWBtjGzTvEGfvC/GTmH/ZfAuBB+aW5nYK5u3Z2Ki3Vo290SsnmP8jrMwE+fR6Uk
         qDzLL4K4bqoTg==
Date:   Tue, 11 Apr 2023 21:09:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/7] Add JH7110 DPHY PMU support
Message-ID: <20230411-senator-clarity-7577b85884ad@spud>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YamoAzPVhVpZIOuh"
Content-Disposition: inline
In-Reply-To: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YamoAzPVhVpZIOuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Walker,

On Mon, Apr 10, 2023 at 11:47:36PM -0700, Changhuang Liang wrote:
> This patchset adds mipi dphy power domain driver for the StarFive JH7110
> SoC. It is used to turn on dphy power switch. The series has been tested
> on the VisionFive 2 board.

Could you review the driver changes here please.

Thanks,
Conor.

>=20
> This patchset should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20230406103308.1280860-1-william.qiu@star=
fivetech.com/
>=20
> Changhuang Liang (7):
>   dt-bindings: power: Constrain properties for JH7110 PMU
>   soc: starfive: Replace SOC_STARFIVE with ARCH_SATRFIVE
>   soc: starfive: Modify ioremap to regmap
>   soc: starfive: Add pmu type operation
>   soc: starfive: Use call back to parse device tree resources
>   soc: starfive: Add dphy pmu support
>   riscv: dts: starfive: Add dphy rx pmu node
>=20
>  .../bindings/power/starfive,jh7110-pmu.yaml   |  14 +-
>  MAINTAINERS                                   |   1 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   5 +
>  drivers/soc/starfive/Kconfig                  |   4 +-
>  drivers/soc/starfive/jh71xx_pmu.c             | 213 ++++++++++++++----
>  .../dt-bindings/power/starfive,jh7110-pmu.h   |   3 +
>  6 files changed, 187 insertions(+), 53 deletions(-)
>=20
>=20
> base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
> prerequisite-patch-id: 388b8adbb0fe2daf4d07a21eafd4f1bd50ce2403
> prerequisite-patch-id: 1117ecaa40a353c667b71802ab34ecf9568d8bb2
> prerequisite-patch-id: b00c6b21fbd0353d88b7c9b09093ba30b765f45b
> prerequisite-patch-id: 08ec9027e8a5c6fdf201726833168c7464a9b94d
> prerequisite-patch-id: fb5120248e48fe1faf053ae0b490c92507ec2b44
> prerequisite-patch-id: 4b93d8d590b0a2abe7b4be5287232c494c35be4a
> prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
> prerequisite-patch-id: c09c4c68af017b8e5c97b515cb50b70c18a2e705
> prerequisite-patch-id: 0df8ccb0e848c2df4c2da95026494bebecede92d
> prerequisite-patch-id: 315303931e4b6499de7127a88113763f86e97e16
> prerequisite-patch-id: 40cb8212ddb024c20593f73d8b87d9894877e172
> prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
> prerequisite-patch-id: d57cc467fb036241b9276320ff076c4a30d376d6
> prerequisite-patch-id: 6e563d68bc5dbf951d4ced17897f9cc4d56169fe
> prerequisite-patch-id: 61ec2caa21fd0fc60e57977f7d16d3f72b135745
> prerequisite-patch-id: 1387a7e87b446329dfc21f3e575ceae7ebcf954c
> prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
> prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
> prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
> prerequisite-patch-id: 9007c8610fdcd387592475949864edde874c20a2
> prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
> prerequisite-patch-id: 0a0ac5a8a90655b415f6b62e324f3db083cdaaee
> prerequisite-patch-id: 7ff6864ac74df5392c8646fe756cadd584fcc813
> prerequisite-patch-id: 284b5d1b95c6d68bca08db1e82ed14930c98b777
> --
> 2.25.1

--YamoAzPVhVpZIOuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDW+gQAKCRB4tDGHoIJi
0hNnAQC1KGXvowdmm9YQEJTQeXKxPfXriyg+RJhOctyiR1stjAEA3Cni1XQ7tv+c
y6rF+267+XfMV52+KOBvM/ImGhaxtws=
=KRno
-----END PGP SIGNATURE-----

--YamoAzPVhVpZIOuh--
