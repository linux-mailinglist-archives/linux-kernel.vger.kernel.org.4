Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F286D6F83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjDDV7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjDDV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:59:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA610DF;
        Tue,  4 Apr 2023 14:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A95BA63A3D;
        Tue,  4 Apr 2023 21:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FBDC433D2;
        Tue,  4 Apr 2023 21:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680645589;
        bh=oVb/3Yv6tCP2RVhr47u84gv2ub6ZCrD3LzM01ty7vrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srKJzP4unsO7VCYXuoEw/yp2w/Da1xNjdL6eqfAk4O4BXMGD2eDCasq2ri+OolkBN
         +GLaCazAspMZrawj5jRSVVbHh/ydzuyqxqlNRhly+PDdZoGwVCd7uh0tqPkODHY0ME
         gIlPw1yX+155k4I850he81of9BweX0/iu3+xLsqqymbfQEJ/J7hYXwqaTx+2f4r9m4
         0f6vOhJfrDXrQVgMUMOyd1w3HFg0/LW8qj8fftiRTNPyttBrosP2Cg8nb6j8nxaNLs
         8rN7SYSWMf9zpCBnQ73B2PG8sF9Szly9Ro0J7A+wOXpUf9iwAvolFdy2TgSWY7Vz6w
         gHTAwvOsIsnPw==
Date:   Tue, 4 Apr 2023 22:59:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Weili Qian <qianweili@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V4 23/23] crypto: hisilicon/qm: Workaround to enable
 build with RISC-V clang
Message-ID: <20230404-viewpoint-shank-674a8940809a@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-24-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g2rJHKXDBniPI9UF"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-24-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g2rJHKXDBniPI9UF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

This one made me scratch my head for a bit..

On Tue, Apr 04, 2023 at 11:50:37PM +0530, Sunil V L wrote:
> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
> allmodconfig build. The gcc tool chain builds this driver removing the
> inline arm64 assembly code. However, clang for RISC-V tries to build
> the arm64 assembly and below error is seen.

There's actually nothing RISC-V specific about that behaviour, that's
just how clang works. Quoting Nathan:
"Clang performs semantic analysis (i.e., validates assembly) before
dead code elimination, so IS_ENABLED() is not sufficient for avoiding
that error."

> drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint '+=
Q' in asm
>                        "+Q" (*((char __iomem *)fun_base))
>                        ^
> It appears that RISC-V clang is not smart enough to detect
> IS_ENABLED(CONFIG_ARM64) and remove the dead code.

So I think this statement is just not true, it can remove dead code, but
only after it has done the semantic analysis.

The reason that this has not been seen before, again quoting Nathan, is:
"arm64 and x86_64 both support the Q constraint, we cannot build
LoongArch yet (although it does not have support for Q either so same
boat as RISC-V), and ia64 is dead/unsupported in LLVM. Those are the
only architectures that support ACPI, so I guess that explains why we
have seen no issues aside from RISC-V so far."

> As a workaround, move this check to preprocessing stage which works
> with the RISC-V clang tool chain.

I don't think there's much else you can do!
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Perhaps it is also worth adding:
Link: https://github.com/ClangBuiltLinux/linux/issues/999

Cheers,
Conor.

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index e4c84433a88a..a5f521529ab2 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -611,13 +611,9 @@ EXPORT_SYMBOL_GPL(hisi_qm_wait_mb_ready);
>  static void qm_mb_write(struct hisi_qm *qm, const void *src)
>  {
>  	void __iomem *fun_base =3D qm->io_base + QM_MB_CMD_SEND_BASE;
> -	unsigned long tmp0 =3D 0, tmp1 =3D 0;
> =20
> -	if (!IS_ENABLED(CONFIG_ARM64)) {
> -		memcpy_toio(fun_base, src, 16);
> -		dma_wmb();
> -		return;
> -	}
> +#if IS_ENABLED(CONFIG_ARM64)
> +	unsigned long tmp0 =3D 0, tmp1 =3D 0;
> =20
>  	asm volatile("ldp %0, %1, %3\n"
>  		     "stp %0, %1, %2\n"
> @@ -627,6 +623,11 @@ static void qm_mb_write(struct hisi_qm *qm, const vo=
id *src)
>  		       "+Q" (*((char __iomem *)fun_base))
>  		     : "Q" (*((char *)src))
>  		     : "memory");
> +#else
> +	memcpy_toio(fun_base, src, 16);
> +	dma_wmb();
> +#endif
> +
>  }
> =20
>  static int qm_mb_nolock(struct hisi_qm *qm, struct qm_mailbox *mailbox)
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--g2rJHKXDBniPI9UF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCydzQAKCRB4tDGHoIJi
0kS+APwI9urufiYlmUkAYkyAnD4XxPqkVAgS1QApjqn9spoehQD9GoxZzTCmlOmj
V0HIsqbbKh/l2SrUpOETJlfKaSTkhwE=
=P4m+
-----END PGP SIGNATURE-----

--g2rJHKXDBniPI9UF--
