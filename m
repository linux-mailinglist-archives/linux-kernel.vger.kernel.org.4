Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B796A4EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjB0Ws3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjB0WsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:48:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2F977D;
        Mon, 27 Feb 2023 14:47:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 978C8B80DC4;
        Mon, 27 Feb 2023 22:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E722C433D2;
        Mon, 27 Feb 2023 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677538065;
        bh=BQC2Xe6hyxIuIr07Xnnpv5N2HK5t+HJGmgw69hotKhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUdwByaAfmWSQWUwaa2Pzj7uqN5fr/iyGfkHiph0wlw6lBaS7nN54qr2XkJrl6K4q
         pZooF51PQQQ/fBKH4rabmZ+c50pagzmIbskodCuRNPyZuJNWoHjRGGBRWfrZg2l9VZ
         7zA9ZxTg/DdI+lFynt2kUBi3vBv8dtccg/I9JOqbzTwQsRb/P7QpVGPZHr9KtxJPO2
         qhOr0fCsTxe+ZvbBlZmOHSx8vESp4rS+zeAHgKiKRz2NIuPas2I4AicdI8eu41kS/w
         +V8j5RYKH6VIM7/O5n9kg3DcUNyOzAR0jL+e6S6h8zLPXegg6ChgxMwg9jTVHVPsZ3
         HNbMnJERCqs2w==
Date:   Mon, 27 Feb 2023 22:47:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/7] RISC-V: hwprobe: Add support for
 RISCV_HWPROBE_BASE_BEHAVIOR_IMA
Message-ID: <Y/0zC0Dn9gwC8N5w@spud>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-4-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YEhy8lQvUbxojQ+D"
Content-Disposition: inline
In-Reply-To: <20230221190858.3159617-4-evan@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YEhy8lQvUbxojQ+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

On Tue, Feb 21, 2023 at 11:08:54AM -0800, Evan Green wrote:
> We have an implicit set of base behaviors that userspace depends on,
> which are mostly defined in various ISA specifications.
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>=20
> Changes in v3:
>  - Refactored base ISA behavior probe to allow kernel probing as well,
>    in prep for vDSO data initialization.
>  - Fixed doc warnings in IMA text list, use :c:macro:.
>=20
>  Documentation/riscv/hwprobe.rst       | 21 +++++++++++++++++++++
>  arch/riscv/include/asm/hwprobe.h      |  2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h |  5 +++++
>  arch/riscv/kernel/sys_riscv.c         | 20 ++++++++++++++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprob=
e.rst
> index 88b015a2026e..9f2da414fbf8 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -37,3 +37,24 @@ The following keys are defined:
>    defined by the RISC-V privileged architecture specification.
>  * :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid`=
`, as
>    defined by the RISC-V privileged architecture specification.
> +* :c:macro:`RISCV_HWPROBE_KEY_BASE_BEHAVIOR`: A bitmask containing the b=
ase
> +  user-visible behavior that this kernel supports.  The following base u=
ser ABIs
> +  are defined:
> +
> +  * :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: Support for rv32ima or
> +    rv64ima, as defined by version 2.2 of the user ISA and version 1.10 =
of the
> +    privileged ISA, with the following known exceptions (more exceptions=
 may be
> +    added, but only if it can be demonstrated that the user ABI is not b=
roken):
> +
> +    * The :fence.i: instruction cannot be directly executed by userspace
> +      programs (it may still be executed in userspace via a
> +      kernel-controlled mechanism such as the vDSO).
> +* :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_0`: A bitmask containing the exten=
sions
> +  that are compatible with the :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA=
`:
> +  base system behavior.
> +
> +  * :c:macro:`RISCV_HWPROBE_IMA_FD`: The F and D extensions are supporte=
d, as
> +    defined by commit cd20cee ("FMIN/FMAX now implement
> +    minimumNumber/maximumNumber, not minNum/maxNum") of the RISC-V ISA m=
anual.
> +  * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as def=
ined
> +    by version 2.2 of the RISC-V ISA manual.

I think I asked for some newlines, but this all seems kinda random now
as to whether there is a blank line between list items or not.

> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 02c2f1f7417e..f2b224550923 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -9,6 +9,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/hwprobe.h>
>  #include <asm/sbi.h>
> +#include <asm/switch_to.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
>  #include <asm-generic/mman-common.h>
> @@ -124,6 +125,25 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>  	case RISCV_HWPROBE_KEY_MIMPID:
>  		hwprobe_arch_id(pair, cpus);
>  		break;
> +	/*
> +	 * The kernel already assumes that the base single-letter ISA
> +	 * extensions are supported on all harts, and only supports the
> +	 * IMA base, so just cheat a bit here and tell that to
> +	 * userspace.
> +	 */
> +	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
> +		pair->value =3D RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
> +		break;
> +
> +	case RISCV_HWPROBE_KEY_IMA_EXT_0:
> +		pair->value =3D 0;
> +		if (has_fpu())
> +			pair->value |=3D RISCV_HWPROBE_IMA_FD;
> +
> +		if (elf_hwcap & RISCV_ISA_EXT_c)
> +			pair->value |=3D RISCV_HWPROBE_IMA_C;
> +
> +		break;
> =20
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole

This looks a lot nicer after the refactor, sans the {}.
With a consistent approach taken to newlines:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--YEhy8lQvUbxojQ+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/0zCwAKCRB4tDGHoIJi
0nP/AP4/GMxjR+8aS2db8L6UNa8dMZrUVlDVN9gqSAuBgYHEdQEAjO85CrCUpq4r
bNmr88hLkiB/gnFkN44wqNyLANSZLgk=
=hgpt
-----END PGP SIGNATURE-----

--YEhy8lQvUbxojQ+D--
