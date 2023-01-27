Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA9467F248
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjA0Xgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjA0Xgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:36:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B76D757AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03599B82208
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D09C433EF;
        Fri, 27 Jan 2023 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674862603;
        bh=VWlzWalnkhO1dohr/NVJ6IZeHtHEw2u6z553J4C7hrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNksFuc7dfDCFXFmM+MOZMTmiGs5w0d9rSTZdOucxVGg+rPtU0FZyHxukJrwGMnyE
         P53Yl7QKjzeg/+lgWEZcuieSfeNvsctPmI+6dqUTI7yqWEEOUebzOVlv8WAvpXZxYP
         6dYY7SE98rIkmefqh11iFJ/OGy+iCTUK/3uygjMPd4JlhKxFkwI7v5UzE82n8gBRzN
         whv545rDPf/4WQZUfowe7OBB3T0xJccYN1Wpu+s2u1QC1d41kZRZ2GXK/Wdw3SZlkK
         cpazTg+eXGRgIl2tPacpLk8lVTs04FAfAc34xQJoE+SZXBXZ+cHesENMj4iLBP8JDe
         mknmGSb55FBGA==
Date:   Fri, 27 Jan 2023 23:36:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, bjorn@kernel.org, tongtiangen@huawei.com,
        ajones@ventanamicro.com, andrew@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] riscv: Fixup race condition on PG_dcache_clean in
 flush_icache_pte
Message-ID: <Y9RgBh9X6KM1/uvp@spud>
References: <20230127035306.1819561-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GuNVYafotbXvgZR0"
Content-Disposition: inline
In-Reply-To: <20230127035306.1819561-1-guoren@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GuNVYafotbXvgZR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guo Ren,

On Thu, Jan 26, 2023 at 10:53:06PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> In commit 588a513d3425 ("arm64: Fix race condition on PG_dcache_clean
> in __sync_icache_dcache()"), we found RISC-V has the same issue as the
> previous arm64. The previous implementation didn't guarantee the correct
> sequence of operations, which means flush_icache_all() hasn't been
> called when the PG_dcache_clean was set. That would cause a risk of page
> synchronization.
>=20
> Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executabl=
e")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
> Changelog:
> V2:
>  - Optimize commit log

Probably would have benefited from providing the analysis that the arm64
commit did, for riscv, rather than referring to theirs.
But that's not really important and the diff itself seems sound, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  - Rebase on riscv for-next (20230127)
>=20
> V1:
> https://lore.kernel.org/linux-riscv/20221023133205.3493564-2-guoren@kerne=
l.org/
> ---
>  arch/riscv/mm/cacheflush.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 3cc07ed45aeb..fcd6145fbead 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -90,8 +90,10 @@ void flush_icache_pte(pte_t pte)
>  	if (PageHuge(page))
>  		page =3D compound_head(page);
> =20
> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> +	if (!test_bit(PG_dcache_clean, &page->flags)) {
>  		flush_icache_all();
> +		set_bit(PG_dcache_clean, &page->flags);
> +	}
>  }
>  #endif /* CONFIG_MMU */
> =20
> --=20
> 2.36.1
>=20

--GuNVYafotbXvgZR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9RgBgAKCRB4tDGHoIJi
0m+jAQCoWHcrkvq5cRc39KGXssFRtqfRT9ZMxIkLfGtPSIG16QD/fWAAQ8JWzxde
siNntjh6A6FImIAQ0pLweSyiW0bfEAk=
=qMS9
-----END PGP SIGNATURE-----

--GuNVYafotbXvgZR0--
