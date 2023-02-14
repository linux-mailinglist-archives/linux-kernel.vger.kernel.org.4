Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783A9696FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBNViv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:38:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665828D31
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:38:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B6CA618F5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C8FC4339B;
        Tue, 14 Feb 2023 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676410728;
        bh=6jbhCugUXCS4XCdW63SXO4wmvPiA/c8ygiTvvYBz15w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpGAwpRsBKElwLUHUGFBFZvMltk/e1tfCNqYocBpogklr9EhyLK6YgLZEDnUK5f9q
         QLzJChn2wwaQzXjtqBo1ySt+YsLn8nLrF96ustKi0Q4ik3eusoA37QFmd1198YVvtk
         7y7Ce4OysTBPGyLGb/AQ6Rkvq2kv/KAKKAl0Hu+HD2lQL57fQsH3KJRlGsZ5HsE9gz
         anFPTbfyrPWRYrCdu8XZ4nzYQJ26EGcaChJTVVFwA+Wt4kGyM1U7BnKAOOVtgkLPKV
         gVgFeTKV6/SfaBb87/q7EuzesfHEhCaifbTXK5r0EzRvTTLzw8EeI2HOe8bJHnerLc
         KFIetAPy9oNLA==
Date:   Tue, 14 Feb 2023 21:38:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] RISC-V: Move struct riscv_cpuinfo to new header
Message-ID: <Y+v/Yu/ELfzx954s@spud>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-2-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5tYJzmdjbJLMszm"
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-2-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5tYJzmdjbJLMszm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 12:14:50PM -0800, Evan Green wrote:
> In preparation for tracking and exposing microarchitectural details to
> userspace (like whether or not unaligned accesses are fast), move the
> riscv_cpuinfo struct out to its own new cpufeatures.h header. It will
> need to be used by more than just cpu.c.
>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>=20
> (no changes since v1)

Really? I don't recall seeing this patch in v1? ;)

>=20
>  arch/riscv/include/asm/cpufeature.h | 21 +++++++++++++++++++++
>  arch/riscv/kernel/cpu.c             |  8 ++------
>  2 files changed, 23 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpufeature.h
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> new file mode 100644
> index 000000000000..66c251d98290
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2022 Rivos, Inc
> + */
> +
> +#ifndef _ASM_CPUFEATURE_H
> +#define _ASM_CPUFEATURE_H
> +
> +/*
> + * These are probed via a device_initcall(), via either the SBI or direc=
tly
> + * from the cooresponding CSRs.

May as well fix the typo here while we are moving the code & a respin is
required anyway.

I'm sure we'll need this patch regardless of approach, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--f5tYJzmdjbJLMszm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+v/YgAKCRB4tDGHoIJi
0tZUAP9alaj90UKMameldRPMqw+IPDy0llCUwKgwfXm1M4dLnwD9Fs25ZbsYQRWN
myGAiC3u18dRkuCDk/kRsy20aoskSQU=
=mKq5
-----END PGP SIGNATURE-----

--f5tYJzmdjbJLMszm--
