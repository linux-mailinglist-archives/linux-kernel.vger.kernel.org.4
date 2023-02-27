Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F338D6A4DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjB0WUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB0WUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:20:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903571C7F0;
        Mon, 27 Feb 2023 14:20:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A8DCB80D9A;
        Mon, 27 Feb 2023 22:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37953C433D2;
        Mon, 27 Feb 2023 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677536402;
        bh=BRZW2CPrqrzUKqLHGgsYAAf75xiDMUePxhcVBDQ50pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtEEb0u0cDuEahRcqb9OMSBqgaL5tpKzJq5Wbx2VCEvo1ldHuwxfzrGk1A0hmhPil
         e9DFyF3oF1hwfyFzk28JSCP/JsQ3IYbB2MeC9YdekJRUxLfaB0RViWYaD76tmv/+yP
         1SO4wXd8qDkeZQ7UORowt/LCfZEzpuJnWi0hbQi3c7XtQ6OHi29ocAydB4o/Y7lR2n
         0bCPnDYtpdNfYPhZi/XvaglhCpHr+nDtS8aCfGZHbFAaNd+SO96Wl/XjxOm3e6cp0I
         PrKHh2iK38pYfRwiNcqLPqKwNM2y8+XsAK0RZVE+bpKeiABf9YG8wPJfDufu1I1VPn
         w3uRE9gK5NYMw==
Date:   Mon, 27 Feb 2023 22:19:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/7] RISC-V: Add a syscall for HW probing
Message-ID: <Y/0sikPIVR3j7cKI@spud>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-3-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WERgPH8NLamXNLLe"
Content-Disposition: inline
In-Reply-To: <20230221190858.3159617-3-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WERgPH8NLamXNLLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 11:08:53AM -0800, Evan Green wrote:
> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> system call that quite does this, so let's just provide an arch-specific
> one to probe for hardware capabilities.  This currently just provides
> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> the future.
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>

> +static
> +int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_count,
> +		      long cpu_count, unsigned long __user *cpus_user,
> +		      unsigned long flags)

I almost feel bad commenting this, but this is now the only function
split like this w/ the static on its own line.

With the same caveat about ignorance about glibc's desires & lingering
doubt as to whether this interface is the right way to go, this looks
good to me now.
I'm reluctant to give an R-b for the latter reason, but assuming the
Higher Power deem this approach acceptable:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--WERgPH8NLamXNLLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/0sigAKCRB4tDGHoIJi
0sB+APwPbrJoN2ZTjbu9wQhfhdvGJ5YTQBDL1iNUak2khoxEtwD/d1Mt0NmZaWq9
vtXIm6otTg5BOlzMVEZ1+eEce/1G8QI=
=cgIn
-----END PGP SIGNATURE-----

--WERgPH8NLamXNLLe--
