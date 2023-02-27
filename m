Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BACA6A4BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjB0Tx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjB0Txm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:53:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B926CEA;
        Mon, 27 Feb 2023 11:53:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BCC560F1B;
        Mon, 27 Feb 2023 19:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AF4C433EF;
        Mon, 27 Feb 2023 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677527592;
        bh=FN7q+7LSkEQEP880hk5AYmzKXSJvzUeUVUoebZQ16HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYj+uDZDne/XGQiIqDWNdSQzxsv/OBNbwggrKIK5fDT5AdGAdFlLg7n1KODd+NYf+
         EV1Ne8D2msXpPrcqoSSSSy3os+Z0QHTf/KSQWv7RdFamOk16lGvZcGShDlqko/Rftm
         1J9NTjHHxoAzBVROVwzTTvqxwX4ykZpGgjxd571UFCAZ+a7WyvJUBlWzQwjzN1nGdQ
         Na6nld+VvRuyiOj2pQt2uIExSPPVE5JDc3ioC1axM5c3VHqmVmJbtE+J1k37rNYakU
         HC0hpyzsdMk36kbPalLwJBHb9nM5yvEdz65WHE5FpHQjgr/8HJ6u7QVb2ORaXyTWB3
         JiVsEeuo8RBXA==
Date:   Mon, 27 Feb 2023 19:53:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
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
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/11] riscv: dts: starfive: jh7110: Add
 STGCRG/ISPCRG/VOUTCRG nodes
Message-ID: <Y/0KI0rgqjqMi1Db@spud>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-12-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zQa043iT/WKT54d9"
Content-Disposition: inline
In-Reply-To: <20230221083323.302471-12-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zQa043iT/WKT54d9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 04:33:23PM +0800, Xingyu Wu wrote:
> Add STGCRG/ISPCRG/VOUTCRG new node to support JH7110
> System-Top-Group, Image-Signal-Process and Video-Output
> clock and reset drivers for the JH7110 RISC-V SoC.
>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 59 ++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index a5e6fb3ad188..697ab59191a1 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -6,6 +6,7 @@
> =20
>  /dts-v1/;
>  #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +#include <dt-bindings/power/starfive,jh7110-pmu.h>
>  #include <dt-bindings/reset/starfive,jh7110-crg.h>

Please keep these sorted alphabetically, otherwise this *looks* fine to
me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--zQa043iT/WKT54d9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/0KIwAKCRB4tDGHoIJi
0jvJAQDekG/U779L3Qjyj6JbBBmIo+FDgfYF3Uun3G4Hi9mw+AD/XmgxAMbFNf8a
ktj4/8QaSfT2gPFgTUOnACOYIdRbDw0=
=e2v5
-----END PGP SIGNATURE-----

--zQa043iT/WKT54d9--
