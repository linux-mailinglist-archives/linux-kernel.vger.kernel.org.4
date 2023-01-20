Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203F675F10
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjATUoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjATUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:44:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65F94C98
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:44:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 963B7B82906
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675F5C433D2;
        Fri, 20 Jan 2023 20:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674247455;
        bh=Vt8oiZbQmXunlXHeri8Xgh7T7MbWYfRl0mIFfOXZhl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FraY02Z+vIyhI39A2tB238RgSVTmrc5QEqs8Q7NpfJERPTu4+eYfQ1w6qkNU6sxUZ
         K4nQG7utxJXOGG/nocXL6uDfGxn6zhHKCxGd3a9EXY4u9AR8KEX8LvAh7WIzfnIQFD
         MDWWpp39FJE7RCiBAQ9JswhfnBlV8lSVaQ+qzM/iG3Sn7whCUn/Y0DtJjp+mjHp43C
         jr+0nqt3d2UO9CeFKAOqCaj4L2+WARiArorPGIBGaDK0iYZwiz886+BxlyZzxHdQ9X
         /lITu0zq1vVEVb6dQ/SfmcGzx5OmjAKJXp8av9OCLJ0FVelFDh6QXjXvCfmRK3j9Yv
         QUTiYmHr9YlqA==
Date:   Fri, 20 Jan 2023 20:44:10 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v1 1/2] riscv: Kconfig: Allow RV32 to build with no MMU
Message-ID: <Y8r9GuyUAfJWYY5Z@spud>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
 <20230119052642.1112171-2-Mr.Bossman075@gmail.com>
 <Y8pJ4y7FyBDQPqIT@wendy>
 <056f0d30-d340-fdc4-3744-1cdedd8b4048@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="axrD9d1syAKU/5YD"
Content-Disposition: inline
In-Reply-To: <056f0d30-d340-fdc4-3744-1cdedd8b4048@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--axrD9d1syAKU/5YD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jesse,

On Fri, Jan 20, 2023 at 12:39:06PM -0500, Jesse Taube wrote:
> On 1/20/23 02:59, Conor Dooley wrote:
> > Since you'll have to re-submit, making sure that allowing !MMU on rv32
> > doesn't break the build due to canaan k210 drivers being enabled despite
> > relying on 64-bit divisions, I've got some nits for you.
> Not sure what driver needs 64bit, but sense !MMU was only selected by 64B=
IT.

LKP reported a build error for it:
https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/

> This should work.
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..b9835b8ede86 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -43,7 +43,7 @@ config SOC_VIRT
>=20
>  config SOC_CANAAN
>         bool "Canaan Kendryte K210 SoC"
> -       depends on !MMU
> +       depends on !MMU && 64BIT
>         select CLINT_TIMER if RISCV_M_MODE
>         select SERIAL_SIFIVE if TTY
>         select SERIAL_SIFIVE_CONSOLE if TTY

I don't think this is the correct fix for the problem - the drivers
really should not do implicit 64-bit divisions IMO.
Linux has division helpers for them in math64.h.
None of the other SoCs have a dependency on 64BIT and I'd not been keen
on adding on here.

I suspect the fix is as simple as the below, but I'd need to go test it.

Thanks,
Conor.

--- 8< ---
=46rom ecfa79ad1b24f68cfccb77d666e443293d52d066 Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Fri, 20 Jan 2023 20:36:29 +0000
Subject: [PATCH] clk: k210: remove an implicit 64-bit division

The K210 clock driver depends on SOC_CANAAN, which is only selectable
when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
have been sent for its enabling. The kernel test robot reported this
implicit 64-bit division there.

Replace the implicit division with an explicit one.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.c=
om/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Since it was always guarded such that it only ever built for 64-bit, I
am not sure that a fixes tag is needed, but it would be:
Fixes: c6ca7616f7d5 ("clk: Add RISC-V Canaan Kendryte K210 clock driver")
---
 drivers/clk/clk-k210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
index 67a7cb3503c3..17c5bfb384ad 100644
--- a/drivers/clk/clk-k210.c
+++ b/drivers/clk/clk-k210.c
@@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_hw *h=
w,
 	f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
 	od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
=20
-	return (u64)parent_rate * f / (r * od);
+	return div_u64(parent_rate * f, r * od);
 }
=20
 static const struct clk_ops k210_pll_ops =3D {
--=20
2.39.0


--axrD9d1syAKU/5YD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8r9GgAKCRB4tDGHoIJi
0kllAQDKgK/+5PpYdTkzPe0Ai+nKWB4Wc4qSfHnfZoIl5Y7ibQD1FwXPEeo2EZBb
EiqR1/R9JwfcXsFaHsw51dpTq066CA==
=734a
-----END PGP SIGNATURE-----

--axrD9d1syAKU/5YD--
