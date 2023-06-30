Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DAA744296
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjF3TD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3TD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6833C07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF48617E8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AEBC433C0;
        Fri, 30 Jun 2023 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688151805;
        bh=V5IBn/evDQRFoADoP9GjVWUyd4RyxJcnLBcMQx5mzo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGWh90/19eaYQN9pgIkTZCQCl4pcbTwwaFzTnSoQo6bNF6+4kY10d9OdV08B2IAYX
         QjO9BwlyNzzHvkEnddAZJO8mIrCDIBMvmjz+dXRyrr8DLorU0BmMnf9ksTQtkQEp+L
         t8AKrR+CWrmeURGwKrDdlZRyER7vKOudccklPMvh2GGVSA9E00A7u/ChwJDZwBye68
         BYzbBWOKqz3I432VFzWmihSrNqPxYieKRwFkV6qTN9++NUwsfIRIeYg9IiocaX3BPR
         Q+Gcrdg8tEVY2zhI9QR6wxYVmTGU2pmwGMi914tq1+z6M7NsmTttPAi2X/OZM8jUyd
         rBR2XqCdaMD7g==
Date:   Fri, 30 Jun 2023 20:03:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] riscv: Add CFI error handling
Message-ID: <20230630-utopia-drizzle-df8c14558696@spud>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2hnuImplXuBy7/70"
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-12-samitolvanen@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2hnuImplXuBy7/70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sami,

On Thu, Jun 29, 2023 at 11:42:49PM +0000, Sami Tolvanen wrote:

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b54a830eb5c6..20a40927175e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -44,6 +44,7 @@ config RISCV
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>  	select ARCH_SUPPORTS_HUGETLBFS if MMU
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> +	select ARCH_USES_CFI_TRAPS if CFI_CLANG

Could you please add new entries in alphanumerical order?

>  	select ARCH_USE_MEMTEST
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU

> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 8d5c84f2d5ef..45bc485fcf3f 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -63,6 +63,7 @@
>  #define RVG_RS1_OPOFF		15
>  #define RVG_RS2_OPOFF		20
>  #define RVG_RD_OPOFF		7
> +#define RVG_RS1_MASK		GENMASK(4, 0)
>  #define RVG_RD_MASK		GENMASK(4, 0)
> =20
>  /* The bit field of immediate value in RVC J instruction */
> @@ -129,6 +130,7 @@
>  #define RVC_C2_RS1_OPOFF	7
>  #define RVC_C2_RS2_OPOFF	2
>  #define RVC_C2_RD_OPOFF		7
> +#define RVC_C2_RS1_MASK		GENMASK(4, 0)
> =20
>  /* parts of opcode for RVG*/
>  #define RVG_OPCODE_FENCE	0x0f
> @@ -258,6 +260,10 @@ static __always_inline bool riscv_insn_is_branch(u32=
 code)
>  #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
>  #define RVC_X(X, s, mask) RV_X(X, s, mask)
> =20
> +#define RV_EXTRACT_RS1_REG(x) \
> +	({typeof(x) x_ =3D (x); \
> +	(RV_X(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
> +
>  #define RV_EXTRACT_RD_REG(x) \
>  	({typeof(x) x_ =3D (x); \
>  	(RV_X(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
> @@ -285,6 +291,10 @@ static __always_inline bool riscv_insn_is_branch(u32=
 code)
>  	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
>  	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
> =20
> +#define RVC_EXTRACT_C2_RS1_REG(x) \
> +	({typeof(x) x_ =3D (x); \
> +	(RV_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
> +
>  #define RVC_EXTRACT_JTYPE_IMM(x) \
>  	({typeof(x) x_ =3D (x); \
>  	(RVC_X(x_, RVC_J_IMM_3_1_OPOFF, RVC_J_IMM_3_1_MASK) << RVC_J_IMM_3_1_OF=
F) | \

I was surprised that we didn't have these bits before, had to go
looking. Think the optprobes series had handrolled copies of these,
which is probably the source of my surprise.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com> # ISA bits

--2hnuImplXuBy7/70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8m+AAKCRB4tDGHoIJi
0jBUAP0UMMzoYNXY5nsJHuteXP1BsQTrz11CKX9PQUFp3nlqBgEA6PNVMrlF90jy
yn449Glx4Y4AQdasyKf/P30AlWM9hgo=
=Vt5W
-----END PGP SIGNATURE-----

--2hnuImplXuBy7/70--
